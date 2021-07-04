<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GeneratingReceipt.aspx.cs" Inherits="Assignment.GeneratingReceipt" %>

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
        <%--<h1 style="padding:0 0 0 20px; color:white;">Generating purchase record....</h1>--%>
    <p>Your delivery detail is received</p>
        <p>Please wait for a moment</p>
     <table>
         <tr>
             <td><p>You will be able to view <a href="Receipt.aspx">your purchase</a> after 3 seconds </p></td>
             <td><img src="images/loading_1.gif" style="height:50px; width:40px;"/></td>
         </tr>
     </table>
    
    <script>
        setTimeout("location = 'Receipt.aspx' ", 3000);
    </script>
    </form>
</body>
</html>
