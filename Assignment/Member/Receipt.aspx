<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Receipt.aspx.cs" Inherits="Assignment.Receipt" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
body {
    background-color: lightgrey;
    background-image: url('../images/Bckgrdimg.jpg');
    background-size: cover;
    background-repeat: no-repeat;
}
p{
   color:white;
}
.auto-style1 {
    padding: 20px;
}
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <h1 style=" color:white; text-align:center;">Your Purchase</h1>
        <br />
        <%--<table>
            <tr>
                <td style="font-size:30px; color:white;">Cart Item ID:</td>
                <td><asp:Label ID="lblcartitemid" runat="server" Text="" Height="30px" Width="250px" ForeColor="White" font-size="30px"></asp:Label></td>
            </tr>
            <tr>
                <td style="font-size:30px; color:white;">Cart ID:</td>
                <td><asp:Label ID="lblcartid" runat="server" Text="" Height="30px" Width="250px" ForeColor="White" font-size="30px"></asp:Label></td>
            </tr>
            <tr>
                <td style="font-size:30px; color:white;">Product ID:</td>
                <td><asp:Label ID="lblproductid" runat="server" Text="" Height="30px" Width="250px" ForeColor="White" font-size="30px"></asp:Label></td>
            </tr>
            <tr>
                <td style="font-size:30px; color:white;">Quantity:</td>
                <td><asp:Label ID="lblquantity" runat="server" Text="" Height="30px" Width="250px" ForeColor="White" font-size="30px"></asp:Label></td>
            </tr>
            <tr>
                <td style="font-size:30px; color:white;">Total Price:</td>
                <td><asp:Label ID="lbltotalprice" runat="server" Text="" Height="30px" Width="250px" ForeColor="White" font-size="30px"></asp:Label></td>
            </tr>
        </table>--%>
        <div class="auto-style1">
            <center>
        <asp:GridView ID="gvCheckOut" runat="server" AutoGenerateColumns="False" ForeColor="White">
        <Columns>
            <asp:BoundField HeaderText="Cart ID" DataField="c.CartID" />
            <asp:BoundField HeaderText="Cart Item ID" DataField="ci.CartItemID" />
            <asp:BoundField HeaderText="Product ID" DataField="ci.ProductID" />
            <asp:BoundField HeaderText="Quantity" DataField="ci.Quantity" />
            <asp:BoundField HeaderText="Total Price" DataField="ci.TotalPrice" />
            <asp:BoundField HeaderText="" DataField="p.ProductName" />
            <asp:BoundField HeaderText="" DataField="p.ProductPrice" />
        </Columns>
    </asp:GridView>
            </center>
            </div>
        <br />
        <center>
        <table>
         <tr>
             <td><p>Automatically back to <a href="Home.aspx">Home</a> after 20 seconds </p></td>
             <td><img src="images/loading_1.gif" style="height:50px; width:40px;"/></td>
         </tr>
     </table>
    </center>
    <script>
        setTimeout("location = '../Home.aspx' ", 20000);
    </script>
        <center>
        <asp:Button ID="btnexit" runat="server" Text="Exit to Home page" style="border-radius: 8px;" Height="30px" Width="150px" OnClick="btnexit_Click"/>
            </center>
    </form>
</body>
</html>
