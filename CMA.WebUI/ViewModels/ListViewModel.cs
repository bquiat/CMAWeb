using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CMA.WebUI.ViewModels
{
    public class ListViewModel
    {
        public string TableName { get; set; }
        public string TableData { get; set; }
        public string SearchText { get; set; }
        public string Caption { get; set; }
        public int MaxListRecords { get; set; }
        public ListInput InputParam { get; set; }
        public List<DataColumn> DataColumns { get; set; }
    }

    //public class TableHeaders
    //{
    //    public string ColumnName { get; set; }
    //    public string DataType { get; set; }
    //    public int Length { get; set; }
    //    public bool Required { get; set; }
    //    public bool IsPrimaryKey { get; set; }
    //    public string Caption { get; set; }
    //    public int DisplayLength { get; set; }
    //    public bool ReadOnly { get; set; }
    //}



    public class ListInput
    {
        public string TableName { get; set; } // For the Table Name
        public string SubQuery { get; set; } // For the Code Type
        public string Menu { get; set; } // For the Navigation
        public string ContainerId { get; set; } // Container ID
        public string Type { get; set; }
    }
    

    public class DataColumn
    {
        public string DBColumnName { get; set; }
        public string DisplayName { get; set; }
        public int MaxLength { get; set; }
        public bool ReadOnly { get; set; }
        public bool IsPrimaryKey { get; set; }
        public bool IsRequired { get; set; }
        public int Width { get; set; }
        public bool IsSearchAble { get; set; }
        public bool IsVisible { get; set; }
        public bool IsSubQuery { get; set; }
        public string DefaultValue { get; set; }
        public string OrderBy { get; set; }
    }
}

