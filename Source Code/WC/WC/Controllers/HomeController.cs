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
            var posts = GetNewsfeed();

            var view = new NewsfeedViewModel
            {
                Id = CurrentUserID,
                Setting = setting,
                Posts = posts.ToList()
            };
            return View(view);
        }

        public ActionResult Hashtags(string hashtag)
        {
            ViewBag.Title = hashtag;
            var posts = GetHashTags(hashtag);

            return View(posts.ToList());
        }

        public ActionResult Profile(string username)
        {
            if (string.IsNullOrEmpty(username)) return RedirectToAction("Newsfeed", "Home");
            //fromUser: whose profile is being load
            //toUser: who request to view fromUser's profile
            var fromUser = UserManager.FindByName(username);
            if (fromUser == null) return RedirectToAction("Newsfeed", "Home");
            var fromUserInfo = db.Users.FirstOrDefault(x => x.UserID == fromUser.Id);
            var toUser = CurrentUserID;

            var postList = GetPosts(fromUser).Take(DefautValue.PostLoad).ToList();
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
                user.BirthDay = fromUserInfo.MySettings.First().ShowBirthday == (int)ShowBirthDay.Show
                    ? fromUserInfo.BirthDay.ToString(DateTimeFormat.DDMMYYYY)
                    : fromUserInfo.MySettings.First().ShowBirthday == (int)ShowBirthDay.HideYear
                        ? fromUserInfo.BirthDay.ToString(DateTimeFormat.DDMM)
                        : string.Empty;
                user.Gender = fromUserInfo.Gender;
                user.FriendCount = fromUserInfo.Friends.Count(x => x.FriendStatus);
                user.Posts = postList;
                user.Work = fromUserInfo.Work;
                user.ContactNumber = fromUserInfo.ContactNumber;
                user.Avatar = UrlImage("avatar", fromUserInfo.UserID);
                user.Cover = UrlImage("cover", fromUserInfo.UserID);
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
         
        public ActionResult Settings(ManageMessageId? message)
        {
            ViewBag.StatusMessage =
                message == ManageMessageId.ChangePasswordSuccess ? "Your password has been changed." : "";
            try
            {
                var currentUserInfo = db.Users.First(x => x.UserID == CurrentUserID);
                if (currentUserInfo == null)
                {
                    return RedirectToAction("Newsfeed");
                }
                else
                {
                    var setting = currentUserInfo.MySettings.First();
                    ViewBag.DisplayName = currentUserInfo.FirstName + " " + currentUserInfo.LastName;
                    ViewBag.AllowOthersPost = setting.AllowOtherToPost;
                    ViewBag.MyPost = setting.DefaultMyPostVisibility;
                    ViewBag.OthersPost = setting.DefaultOtherPostVisibility;
                    ViewBag.ShowBirthday = setting.ShowBirthday;
                    return View();
                }
            }
            catch (Exception exception)
            {
                Helper.WriteLog(exception);
            }
            return RedirectToAction("Newsfeed");
        }
        
        #region Post Methods
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
                        var hisUsername = db.Users.First(x => x.UserID == friendId).UserName;

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
                        PushNotification(CurrentUserID, hisUsername, (int)NotificationType.AcceptFriendRequest);
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
                    ProfileImgUrl = UrlImage("avatar", item.FriendsListId),
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
        
        [HttpPost]
        public ActionResult LoadMoreNewsfeed(int loadedPostCount)
        {
            var morePost = new MorePostViewModel();

            var posts = GetNewsfeed().ToList();
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
            if (morePost.NoMore)
            {
                morePost.Posts = "";
                return Json(morePost);
            }

            morePost.Posts = RenderPartialViewToString("PostListPartial", posts);

            return Json(morePost);
        }

        [HttpPost]
        public ActionResult LoadMoreHashtag(string hashtag, int loadedPostCount)
        {
            var morePost = new MorePostViewModel();

            var posts = GetHashTags(hashtag).ToList();
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
            if (morePost.NoMore)
            {
                morePost.Posts = "";
                return Json(morePost);
            }

            morePost.Posts = RenderPartialViewToString("PostListPartial", posts);

            return Json(morePost);
        }

        [HttpPost]
        public void UnFriend(string targetUserId)
        {
            var curId = User.Identity.GetUserId();
            var curFriend = db.Friends.FirstOrDefault(x => x.FriendsListId == curId && x.FriendId == targetUserId);
            if (curFriend != null)
            {
                db.Friends.Remove(curFriend);
            }

            var targetFriend = db.Friends.FirstOrDefault(x => x.FriendsListId == targetUserId && x.FriendId == curId);
            if (targetFriend != null)
            {
                db.Friends.Remove(targetFriend);
            }
            db.SaveChanges();
        }

        [HttpPost]
        public string FriendControl(string targetUserId, int type)
        {
            string result = "";
            var since = DateTime.UtcNow;
            var curId = CurrentUserID;
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
                            FriendToast(targetUserId);
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
            var address = fc["address"];
            var number = fc["number"];
            var about = fc["aboutme"];
            var id = fc["iduser"];
            var u = db.Users.FirstOrDefault(x => x.UserID == id);
            u.LastName = lName;
            u.FirstName = fName;
            u.Work = work;
            u.Address = address;
            u.ContactNumber = number;
            u.About = about;
            db.SaveChanges();

            return RedirectToAction("profile", new { username = u.UserName });
        }

        [HttpPost]
        public string AllowOtherPost(bool isAllow)
        {
            try
            {
                var setting =
                    db.MySettings.FirstOrDefault(
                        x => x.UserID.Equals(CurrentUserID, StringComparison.InvariantCultureIgnoreCase));

                if (setting == null)
                {
                    return ActionResults.Deleted.ToString();
                }
                else
                {
                    setting.AllowOtherToPost = isAllow;
                    db.SaveChanges();
                    return ActionResults.Succeed.ToString();
                }
            }
            catch (Exception exception)
            {
                Helper.WriteLog(exception);
                return ActionResults.Failed.ToString();
            }
        }

        [HttpPost]
        public string UpdateDefaultVisibleType(string name, int pk, string value)
        {
            try
            {
                var setting =
                    db.MySettings.FirstOrDefault(
                        x => x.UserID.Equals(CurrentUserID, StringComparison.InvariantCultureIgnoreCase));

                if (setting == null)
                {
                    return ActionResults.Deleted.ToString();
                }
                else
                {
                    if (name == "MyPost")
                    {
                        setting.DefaultMyPostVisibility = int.Parse(value);
                    }
                    else if (name == "OtherPost")
                    {
                        setting.DefaultOtherPostVisibility = int.Parse(value);
                    }
                    else
                    {
                        setting.ShowBirthday = int.Parse(value);
                    }
                    db.SaveChanges();
                    return ActionResults.Succeed.ToString();
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

        private void FriendToast(string receiverId)
        {
            try
            {
                var receiver =
                        db.Users.FirstOrDefault(x => x.UserID.Equals(receiverId, StringComparison.InvariantCultureIgnoreCase));
                var sender =
                        db.Users.FirstOrDefault(x => x.UserID.Equals(CurrentUserID, StringComparison.InvariantCultureIgnoreCase));
                if (sender != null && receiver != null)
                {
                    //create toast for notif
                    var toastUrl = Url.Action(sender.UserName, "profile");
                    var toastMessage = string.Format(NotificationMessage.NOTIF_ADD_FRIEND,
                        sender.FirstName + " " + sender.LastName, sender.Gender ? "his" : "her");

                    //create sub hub context
                    var hubContext = GlobalHost.ConnectionManager.GetHubContext<ChatHub>();

                    var data = db.Friends.Where(x => x.FriendId == receiver.UserID && !x.FriendStatus).ToList();
                    var friendRequest = new List<FriendViewModel>();

                    foreach (var item in data)
                    {
                        var requester = db.Users.First(x => x.UserID == item.FriendsListId);
                        var request = new FriendViewModel
                        {
                            FriendId = item.FriendsListId,
                            Name = requester.FirstName + " " + requester.LastName,
                            ProfileImgUrl = UrlImage("avatar", item.FriendsListId),
                            UserName = requester.UserName
                        };

                        friendRequest.Add(request);
                    }

                    var html = RenderPartialViewToString("FriendRequest", friendRequest);
                    hubContext.Clients.All.updateRequest(receiver.UserID, html);
                    hubContext.Clients.All.toastNotif(receiver.UserID, toastUrl, toastMessage);
                }
            }
            catch (Exception exception)
            {
                Helper.WriteLog(exception);
            }
        }

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
                    listView = db.Posts.Where(x => x.PostedOn == fromUser.Id)
                                        .Where(x => x.VisibleType == (int)VisibleType.Public
                                                || (x.VisibleType == (int)VisibleType.Friend
                                                    && x.User1.FriendLists.FirstOrDefault().Friends.Any(y => y.FriendId == CurrentUserID && y.FriendStatus))
                                                || (x.VisibleType == (int)VisibleType.Private
                                                    && x.UserID.Equals(CurrentUserID, StringComparison.InvariantCultureIgnoreCase)))
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

        private IEnumerable<Post> GetNewsfeed()
        {
            var listView = new List<Post>();
            try
            {
                var friends =
                    db.Friends.Where(
                        x => x.FriendsListId.Equals(CurrentUserID, StringComparison.InvariantCultureIgnoreCase)
                        && x.FriendStatus);

                foreach (var friend in friends)
                {
                    var temp = DateTime.UtcNow.AddDays(DefautValue.RecentNewsfeed);
                    var beginDay = new DateTime(temp.Year, temp.Month, temp.Day);

                    listView.AddRange(
                        friend.User.Posts.Where(
                            x => x.PostedDate.Date >= beginDay
                                 && (x.VisibleType == (int)VisibleType.Public
                                                || (x.VisibleType == (int)VisibleType.Friend
                                                    && x.User1.FriendLists.FirstOrDefault().Friends.Any(y => y.FriendId == CurrentUserID && y.FriendStatus))
                                                || (x.VisibleType == (int)VisibleType.Private
                                                    && x.UserID.Equals(CurrentUserID, StringComparison.InvariantCultureIgnoreCase)))));
                }

                listView.AddRange(db.Posts.Where(x => x.UserID.Equals(CurrentUserID, StringComparison.InvariantCultureIgnoreCase)));

                return listView.OrderByDescending(x => x.PostedDate);
            }
            catch (Exception exception)
            {
                Helper.WriteLog(exception);
            }
            return listView;
        }

        private IEnumerable<Post> GetHashTags(string hashtag)
        {
            var listView = new List<Post>();
            try
            {
                var temp = DateTime.UtcNow.AddDays(DefautValue.RecentNewsfeed);

                var beginDay = new DateTime(temp.Year, temp.Month, temp.Day);

                listView.AddRange(
                    db.Posts.Where(x => x.PostedDate >= beginDay
                                    && (x.VisibleType == (int)VisibleType.Public
                                                || (x.VisibleType == (int)VisibleType.Friend
                                                    && x.User1.FriendLists.FirstOrDefault().Friends.Any(y => y.FriendId == CurrentUserID && y.FriendStatus))
                                                || (x.VisibleType == (int)VisibleType.Private
                                                    && x.UserID.Equals(CurrentUserID, StringComparison.InvariantCultureIgnoreCase)))));

                listView.AddRange(db.Posts.Where(x => x.UserID.Equals(CurrentUserID, StringComparison.InvariantCultureIgnoreCase)
                                                        || x.PostedOn.Equals(CurrentUserID, StringComparison.InvariantCultureIgnoreCase)));
                listView = listView.Distinct().Where(x => x.PostContent.ToLower().Contains("#" + hashtag.ToLower())).ToList();

                return listView.Take(100).OrderByDescending(x => x.PostedDate);
            }
            catch (Exception exception)
            {
                Helper.WriteLog(exception);
            }
            return listView;
        }
        #endregion
    }
}