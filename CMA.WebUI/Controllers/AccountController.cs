﻿using System;
using System.Collections.Generic;
using System.Diagnostics.CodeAnalysis;
using System.Linq;
using System.Security.Principal;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;
using System.Web.Security;
using CMA.WebUI.Models;
using CMA.WebUI.ActionFilters;

namespace CMA.WebUI.Controllers
{

    [HandleError]
    public class AccountController : Controller
    {   
        ViewModels.ViewModelBase viewModel;
        public IFormsAuthenticationService FormsService { get; set; }
        public IMembershipService MembershipService { get; set; }
        protected override void Initialize(RequestContext requestContext)
        {
            if (FormsService == null) { FormsService = new FormsAuthenticationService(); }
            if (MembershipService == null) { MembershipService = new AccountMembershipService(); }
            viewModel = new ViewModels.ViewModelBase();

            if (requestContext.HttpContext.User.Identity.IsAuthenticated)
            {
                CMADataContext dataContext = new CMADataContext();

                viewModel.loggedOnUser = (from u in dataContext.USER_s
                                          where u.User_ID == System.Web.HttpContext.Current.User.Identity.Name
                                          select u).FirstOrDefault();

                viewModel.loggedOnUserRole = (from a in dataContext.USERACCs
                                              join b in dataContext.USER_s on a.User_ equals b.User_ID
                                              where b.User_ID == System.Web.HttpContext.Current.User.Identity.Name
                                              select a).FirstOrDefault();
                dataContext.Dispose();
            }
            else
                RedirectToAction("LogOn", "Account");

            base.Initialize(requestContext);

        }
        
        public ActionResult LogOn()
        {
            //ViewModels.ViewModelBase viewModel = new ViewModels.ViewModelBase();
            return View();
        }

        [HttpPost]
        public ActionResult LogOn(ViewModels.LogOnModel model, string returnUrl)
        {
            if (ModelState.IsValid)
            {
                string userName = Request.Form["txtUsername"] != null ? Request.Form["txtUsername"].ToString() : string.Empty;
                string password = Request.Form["txtPassword"] != null ? Request.Form["txtPassword"].ToString() : string.Empty;

                if (ValidateUser(userName,password))
                {   
                    FormsService.SignIn(userName, false);
                    if (!String.IsNullOrEmpty(returnUrl))
                    {
                        return Redirect(returnUrl);
                    }
                    else
                    {
                        Response.Redirect("/Manage/Home", true);
                    }
                }
                else
                {
                    ViewData["ErrorMessage"]= "The user name or password provided is incorrect.";
                }
            }
            // If we got this far, something failed, redisplay form
            return View(model);
        }

        public bool ValidateUser(string userName, string Password)
        {
            bool isValid = false;
            if (!string.IsNullOrEmpty(userName) && !string.IsNullOrEmpty(Password))
            {
                CMADataContext dataContext = new CMADataContext();
                var user = dataContext.USER_s.Where(_ => _.User_ID == userName && _.IsActive.HasValue && _.IsActive.Value == 1).FirstOrDefault();
                if (user != null && !string.IsNullOrEmpty(user.Password_) && string.Equals(user.Password_, Password, StringComparison.CurrentCulture))
                {
                    List<string> EpisodeIds = new List<string>();
                    if (!string.IsNullOrEmpty(user.Episode1))
                        EpisodeIds.Add(user.Episode1);
                    if (!string.IsNullOrEmpty(user.Episode2))
                        EpisodeIds.Add(user.Episode2);
                    if (!string.IsNullOrEmpty(user.Episode3))
                        EpisodeIds.Add(user.Episode3);
                    if (!string.IsNullOrEmpty(user.Episode4))
                        EpisodeIds.Add(user.Episode4);
                    if (!string.IsNullOrEmpty(user.Episode5))
                        EpisodeIds.Add(user.Episode5);

                    if (EpisodeIds.Any() && EpisodeIds.Count > 0)
                    {
                        var episodes = dataContext.Episodes.Where(e => EpisodeIds.Contains(e.EpisodeID)).ToList();
                        if (episodes!=null && episodes.Any())
                        {
                            List<string> NamesIds = new List<string>();
                            foreach (var episode in episodes.Distinct())
                                NamesIds.Add(episode.NameID);

                            if (NamesIds!=null && NamesIds.Count > 0)
                            {
                                var names = dataContext.Namezs.Where(n => NamesIds.Contains(n.NameID)).ToList();
                                if (names!=null && names.Any())
                                {
                                    Session["AuthUserID"] = user.User_ID;
                                    Session["AuthNameID"] = names.FirstOrDefault().Names_ID;
                                }
                            }
                        }
                    }
                    isValid = true;
                }

                dataContext.Dispose();
            }

            return isValid;
        }
        public ActionResult LogOff()
        {
            FormsService.SignOut();
            Session["AuthUserID"] = Session["AuthNameID"] = null;
            Response.Redirect("/Account/LogOn", true);
            return null;
        }
    }
}
