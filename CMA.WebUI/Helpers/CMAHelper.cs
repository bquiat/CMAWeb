using System;

namespace CMA.WebUI.Helpers
{
    public static class CMAHelper
    {
        public static string ReplaceWithFriendlyName(string input)
        {
            return input.Replace("Code1", "Code");
        }
    }
}
