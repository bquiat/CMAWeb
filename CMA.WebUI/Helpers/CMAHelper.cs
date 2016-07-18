using System;
using System.Text.RegularExpressions;
namespace CMA.WebUI.Helpers
{
    public static class CMAHelper
    {
        public static string ReplaceWithFriendlyName(string input)
        {
            return input.Replace("Code1", "Code");
        }
        public static string ReplaceWithLINQName(string input)
        {
            return input.Replace("Code", "Code1");
        }
        public static string ConvertSentenceCase(string input)
        {
            var lowerCase = input.ToLower();
            var r = new Regex(@"(^[a-z])|\.\s+(.)", RegexOptions.ExplicitCapture);
            return r.Replace(lowerCase, s => s.Value.ToUpper());
        }
    }
}
