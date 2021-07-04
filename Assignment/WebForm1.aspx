<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="Assignment.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <asp:LinqDataSource ID="LinqDataSource1" runat="server" ContextTypeName="Assignment.AssignmentDBDataContext" EntityTypeName="" Select="new (Quantity, TotalPrice, ProductName, ProductImage, ProductPrice, CheckOut, CategoryName, ProductID)" TableName="Carts1" EnableDelete="True" EnableInsert="True" EnableUpdate="True">
    </asp:LinqDataSource>

    <asp:GridView ID="gvProduct" runat="server" AutoGenerateColumns="False" DataSourceID="LinqDataSource1">
        <Columns>
            <asp:BoundField DataField="Quantity" HeaderText="Quantity" ReadOnly="True" SortExpression="Quantity" />
            <asp:BoundField DataField="TotalPrice" HeaderText="TotalPrice" ReadOnly="True" SortExpression="TotalPrice" />
            <asp:BoundField DataField="ProductName" HeaderText="ProductName" ReadOnly="True" SortExpression="ProductName" />
            <asp:BoundField DataField="ProductImage" HeaderText="ProductImage" ReadOnly="True" SortExpression="ProductImage" />
            <asp:BoundField DataField="ProductPrice" HeaderText="ProductPrice" ReadOnly="True" SortExpression="ProductPrice" />
            <asp:TemplateField HeaderText="CheckOut" SortExpression="CheckOut">
                <ItemTemplate>
                    <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Bind("CheckOut") %>' Enabled="true" OnCheckedChanged="CheckBox_CheckedChanged"  AutoPostBack="true"/>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="CategoryName" HeaderText="CategoryName" ReadOnly="True" SortExpression="CategoryName" />
            <asp:BoundField DataField="ProductID" HeaderText="ProductID" ReadOnly="True" SortExpression="ProductID" />
        </Columns>
    </asp:GridView>
    </form>
</body>
</html>
