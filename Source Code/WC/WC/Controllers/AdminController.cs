using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WC.Constants;
using WC.Data;
using WC.Models;
using WC.Utils;

namespace WC.Controllers
{
    [Authorize]
    public class AdminController : AccountController
    {
        //
        // GET: /Admin/
        public ActionResult Index()
        {
            var isAdmin = db.Roles.Any(x => x.UserID == CurrentUserID);
            if (!isAdmin) return RedirectToAction("Newsfeed", "Home");
            var statictisModel = new StatictisViewModel
            {
                Users = db.Users.Count(),
                Posts = db.Posts.Count(),
                Likes = db.CommentLikes.Count() + db.PostLikes.Count(),
                Reports = db.Reports.Count()
            };

            var beginDate = DateTime.UtcNow.Date.AddDays(-6);
            var endDate = DateTime.UtcNow.Date;

            var statictises = new List<Statictis>();

            for (var temp = beginDate; temp.Ticks <= endDate.Ticks; temp = temp.AddDays(1))
            {
                var beginDay = new DateTime(temp.Year, temp.Month, temp.Day);
                var endDay = beginDay.AddDays(1);
                var statictis = new Statictis
                {
                    RegisteredDate = temp,
                    Count = db.Users.Count(x => beginDay <= x.RegisteredDate && x.RegisteredDate < endDay)
                };
                statictises.Add(statictis);
            }

            statictisModel.Statictis = statictises;



            return View(statictisModel);
        }

        public ActionResult Administrators()
        {
            var isSuperAdmin = db.Roles.Any(x => x.UserID == CurrentUserID && x.RoleType == (int)RoleType.SuperAdmin);
            if (!isSuperAdmin) return RedirectToAction("Newsfeed", "Home");
            var roles = db.Roles.Where(x => x.RoleType != (int)RoleType.SuperAdmin).ToList();
            var admins = new List<FriendViewModel>();

            foreach (var role in roles)
            {
                var user = db.Users.FirstOrDefault(x => x.UserID == role.UserID);
                if (user == null) continue;                
                var admin = new FriendViewModel
                {
                    FriendId = user.UserID,
                    Name = user.FirstName + " " + user.LastName,
                    ProfileImgUrl = UrlImage("avatar", user.UserID),
                    UserName = user.UserName
                };
                admins.Add(admin);
            }
            return View(admins);
        }

        [HttpPost]
        public string RemoveAdmin(string userId)
        {
            try
            {
                var isAuthorize = db.Roles.Any(x => x.UserID == CurrentUserID && x.RoleType == (int)RoleType.SuperAdmin);
                if (!isAuthorize)
                {
                    return ActionResults.Failed.ToString();
                }
                var admin =
                    db.Roles.FirstOrDefault(x => x.UserID.Equals(userId, StringComparison.InvariantCultureIgnoreCase) && x.RoleType != (int)RoleType.SuperAdmin);
                if (admin == null)
                {
                    return ActionResults.Deleted.ToString();
                }
                db.Roles.Remove(admin);
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
        public string GetInfo(string username)
        {
            try
            {
                var user =
                    db.Users.FirstOrDefault(
                        x => x.UserName.Equals(username, StringComparison.InvariantCultureIgnoreCase));
                //alert if username is not existed
                if (user == null)
                {
                    return ActionResults.Deleted.ToString();
                }
                //if user is already admin, do not thing
                var isAlreadyGrant =
                    db.Roles.Any(x => x.UserID.Equals(user.UserID, StringComparison.InvariantCultureIgnoreCase));
                if (isAlreadyGrant)
                {
                    return ActionResults.AlreadyDone.ToString();
                }

                var listView = new List<FriendViewModel>();
                var view = new FriendViewModel();
                view.FriendId = user.UserID;
                view.Name = user.FirstName + " " + user.LastName;
                view.ProfileImgUrl = UrlImage("avatar", user.UserID);
                view.UserName = user.UserName;

                listView.Add(view);

                var str = RenderPartialViewToString("AdminInfo", listView);

                return str;
            }
            catch (Exception exception)
            {
                Helper.WriteLog(exception);
            }
            return ActionResults.Failed.ToString();
        }

        [HttpPost]
        public string AddAdmin(string username)
        {
            try
            {
                var user =
                    db.Users.FirstOrDefault(
                        x => x.UserName.Equals(username, StringComparison.InvariantCultureIgnoreCase));
                //alert if username is not existed
                if (user == null)
                {
                    return ActionResults.Deleted.ToString();
                }
                //stop if user is not authorize as super admin
                var isAuthorize = db.Roles.Any(x => x.UserID == CurrentUserID && x.RoleType == (int)RoleType.SuperAdmin);
                if (!isAuthorize)
                {
                    return ActionResults.Failed.ToString();
                }
                //if user is already admin, do not thing
                var isAlreadyGrant =
                    db.Roles.Any(x => x.UserID.Equals(user.UserID, StringComparison.InvariantCultureIgnoreCase));
                if (isAlreadyGrant)
                {
                    return ActionResults.AlreadyDone.ToString();
                }
                // otherwise, grant permission
                var role = new Role
                {
                    UserID = user.UserID,
                    RoleType = (int) RoleType.Admin,
                    AssignedBy = CurrentUserID,
                    AssignedDate = DateTime.UtcNow
                };
                db.Roles.Add(role);
                db.SaveChanges();


                var listView = new List<FriendViewModel>();
                var view = new FriendViewModel();
                view.FriendId = user.UserID;
                view.Name = user.FirstName + " " + user.LastName;
                view.ProfileImgUrl = UrlImage("avatar", user.UserID);
                view.UserName = user.UserName;

                listView.Add(view);

                var str = RenderPartialViewToString("AdministratorPartial", listView);

                return str;
            }
            catch (Exception exception)
            {
                Helper.WriteLog(exception);
            }
            return ActionResults.Failed.ToString();
        }

        [ChildActionOnly]
        public ActionResult AdministratorPartial(List<FriendViewModel> Model)
        {
            return PartialView(Model);
        }
	}
}