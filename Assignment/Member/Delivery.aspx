<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Delivery.aspx.cs" Inherits="Assignment.Delivery" %>

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
    background-image: url('../images/Delivery.jpg');
    background-size: cover;
    background-repeat: no-repeat;
}

        .auto-style1 {
            color:white;
        }

    </style>
</head>
<body>
    <form id="form1" runat="server">
        <h1 style="text-align:center; padding:0 0 0 20px; color:white;">Delivery</h1>
        <br />

        <table align="center">
            <tr>
                <td style="font-size:30px; color:white;">Delivery ID:</td>
                <td>
                    <asp:Label ID="lbldeliveryid" runat="server" Height="30px" Width="250px" ForeColor="White" font-size="30px"></asp:Label></td>
            </tr>
            
            <tr>
                <td style="font-size:30px; color:white;">Order ID:</td>
                <td>
                    <asp:Label ID="lblorderid" runat="server" Height="30px" Width="250px" ForeColor="White" font-size="30px"></asp:Label></td>
            </tr>

            <tr>
                <td style="font-size:30px; color:white;">Delivery company:</td>
                <td>
                    <asp:RadioButtonList ID="rblcompanyid" DataValueField="CompanyID" DataTextField="CompanyName" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow" CssClass="auto-style1">
                        
                    </asp:RadioButtonList>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="rblcompanyid" CssClass="error" Display="Dynamic" ErrorMessage="Please choose your delievery company"></asp:RequiredFieldValidator>
                </td>
            </tr>

            <tr>
                <td style="font-size:30px; color:white;">Delivery Address:</td>
                <td>
                    <asp:TextBox ID="txtdeliveryaddress" runat="server" Height="70px" Width="300px" TextMode="MultiLine" font-size="20px" placeholder="Fill in your home address"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtdeliveryaddress" CssClass="error" Display="Dynamic" ErrorMessage="Please enter delievery address."></asp:RequiredFieldValidator>
                </td>
            </tr>
        </table>
        <br />
        <center>
        <asp:Button ID="btnsubmit" runat="server" Text="Submit" Height="30px" Width="120px" style="border-radius: 8px;" OnClick="btnsubmit_Click"  />
        <asp:Button ID="btnclear" runat="server" Text="Clear" Height="30px" Width="120px" style="border-radius: 8px;" />
            </center>
        <br />
        <div id="footer">
            &copy; 2021 ShopBee SDN BHD. ALL RIGHT RESERVED
        </div>
    </form>
</body>
</html>
