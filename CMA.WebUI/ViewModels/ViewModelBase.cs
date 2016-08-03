using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml;
using CMA.WebUI.Models;

namespace CMA.WebUI.ViewModels
{
    public class ViewModelBase : IDisposable
    {
        
        public List<USER_> userList;
        public List<USERACC> userAccList;

        public USER_ loggedOnUser;
        public USERACC loggedOnUserRole;
        //public List<aspnet_Role> userRoles;
        //public List<aspnet_UsersInRole> userInRoleList;
        public void Dispose()
        {
            GC.SuppressFinalize(this);
        }
    }
    public class LogOnModel
    {
        
        public string UserName { get; set; }
        public string Password { get; set; }
        public bool RememberMe { get; set; }
    }
    
}