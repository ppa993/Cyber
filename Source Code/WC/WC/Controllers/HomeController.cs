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
            var listView =
                db.Posts.Where(x => x.UserID == currentUser.Id).Take(10).OrderByDescending(x => x.PostedDate).ToList();
            var user = new ProfileViewModel();

            if (userInfo != null)
            {
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

        [HttpPost]
        public string PostStatus(string content)
        {
            Post post;
            try
            {
                post = new Post
                {
                    PostID = Guid.NewGuid().ToString().Replace("-", string.Empty),
                    PostContent = content,
                    UserID = User.Identity.GetUserId(),
                    PostType = (int)PostType.Status,
                    PostedDate = DateTime.Now,
                    LastModified = DateTime.Now,
                    VisibleType = (int)VisibleType.Public,

                };

                data.Posts.Add(post);
                data.SaveChanges();
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
                    UserID = User.Identity.GetUserId(),
                    CommentedDate = DateTime.Now,
                    LastModified = DateTime.Now,

                };

                data.Comments.Add(comment);
                data.SaveChanges();
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
    }
}