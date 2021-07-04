<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Category.aspx.cs" Inherits="Assignment.Admin.Category" %>

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

        <div class="row mt-2">
            <div class="col-6">
                <h1>Categories</h1>
            </div>
            <div class="col-6 text-right">
                <asp:Button ID="btnBackUp" CausesValidation="false" CssClass="btn btn-info" runat="server" Text="Backup" OnClick="btnBackUp_Click" />
                <asp:Button ID="btnRestore" CausesValidation="false" CssClass="btn btn-success" runat="server" Text="Restore" OnClick="btnRestore_Click" />
            </div>
        </div>
        
        <br /><br />

        <div class="row">
            <div class="col-6">
                 <div style="display:inline-block">
                     <asp:TextBox ID="txtSearch" CssClass="form-control rounde" placeholder="Search" runat="server"></asp:TextBox>   
                 </div>            
                <asp:Button ID="btnSearch" CssClass="btn btn-outline-primary d-inline-block" CausesValidation="false" OnClick="btnSearch_Click1" runat="server" Text="Search" />
            </div>
            <div class="col-6 text-right">
                <button class="btn btn-primary" type="button" data-toggle="collapse" data-target="#collapseExample" aria-expanded="false" aria-controls="collapseExample">
                    Add Category</button>
            </div>
        </div>

        <div class="collapse" id="collapseExample">
            <div class="card card-body">
                <div class="row m-2">   
                    <div class="col-sm-3">
                        <asp:TextBox ID="txtCategoryName" CssClass="form-control" placeholder="Category Name" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Please enter category name" ControlToValidate="txtCategoryName" CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
                        <asp:CustomValidator ID="CustomValidator1" runat="server" ErrorMessage="Category Name Exists!" ControlToValidate="txtCategoryName" Display="Dynamic" CssClass="error" OnServerValidate="CustomValidator1_ServerValidate"></asp:CustomValidator>
                    </div>
                    <div class="col-sm-2 p-2">
                        Publish: 
                               <label class="switch">
                                   <asp:CheckBox ID="chkPublish1" Checked="true" runat="server" />
                                   <span class="slider round"></span>
                               </label>
                    </div>
                    <div class="col-sm-2">
                        <asp:Button ID="btnCategoryAdd" CssClass="btn btn-outline-primary" runat="server" Text="Add" OnClick="btnCategoryAdd_Click"></asp:Button>
                    </div>
                </div>
            </div>
        </div>
        <br />
        <br />
        <b>  
            <a href="?">All</a> | 
            <a href="?publish=true">Published</a> | 
            <a href="?publish=false">Unpublished</a>
        </b>
        <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="error" />
        <asp:GridView ID="gvCategory" runat="server" AutoGenerateColumns="False" AllowPaging="True" CssClass="gridview" Width="100%" CellPadding="4" ForeColor="#333333" GridLines="None" DataKeyNames="CategoryID" PageSize="5" OnRowCreated="gvCategory_RowCreated" OnRowDataBound="gvCategory_RowDataBound" OnRowEditing="OnRowEditing" OnRowCancelingEdit="OnRowCancelingEdit" OnRowUpdating="OnRowUpdating" OnRowUpdated="gvCategory_RowUpdated" OnRowDeleting="OnRowDeleting" OnPageIndexChanging="gvCategory_PageIndexChanging"  EmptyDataText="No records has been added.">
            <Columns>
                <asp:TemplateField HeaderText="No" >
                    <ItemTemplate>
                        <asp:Label ID="lblItemIndex" Text="<%# Container.DataItemIndex + 1 %>" runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Name" SortExpression="CategoryName">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" MaxLength="50" Text='<%# Bind("CategoryName") %>'></asp:TextBox>
                        <asp:HiddenField ID="hfCategoryID" Value='<%#Eval("CategoryID") %>' runat="server" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="TextBox1" Display="Dynamic" ErrorMessage="Please enter new category name" ForeColor="Red">*</asp:RequiredFieldValidator>
                        <asp:CustomValidator ID="CustomValidator2" runat="server" ErrorMessage="Category Name Exists!" ControlToValidate="TextBox1" Display="Dynamic" OnServerValidate="CustomValidator2_ServerValidate">*</asp:CustomValidator>
                    </EditItemTemplate> 
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("CategoryName") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Publish" SortExpression="chkPublish">
                    <EditItemTemplate>
                        <asp:CheckBox ID="chkPublish" CausesValidation="false" Checked='<%#Eval("Publish") %>' runat="server" />
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:HiddenField ID="hfCategoryID" Value='<%#Eval("CategoryID") %>' runat="server" />
                        <label class="switch">
                            <asp:CheckBox ID="chkPublish" Checked='<%#Convert.ToBoolean(Eval("Publish")) %>' AutoPostBack="true" OnCheckedChanged="CheckBox1_CheckedChanged" runat="server" />

                            <span class="slider round"></span>
                        </label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:CommandField ShowEditButton="True" HeaderText="Edit" ControlStyle-CssClass="btn btn-info" ControlStyle-ForeColor="white" EditText="Edit" />
                <asp:CommandField ShowDeleteButton="True" HeaderText="Delete" ControlStyle-CssClass="btn btn-danger" DeleteText="Delete" ControlStyle-ForeColor="white" />
            </Columns>
            <PagerStyle CssClass="pager" HorizontalAlign="Right"  />
            <PagerSettings Mode="NumericFirstLast" PageButtonCount="3"  FirstPageText="First" LastPageText="Last"/>
            <RowStyle CssClass="rowStyle" />
            <SortedAscendingHeaderStyle CssClass="sort-asc" />
            <SortedDescendingHeaderStyle CssClass="sort-desc" />
        </asp:GridView>
    </div>
</asp:Content>
