<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProductList Testing.aspx.cs" Inherits="Assignment.ProductList_Testing" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:LinqDataSource ID="dsProduct" runat="server" ContextTypeName="Assignment.AssignmentDBDataContext" EntityTypeName="" TableName="Products" Select="new (ProductID, ProductName, ProductDescription, ProductPrice, ProductQuantity, ProductImage, TotalSalesPrice, TotalSalesQuantity)"></asp:LinqDataSource>
    <asp:GridView ID="gvProduct" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataSourceID="dsProduct">
        <Columns>
            <asp:BoundField DataField="ProductID" HeaderText="ProductID" ReadOnly="True" SortExpression="ProductID" />
            <asp:BoundField DataField="ProductName" HeaderText="ProductName" SortExpression="ProductName" ReadOnly="True" />
            <asp:BoundField DataField="ProductDescription" HeaderText="ProductDescription" SortExpression="ProductDescription" ReadOnly="True" />
            <asp:BoundField DataField="ProductPrice" HeaderText="ProductPrice" SortExpression="ProductPrice" ReadOnly="True" />
            <asp:BoundField DataField="ProductQuantity" HeaderText="ProductQuantity" SortExpression="ProductQuantity" ReadOnly="True" />
            <asp:BoundField DataField="TotalSalesPrice" HeaderText="TotalSalesPrice" SortExpression="TotalSalesPrice" ReadOnly="True" />
            <asp:BoundField DataField="TotalSalesQuantity" HeaderText="TotalSalesQuantity" SortExpression="TotalSalesQuantity" ReadOnly="True" />
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%# Eval("ProductID", "ProductDetail.aspx?ProductID={0}") %>' Text="Testing"></asp:HyperLink>
                    <asp:Image ID="Image1" runat="server" Height="100px" Width="100px" ImageUrl='<%# Eval("ProductImage", "images/{0}") %>' />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
        </div>
    </form>
</body>
</html>
