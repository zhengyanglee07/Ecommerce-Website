<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Payment.aspx.cs" Inherits="Assignment.Payment" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
        #footer {
    padding: 20px;
    position: fixed;
    left: 0;
    bottom: 0;
    width: 100%;
    color: white;
    text-align: center;
}

body, table, input, select {
    font: 11pt Calibri;
}

.error {
    color: red;
    background-image: url(../images/error.png);
    background-repeat: no-repeat;
    background-position: left center;
    padding-left: 20px;
}

body {
    background-image: url('../images/Bckgrdimg.jpg');
    background-size: cover;
    background-repeat: no-repeat;
}

.auto-style1 {
    padding: 20px;
}
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <h1 style="padding:0 0 0 20px; color:white;">ShopBee Pay</h1>
        <br />
        <div class="auto-style1">
            <center>
        <asp:GridView ID="gvCheckOut" runat="server" AutoGenerateColumns="false" ForeColor="White">
        <Columns>
            <asp:BoundField HeaderText="Total Price" DataField="ci.TotalPrice" />
            <asp:BoundField HeaderText="Item" DataField="p.ProductName" />
        </Columns>
    </asp:GridView>
                </center>
            </div>

        <table align="center">
            <tr>
                <td style="font-size:30px; color:white;">PayMethodID:</td>
                <td>
                    <asp:Label ID="lblpaymethodid" runat="server" ForeColor="White" Height="30px" Text="" Width="250px" font-size="30px"></asp:Label>
                </td>
            </tr>
            <tr>
                <td style="font-size:30px; color:white;">Bank:</td>
                <td>
                    <asp:DropDownList ID="ddlbank" runat="server" Height="30px" Width="260px">
                        <asp:ListItem Value="0">-Select-</asp:ListItem>
                        <asp:ListItem Value="Maybank">Maybank</asp:ListItem>
                        <asp:ListItem Value="CIMB bank">CIMB bank</asp:ListItem>
                        <asp:ListItem Value="Public bank">Public bank</asp:ListItem>
                        <asp:ListItem Value="UOB bank">UOB bank</asp:ListItem>
                        <asp:ListItem Value="Hong Leong bank">Hong Leong bank</asp:ListItem>
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Please select bank." ControlToValidate="ddlbank" CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="font-size:30px; color:white;">Name On Card:</td>
                <td>
                    <asp:TextBox ID="txtnameoncard" runat="server" Height="30px" Width="250px" placeholder="Your full name"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Please enter your name." ControlToValidate="txtnameoncard" CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="font-size:30px; color:white;">Card Number:<br />
                </td>
                <td>
                    <asp:TextBox ID="txtcardnumber" runat="server" Height="30px" Width="250px" placeholder="1111-2222-3333-4444" MaxLength="19"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Please enter card number." ControlToValidate="txtcardnumber" CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtcardnumber" CssClass="error" Display="Dynamic" ErrorMessage="Invalid number" ValidationExpression="\d{4}-\d{4}-\d{4}-\d{4}"></asp:RegularExpressionValidator>
                </td>
            </tr>
            <tr>
                <td></td>
                <td>
                    <img src="images/Payment%20Mastercard.png" style="height:50px; width:80px;" padding:"10px 100px 0 10px;"/>
                    <img src="images/VISA%20payment.jpg" style="height:50px; width:80px;" />
                </td>
            </tr>
            <tr>
                <td style="font-size:30px; color:white;">Card Type:</td>
                <td>
                    <asp:RadioButtonList ID="rblcardtype" runat="server" Height="30px" Width="250px" RepeatDirection="Horizontal" RepeatLayout="Flow">
                        <asp:ListItem Value="C" style="color:white;">Credit card</asp:ListItem>
                        <asp:ListItem Value="D" style="color:white;">Debit card</asp:ListItem>
                    </asp:RadioButtonList>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="Please choose card type." ControlToValidate="rblcardtype" CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td></td>
                <td></td>
            </tr>
            <tr>
                <td style="font-size:30px; color:white;">Expiry Date:</td>
                <td>
                    <asp:TextBox ID="txtexepirydate" runat="server" Height="30px" Width="250px" placeholder="XX/XX" MaxLength="5"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="Please enter expiry date." ControlToValidate="txtexepirydate" CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="txtexepirydate" CssClass="error" Display="Dynamic" ErrorMessage="Invalid expiry date" ValidationExpression="\d{2}/\d{2}"></asp:RegularExpressionValidator>
                </td>
            </tr>
            <tr>
                <td style="font-size:30px; color:white;">CVV:</td>
                <td>
                    <asp:TextBox ID="txtcvv" runat="server" Height="30px" Width="250px" placeholder="123" MaxLength="3"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="Please enter CVV." ControlToValidate="txtcvv" CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtcvv" CssClass="error" Display="Dynamic" ErrorMessage="Invalid CVV" ValidationExpression="\d{3}"></asp:RegularExpressionValidator>
            </td>
            </tr>
        </table>
        <br />
        <center>
        <asp:Button ID="btnpay" runat="server" Text="Pay" style="border-radius: 8px;" Height="30px" Width="120px" OnClick="btnpay_Click" />
        <asp:Button ID="btnreset" runat="server" Text="reset" style="border-radius: 8px;" Height="30px" Width="120px" OnClick="btnreset_Click" />
            </center>
        <br />
        <div id="footer">
            &copy; 2021 ShopBee SDN BHD. ALL RIGHT RESERVED
        </div>
    </form>
</body>
</html>
