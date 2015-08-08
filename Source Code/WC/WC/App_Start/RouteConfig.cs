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
                name: "Default",
                url: "{controller}/{action}/{id}",
                defaults: new { controller = "Home", action = "Newsfeed", id = UrlParameter.Optional }
            );

            routes.MapRoute(
                "Profile",                                           // Route name
                "{controller}/{action}/{username}",                            // URL with parameters
                new { controller = "Home", action = "Profile", username = UrlParameter.Optional }  // Parameter defaults
            );
        }
    }
}
