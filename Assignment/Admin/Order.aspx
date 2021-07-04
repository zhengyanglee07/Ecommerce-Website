<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Order.aspx.cs" Inherits="Assignment.Admin.Order1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="css/style.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1>Order List</h1>
     <br />
    <div class="container-fluid">
        <table>
            <tr>
                <td>From: <asp:TextBox ID="txtMinDate" TextMode="Date" runat="server"></asp:TextBox></td>
                <td>To: <asp:TextBox ID="txtMaxDate" TextMode="Date" runat="server"></asp:TextBox></td>
                <td><asp:TextBox ID="txtSearch" CssClass="form-control rounde" placeholder="Search" runat="server"></asp:TextBox></td>
                <td><asp:Button ID="btnSearch" CssClass="btn btn-outline-primary d-inline-block" OnClick="btnSearch_Click" runat="server" Text="Search" /></td>
            </tr>
        </table>
    </div>
    <br />
    <asp:LinqDataSource ID="dsOrder" runat="server" ContextTypeName="Assignment.AssignmentDBDataContext" EnableDelete="True" EnableInsert="True" EnableUpdate="True" EntityTypeName="" TableName="OrderDetails" Where="@user_Name == null || user_Name == @user_Name">
        <WhereParameters>
            <asp:QueryStringParameter Name="newparameter" QueryStringField="username" />
        </WhereParameters>
    </asp:LinqDataSource>
    <asp:GridView ID="gvOrder" CssClass="gridview" Width="100%" runat="server" AutoGenerateColumns="False" PageSize="7" OnRowDataBound="gvOrder_RowDataBound" DataKeyNames="OrderInfoID" AllowPaging="True" OnRowCreated="gvOrder_RowCreated" DataSourceID="dsOrder" EmptyDataText="No Data Found" AllowSorting="True">
        <columns>
                <asp:TemplateField HeaderText="No" Visible="false">
                    <ItemTemplate>
                        <asp:Label ID="lblItemIndex" Text="<%# Container.DataItemIndex + 1 %>" runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:HyperLinkField  HeaderText="Order ID" DataNavigateUrlFields="OrderInfoID" DataNavigateUrlFormatString="OrderEdit.aspx?oid={0}" DataTextField="OrderInfoID"  />
                <asp:BoundField HeaderText="Customers" DataField="user_Name" SortExpression="user_Name"  />
                <asp:BoundField DataField="OrderDate" HeaderText="OrderDate" SortExpression="OrderDate" />
                <asp:BoundField DataField="LastModified" HeaderText="LastModified" SortExpression="LastModified" />
                <asp:TemplateField HeaderText="OrderStatus" SortExpression="OrderStatus">
                    <ItemTemplate>
                        <asp:DropDownList ID="ddlOrderStatus" CssClass="btn-outline-info font-weight-bold"  AutoPostBack="true" OnSelectedIndexChanged="ddlOrderStatus_SelectedIndexChanged" runat="server">
                            <asp:ListItem Text="Pending" Value="pending"></asp:ListItem>
                            <asp:ListItem Text="Processing" Value="processing"></asp:ListItem>
                            <asp:ListItem Text="Shipped" Value="shipped"></asp:ListItem>
                            <asp:ListItem Text="Completed" Value="completed"></asp:ListItem>
                            <asp:ListItem Text="Cancelled" Value="cancelled"></asp:ListItem>
                        </asp:DropDownList>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField HeaderText="OrderTotal" DataField="OrderTotal" SortExpression="OrderTotal" DataFormatString="{0:0.00}" />
                <asp:TemplateField HeaderText="View" ShowHeader="False">
                    <ItemTemplate>
                        <asp:LinkButton ID="btnView" runat="server" CausesValidation="false" OnCommand="btnView_Command" CommandArgument='<%# Eval("OrderInfoID") %>' Text="View"></asp:LinkButton>
                    </ItemTemplate>
                    <ControlStyle CssClass="btn btn-info" />
                </asp:TemplateField>
                <asp:CommandField DeleteText="Remove" HeaderText="Remove" ControlStyle-CssClass="btn btn-danger" ShowDeleteButton="True" />
            </columns>
            <pagerstyle cssclass="pager" horizontalalign="Right" />
            <pagersettings mode="NumericFirstLast" pagebuttoncount="5" firstpagetext="First" lastpagetext="Last" />
            <rowstyle cssclass="rowStyle" />
            <sortedascendingheaderstyle cssclass="sort-asc" />
            <sorteddescendingheaderstyle cssclass="sort-desc" />
    </asp:GridView>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
