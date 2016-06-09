using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace CMA.WebUI
{
    public class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");
            routes.MapRoute(
                name: "ManageLists",
                url: "{controller}/{action}/{id}",
                defaults: new { controller = "Manage", action = "Home", id = UrlParameter.Optional }
            );
        }
    }
}
