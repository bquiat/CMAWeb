using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CMA.WebUI.ViewModels
{
    public class ListViewModel
    {
        public string ListType { get; set; }
        public string TableName { get; set; }
        public List<TableHeaders> TableHeaders { get; set; }
        public string TableData { get; set; }

        public string SearchText { get; set; }
        public string codeType { get; set;  }
    }

    public class TableHeaders
    {
        public string ColumnName { get; set; }
        public string DataType { get; set; }
        public int Length { get; set; }
        public bool Required { get; set; }
        public bool IsPrimaryKey { get; set; }

        public string Caption;
        public int DisplayLength;
        public bool ReadOnly;
    }

    //public class TableData
    //{
    //    public string data { get; set; }
    //}

}

