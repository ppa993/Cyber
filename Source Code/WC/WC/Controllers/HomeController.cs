using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Microsoft.AspNet.Identity;
using WC.Data;
using WC.Models;

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
            var user = new ProfileViewModel();

            if (userInfo != null)
            {
                user.About = userInfo.About;
                user.DisplayName = userInfo.FirstName + " " + userInfo.LastName;
                user.Address = userInfo.Address;
                user.Email = userInfo.Email;
            }
            return View(user);
        }

    }
}