<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="ShoppingCart.aspx.cs" Inherits="Assignment.ShoppingCart" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" runat="server">
    &nbsp;<asp:LinqDataSource ID="LinqDataSource1" runat="server" ContextTypeName="Assignment.AssignmentDBDataContext" EntityTypeName="" TableName="Carts1" EnableDelete="True" EnableInsert="True" EnableUpdate="True" OnDeleting="LinqDataSource1_Deleting">
    </asp:LinqDataSource>
    <br />

    <div class="product-container">
        You Have 
    <asp:Label ID="lbCountProductType" runat="server" Font-Bold="True"></asp:Label>
        Type In Your Cart&nbsp;&nbsp;&nbsp;   [
    <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="Product Testing Page.aspx">Continue Shopping</asp:HyperLink>
        &nbsp;]<br />
        <br />
        <asp:Label ID="lbErrorMessage" runat="server" ForeColor="Red"></asp:Label>
       <asp:GridView ID="gvProduct" runat="server" AutoGenerateColumns="False" CellPadding="10" CellSpacing="1" ForeColor="#333333" GridLines="None" DataKeyNames="CartID" OnRowDeleting="gvProduct_RowDeleting" OnRowDataBound="gvProduct_RowDataBound"     >
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:TemplateField HeaderText="CheckOut" SortExpression="CheckOut">
                    <ItemTemplate>
                        <asp:CheckBox ID="CheckOut" runat="server" Checked='<%# Bind("CheckOut") %>' Enabled="true" OnCheckedChanged="CheckBox_CheckedChanged" AutoPostBack="true" />
                        <asp:HiddenField ID="ProductID" Value='<%# Bind("ProductID") %>' runat="server" />
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="CategoryName" SortExpression="CategoryName">
                    <EditItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("CategoryName") %>'></asp:Label>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("CategoryName") %>'></asp:Label>
                        <asp:HiddenField ID="CartItemID" Value='<%# Bind("CartItemID") %>' runat="server" />
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Product Image">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Eval("ProductImage") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:HiddenField ID="HiddenField1" Value='<%# Eval("ProductID") %>' runat="server" />
                        <asp:Image ID="Image1" runat="server" />
                    </ItemTemplate>
                    <ControlStyle Height="150px" Width="150px" />
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:BoundField DataField="ProductName" HeaderText="ProductName" ReadOnly="True" SortExpression="ProductName">
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="Quantity" HeaderText="Quantity" ReadOnly="True" SortExpression="Quantity">
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="ProductPrice" HeaderText="ProductPrice" ReadOnly="True" SortExpression="ProductPrice">
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="TotalPrice" HeaderText="TotalPrice" ReadOnly="True" SortExpression="TotalPrice">
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:CommandField DeleteText="Remove" ShowDeleteButton="True" />
            </Columns>
            <EditRowStyle BackColor="#2461BF" />
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#EFF3FB" />
            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
            <SortedAscendingCellStyle BackColor="#F5F7FB" />
            <SortedAscendingHeaderStyle BackColor="#6D95E1" />
            <SortedDescendingCellStyle BackColor="#E9EBEF" />
            <SortedDescendingHeaderStyle BackColor="#4870BE" />
        </asp:GridView>

        <br />
        <asp:Button ID="btnCheckOut" runat="server" OnClick="btnCheckOut_Click" Text="Check Out" />
    </div>
</asp:Content>