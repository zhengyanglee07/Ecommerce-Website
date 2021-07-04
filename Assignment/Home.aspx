<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="Assignment.Home" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" runat="server">

    <div class="ImgContainer">

        <div class="mySlide fade">
            <img src="../images/showing_images_780x353.jpeg" class="slideShowImg" />
            <div class="ImgContainer-FirstTitle">Welcome to ShopBee</div>
            <asp:Button ID="Button1" runat="server" Text="SHOP NOW" CssClass="showNow" OnClick="Button1_Click" />
        </div>

        <div class="mySlide fade">
            <img src="../images/background.jpg" class="slideShowImg" />
            <div class="purchaseNow">
                <div style="font-size: 65px;">Over 50</div>
                <div style="font-size: 60px;">Featured Products</div>
                <asp:Button ID="Button2" runat="server" Text="PURCHASE NOW" CssClass="purchaseNow-Button" OnClick="Button1_Click" />
            </div>
        </div>

    </div>

    <div style="text-align: center; margin-top: 20px; margin-bottom: 20px;">
        <span class="dot" onclick="currentSlide(1)"></span>
        <span class="dot" onclick="currentSlide(2)"></span>
    </div>

    <div class="categoryShowPiece-Container" style="margin-bottom: 20px;">
        <p class="categoryPiece-Title">Featured Category</p>
        <a href="Member/Product Testing Page.aspx">
            <div class="categoryPiece-Img">
                <img src="images/Electronic Goods.jpg" style="height: 100%; width: 100%;" />
                <p>Electronic Goods(<asp:Label ID="lbElectronicGoods" runat="server" Text="Label"></asp:Label>)</p>
            </div>
        </a>
        <a href="Member/Product Testing Page.aspx">
            <div class="categoryPiece-Img">
                <img src="images/Health.jpg" style="height: 100%; width: 100%;" />
                <p>Health and Wellness(<asp:Label ID="lbHealth" runat="server" Text="Label"></asp:Label>)</p>
            </div>
        </a>
        <a href="Member/Product Testing Page.aspx">
            <div class="categoryPiece-Img">
                <img src="images/sporting-goods.jpg" style="height: 100%; width: 100%;" />
                <p>Sport and Goods(<asp:Label ID="lbSport" runat="server" Text="Label"></asp:Label>)</p>
            </div>
        </a>
    </div>


    <div class="heatProduct-Container" style="margin-bottom: 20px;">
        <img src="../images/showingProduct3.0.jpg" class="slideShowImg" />
        <img src="../images/vaccum.png" class="heatProduct" />
        <div class="heatProduct-Title">
            <p>TOP</p>
            <p>SALES</p>
        </div>
        <div class="heatProduct-ProductDetail">
            <p>Dyson Vacuum</p>
            <p>RM999.99</p>
            <asp:Button ID="Button3" runat="server" Text="PURCHASE NOW" CssClass="heatProduct-PurchaseNow" OnClick="Button1_Click" />
        </div>

    </div>

    <div class="productShowPiece-Container" style="margin-bottom: 20px;">
        <p class="productPiece-Title">Featured Product</p>
        <a href="Member/ProductDetail.aspx?ProductID=6">
            <div class="productPiece-Img">
                <img src="images/Product_Images/309fbabb-c73f-41c3-a61f-bb72cf43fddbtv5.1.JPG" style="height: 100%; width: 100%;" />
                <p>
                    <asp:Label ID="lbP1" runat="server" Text="Label"></asp:Label>
                </p>
            </div>
        </a>
        <a href="Member/ProductDetail.aspx?ProductID=7">
            <div class="productPiece-Img">
                <img src="images/Product_Images/3fa66afd-0510-4acd-813f-540d3a0f70f2goods_67_422995.jpg" style="height: 100%; width: 100%;" />
                <p>
                    <asp:Label ID="lbP2" runat="server" Text="Label"></asp:Label>
                </p>
            </div>
        </a>
        <a href="Member/ProductDetail.aspx?ProductID=2">
            <div class="productPiece-Img">
                <img src="images/Product_Images/96be350c-3dc7-4e6a-98c8-3100384223b6goods_69_427062.jpg" style="height: 100%; width: 100%;" />
                <p>
                    <asp:Label ID="lbP3" runat="server" Text="Label"></asp:Label>
                </p>
            </div>
        </a>
    </div>


    <script>
        var slideNum = 0;
        showSlides();

        function showSlides() {
            var i;
            var slide = document.getElementsByClassName("mySlide");
            var dot = document.getElementsByClassName("dot");
            for (i = 0; i < slide.length; i++) {
                slide[i].style.display = "none";
            }
            slideNum++;
            if (slideNum > slide.length) { slideNum = 1 }
            for (i = 0; i < dot.length; i++) {
                dot[i].className = dot[i].className.replace(" active", "");
            }
            slide[slideNum - 1].style.display = "block";
            dot[slideNum - 1].className += " active";
            setTimeout(showSlides, 3000);
        }
    </script>
</asp:Content>