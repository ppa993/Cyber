using Microsoft.AspNet.Identity;
using Microsoft.AspNet.SignalR;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using WC.Constants;
using WC.Data;
using WC.Hubs;
using WC.Models;
using WC.Utils;

namespace WC.Controllers
{
    [System.Web.Mvc.Authorize]
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
            ViewBag.CurId = User.Identity.GetUserId();
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
                user.LastName = fromUserInfo.LastName;
                user.FirstName = fromUserInfo.FirstName;
                user.DisplayName = fromUserInfo.FirstName + " " + fromUserInfo.LastName;
                user.Address = fromUserInfo.Address;
                user.Email = fromUserInfo.Email;
                user.Gender = fromUserInfo.Gender;
                user.FriendCount = fromUserInfo.Friends.Count(x => x.FriendStatus);
                user.Posts = postList;
                user.Work = fromUserInfo.Work;
                user.ContactNumber = fromUserInfo.ContactNumber;
                user.Avatar = fromUserInfo.Profile_Photo.ProfileImageUrl;
                user.Cover = fromUserInfo.Profile_Photo.CoverImageUrl;
                user.AllowOtherToPost = fromUserInfo.MySettings.First().AllowOtherToPost;
                user.IsMyTimeline = fromUser.Id.Equals(toUser, StringComparison.InvariantCultureIgnoreCase);
                user.Setting = fromUserInfo.MySettings.First();

                var randomFriends = fromUserInfo.FriendLists.First().Friends.Where(x => x.FriendStatus)
                    .OrderBy(x => Guid.NewGuid())
                    .Take(12).ToList();

                user.Friends =
                    user.FriendCount <= 12
                        ? fromUserInfo.FriendLists.First().Friends.Where(x => x.FriendStatus).ToList()
                        : randomFriends;

                //if this is not my timeline then check for my friend status with this person
                if (!user.IsMyTimeline)
                {
                    var fview = new AddFriendViewModel()
                    {
                        CurrentUserId = toUser,
                        TargetUserId = fromUserInfo.UserID
                    };

                    var myFriend =
                        db.Friends.FirstOrDefault(x => x.FriendsListId == toUser && x.FriendId == fromUserInfo.UserID);
                    var hisFriend =
                        db.Friends.FirstOrDefault(x => x.FriendsListId == fromUserInfo.UserID && x.FriendId == toUser);

                    if (myFriend == null)
                    {
                        //if both of us dont have any relationship, return non friend
                        if (hisFriend == null)
                        {
                            fview.Type = FriendType.NoneFriend;
                        }
                        // if he got relation ship with me, but i have not accept > he's pending
                        else if (!hisFriend.FriendStatus)
                        {
                            fview.Type = FriendType.HisPendingFriend;
                        }
                    }
                    else
                    {
                        //if i got relationship, it's should be friend or my request is pending
                        fview.Type = myFriend.FriendStatus ? FriendType.Friend : FriendType.MyPendingFriend;
                    }
                    ViewData["FriendStatus"] = fview;
                }
                else
                {
                    ViewData["FriendStatus"] = null;
                }
            }
            // if we've gone this far, this username is not exist. return home
            else
            {
                return RedirectToAction("Newsfeed", "Home");
            }

            return View(user);
        }

        [HttpPost]
        public string ProcessFriendRequest(string friendId, string isAccept)
        {
            try
            {
                var hisFriend =
                    db.Friends.First(
                        x => x.FriendsListId.Equals(friendId, StringComparison.InvariantCultureIgnoreCase)
                        && x.FriendId == CurrentUserID);
                if (hisFriend != null)
                {
                    if (isAccept.Equals("1"))
                    {
                        var since = DateTime.UtcNow;

                        hisFriend.FriendStatus = true;
                        hisFriend.FriendSince = since;

                        var entry = db.Entry(hisFriend);
                        entry.Property(x => x.FriendStatus).IsModified = true;
                        entry.Property(x => x.FriendSince).IsModified = true;

                        var myFriend = new Friend
                        {
                            FriendsListId = CurrentUserID,
                            FriendStatus = true,
                            FriendId = friendId,
                            FriendSince = since
                        };
                        db.Friends.Add(myFriend);
                        db.SaveChanges();

                        PushNotification(friendId, CurrentUserName, (int)NotificationType.AcceptFriendRequest);
                    }
                    else
                    {
                        db.Friends.Remove(hisFriend);
                        db.SaveChanges();

                        PushNotification(friendId, CurrentUserName, (int)NotificationType.CancelFriendRequest);
                    }
                }
                else
                {
                    return ActionResults.Deleted.ToString();
                }

                //create sub hub context
                var hubContext = GlobalHost.ConnectionManager.GetHubContext<ChatHub>();

                var data = db.Friends.Where(x => x.FriendId == CurrentUserID && !x.FriendStatus).Select(item => new FriendViewModel
                {
                    FriendId = item.FriendsListId,
                    Name = item.FriendList.User.FirstName + " " + item.FriendList.User.LastName,
                    ProfileImgUrl = item.FriendList.User.Profile_Photo.ProfileImageUrl,
                    UserName = item.FriendList.User.UserName
                }).ToList();

                var html = RenderPartialViewToString("FriendRequest", data);
                hubContext.Clients.All.updateRequest(CurrentUserID, html);

                return ActionResults.Succeed.ToString();
            }
            catch (Exception exception)
            {
                Helper.WriteLog(exception);
                return ActionResults.Failed.ToString();
            }
        }

        [HttpPost]
        public string SeenNotification(string notificationId)
        {
            try
            {
                var notif = db.Notifications.FirstOrDefault(x => x.NotificationID == notificationId);
                if (notif == null || notif.UserID != CurrentUserID) return ActionResults.Deleted.ToString();

                notif.Seen = true;

                var entry = db.Entry(notif);
                entry.Property(x => x.Seen).IsModified = true;
                db.SaveChanges();
                return ActionResults.Succeed.ToString();
            }
            catch (Exception exception)
            {
                Helper.WriteLog(exception);
            }
            return ActionResults.Failed.ToString();
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

        public void UnFriend(string targetUserId)
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
            var since = DateTime.UtcNow;
            var curId = User.Identity.GetUserId();
            var myFriend = db.Friends.FirstOrDefault(x => x.FriendsListId == curId && x.FriendId == targetUserId);
            var hisFriend = db.Friends.FirstOrDefault(x => x.FriendsListId == targetUserId && x.FriendId == curId);

            var f = new Friend()
            {
                FriendsListId = curId,
                FriendId = targetUserId,
                FriendStatus = false
            };
            switch ((FriendType)type)
            {
                case FriendType.NoneFriend:
                    try
                    {
                        if (myFriend == null && hisFriend == null)
                        {
                            db.Friends.Add(f);
                            db.SaveChanges();
                            result = "Pending";
                        }
                        else
                        {
                            result = ActionResults.Failed.ToString();
                        }
                    }
                    catch (Exception exception)
                    {
                        Helper.WriteLog(exception);
                    }
                    break;
                case FriendType.HisPendingFriend:
                    try 
                    {
                        if (hisFriend != null && myFriend == null)
                        {
                            hisFriend.FriendStatus = true;
                            hisFriend.FriendSince = since;
                            f.FriendStatus = true;
                            f.FriendSince = since;
                            db.Friends.Add(f);
                            db.SaveChanges();
                            result = "Friend";
                        }
                        else
                        {
                            result = ActionResults.Failed.ToString();
                        }
                    }
                    catch (Exception exception)
                    {
                        Helper.WriteLog(exception);
                    }
                    break;

                case FriendType.MyPendingFriend:
                case FriendType.Friend:
                    try 
                    {
                        result = myFriend != null ? "Remove" : ActionResults.Failed.ToString();
                    }
                    catch (Exception exception)
                    {
                        Helper.WriteLog(exception);
                    }
                    break;
            }
            return result;
        }

        [HttpPost]
        public ActionResult UpdateInfo(FormCollection fc)
        {
            var lName = fc["lname"];
            var fName = fc["fname"];
            var work = fc["work"];
            var number = fc["number"];
            var about = fc["aboutme"];
            var id = fc["iduser"];
            var u = db.Users.FirstOrDefault(x => x.UserID == id);
            u.LastName = lName;
            u.FirstName = fName;
            u.Work = work;
            u.ContactNumber = number;
            u.About = about;
            db.SaveChanges();

            return RedirectToAction("Profile", new { username = u.UserName });
        }
    }
}