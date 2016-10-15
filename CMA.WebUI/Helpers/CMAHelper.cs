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
            switch (input)
            {
                case "Code":
                    return "Code1";
                case "CPT":
                    return "CPT1";
                case "DSM":
                    return "DSM1";
                case "DRG":
                    return "DRG1";
                case "ICD":
                    return "ICD1";
                default:
                    return input;
            }
        }
        public static string ConvertSentenceCase(string input)
        {
            var lowerCase = input.ToLower();
            var r = new Regex(@"(^[a-z])|\.\s+(.)", RegexOptions.ExplicitCapture);
            return r.Replace(lowerCase, s => s.Value.ToUpper());
        }

        public static string GetValue(string input)
        {
            if (!string.IsNullOrEmpty(input))
                return input;
            else
                return string.Empty;
        }
    }
}
