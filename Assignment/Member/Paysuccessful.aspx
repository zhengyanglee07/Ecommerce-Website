<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Paysuccessful.aspx.cs" Inherits="Assignment.Paysuccessful" %>

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
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <h1 style="text-align:center; color:white;">Successful</h1>
    <br />
        <center>
    <p>Your payment is successful</p>
     <table>
         <tr>
             <td><p>You will be redirected to <a href="Delivery.aspx">Delievery page</a> after 3 seconds to fill your delivery detail</p></td>
             <td><img src="images/loading_1.gif" style="height:50px; width:40px;"/></td>
         </tr>
     </table>
    </center>
    <script>
        setTimeout("location = 'Delivery.aspx' ", 3000);
    </script>
    </form>
</body>
</html>
