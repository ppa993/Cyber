using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace WC.Controllers
{
    public class AccountController : BaseController
    {

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