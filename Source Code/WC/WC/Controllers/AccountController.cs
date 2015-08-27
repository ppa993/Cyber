using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using Microsoft.AspNet.SignalR;
using Microsoft.Owin.Security;
using WC.Constants;
using WC.Data;
using WC.Hubs;
using WC.Models;
using WC.Utils;

namespace WC.Controllers
{
    [System.Web.Mvc.Authorize]
    public class AccountController : BaseController
    {
        public AccountController()
            : this(new UserManager<ApplicationUser>(new UserStore<ApplicationUser>(new ApplicationDbContext())))
        {
        }

        public AccountController(UserManager<ApplicationUser> userManager)
        {
            UserManager = userManager;
        }

        public UserManager<ApplicationUser> UserManager { get; private set; }

        //
        // GET: /Account/Login
        [AllowAnonymous]
        public ActionResult Login(string returnUrl)
        {
            ViewBag.ReturnUrl = returnUrl;
            return View();
        }

        //
        // POST: /Account/Login
        [HttpPost]
        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Login(LoginViewModel model, string returnUrl)
        {
            if (ModelState.IsValid)
            {
                var user = await UserManager.FindAsync(model.UserName, model.Password);
                if (user != null)
                {
                    await SignInAsync(user, model.RememberMe);
                    return RedirectToLocal(returnUrl);
                    //return RedirectToAction("Newsfeed","Home");
                }
                else
                {
                    ModelState.AddModelError("", "Invalid username or password.");
                }
            }

            // If we got this far, something failed, redisplay form
            return View(model);
        }

        //
        // GET: /Account/Register
        [AllowAnonymous]
        public ActionResult Register()
        {
            return View();
        }

        //
        // POST: /Account/Register
        [HttpPost]
        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Register(RegisterViewModel model)
        {
            var birthdayString = string.Format("{0}/{1}/{2}", model.Day, model.Month, model.Year);
            DateTime birthday;
            var parseResult = DateTime.TryParseExact(birthdayString, DateTimeFormat.DMYYYY, CultureInfo.InvariantCulture, DateTimeStyles.None,
                out birthday);

            if (parseResult && ModelState.IsValid)
            {
                var user = new ApplicationUser { UserName = model.UserName };
                var result = await UserManager.CreateAsync(user, model.Password);
                if (result.Succeeded)
                {
                    var userInfo = new User
                    {
                        UserID = user.Id,
                        Email = model.Email,
                        FirstName = model.Firstname,
                        LastName = model.Lastname,
                        UserName = model.UserName,
                        BirthDay = birthday,
                        Gender = model.Gender,
                        Relationship = (int)Relationship.Single
                    };
                    db.Users.Add(userInfo);
                    db.SaveChanges();

                    var photo = new Profile_Photo
                    {
                        UserID = userInfo.UserID,
                        ProfileImageUrl = userInfo.Gender ? Common.MALE_AVATAR : Common.FEMALE_AVATAR
                    };
                    db.Profile_Photo.Add(photo);

                    var friendList = new FriendList
                    {
                        Id = user.Id,
                        UserId = user.Id,
                        CreatedDate = DateTime.UtcNow
                    };
                    db.FriendLists.Add(friendList);

                    var mySetting = new MySetting
                    {
                        SettingID = Guid.NewGuid().ToString(),
                        UserID = user.Id,
                        AllowOtherToPost = true,
                        DefaultMyPostVisibility = (int)VisibleType.Friend,
                        DefaultOtherPostVisibility = (int)VisibleType.Friend,
                        ShowBirthday = (int)ShowBirthDay.Show
                    };
                    db.MySettings.Add(mySetting);

                    //Init default album avatar and cover
                    db.Albums.AddRange(DefaultAlbum(user.Id));
                    //Init default image
                    db.AlbumDetails.AddRange(DefaultImage(user.Id, userInfo.Gender));

                    db.SaveChanges();

                    await SignInAsync(user, isPersistent: false);
                    return RedirectToAction("Newsfeed", "Home");
                }
                else
                {
                    AddErrors(result);
                }
            }
            else
            {
                ModelState.AddModelError("", Message.INVALID_BIRTHDAY);
            }


            // If we got this far, something failed, redisplay form
            return View(model);
        }

        //
        // GET: /Account/Manage
        public ActionResult Manage(ManageMessageId? message)
        {
            ViewBag.StatusMessage =
                message == ManageMessageId.ChangePasswordSuccess ? "Your password has been changed."
                : message == ManageMessageId.SetPasswordSuccess ? "Your password has been set."
                : message == ManageMessageId.RemoveLoginSuccess ? "The external login was removed."
                : message == ManageMessageId.Error ? "An error has occurred."
                : "";
            ViewBag.HasLocalPassword = HasPassword();
            ViewBag.ReturnUrl = Url.Action("Settings", "");
            return View();
        }

        //
        // POST: /Account/Manage
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Manage(ManageUserViewModel model)
        {
            bool hasPassword = HasPassword();
            ViewBag.HasLocalPassword = hasPassword;
            ViewBag.ReturnUrl = Url.Action("Settings","");
            if (hasPassword)
            {
                if (ModelState.IsValid)
                {
                    IdentityResult result = await UserManager.ChangePasswordAsync(User.Identity.GetUserId(), model.OldPassword, model.NewPassword);
                    if (result.Succeeded)
                    {
                        return RedirectToAction("Settings", "", new { Message = ManageMessageId.ChangePasswordSuccess });
                    }
                    else
                    {
                        AddErrors(result);
                    }
                }
            }
            else
            {
                // User does not have a password so remove any validation errors caused by a missing OldPassword field
                ModelState state = ModelState["OldPassword"];
                if (state != null)
                {
                    state.Errors.Clear();
                }

                if (ModelState.IsValid)
                {
                    IdentityResult result = await UserManager.AddPasswordAsync(User.Identity.GetUserId(), model.NewPassword);
                    if (result.Succeeded)
                    {
                        return RedirectToAction("Settings", "", new { Message = ManageMessageId.SetPasswordSuccess });
                    }
                    else
                    {
                        AddErrors(result);
                    }
                }
            }

            // If we got this far, something failed, redisplay form
            return View(model);
        }
        
        //
        // POST: /Account/LogOff
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult LogOff()
        {
            AuthenticationManager.SignOut();
            return RedirectToAction("Login", "Account");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing && UserManager != null)
            {
                UserManager.Dispose();
                UserManager = null;
            }
            base.Dispose(disposing);
        }

        public string CurrentUserID
        {
            get { return User.Identity.GetUserId(); }
        }

        public string CurrentUserName
        {
            get { return User.Identity.Name; }
        }

        public void PushNotification(string receiver, string itemId, int notifType)
        {
            try
            {
                var byUserId = CurrentUserID;
                var byUser = db.Users.First(x => x.UserID == byUserId);
                var displayName = string.Format("{0} {1}", byUser.FirstName, byUser.LastName);
                string notifContent;

                switch ((NotificationType)notifType)
                {
                    case NotificationType.Post:
                        notifContent = string.Format(NotificationMessage.NOTIF_POST, displayName);
                        break;
                    case NotificationType.CommentMyPost:
                        notifContent = string.Format(NotificationMessage.NOTIF_COMMENT_MY_POST, displayName);
                        break;
                    case NotificationType.CommentOthers:
                        notifContent = string.Format(NotificationMessage.NOTIF_COMMENT_OTHER, displayName,
                            byUser.Gender ? "his" : "her");
                        break;
                    case NotificationType.LikeMyPost:
                        notifContent = string.Format(NotificationMessage.NOTIF_LIKE_MY_POST, displayName);
                        break;
                    case NotificationType.LikeMyComment:
                        notifContent = string.Format(NotificationMessage.NOTIF_LIKE_MY_COMMENT, displayName);
                        break;
                    case NotificationType.AcceptFriendRequest:
                        notifContent = string.Format(NotificationMessage.NOTIF_ACCEPT_REQUEST, displayName);
                        break;
                    default:
                        notifContent = string.Format(NotificationMessage.NOTIF_CANCEL_REQUEST, displayName);
                        break;
                }


                var notif = new Notification
                {
                    NotificationID = Guid.NewGuid().ToString().Replace("-", string.Empty),
                    UserID = receiver,
                    NotificationType = notifType,
                    NotificationContent = notifContent,
                    NotificationItemID = itemId,
                    NotificationDate = DateTime.UtcNow,
                    Seen = false
                };

                db.Notifications.Add(notif);
                db.SaveChanges();

                //create toast for notif
                var toastLinkAction = (NotificationType)notifType == NotificationType.AcceptFriendRequest
                                      || (NotificationType)notifType == NotificationType.CancelFriendRequest
                    ? "Profile"
                    : "Posts";
                var toastUrl = Url.Action(itemId, toastLinkAction);
                var toastMessage = notifContent;


                //create sub hub context
                var hubContext = GlobalHost.ConnectionManager.GetHubContext<ChatHub>();
                var data =
                    db.Notifications.Where(x => x.UserID == receiver && !x.Seen)
                        .OrderByDescending(y => y.NotificationDate)
                        .ToList();
                var html = RenderPartialViewToString("NotificationPartial", data);
                hubContext.Clients.All.recieveNotify(receiver, html);
                hubContext.Clients.All.toastNotif(receiver, toastUrl, toastMessage);
            }
            catch (Exception exception)
            {
                Helper.WriteLog(exception);
            }
        }

        #region Helpers
        // Used for XSRF protection when adding external logins
        private const string XsrfKey = "XsrfId";

        private IAuthenticationManager AuthenticationManager
        {
            get
            {
                return HttpContext.GetOwinContext().Authentication;
            }
        }

        private async Task SignInAsync(ApplicationUser user, bool isPersistent)
        {
            AuthenticationManager.SignOut(DefaultAuthenticationTypes.ExternalCookie);
            var identity = await UserManager.CreateIdentityAsync(user, DefaultAuthenticationTypes.ApplicationCookie);
            AuthenticationManager.SignIn(new AuthenticationProperties() { IsPersistent = isPersistent }, identity);
        }

        private void AddErrors(IdentityResult result)
        {
            foreach (var error in result.Errors)
            {
                ModelState.AddModelError("", error);
            }
        }

        private bool HasPassword()
        {
            var user = UserManager.FindById(User.Identity.GetUserId());
            if (user != null)
            {
                return user.PasswordHash != null;
            }
            return false;
        }

        public enum ManageMessageId
        {
            ChangePasswordSuccess,
            SetPasswordSuccess,
            RemoveLoginSuccess,
            Error
        }

        private ActionResult RedirectToLocal(string returnUrl)
        {
            if (Url.IsLocalUrl(returnUrl))
            {
                return Redirect(returnUrl);
            }
            else
            {
                return RedirectToAction("Newsfeed", "Home");
            }
        }

        private class ChallengeResult : HttpUnauthorizedResult
        {
            public ChallengeResult(string provider, string redirectUri)
                : this(provider, redirectUri, null)
            {
            }

            public ChallengeResult(string provider, string redirectUri, string userId)
            {
                LoginProvider = provider;
                RedirectUri = redirectUri;
                UserId = userId;
            }

            public string LoginProvider { get; set; }
            public string RedirectUri { get; set; }
            public string UserId { get; set; }

            public override void ExecuteResult(ControllerContext context)
            {
                var properties = new AuthenticationProperties() { RedirectUri = RedirectUri };
                if (UserId != null)
                {
                    properties.Dictionary[XsrfKey] = UserId;
                }
                context.HttpContext.GetOwinContext().Authentication.Challenge(properties, LoginProvider);
            }
        }
        #endregion
    }
}