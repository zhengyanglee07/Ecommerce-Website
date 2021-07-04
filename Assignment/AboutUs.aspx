<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Aboutus.aspx.cs" Inherits="Assignment.Aboutus" MasterPageFile="~/Site1.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="main" runat="server">

    <div class="aboutus-container">
        <h1 style="padding: 0 0 0 20px; color: white;">About Us</h1>
        <div style="height: 200px;">
            <h2 style="padding: 30px 0 5px 0; text-decoration: underline; color: white;">Welcome</h2>
            <p>
                We set out on this journey to create
                <br />
                quality living essentials for the
                <br />
                everyday Asian, helping you look
                <br />
                good and feel good at an affordable price.
            </p>
        </div>
        <br />
        <table style="height: 100%; transform:translateY(-300px);">
            <tr>
                <td style="padding: 0 60px 0 100px;">
                    <img src="images/1%20ppl.jpg" style="height: 150px; width: 220px; border-radius: 80%; margin-left:100px" />
                    <h3 style="text-align: center; color: white;">Zheng Yang</h3>
                    <br />
                    <p>
                        We cut out unnecessary costs, such as middlemen 
                        and retail mark-up, to offer prices primarily 
                        based on the quality of the materials and craftsmanship. 
                        And we’re always upfront about the true costs 
                        behind all of our products.
                    </p>
                </td>

                <td style="padding: 0 60px 0 80px;">
                    <img src="images/2%20ppl.jpg" style="height: 150px; width: 220px; border-radius: 80%; margin-left:50px;" />
                    <h3 style="text-align: center; color: white;">Auxon</h3>
                    <br />
                    <p>
                        Our focus on timeless pieces is intentional, 
                        because we believe in products that will last 
                        you for years and years. It's not just good 
                        for your wallet,but good for the environment.
                    </p>
                </td>
                <td style="padding: 0 60px 0 80px;">
                    <img src="images/3%20ppl.jpg" style="height: 150px; width: 220px; border-radius: 80%; margin-left:10px;" />
                    <h3 style="text-align: center; color: white;">Teik Keen</h3>
                    <br />
                    <p>
                        This year, our journey towards sustainable living 
                        begins. Here's how we're doing our part to be 
                        kinder to our planet.
                    </p>
                </td>
                <td style="padding: 0 100px 0 80px;">
                    <img src="images/4%20ppl.jpg" style="height: 150px; width: 220px; border-radius: 80%; margin-left:50px;" />
                    <h3 style="text-align: center; color: white;">Sheng Zhen</h3>
                    <br />
                    <p>
                        We are conscious about the materials that go into 
                        our products and the partners we work with to 
                        manufacture them. We are constantly working 
                        to reduce our impacton the environment.
                    </p>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>

