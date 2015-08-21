using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using WC.Constants;
using WC.Data;
using WC.Models;
using WC.Utils;

namespace WC.Controllers
{
    [Authorize]
    public class HomeController : AccountController
    {
       // GET: Home
        public ActionResult Newsfeed()
        {
            ViewData["FriendList"] = GetHtmlListFriendsOf(User.Identity.GetUserId());
            return View();
        }

        public ActionResult Profile([Bind(Prefix = "id")] string username)
        {
            if (string.IsNullOrEmpty(username)) return RedirectToAction("Newsfeed", "Home");

            var currentUser = UserManager.FindByName(username);
            var userInfo = db.Users.FirstOrDefault(x => x.UserID == currentUser.Id);
            var requestUserId = CurrentUserID;
            List<Post> listView;
            if (CurrentUserName == username)
            {
                listView = db.Posts.Where(x => x.PostedOn == currentUser.Id)
                                    .Take(10)
                                    .OrderByDescending(x => x.PostedDate)
                                    .ToList();
            }
            else
            {
                listView = db.Posts.Where(x => x.PostedOn == currentUser.Id)
                                    .Where(x => x.VisibleType == (int)VisibleType.Public
                                        || (x.VisibleType == (int)VisibleType.Friend && db.FriendLists.FirstOrDefault(y => y.UserId == currentUser.Id)
                                                                                                        .Friends.Any(z => z.FriendId == requestUserId
                                                                                                        && z.FriendStatus))
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
                user.Avatar = userInfo.Profile_Photo.ProfileImageUrl;
                user.Cover = userInfo.Profile_Photo.CoverImageUrl;
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
                    PostContent = content.Trim(),
                    UserID = CurrentUserID,
                    PostedOn = postedOn,
                    PostType = (int)PostType.Status,
                    PostedDate = DateTime.Now,
                    LastModified = DateTime.Now,
                    VisibleType = (int)VisibleType.Friend,

                };

                db.Posts.Add(post);
                db.SaveChanges();

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
            view.User = db.Users.First(x => x.UserID == post.UserID);
            view.PostLikes = db.PostLikes.Where(x => x.PostID == post.PostID).ToList();
            view.Comments = db.Comments.Where(x => x.PostID == post.PostID).ToList();

            listView.Add(view);

            var str = RenderPartialViewToString("PostList", listView);

            return str;

        }

        [HttpPost]
        public string PostComment(string postId, string content)
        {
            Comment comment;
            try
            {
                comment = new Comment
                {
                    CommentID = Guid.NewGuid().ToString().Replace("-", string.Empty),
                    PostID = postId,
                    CommentContent = content.Trim(),
                    UserID = CurrentUserID,
                    CommentedDate = DateTime.Now,
                    LastModified = DateTime.Now,

                };

                db.Comments.Add(comment);
                db.SaveChanges();

                //push notif for user whose post got new comment
                var currentPost = db.Posts.First(x => x.PostID == postId);
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
            view.User = db.Users.First(x => x.UserID == comment.UserID);
            view.CommentLikes = db.CommentLikes.Where(x => x.CommentID == comment.CommentID).ToList();

            listView.Add(view);

            var str = RenderPartialViewToString("CommentList", listView);

            return str;
        }

        [HttpPost]
        public string EditPost(string postId)
        {
            try
            {
                var post = db.Posts.FirstOrDefault(x => x.PostID == postId);
                return post != null ? post.PostContent : ActionResults.Deleted.ToString();
            }
            catch (Exception exception)
            {
                Helper.WriteLog(exception);
                return ActionResults.Failed.ToString();
            }
        }

        [HttpPost]
        public string EditComment(string commentId)
        {
            try
            {
                var comment = db.Comments.FirstOrDefault(x => x.CommentID == commentId);
                return comment != null ? comment.CommentContent : ActionResults.Deleted.ToString();
            }
            catch (Exception exception)
            {
                Helper.WriteLog(exception);
                return ActionResults.Failed.ToString();
            }
        }

        [HttpPost]
        public string UpdatePost(string postId, string content)
        {
            try
            {
                var post = db.Posts.FirstOrDefault(x => x.PostID.Equals(postId, StringComparison.InvariantCultureIgnoreCase));
                if (post != null)
                {
                    post.PostContent = content;

                    db.Posts.Attach(post);
                    var entry = db.Entry(post);
                    entry.Property(x => x.PostContent).IsModified = true;
                    db.SaveChanges();
                }
                else
                {
                    return ActionResults.Deleted.ToString();
                }
            }
            catch (Exception exception)
            {
                Helper.WriteLog(exception);
                return ActionResults.Failed.ToString();
            }
            return ActionResults.Succeed.ToString();
        }

        [HttpPost]
        public string UpdateComment(string commentId, string content)
        {
            try
            {
                var comment = db.Comments.FirstOrDefault(x => x.CommentID.Equals(commentId, StringComparison.InvariantCultureIgnoreCase));
                if (comment != null)
                {
                    comment.CommentContent = content;

                    db.Comments.Attach(comment);
                    var entry = db.Entry(comment);
                    entry.Property(x => x.CommentContent).IsModified = true;
                    db.SaveChanges();
                }
                else
                {
                    return ActionResults.Deleted.ToString();
                }
            }
            catch (Exception exception)
            {
                Helper.WriteLog(exception);
                return ActionResults.Failed.ToString();
            }
            return ActionResults.Succeed.ToString();
        }

        [HttpPost]
        public string DeletePost(string postId)
        {
            try
            {
                var post =
                    db.Posts.FirstOrDefault(x => x.PostID.Equals(postId, StringComparison.InvariantCultureIgnoreCase));
                if (post != null)
                {
                    if (post.UserID == CurrentUserID || post.PostedOn == CurrentUserID)
                    {
                        foreach (var comment in post.Comments)
                        {
                            db.CommentLikes.RemoveRange(comment.CommentLikes);
                        }
                        db.SaveChanges();

                        db.Comments.RemoveRange(post.Comments);
                        db.PostLikes.RemoveRange(post.PostLikes);
                        db.SaveChanges();

                        db.Posts.Remove(post);
                        db.SaveChanges();
                    }
                    else
                    {
                        return ActionResults.Failed.ToString();
                    }
                }
                else
                {
                    return ActionResults.Deleted.ToString();
                }

            }
            catch (Exception exception)
            {
                Helper.WriteLog(exception);
                return ActionResults.Failed.ToString();
            }

            return ActionResults.Succeed.ToString();

        }

        [HttpPost]
        public string DeleteComment(string commentId)
        {
            Post post;
            try
            {
                var comment =
                    db.Comments.FirstOrDefault(x => x.CommentID.Equals(commentId, StringComparison.InvariantCultureIgnoreCase));
                if (comment != null)
                {
                    post =
                        db.Posts.FirstOrDefault(
                            x => x.PostID.Equals(comment.PostID, StringComparison.InvariantCultureIgnoreCase));
                    if (post != null)
                    {
                        if (comment.UserID == CurrentUserID || post.PostedOn == CurrentUserID)
                        {
                            db.CommentLikes.RemoveRange(comment.CommentLikes);
                            db.SaveChanges();

                            db.Comments.Remove(comment);
                            db.SaveChanges();
                        }
                        else
                        {
                            return ActionResults.Failed.ToString();
                        }
                    }
                    else
                    {
                        return ActionResults.Deleted.ToString();
                    }
                }
                else
                {
                    return ActionResults.Deleted.ToString();
                }

            }
            catch (Exception exception)
            {
                Helper.WriteLog(exception);
                return ActionResults.Failed.ToString();
            }

            return post.PostID;

        }

        [HttpPost]
        public string LikeUnlikePost(string postId, bool isLike)
        {
            try
            {
                if (isLike)
                {
                    var like = new PostLike
                    {
                        PostLikeID = Guid.NewGuid().ToString().Replace("-", string.Empty),
                        PostID = postId,
                        UserID = CurrentUserID
                    };

                    db.PostLikes.Add(like);
                    db.SaveChanges();

                    //push notif for post owner if some one like his post, but not when he like it himself
                    var postOwner = db.Posts.First(x => x.PostID == postId).User.UserID;
                    if (!postOwner.Equals(CurrentUserID, StringComparison.InvariantCultureIgnoreCase))
                    {
                        PushNotification(postOwner, postId, (int)NotificationType.LikeMyPost);
                    }

                    //return total like
                    var likeCount =
                        db.Posts.First(x => x.PostID.Equals(postId, StringComparison.InvariantCultureIgnoreCase))
                            .PostLikes.Count.ToString();
                    return likeCount;
                }
                else
                {
                    var unlike =
                        db.PostLikes.FirstOrDefault(x => x.PostID == postId && x.UserID == CurrentUserID);
                    db.PostLikes.Remove(unlike);
                    db.SaveChanges();
                    var likeCount =
                        db.Posts.First(x => x.PostID.Equals(postId, StringComparison.InvariantCultureIgnoreCase))
                            .PostLikes.Count.ToString();
                    return likeCount;
                }
            }
            catch (Exception exception)
            {
                Helper.WriteLog(exception);
                return ActionResults.Failed.ToString();
            }
        }

        [HttpPost]
        public string LikeUnlikeComment(string commentId, bool isLike)
        {
            try
            {
                if (isLike)
                {
                    var like = new CommentLike
                    {
                        CommentLikeID = Guid.NewGuid().ToString().Replace("-", string.Empty),
                        CommentID = commentId,
                        UserID = CurrentUserID
                    };

                    db.CommentLikes.Add(like);
                    db.SaveChanges();

                    //push notif for comment owner if some one like his comment, but not when he like it himself
                    var commentOwner = db.Comments.First(x => x.CommentID == commentId).User.UserID;
                    if (!commentOwner.Equals(CurrentUserID, StringComparison.InvariantCultureIgnoreCase))
                    {
                        PushNotification(commentOwner, commentId, (int)NotificationType.LikeMyComment);
                    }

                    //return total like
                    var likeCount =
                        db.Comments.First(x => x.CommentID.Equals(commentId, StringComparison.InvariantCultureIgnoreCase))
                            .CommentLikes.Count.ToString();
                    return likeCount;
                }
                else
                {
                    var unlike =
                        db.CommentLikes.FirstOrDefault(x => x.CommentID == commentId && x.UserID == CurrentUserID);
                    db.CommentLikes.Remove(unlike);
                    db.SaveChanges();
                    var likeCount =
                        db.Comments.First(x => x.CommentID.Equals(commentId, StringComparison.InvariantCultureIgnoreCase))
                            .CommentLikes.Count.ToString();
                    return likeCount;
                }
            }
            catch (Exception exception)
            {
                Helper.WriteLog(exception);
                return ActionResults.Failed.ToString();
            }
        } 
        #endregion

        #region Private Methods
        private void PushNotification(string receiver, string itemId, int notifType)
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
                    UserID = receiver,
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