<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="Assignment.Contact" MasterPageFile="~/Site1.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" runat="server">

    <div class="contactus-container">
        <h1 style="padding: 0 0 0 20px; color: white;">Contact Us</h1>
        <br />
        <h2 style="text-align: center; color: white;">How can we help?</h2>
        <h2 style="text-align: center; color: white;">Send us a message!</h2>

        <br />
        <table style="text-align: left; margin-left: 40%;">
            <tr>
                <td style="font-size: 30px; color: white;">First Name:</td>
                <td>
                    <asp:TextBox ID="txtfirstname" runat="server" placeholder="Your name" Height="30px" Width="250px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtfirstname" CssClass="error" Display="Dynamic" ErrorMessage="Please enter first name."></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="font-size: 30px; color: white;">Last Name:</td>
                <td>
                    <asp:TextBox ID="txtlastname" runat="server" placeholder="Your last name" Height="30px" Width="250px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtlastname" CssClass="error" Display="Dynamic" ErrorMessage="Please enter last name."></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="font-size: 30px; color: white;">Email:</td>
                <td>
                    <asp:TextBox ID="txtemail" runat="server" placeholder="Your Email" Height="30px" Width="250px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtemail" CssClass="error" Display="Dynamic" ErrorMessage="Please enter email."></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtemail" CssClass="error" Display="Dynamic" ErrorMessage="Please enter valid email."></asp:RegularExpressionValidator>
                </td>
            </tr>
            <tr>
                <td style="font-size: 30px; color: white;">Message:</td>
                <td>
                    <asp:TextBox ID="txtmessage" runat="server" placeholder="Write Something..." Height="30px" Width="250px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtmessage" CssClass="error" Display="Dynamic" ErrorMessage="Please enter message."></asp:RequiredFieldValidator>
                </td>
            </tr>
        </table>
        <br />
        <div class="contactus-buttonContainer">
        <asp:Button ID="btnsubmit" runat="server" Text="Send" Height="30px" Width="120px" CssClass="contactus-button" OnClick="btnregister_Click"/>
        <asp:Button ID="btnreset" runat="server" Text="Reset" Height="30px" Width="120px" CssClass="contactus-button" OnClick="btnreset_Click"/>
        </div>
        <br />
    </div>
</asp:Content>

