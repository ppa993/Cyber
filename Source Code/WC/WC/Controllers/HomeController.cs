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

        public ActionResult Profile(string username)
        {
            if (string.IsNullOrEmpty(username)) return RedirectToAction("Newsfeed", "Home");

            //fromUser: whose profile is being load
            //toUser: who request to view fromUser's profile
            var fromUser = UserManager.FindByName(username);
            var fromUserInfo = db.Users.FirstOrDefault(x => x.UserID == fromUser.Id);
            var toUser = CurrentUserID;

            var postList = GetPosts(fromUser, toUser).Take(DefautValue.PostLoad).ToList();
            var user = new ProfileViewModel();

            if (fromUserInfo != null)
            {
                user.Id = fromUserInfo.UserID;
                user.About = fromUserInfo.About;
                user.DisplayName = fromUserInfo.FirstName + " " + fromUserInfo.LastName;
                user.Address = fromUserInfo.Address;
                user.Email = fromUserInfo.Email;
                user.Gender = fromUserInfo.Gender;
                user.Friends = fromUserInfo.FriendLists.First();
                user.Posts = postList;
                user.Avatar = fromUserInfo.Profile_Photo.ProfileImageUrl;
                user.Cover = fromUserInfo.Profile_Photo.CoverImageUrl;
                user.AllowOtherToPost = fromUserInfo.MySettings.First().AllowOtherToPost;
                user.IsMyTimeline = fromUser.Id.Equals(toUser, StringComparison.InvariantCultureIgnoreCase);
                user.Setting = fromUserInfo.MySettings.First();
            }
            
            return View(user);
        }


        /// <summary>
        /// Get 10 posts from fromUser if toUser have permission
        /// </summary>
        /// <param name="fromUser">whose profile is being view</param>
        /// <param name="toUser">who request to view this profile</param>
        /// <returns></returns>
        private List<Post> GetPosts(ApplicationUser fromUser, string toUser)
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
                    listView = db.Posts.Where(x => x.PostedOn == fromUser.Id)
                                        .Where(x => x.VisibleType == (int)VisibleType.Public
                                            || (x.VisibleType == (int)VisibleType.Friend && db.FriendLists.FirstOrDefault(y => y.UserId == fromUser.Id)
                                                                                                            .Friends.Any(z => z.FriendId == toUser
                                                                                                            && z.FriendStatus))
                                            || x.UserID == toUser)
                                        .OrderByDescending(x => x.PostedDate)
                                        .ToList();
                }
            }
            catch (Exception exception)
            {
                Helper.WriteLog(exception);
            }
            return listView;
        }
    }
}