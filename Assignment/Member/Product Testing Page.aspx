<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Product Testing Page.aspx.cs" Inherits="Assignment.Product_Testing_Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" runat="server">

    <asp:LinqDataSource ID="dsProduct" runat="server" ContextTypeName="Assignment.AssignmentDBDataContext" EntityTypeName="" TableName="Products"></asp:LinqDataSource>

    <asp:LinqDataSource ID="LinqDataSource1" runat="server" ContextTypeName="Assignment.AssignmentDBDataContext" EntityTypeName="" TableName="Categories">
    </asp:LinqDataSource>

    <div class="product-container">
        <h1 style="font-family: Corbel">Shop</h1>

        <div>
            You Have Products in Your Cart 
            <asp:Label ID="lbCountItem" runat="server" Font-Bold="True" ViewStateMode="Enabled"></asp:Label>
            &nbsp;<asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="ShoppingCart.aspx">Show Cart</asp:HyperLink>
            <br />
        </div>

        <hr style="width: 67%; margin-left: 0" />
        <asp:DropDownList ID="ddlCategory" runat="server" DataSourceID="LinqDataSource1" DataTextField="CategoryName" DataValueField="CategoryID" CssClass="ddlCategoryCss" AutoPostBack="True" OnSelectedIndexChanged="ddlCategory_SelectedIndexChanged"></asp:DropDownList>

        <div>
            <asp:ListView ID="lvProduct" runat="server" DataKeyNames="ProductID" DataSourceID="dsProduct" GroupItemCount="3" OnItemDataBound="lvProduct_ItemDataBound1">
                <LayoutTemplate>
                    <div>
                        <asp:PlaceHolder ID="groupPlaceholder" runat="server" />
                    </div>
                </LayoutTemplate>

                <GroupTemplate>
                    <div>
                        <asp:PlaceHolder ID="itemPlaceholder" runat="server" />
                    </div>
                </GroupTemplate>

                <ItemTemplate>
                            
                    <asp:HiddenField ID="HiddenField1" Value='<%# Eval("ProductID") %>' runat="server" />
                    <a class="product-list" href="ProductDetail.aspx?ProductID=<%# Eval("ProductID") %>">
                        <asp:Image ID="imgProduct" CssClass="imgProductShow" runat="server" />
                        <div class="imgProductShow-text">
                            <div style="margin-bottom:5px;"><%# Eval("ProductName") %></div>
                            <div>RM <%# Eval("ProductPrice") %></div>
                        </div>

                    </a>
                </ItemTemplate>
            </asp:ListView>
            <asp:DataPager ID="DataPager1" runat="server" class="datapager" PagedControlID="lvProduct" PageSize="6">
                <Fields>
                    <asp:NumericPagerField />
                </Fields>
            </asp:DataPager>
        </div>
    </div>
</asp:Content>