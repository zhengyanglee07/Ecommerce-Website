<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Customer.aspx.cs" Inherits="Assignment.Admin.Customer" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="css/style.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
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

    <h1>Customer List</h1>
    <br />
    <div class="container-fluid">
        <table>
            <tr>
                <td>From:
                    <asp:TextBox ID="txtMinDate" TextMode="Date" runat="server"></asp:TextBox></td>
                <td>To:
                    <asp:TextBox ID="txtMaxDate" TextMode="Date" runat="server"></asp:TextBox></td>
                <td>
                    <asp:TextBox ID="txtSearch" CssClass="form-control rounde" placeholder="Search" runat="server"></asp:TextBox></td>
                <td>
                    <asp:Button ID="btnSearch" CssClass="btn btn-outline-primary d-inline-block" OnClick="btnSearch_Click" runat="server" Text="Search" /></td>
            </tr>
        </table>
    </div>
    <br />
    <asp:ValidationSummary ID="ValidationSummary1" CssClass="error" runat="server" />
    <asp:LinqDataSource ID="dxCustomer" runat="server" ContextTypeName="Assignment.AssignmentDBDataContext" EntityTypeName="" TableName="Members" EnableUpdate="True" EnableDelete="True" EnableInsert="True">
    </asp:LinqDataSource>
    <asp:GridView ID="gvCustomer" Width="100%" runat="server" CssClass="gridview" AllowPaging="True" PageSize="5" DataSourceID="dxCustomer" OnRowDataBound="gvCustomer_RowDataBound" AutoGenerateColumns="False" AllowSorting="True" EmptyDataText="No Data Found!">
        <Columns>
            <asp:BoundField DataField="userID" HeaderText="User ID" SortExpression="userID" ReadOnly="True" InsertVisible="False" />
            <asp:TemplateField HeaderText="User Name" SortExpression="user_Name">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("user_Name") %>'></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TextBox1" Display="Dynamic" ErrorMessage="Username cannot be empty!" ForeColor="Red">*</asp:RequiredFieldValidator>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("user_Name") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="User Email" SortExpression="user_Email">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("user_Email") %>'></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="TextBox2" Display="Dynamic" ErrorMessage="Please enter user email!" ForeColor="Red">*</asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="TextBox2" Display="Dynamic" ErrorMessage="Inavlid Email!" ForeColor="Red" ValidationExpression="\w+([-+.']\w+)@\w+([-.]\w+)\.\w+([-.]\w+)"></asp:RegularExpressionValidator>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("user_Email") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Track Order">
                <ItemTemplate>
                    <asp:HiddenField ID="HiddenField1" Value='<%# Eval("user_Name") %>' runat="server" />
                    <asp:HyperLink ID="HyperLink1" runat="server">Track Order</asp:HyperLink>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="registerDate" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Register Date" SortExpression="registerDate" />
        </Columns>
        <PagerStyle CssClass="pager" HorizontalAlign="Right" />
        <PagerSettings Mode="NumericFirstLast" PageButtonCount="5" FirstPageText="First" LastPageText="Last" />
        <RowStyle CssClass="rowStyle" />
        <SortedAscendingHeaderStyle CssClass="sort-asc" />
        <SortedDescendingHeaderStyle CssClass="sort-desc" />
    </asp:GridView>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
