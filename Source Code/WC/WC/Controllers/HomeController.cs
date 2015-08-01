using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace WC.Controllers
{
    public class HomeController : Controller
    {
        // GET: Home
        public ActionResult NewsFeed()
        {
            return View();
        }

        public ActionResult Profile(string id)
        {
            if (string.IsNullOrEmpty(id)) ViewBag.id = id;
            return View();
        }

        public ActionResult Login()
        {
            return View();
        }

        public ActionResult Register()
        {
            return View();
        }

        public ActionResult Forgot()
        {
            return View();
        }
    }
}