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
        public ActionResult Index(string id)
        {
            if (id != null || id != "") ViewBag.id = id;
            return View();
        }

        public ActionResult Wall()
        { 
            return View();
        }
    }
}