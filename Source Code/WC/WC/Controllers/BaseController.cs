using System.Collections.Generic;
using System.IO;
using System.Web.Mvc;
using WC.Data;
using WC.Models;
using System.Linq;

namespace WC.Controllers
{
    public class BaseController : Controller
    {
        public CyberEntities db = new CyberEntities();

        public List<FriendViewModel> GetListFriendsOf(string userId)
        {
            var query = from fl in db.FriendLists
                        from f in db.Friends
                        from u in db.Users
                        from pp in db.Profile_Photo
                        where fl.Id == f.FriendsListId
                        && f.FriendId==u.UserID
                        && u.UserID==pp.UserID
                        select new FriendViewModel()
                        {
                            FriendId = f.FriendId,
                            Name = u.FirstName + " " + u.LastName,
                            ProfileImgUrl=pp.ProfileImageUrl
                        };
            return query.ToList();
        }

        public string GetHtmlListFriendsOf(string userId)
        {
            string html = "";
            html+= RenderPartialViewToString("FriendListPartial", GetListFriendsOf(userId));
            return html;
        }

        //[HttpPost]
        //public string Register(string firstName, string lastName,string username, 
        //    string password, string email, string birthDay, string gender)
        //{
        //    var DOB = DateTime.Parse(birthDay);

        //    const string emailpattern = @"\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*";
        //    if (!Regex.IsMatch(email.Trim(), emailpattern))
        //    {
        //        return Message.INVALID_EMAIL;
        //    }

        //    if (db.Memberships.Any(x => x.Username.Equals(username)))
        //    {
        //        return Message.EXISTED_USERNAME;
        //    }

        //    if (db.Memberships.Any(x => x.Email.Equals(email)))
        //    {
        //        return Message.EXISTED_EMAIL;
        //    }

        //    try
        //    {
        //        var encryptedPass = Helper.GetSHA1HashData(password);

        //        var membership = new Membership
        //                    {
        //                        UserID = Guid.NewGuid().ToString().Replace("-",""),
        //                        Username = username,
        //                        Email = email,
        //                        Password = encryptedPass,
        //                        Status = true,
        //                        CreatedDate = DateTime.Now,
        //                        LastTimeLogIn = DateTime.Now
        //                    };

        //        db.Memberships.Add(membership);

        //        var user = new User
        //        {
        //            UserID = membership.UserID,
        //            BirthDay = DOB,
        //            FirstName = firstName,
        //            LastName = lastName,
        //            Gender = gender.Equals("1"),
        //            RelationshipID = (int)Relationship.Single
        //        };

        //        db.Users.Add(user);
        //        db.SaveChanges();
        //        return Message.REGISTERED_SUCCESSFULLY;
        //    }
        //    catch (Exception exception)
        //    {
        //        Helper.WriteLog(exception);
        //    }

        //    return Message.REGISTER_FAILED;
        //}

        //[HttpPost]
        //public string LogIn(string username, string password)
        //{
        //    var encryptedPassword = Helper.GetSHA1HashData(password);
        //    var user = db.Memberships
        //        .FirstOrDefault(x => (x.Username == username || x.Email == username) && x.Password == encryptedPassword);

        //    if (user != null)
        //    {
        //        Session[Common.SESSION_USER] = user;
        //    }
        //    return user != null ? LogInResult.Successfully.ToString() : LogInResult.Failed.ToString();
        //}

        //[HttpPost]
        //public void LogOut()
        //{
        //    Session[Common.SESSION_USER] = null;
        //}

        //public bool IsLoggedIn()
        //{
        //    return Session[Common.SESSION_USER] != null;
        //}


        protected string RenderPartialViewToString(string viewName, object model)
        {
            if (string.IsNullOrEmpty(viewName))
                viewName = ControllerContext.RouteData.GetRequiredString("action");

            ViewData.Model = model;

            using (var sw = new StringWriter())
            {
                var viewResult =
                    ViewEngines.Engines.FindPartialView(ControllerContext, viewName);
                var viewContext = new ViewContext
                    (ControllerContext, viewResult.View, ViewData, TempData, sw);
                viewResult.View.Render(viewContext, sw);

                return sw.GetStringBuilder().ToString();
            }
        }
    }
}