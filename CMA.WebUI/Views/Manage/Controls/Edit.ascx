<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<CMA.WebUI.ViewModels.ListViewModel>" %>
<%@ Import Namespace="CMA.WebUI.Helpers" %>
<section class="window-inner-header">
    <div class="wdw-hdr-block">
        <div class="wdw-hdr-block-title"><%=Model.Caption %></div>
        <form id="frm-<%=Model.InputParam.ContainerId %>-edit" method="post">
            <%
                var obj = Model.TableData!=null ? 
                            Newtonsoft.Json.JsonConvert.DeserializeObject<Newtonsoft.Json.Linq.JArray>(Model.TableData) != null ? Newtonsoft.Json.JsonConvert.DeserializeObject<Newtonsoft.Json.Linq.JArray>(Model.TableData).FirstOrDefault() : null
                          : null;
                foreach (var col in Model.DataColumns)
                {
                    if (col.IsPrimaryKey)
                    {
            %>
                    <input type="hidden" id="pkey" name="pkey" value="<%=col.DBColumnName %>" />
                    <% 
                        if (obj != null)
                        {
                    %>
                    <input type="hidden" id="pkeyValue" name="pkeyValue" value="<%=obj[CMAHelper.ReplaceWithLINQName(col.DBColumnName)].ToString() %>" />
            <%
                        }
                    }
            %>

            <div class="row">
                <div class="col-xs-12 tp-pdd--1">
                    <div class="row">
                        <div class="col-xs-1">
                            <label><%=col.DisplayName %>:</label>
                        </div>
                        <div class="col-xs-11">
                            <span class="txtbx--1">
                                <input type="text" 
                                        class="form-control <%=col.IsRequired ? "required" : "" %>" 
                                        style="width: 450px;" 
                                        <%=(col.MaxLength  > 0 ? " Maxlength = " + col.MaxLength : "") %>
                                        id="txt-<%=Model.InputParam.ContainerId %>-<%= col.DBColumnName.ToLower()%>" 
                                        name="txt-<%=Model.InputParam.ContainerId %>-<%= col.DBColumnName.ToLower()%>" 
                                        value="<%=obj!=null ? obj[CMAHelper.ReplaceWithLINQName(col.DBColumnName)].ToString(): string.Empty%>" 
                                />
                            </span>
                            <span class="search-btn no--float">
                                
                            </span>
                        </div>
                    </div>
                </div>
            </div>
            <% 
                }
            %>
            <div class="row">
                <div class="col-xs-12 tp-pdd--1">
                    <div class="row">
                        <div class="col-xs-1">
                        </div>
                        <div class="col-xs-11">
                            <button type="button" class="btncancel" onclick="javascript:showhide('lstview-<%=Model.InputParam.ContainerId%>','addeditview-<%=Model.InputParam.ContainerId%>');">Cancel</button>
                            <button type="button" class="btnupdate" 
                                onclick="javascript:saveRecord('<%=Model.InputParam.ContainerId %>',
                                                                '<%=Model.InputParam.Type %>',
                                                                '<%=Model.InputParam.Menu %>',
                                                                '<%=Model.InputParam.TableName %>',
                                                                '<%=Model.InputParam.SubQuery %>',
                                                                '<%=Model.InputParam.ContainerId %>');">
                                <%=obj!=null ? "Update" : "Add New" %>
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
</section>
