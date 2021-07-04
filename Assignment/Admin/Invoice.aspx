<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Invoice.aspx.cs" Inherits="Assignment.Admin.Invoice" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link rel="stylesheet" href="https://unpkg.com/@coreui/coreui/dist/css/coreui.min.css">
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <table>
                <tr>
                    <td>
                        <h2>SHOBEE</h2>
                        <p>[Street Address]</p>
                        <p>[City, St ZIP]</p>
                        <p>Phone: 012-345-6789</p>
                        <p>Fax: 013-456-7890</p>
                    </td>
                    <td>
                        <h1 class="font-weight-bold">INVOICE</h1>
                        <table class="float-right">
                            <tr>
                                <td><b>Order Number:&nbsp;</b></td>
                                <td>
                                    <asp:Label ID="lblOrderNo" runat="server" Text="-"></asp:Label></td>
                            </tr>
                            <tr>
                                <td><b>Order Date:&nbsp;</b></td>
                                <td>
                                    <asp:Label ID="lblOrderDate" runat="server" Text="-"></asp:Label></td>
                            </tr>
                            <tr>
                                <td><b>Payment Method:&nbsp;</b> </td>
                                <td>Credit Card</td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            <br />
            <asp:GridView ID="gvOrderItem" Width="100%" runat="server" AutoGenerateColumns="false" EmptyDataText="No Record Found!" HorizontalAlign="Center">
                <Columns>
                    <asp:BoundField HeaderText="Item" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="50%" DataField="c.ProductName" />
                    <asp:BoundField HeaderText="Cost" DataField="c.ProductPrice" DataFormatString="{0:0.00}" />
                    <asp:BoundField HeaderText="Quantity" DataField="c.Quantity" />
                    <asp:BoundField HeaderText="Total" DataField="c.TotalPrice" DataFormatString="{0:0.00}" />
                </Columns>
                <HeaderStyle HorizontalAlign="Center" />
                <RowStyle HorizontalAlign="Center"></RowStyle>
            </asp:GridView>
            <br />
            <table>
                <tr>
                    <td>
                        <b>Customer Notes</b><br />
                        <asp:Label ID="lblCustomerNotes" runat="server" Text="-"></asp:Label>
                    </td>
                    <td>                 
                        <table style="text-align:  center;">
                            <tr>
                                <td><b>Subtotal</td>
                                <td>
                                    <asp:Label ID="lblSubtotal" runat="server" Text="0.00"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td><b>Shipping</td>
                                <td>
                                    <asp:Label ID="lblShipping" runat="server" Text="0.00"></asp:Label></td>
                            </tr>
                            <tr>
                                <td><b>Total</td>
                                <td>
                                    <asp:Label ID="lblTotal" runat="server" Text="0.00"></asp:Label></td>        
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            <br />
            <br />

            <div style="text-align:center; margin-top: 100px">
                <p>If you have any problem about the invoice, please contact</p>
                <p>Name, phone, email</p>
                <b>Thank You For Your Business!</b>
            </div>
        </div>


    </form>
</body>
</html>
