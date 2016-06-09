using System;

namespace CMA.WebUI.Helpers
{
    public static class SQLHelper
    {
        public static string MakeSQLSafe(string input)
        {
            if (string.IsNullOrEmpty(input))
                return "NULL";

            return "'" + input.Replace("'","''") + "'" ;
        }
    }
}
