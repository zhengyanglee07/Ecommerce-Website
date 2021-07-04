<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.master" AutoEventWireup="true" CodeBehind="Product.aspx.cs"  Inherits="Assignment.Admin.Product" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="css/Common.css" rel="stylesheet" />
    <link href="css/style.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid ">
        <!--Div alert to show action result-->
        <div id="alertSuccess" class="alert alert-success alert-dismissible fade show" role="alert" runat="server">
            <%=successMessage %>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>

        <div id="alertFail" class="alert alert-warning alert-dismissible fade show" role="alert" runat="server">
            <%=errorMessage %>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </div>
    <div class="row mt-2 ">
            <div class="col-6">
                <h1 class="font-weight-bold">Product List</h1>
            </div>
            <div class="col-6 text-right">
                <asp:Button ID="btnBackUp" CssClass="btn btn-info " runat="server" Text="Backup" OnClick="btnBackUp_Click" />
                <asp:Button ID="btnRestore" CssClass="btn btn-success" runat="server" Text="Restore" OnClick="btnRestore_Click" />
            </div>
        </div>
    <br />

    <div class="container-fluid">
        <div class="row"> 
            <div class="col-6"> 
                <asp:DropDownList ID="ddlCategory" Height="35px" CssClass="btn-outline-info" DataTextField="CategoryName" DataValueField="CategoryID" runat="server">
                </asp:DropDownList>
                 <div style="display:inline-block">
                     <asp:TextBox ID="txtSearch" CssClass="form-control rounde" placeholder="Search" runat="server"></asp:TextBox>   
                 </div>            
                <asp:Button ID="btnSearch" CssClass="btn btn-outline-primary d-inline-block" OnClick="btnSearch_Click" runat="server" Text="Search" />
            </div>
            <div class="col-4">
            </div>
            <div class="col-2">
                <div class="text-right">
                    <asp:Button ID="btnAdd" CssClass="btn btn-primary" runat="server" Text="Add" OnClick="btnAdd_Click" />
                </div>
            </div>
          </div>
        </div>
    <br />

    <a href="?">All</a> | 
    <a href="?publish=true">Published</a> | 
    <a href="?publish=false">Unpublished</a>
    <br />.
        
        <asp:GridView ID="gvProducts" OnRowCreated="gvProducts_RowCreated" Width="100%" CssClass="gridview" PageSize="5" OnPageIndexChanging="gvProducts_PageIndexChanging" runat="server" AutoGenerateColumns="False" DataKeyNames="ProductID" EmptyDataText="No records has been found." AllowPaging="True" AllowSorting="True" OnRowDataBound="gvProducts_RowDataBound" OnRowDeleting="gvProducts_RowDeleting" >
            <Columns>

                <asp:TemplateField HeaderText="No" >
                    <ItemTemplate>
                        <asp:Label ID="lblItemIndex" Text="<%# Container.DataItemIndex + 1 %>" runat="server"></asp:Label>
                        <asp:HiddenField ID="hfProductID" Value='<%#Eval("ProductID") %>' runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField HeaderText="Product Name" DataField="ProductName" SortExpression="ProductName" />
                <asp:TemplateField HeaderText="Product Image">
                    <ItemTemplate>
                        <asp:Image ID="imgProductImage" Width="120" Height="100" runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField HeaderText="Category" DataField="CategoryName" SortExpression="CategoryName" />
                <asp:BoundField HeaderText="Price" DataField="ProductPrice" SortExpression="ProductPrice" />
                <asp:BoundField HeaderText="Stock" DataField="ProductQuantity" SortExpression="ProductQuantity" />
                <asp:TemplateField HeaderText="Publish">    
                    <ItemTemplate>
                        <label class="switch">
                             <asp:CheckBox ID="chkPublish" Checked='<%#Convert.ToBoolean(Eval("Publish")) %>' AutoPostBack="true" CausesValidation="false" OnCheckedChanged="CheckBox1_CheckedChanged" runat="server" />
                            <span class="slider round"></span>
                        </label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:HyperLinkField HeaderText="View/Edit" Text="View/Edit" DataNavigateUrlFields="ProductID" ControlStyle-CssClass="btn btn-info" DataNavigateUrlFormatString="ProductAction.aspx?action=edit&amp;id={0}" />
                <asp:CommandField ShowDeleteButton="True" ControlStyle-CssClass="btn btn-danger" HeaderText="Delete" DeleteText="Delete" />
            </Columns>
            <PagerStyle CssClass="pager" HorizontalAlign="Right"  />
            <PagerSettings Mode="NumericFirstLast" PageButtonCount="3"  FirstPageText="First" LastPageText="Last"/>
            <RowStyle CssClass="rowStyle" />
            <SortedAscendingHeaderStyle CssClass="sort-asc" />
            <SortedDescendingHeaderStyle CssClass="sort-desc" />
                                   
            </asp:GridView>

</asp:Content>
