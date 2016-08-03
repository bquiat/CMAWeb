using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;
using CMA.WebUI.Models;

namespace CMA.WebUI.ActionFilters
{
    public class RequiresUserRolesAttribute : ActionFilterAttribute
    {
        public string minimumRoleLevel { get; set; }

        public override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            if (!filterContext.HttpContext.Response.IsRequestBeingRedirected)
                if (minimumRoleLevel != null && minimumRoleLevel.Length != 0)
                    if (!filterContext.HttpContext.User.Identity.IsAuthenticated || filterContext.HttpContext.User.Identity.Name.Length == 0)
                    {
                        filterContext.HttpContext.Response.Redirect("/Account/LogOn", true);
                    }
        }

        public override void OnActionExecuted(ActionExecutedContext filterContext)
        {
            if (!filterContext.HttpContext.Response.IsRequestBeingRedirected)
                if (minimumRoleLevel != null && minimumRoleLevel.Length != 0)
                    if (!filterContext.HttpContext.User.Identity.IsAuthenticated || filterContext.HttpContext.User.Identity.Name.Length == 0)
                    {
                        filterContext.HttpContext.Response.Redirect("/Account/LogOn", true);
                    }
                    else
                    {
                        bool IsUserInRole = filterContext.HttpContext.User.IsInRole(minimumRoleLevel);
                        CMADataContext dataContext = new CMADataContext();
                        var loggedInUserRole = (from a in dataContext.USER_s
                                                join b in dataContext.USERACCs on a.User_ID equals b.User_
                                              where a.User_ID == filterContext.HttpContext.User.Identity.Name
                                              select b.Access).FirstOrDefault();

                        if (loggedInUserRole!= null && loggedInUserRole.HasValue)                        
                            if (loggedInUserRole.Value.ToString().Equals (minimumRoleLevel))
                                IsUserInRole = true;

                        if (!IsUserInRole)
                        {
                            UrlHelper _uHelp = new UrlHelper(filterContext.RequestContext);
                            string redirectURL = _uHelp.Action("AccessRestricted", "Home", null);
                            filterContext.HttpContext.Response.Redirect(redirectURL, true);
                        }
                    }            


        }
    }
}