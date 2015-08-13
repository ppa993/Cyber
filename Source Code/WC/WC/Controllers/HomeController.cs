using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Microsoft.AspNet.Identity;
using WC.Constants;
using WC.Data;
using WC.Models;
using WC.Utils;

namespace WC.Controllers
{
    [Authorize]
    public class HomeController : AccountController
    {
        public CyberEntities data = new CyberEntities();
        // GET: Home
        public ActionResult Newsfeed()
        {
            return View();
        }

        public ActionResult Profile([Bind(Prefix = "id")] string username)
        {
            if (string.IsNullOrEmpty(username)) return RedirectToAction("Newsfeed", "Home");

            var currentUser = UserManager.FindByName(username);
            var userInfo = data.Users.FirstOrDefault(x => x.UserID == currentUser.Id);
            var requestUserId = CurrentUserID;
            List<Post> listView;
            if (CurrentUserID == username)
            {
                listView = db.Posts.Where(x => x.PostedOn == currentUser.Id)
                                    .Take(10)
                                    .OrderByDescending(x => x.PostedDate)
                                    .ToList();
            }
            else
            {
                listView = db.Posts.Where(x => x.PostedOn == currentUser.Id)
                                    .Where(x => x.VisibleType == 1 
                                        || (x.VisibleType == 2 && db.Friends.Any(y => y.UserID == currentUser.Id 
                                                                && y.FriendID == requestUserId 
                                                                && y.FriendStatus))
                                        || x.UserID == requestUserId)
                                    .Take(10)
                                    .OrderByDescending(x => x.PostedDate)
                                    .ToList();
            }
            var user = new ProfileViewModel();

            if (userInfo != null)
            {
                user.Id = userInfo.UserID;
                user.About = userInfo.About;
                user.DisplayName = userInfo.FirstName + " " + userInfo.LastName;
                user.Address = userInfo.Address;
                user.Email = userInfo.Email;
                var friends = userInfo.Friends;
                user.Friends = friends;
                user.Posts = listView;
            }
            
            return View(user);
        }

        [ChildActionOnly]
        public ActionResult PostList(List<Post> Model)
        {
            return PartialView(Model);
        }

        [ChildActionOnly]
        public ActionResult CommentList(List<Comment> Model)
        {
            return PartialView(Model);
        }

        #region Web Post Methods
        [HttpPost]
        public string PostStatus(string postedOn, string content)
        {
            Post post;
            try
            {
                post = new Post
                {
                    PostID = Guid.NewGuid().ToString().Replace("-", string.Empty),
                    PostContent = content,
                    UserID = CurrentUserID,
                    PostedOn = postedOn,
                    PostType = (int)PostType.Status,
                    PostedDate = DateTime.Now,
                    LastModified = DateTime.Now,
                    VisibleType = (int)VisibleType.Friend,

                };

                data.Posts.Add(post);
                data.SaveChanges();

                //if is not post on his own timeline, then push new notif for user who has been posted on
                if (postedOn != CurrentUserID)
                {
                    PushNotification(postedOn, post.PostID, (int)NotificationType.Post);
                }
            }
            catch (Exception exception)
            {
                Helper.WriteLog(exception);
                return ActionResults.Failed.ToString();
            }

            var listView = new List<Post>();
            var view = post;
            view.User = data.Users.First(x => x.UserID == post.UserID);
            view.PostLikes = data.PostLikes.Where(x => x.PostID == post.PostID).ToList();
            view.Comments = data.Comments.Where(x => x.PostID == post.PostID).ToList();

            listView.Add(view);

            var str = RenderPartialViewToString("PostList", listView);

            return str;

        }

        [HttpPost]
        public string PostComment(string postID, string content)
        {
            Comment comment;
            try
            {
                comment = new Comment
                {
                    CommentID = Guid.NewGuid().ToString().Replace("-", string.Empty),
                    PostID = postID,
                    CommentContent = content,
                    UserID = CurrentUserID,
                    CommentedDate = DateTime.Now,
                    LastModified = DateTime.Now,

                };

                data.Comments.Add(comment);
                data.SaveChanges();

                //push notif for user whose post got new comment
                var currentPost = db.Posts.First(x => x.PostID == postID);
                //don't count current commenter himself in for notif
                var postCommenters = currentPost.Comments.Select(x => x.UserID).Where(x => x != CurrentUserID).ToList();
                var postOwner = currentPost.User;
                //if not post owner, give owner a notif
                if (CurrentUserID != postOwner.UserID)
                {
                    PushNotification(postOwner.UserID, comment.CommentID, (int)NotificationType.CommentMyPost);
                }
                else //if post owner is commenting, give notif for those who commented on his post
                {
                    foreach (var commenter in postCommenters)
                    {
                        PushNotification(commenter, comment.CommentID, (int)NotificationType.CommentOthers);
                    }
                }

            }
            catch (Exception exception)
            {
                Helper.WriteLog(exception);
                return ActionResults.Failed.ToString();
            }

            var listView = new List<Comment>();
            var view = comment;
            view.User = data.Users.First(x => x.UserID == comment.UserID);
            view.CommentLikes = data.CommentLikes.Where(x => x.CommentID == comment.CommentID).ToList();

            listView.Add(view);

            var str = RenderPartialViewToString("CommentList", listView);

            return str;
        }

        [HttpPost]
        public string LikeUnlikePost(string postID, bool isLike)
        {
            try
            {
                if (isLike)
                {
                    var like = new PostLike
                    {
                        PostLikeID = Guid.NewGuid().ToString().Replace("-", string.Empty),
                        PostID = postID,
                        UserID = CurrentUserID
                    };

                    data.PostLikes.Add(like);
                    data.SaveChanges();
                }
                else
                {
                    var unlike =
                        data.PostLikes.FirstOrDefault(x => x.PostID == postID && x.UserID == CurrentUserID);
                    data.PostLikes.Remove(unlike);
                    data.SaveChanges();
                }
            }
            catch (Exception exception)
            {
                Helper.WriteLog(exception);
                return ActionResults.Failed.ToString();
            }

            return ActionResults.Succeed.ToString();
        } 
        #endregion

        #region Private Methods
        private void PushNotification(string userId, string itemId, int notifType)
        {
            try
            {
                var byUserId = CurrentUserID;
                var byUser = db.Users.First(x => x.UserID == byUserId);
                var displayName = string.Format("{0} {1}", byUser.FirstName, byUser.LastName);
                string notifContent;

                switch (notifType)
                {
                    case 1:
                        notifContent = string.Format(NotificationMessage.NOTIF_POST, displayName);
                        break;
                    case 2:
                        notifContent = string.Format(NotificationMessage.NOTIF_COMMENT_MY_POST, displayName);
                        break;
                    case 3:
                        notifContent =
                            string.Format(
                                byUser.Gender
                                    ? NotificationMessage.NOTIF_COMMENT_HIS_POST
                                    : NotificationMessage.NOTIF_COMMENT_HER_POST, displayName);
                        break;
                    case 4:
                        notifContent = string.Format(NotificationMessage.NOTIF_LIKE_MY_POST, displayName);
                        break;
                    default:
                        notifContent = string.Format(NotificationMessage.NOTIF_LIKE_MY_COMMENT, displayName);
                        break;
                }


                var notif = new Notification
                {
                    UserID = userId,
                    NotificationID = Guid.NewGuid().ToString().Replace("-", string.Empty),
                    NotificationType = notifType,
                    NotificationContent = notifContent,
                    NotificationItemID = itemId,
                    NotificationDate = DateTime.Now,
                    Seen = false
                };

                db.Notifications.Add(notif);
                db.SaveChanges();

            }
            catch (Exception exception)
            {
                Helper.WriteLog(exception);
            }
        } 
        #endregion
    }
}