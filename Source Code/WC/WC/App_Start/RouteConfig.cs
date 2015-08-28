using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace WC
{
    public class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");

            routes.MapRoute(
                "UserProfile",                                           // Route name
                "Profile/{username}",                            // URL with parameters
                new { controller = "Home", action = "Profile", username = UrlParameter.Optional }  // Parameter defaults
            );

            routes.MapRoute(
                "UserSetting",                                           // Route name
                "Settings",                            // URL with parameters
                new { controller = "Home", action = "Settings" }  // Parameter defaults
            );

            routes.MapRoute(
                "SignIn",                                           // Route name
                "LogIn",                            // URL with parameters
                new { controller = "Account", action = "LogIn" }  // Parameter defaults
            );

            routes.MapRoute(
                "SignUp",                                           // Route name
                "Register",                            // URL with parameters
                new { controller = "Account", action = "Register" }  // Parameter defaults
            );

            routes.MapRoute(
                "UserCalendar",                                           // Route name
                "Calendar",                            // URL with parameters
                new { controller = "Calendar", action = "Calendar" }  // Parameter defaults
            );

            routes.MapRoute(
                "ViewPost",                                           // Route name
                "Posts/{postid}",                            // URL with parameters
                new { controller = "Post", action = "ViewPost", postid = UrlParameter.Optional }  // Parameter defaults
            );
             
            routes.MapRoute(
                name: "Default",
                url: "{controller}/{action}/{id}",
                defaults: new { controller = "Home", action = "Newsfeed", id = UrlParameter.Optional }
            );
        }
    }
}
