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
                "profile/{username}",                            // URL with parameters
                new { controller = "Home", action = "Profile", username = UrlParameter.Optional }  // Parameter defaults
            );

            routes.MapRoute(
                "Hashtags",                                           // Route name
                "hashtag/{hashtag}",                            // URL with parameters
                new { controller = "Home", action = "Hashtags", hashtag = UrlParameter.Optional }  // Parameter defaults
            );

            routes.MapRoute(
                "UserAlbum",                                           // Route name
                "Photos/{username}",                            // URL with parameters
                new { controller = "Album", action = "Photos", username = UrlParameter.Optional }  // Parameter defaults
            );

            routes.MapRoute(
                "EditPhoto",                                           // Route name
                "Editor/{photoID}",                            // URL with parameters
                new { controller = "Album", action = "Editor", username = UrlParameter.Optional }  // Parameter defaults
            );

            routes.MapRoute(
                "UserSetting",                                           // Route name
                "settings",                            // URL with parameters
                new { controller = "Home", action = "Settings" }  // Parameter defaults
            );

            routes.MapRoute(
                "SignIn",                                           // Route name
                "Login",                            // URL with parameters
                new { controller = "Account", action = "LogIn" }  // Parameter defaults
            );

            routes.MapRoute(
                "SignUp",                                           // Route name
                "Register",                            // URL with parameters
                new { controller = "Account", action = "Register" }  // Parameter defaults
            );

            routes.MapRoute(
                "UserCalendar",                                           // Route name
                "calendar",                            // URL with parameters
                new { controller = "Calendar", action = "Calendar" }  // Parameter defaults
            );

            routes.MapRoute(
                "ViewPost",                                           // Route name
                "posts/{postid}",                            // URL with parameters
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
