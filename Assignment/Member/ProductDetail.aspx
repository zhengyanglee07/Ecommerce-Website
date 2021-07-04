<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="ProductDetail.aspx.cs" Inherits="Assignment.ProductDetail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .padding-20 {
            padding: 20px;
        }

        .auto-style8 {
            width: 520px;
            text-align: center;
        }

        .auto-style18 {
            width: 1050px;
            height: 670px;
        }

        .auto-style32 {
            text-align: left;
            height: 100px;
            width: 1200px;
        }

        .auto-style33 {
            text-align: left;
            height: 21px;
        }

        .auto-style40 {
            text-align: center;
            width: 501px;
            height: 125px;
            border: 1px solid black;
        }

        .auto-style41 {
            width: 1050px;
            height: 30px;
        }

        .auto-style47 {
            text-align: left;
            height: 125px;
            width: 500px;
            border: 1px solid black;
        }
        .auto-style48 {
            top: 90%;
            left: 5%;
            background-color: #ffffcc;
            color: #EBAF4C;
            font-size: 20px;
            padding: 12px 24px;
            border: #EBAF4C solid 1px;
            cursor: pointer;
            border-radius: 1px;
            font-weight: bold;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" runat="server">


    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:AssignmentDBConnectionString %>" SelectCommand="SELECT DISTINCT * FROM [Product] WHERE ([ProductID] = @ProductID)">
        <SelectParameters>
            <asp:QueryStringParameter Name="ProductID" QueryStringField="ProductID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <br />

    <div style="margin-left: 28%;">
        You Have Products in Your Cart 
            <asp:Label ID="lbCountItem" runat="server" Font-Bold="True" ViewStateMode="Enabled"></asp:Label>
        &nbsp;<asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="ShoppingCart.aspx">Show Cart</asp:HyperLink>
        &nbsp;<br />
        <br />
    </div>

    <asp:DataList ID="DataList1" runat="server" DataKeyField="ProductID" DataSourceID="SqlDataSource1" OnItemDataBound="DataList1_ItemDataBound" BorderStyle="None" CellPadding="15" CellSpacing="20" CssClass="product-container" EnableTheming="True">
        <ItemTemplate>
            <asp:HiddenField ID="HiddenField1" Value='<%# Eval("ProductID") %>' runat="server" />
            <br />
            <table class="auto-style18" style="border: 1px solid black;" dir="ltr">
                <tr>
                    <td class="auto-style8" rowspan="4" aria-checked="undefined" aria-disabled="False">
                        <asp:Image ID="Image1" runat="server" Height="500px" Width="500px" />
                    </td>
                    <td class="auto-style47" style="font-size: 20px;" dir="auto">&nbsp;&nbsp;&nbsp;
                        <asp:Label ID="lbProductName" runat="server" Text='<%# Eval("ProductName") %>'></asp:Label>
                    </td>
                </tr>

                <tr>
                    <td class="auto-style47" style="font-size: 25px; color: #cccc00; font-weight: bolder;" dir="auto">&nbsp;&nbsp;&nbsp; RM
                        <asp:Label ID="lbProductPrice" runat="server" Text='<%# Eval("ProductPrice") %>'></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style47" dir="auto">&nbsp;&nbsp;&nbsp;&nbsp; Quantity&nbsp;<asp:TextBox ID="txtquantity" runat="server" Text="1" TextMode="Number"></asp:TextBox>
                        &nbsp;&nbsp;<asp:Label ID="lbProductStock" runat="server" Font-Bold="True" Font-Italic="True" Font-Size="Medium" Text='<%# Eval("ProductQuantity") %>'></asp:Label>
                        <asp:RangeValidator ID="RangeValidator1" runat="server" ControlToValidate="txtquantity" Display="Dynamic" ErrorMessage="*" MaximumValue='<%# Eval("ProductQuantity") %>' MinimumValue="1" SetFocusOnError="True" Type="Integer" ForeColor="Red"></asp:RangeValidator>
                        &nbsp;piece available</td>
                </tr>
                <tr>
                    <td class="auto-style40" dir="auto">
                        &nbsp;&nbsp;
                        <asp:Button ID="dd" runat="server" CommandName="addtocart" OnClick="btnAddToCart_Click" Text="Add To Cart" CssClass="auto-style48" Width="250px" />
                    </td>
                </tr>
                <tr>
                    <td aria-checked="undefined" aria-disabled="False" class="auto-style33" style="border: 1px solid #181818;" colspan="2" dir="auto">&nbsp;&nbsp;&nbsp; Share to&nbsp; :&nbsp; 
                        <a href="https://twitter.com/share?ref_src=twsrc%5Etfw" class="twitter-share-button" data-size="large" data-text="Wow, this product quality good and fantastic~~~" data-show-count="false">
                            Share
                        </a>
                        <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>
                    </td>
                </tr>
            </table>
            <table class="auto-style41" style="border: 1px solid black;">
                <tr>
                    <td aria-checked="undefined" aria-disabled="False" class="auto-style32">&nbsp;&nbsp;&nbsp; Description :&nbsp;<asp:Label ID="lbProductDescription" runat="server" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Size="Medium" Text='<%# Eval("ProductDescription") %>'></asp:Label>
                    </td>
                </tr>
            </table>
        </ItemTemplate>
    </asp:DataList>


</asp:Content>
