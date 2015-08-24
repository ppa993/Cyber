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
            //ViewData["FriendList"] = GetHtmlListFriendsOf(User.Identity.GetUserId());

            var currentUser = UserManager.FindById(CurrentUserID);
            var setting = db.MySettings.First(x => x.UserID == currentUser.Id);
            var posts = GetPosts(currentUser, currentUser.Id);

            var view = new NewsfeedViewModel
            {
                Id = CurrentUserID,
                Setting = setting,
                Posts = posts
            };
            return View(view);
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

            //Get info to show buttons request friend
            var targetUser = db.Users.FirstOrDefault(x => x.UserName == username);
            var currUserId = User.Identity.GetUserId();

            //don't show button add friend if it has the same user id
            if (targetUser.UserID == currUserId)
            {
                ViewData["FlagShowButton"] = "1";
            }
            else
            {
                if (targetUser != null)
                {
                    var targetFriend = db.Friends.FirstOrDefault(x => x.FriendsListId == targetUser.UserID && x.FriendId == currUserId);
                    var currFriend = db.Friends.FirstOrDefault(x => x.FriendsListId == currUserId && x.FriendId == targetUser.UserID);
                    AddFriendViewModel f = new AddFriendViewModel()
                    {
                        CurrentUserId = currUserId,
                        TargetUserId = targetUser.UserID
                    };
                    if (currFriend == null && targetFriend == null)
                        f.Type = ButtonFriendType.NonRelationship;

                    if (currFriend != null && targetFriend == null)
                        f.Type = ButtonFriendType.WaitForTargetAccepting;

                    if (currFriend == null && targetFriend != null)
                        f.Type = ButtonFriendType.WaitForAcceptting;

                    if (currFriend != null && targetFriend != null)
                        f.Type = ButtonFriendType.HasRelationship;
                    ViewData["FlagShowButton"] = null;
                    ViewData["InfoButtonFriend"] = f;
                }
                else
                {
                    ViewData["InfoButtonFriend"] = null;
                }
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

        public void UndoFriend(string targetUserId)
        {
            var curId = User.Identity.GetUserId();
            var curFriend = db.Friends.FirstOrDefault(x => x.FriendsListId == curId && x.FriendId == targetUserId);
            if (curFriend != null)
            {
                db.Friends.Remove(curFriend);
            }

            var targetFriend= db.Friends.FirstOrDefault(x => x.FriendsListId == targetUserId && x.FriendId == curId);
            if (targetFriend != null)
            {
                db.Friends.Remove(targetFriend);
            }
            db.SaveChanges();
        }

        public string FriendControl(string targetUserId, int type)
        {
            string result = "";
            var curId = User.Identity.GetUserId();
            var checkFriend = db.Friends.FirstOrDefault(x => x.FriendsListId == curId && x.FriendId == targetUserId);
            Friend f = new Friend()
            {
                FriendsListId = curId,
                FriendId = targetUserId,
                FriendStatus = false
            };
            switch ((ButtonFriendType)type)
            {
                case ButtonFriendType.NonRelationship:
                    try {
                        if (checkFriend == null)
                        {
                            db.Friends.Add(f);
                            db.SaveChanges();
                        }
                    }
                    catch { }
                    result = "add";
                    break;
                case ButtonFriendType.WaitForAcceptting:
                    try {
                        var dateSince = DateTime.Now;
                        var targetFriend = db.Friends.FirstOrDefault(x => x.FriendsListId == targetUserId && x.FriendId == curId);
                        if (targetUserId != null)
                        {
                            targetFriend.FriendStatus = true;
                            targetFriend.FriendSince = dateSince;
                        }
                        if (checkFriend == null)
                        {
                            f.FriendStatus = true;
                            f.FriendSince = dateSince;
                            db.Friends.Add(f);
                        }
                        db.SaveChanges();
                    }
                    catch { }
                    result = "accept";
                    break;

                case ButtonFriendType.HasRelationship:
                case ButtonFriendType.WaitForTargetAccepting:
                    result = "remove";
                    break;
            }
            return result;
        }
    }
}