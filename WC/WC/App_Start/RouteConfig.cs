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

            routes.MapRoute
            (
                name: "Id route",
                url: "{id}",
                defaults: new
                { 
                    controller = "Home",
                    action = "Wall",
                    id = UrlParameter.Optional
                });

            routes.MapRoute(
                name: "Basic",
                url: "{controller}/{action}/{id}",
                defaults: new { controller = "Home" , id = UrlParameter.Optional }
            );
        }
    }
}
