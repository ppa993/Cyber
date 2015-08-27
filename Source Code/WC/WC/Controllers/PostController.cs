using Microsoft.AspNet.Identity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using WC.Constants;
using WC.Data;
using WC.Models;
using WC.Utils;

namespace WC.Controllers
{
    [Authorize]
    public class PostController : AccountController
    {
        public ActionResult ViewPost(string postid)
        {
            var posts = new List<Post>();
            try
            {
                var post =
                    db.Posts.FirstOrDefault(x => x.PostID.Equals(postid, StringComparison.InvariantCultureIgnoreCase));

                if (post != null && IsAuthorizeToViewPost(post))
                {
                    posts.Add(post);
                    ViewBag.Title = TruncateAtWord(post.PostContent, 50);

                    //update seen notify
                    var notify = db.Notifications.FirstOrDefault(x => x.UserID == CurrentUserID && x.NotificationItemID == postid && !x.Seen);
                    if (notify != null)
                    {
                        notify.Seen = true;
                        db.SaveChanges();
                    }
                }
                else
                {
                    ViewBag.Title = Message.PAGE_NOT_FOUND;
                }
            }
            catch (Exception exception)
            {
                Helper.WriteLog(exception);
            }
            return View(posts);
        }

        //[ChildActionOnly]
        //public ActionResult PostList(List<Post> Model)
        //{
        //    return PartialView(Model);
        //}

        [ChildActionOnly]
        public ActionResult CommentList(List<Comment> Model)
        {
            return PartialView(Model);
        }

        #region Post Methods
        [HttpPost]
        public string PostStatus(string postedOn, string content)
        {
            Post post;
            try
            {
                var user =
                    db.Users.FirstOrDefault(x => x.UserID.Equals(postedOn, StringComparison.InvariantCultureIgnoreCase));
                if (user == null)
                    return ActionResults.Failed.ToString();
                var setting = user.MySettings.First();

                var postVisible = CurrentUserID == postedOn ? setting.DefaultMyPostVisibility : setting.DefaultOtherPostVisibility;
                post = new Post
                {
                    PostID = Guid.NewGuid().ToString().Replace("-", string.Empty),
                    PostContent = content.Trim(),
                    UserID = CurrentUserID,
                    PostedOn = postedOn,
                    PostType = (int)PostType.Status,
                    PostedDate = DateTime.UtcNow,
                    LastModified = DateTime.UtcNow,
                    VisibleType = postVisible
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
                var currentPost = db.Posts.First(x => x.PostID == postId);

                if (!IsAuthorizeToViewPost(currentPost)) return ActionResults.Deleted.ToString();

                comment = new Comment
                {
                    CommentID = Guid.NewGuid().ToString().Replace("-", string.Empty),
                    PostID = postId,
                    CommentContent = content.Trim(),
                    UserID = CurrentUserID,
                    CommentedDate = DateTime.UtcNow,
                    LastModified = DateTime.UtcNow,

                };

                db.Comments.Add(comment);
                db.SaveChanges();

                //push notif for user whose post got new comment
                //don't count current commenter himself in for notif
                var postCommenters = currentPost.Comments.Select(x => x.UserID).Where(x => x != CurrentUserID).Distinct().ToList();
                var postOwner = currentPost.User;
                //if not post owner, give owner a notif
                if (CurrentUserID != postOwner.UserID)
                {
                    PushNotification(postOwner.UserID, postId, (int)NotificationType.CommentMyPost);
                }
                else //if post owner is commenting, give notif for those who commented on his post
                {
                    foreach (var commenter in postCommenters)
                    {
                        PushNotification(commenter, postId, (int)NotificationType.CommentOthers);
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
                var post = db.Posts.First(x => x.PostID.Equals(postId, StringComparison.InvariantCultureIgnoreCase));
                if (post == null) return ActionResults.Deleted.ToString();
                if (isLike)
                {
                    if (db.PostLikes.Any(x => x.PostID.Equals(postId, StringComparison.InvariantCultureIgnoreCase)
                                              && x.UserID == CurrentUserID))
                    {
                        return ActionResults.AlreadyDone.ToString();
                    }
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
                var comment =
                    db.Comments.First(x => x.CommentID.Equals(commentId, StringComparison.InvariantCultureIgnoreCase));
                if (comment == null)
                    return ActionResults.Deleted.ToString();
                if (isLike)
                {
                    if (db.CommentLikes.Any(x => x.CommentID.Equals(commentId, StringComparison.InvariantCultureIgnoreCase)
                                              && x.UserID == CurrentUserID))
                    {
                        return ActionResults.AlreadyDone.ToString();
                    }
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
                        PushNotification(commentOwner, comment.PostID, (int)NotificationType.LikeMyComment);
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

        [HttpPost]
        public ActionResult LoadMorePost(string userId, int loadedPostCount)
        {
            var morePost = new MorePostViewModel();
            var fromUser = UserManager.FindById(userId);

            var posts = GetPosts(fromUser);
            var notLoadedCount = posts.Count - loadedPostCount;

            if (notLoadedCount <= DefautValue.PostLoad)
            {
                posts = posts.Skip(loadedPostCount).Take(notLoadedCount).ToList();
                morePost.NoMore = true;
            }
            else
            {
                posts = posts.Skip(loadedPostCount).Take(DefautValue.PostLoad).ToList();
                morePost.NoMore = false;
            }

            morePost.Posts = RenderPartialViewToString("PostList", posts);

            return Json(morePost);
        }

        [HttpPost]
        public string ChangeMyDefaultPostVisibility(int visibility)
        {
            try
            {
                var setting = db.MySettings.FirstOrDefault(x => x.UserID == CurrentUserID);
                if (setting == null) return ActionResults.Deleted.ToString();

                setting.DefaultMyPostVisibility = visibility;

                var entry = db.Entry(setting);
                entry.Property(x => x.DefaultMyPostVisibility).IsModified = true;
                db.SaveChanges();
                return ActionResults.Succeed.ToString();
            }
            catch (Exception exception)
            {
                Helper.WriteLog(exception);
            }
            return ActionResults.Failed.ToString();
        }

        [HttpPost]
        public string ChangePostVisibleType(string postId, int visibility)
        {
            try
            {
                var setting = db.Posts.FirstOrDefault(x => x.PostID == postId);
                if (setting == null) return ActionResults.Deleted.ToString();

                setting.VisibleType = visibility;

                var entry = db.Entry(setting);
                entry.Property(x => x.VisibleType).IsModified = true;
                db.SaveChanges();
                return ActionResults.Succeed.ToString();
            }
            catch (Exception exception)
            {
                Helper.WriteLog(exception);
            }
            return ActionResults.Failed.ToString();
        }

        [HttpPost]
        public string IsAlreadyReport(string reportItem)
        {
            try
            {
                var already = db.Reports.Any(
                        x =>
                            x.ReportItem.Equals(reportItem, StringComparison.InvariantCultureIgnoreCase) &&
                            x.Reporter.Equals(CurrentUserID));
                return already ? ActionResults.AlreadyDone.ToString() : string.Empty;

            }
            catch (Exception exception)
            {
                Helper.WriteLog(exception);
                return ActionResults.AlreadyDone.ToString();
            }
        }

        [HttpPost]
        public string Report(string reportItem, string reportType, string reportContent)
        {
            try
            {
                var isExisted = false;
                switch (reportType)
                {
                    case "1":
                        isExisted =
                            db.Posts.Any(x => x.PostID.Equals(reportItem, StringComparison.InvariantCultureIgnoreCase));
                        break;
                    default:
                        isExisted =
                            db.Comments.Any(x => x.CommentID.Equals(reportItem, StringComparison.InvariantCultureIgnoreCase));
                        break;
                }
                //if report item is no longer exist, return
                if (!isExisted) return ActionResults.Deleted.ToString();

                var alreadyDone =
                    db.Reports.Any(x => x.ReportItem.Equals(reportItem, StringComparison.InvariantCultureIgnoreCase)
                                        && x.Reporter.Equals(CurrentUserID));

                //if already report this item, return
                if (alreadyDone) return ActionResults.AlreadyDone.ToString();

                var count =
                    db.Reports.Count(
                        x =>
                            x.ReportItem.Equals(reportItem, StringComparison.InvariantCultureIgnoreCase) &&
                            x.ReportType == reportType.Equals("1"));

                //if this item has more than 50 reports, delete it
                if (count >= 50)
                {
                    if (reportType.Equals("1"))
                    {
                        var post =
                            db.Posts.FirstOrDefault(
                                x => x.PostID.Equals(reportItem, StringComparison.InvariantCultureIgnoreCase));
                        db.Posts.Remove(post);
                        db.SaveChanges();
                    }
                    else
                    {
                        var comment =
                            db.Comments.FirstOrDefault(
                                x => x.CommentID.Equals(reportItem, StringComparison.InvariantCultureIgnoreCase));
                        db.Comments.Remove(comment);
                        db.SaveChanges();
                    }
                }
                //if not, create new report
                else
                {
                    var report = new Report
                    {
                        ReportID = Guid.NewGuid().ToString(),
                        ReportType = reportType.Equals("1"),
                        ReportItem = reportItem,
                        ReportContent = reportContent,
                        Reporter = CurrentUserID,
                        ReportedDate = DateTime.UtcNow
                    };

                    db.Reports.Add(report);
                    db.SaveChanges();
                }
                return ActionResults.Succeed.ToString();
            }
            catch (Exception exception)
            {
                Helper.WriteLog(exception);
                return ActionResults.Failed.ToString();
            }
        }

        #endregion

        #region Private Methods
        
        private List<Post> GetPosts(ApplicationUser fromUser)
        {
            var listView = new List<Post>();
            try
            {
                if (CurrentUserName == fromUser.UserName)
                {
                    listView = db.Posts.Where(x => x.PostedOn == fromUser.Id)
                                        .OrderByDescending(x => x.PostedDate)
                                        .ToList();
                }
                else
                {
                    //listView = db.Posts.Where(x => x.PostedOn == fromUser.Id)
                    //                    .Where(x => IsAuthorizeToViewPost(x))
                    //                    .OrderByDescending(x => x.PostedDate)
                    //                    .ToList();
                    var temp = db.Posts.Where(x => x.PostedOn == fromUser.Id).OrderByDescending(x => x.PostedDate);
                    listView.AddRange(temp.Where(item => IsAuthorizeToViewPost(item)));
                }
            }
            catch (Exception exception)
            {
                Helper.WriteLog(exception);
            }
            return listView;
        }

        private bool IsAuthorizeToViewPost(Post post)
        {
            switch (post.VisibleType)
            {
                case (int)VisibleType.Public:
                    return true;

                case (int)VisibleType.Friend:
                    if (post.User1.FriendLists.First().Friends.Any(x => x.FriendId == CurrentUserID && x.FriendStatus)
                        || post.PostedOn.Equals(CurrentUserID, StringComparison.InvariantCultureIgnoreCase)
                        || post.UserID.Equals(CurrentUserID, StringComparison.InvariantCultureIgnoreCase))
                    {
                        return true;
                    }
                    break;

                case (int)VisibleType.Private:
                    if (post.PostedOn.Equals(CurrentUserID, StringComparison.InvariantCultureIgnoreCase)
                        || post.UserID.Equals(CurrentUserID, StringComparison.InvariantCultureIgnoreCase))
                    {
                        return true;
                    }
                    break;
            }
            return false;
        }

        #endregion
	}
}