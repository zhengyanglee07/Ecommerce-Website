<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="ProductAction.aspx.cs" Inherits="Assignment.Admin.ProductAction" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <link href="css/style.css" rel="stylesheet" />
    <link href="css/Common.css" rel="stylesheet" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://rawgit.com/enyo/dropzone/master/dist/dropzone.js"></script>
    <link rel="stylesheet" href="https://rawgit.com/enyo/dropzone/master/dist/dropzone.css" />

        <!--Style for product image preview box-->
    <style>
        .preview-box {
            display: inline-block !important;
            position: relative !important;
            overflow: hidden;
        }

        .preview-box-overlay {
            display: none;
        }

        .preview-box a:hover .preview-box-overlay {
            display: inline;
            text-align: center;
            position: absolute;
            transition: background 0.2s ease, padding 0.8s linear;
            background-color: rgba(255, 0, 0, 0.58);
            color: #fff;
            width: 100%;
            height: 100%;
            text-shadow: 0 1px 2px rgba(0, 0, 0, .6);
        }


    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <!--Script for dropzone (Drag & Drop files)-->
    <script type="text/javascript">  
        Dropzone.options.myAwesomeDropzone = {
            paramName: "file", // The name that will be used to transfer the file
            resizeWidth: 700,
            resizeHeight: 700,
            maxFilesize: 50, // MB
            addRemoveLinks: true, // Add link to remove img before upload
            maxFiles: 7, //Maximun of 7 images can be uploaded on a time
            url: "FileUpload.ashx", //Redirect to ProductAdd.aspx 
            success: function (file, response) {
                var r = response
                if (document.getElementById("<%=hiddenField1.ClientID %>").value == null) {
                    document.getElementById("<%=hiddenField1.ClientID %>").value = r;
                }
                else {
                    document.getElementById("<%=hiddenField1.ClientID %>").value += ","  + r;
                }
                console.log(document.getElementById("<%=hiddenField1.ClientID %>").value);
            }
        };
    </script>
    <a class="btn btn-info" href="Product.aspx">
        <svg class="c-icon">
            <use xlink:href="icons/free.svg#cil-arrow-circle-left"></use>
        </svg>
        Back
    </a>

    <!--Div alert to show action result-->
    <div id="alertSuccess" class="alert alert-success" role="alert" runat="server">
        <%=successMessage %>
    </div>
    <div id="alertFail" class="alert alert-danger" role="alert" runat="server">
        <%=errorMessage %>
    </div>

    <!--Hold all image name have been selected to upload-->
    <asp:HiddenField runat="server" ID="hiddenField1" />

    <!--Body-->
    <div class="container-fluid">
        <h1 id="title" runat="server"></h1>
        <table class="table" style="width: 90%">
            <tr>
                <td style="width: 20%">
                    <label for="txtProductName" class="col-form-label-lg">Name: </label>
                </td>
                <td>
                    <asp:TextBox ID="txtProductName" MaxLength="50" CssClass="form-control" runat="server" ></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Please enter product name!" CssClass="error" ControlToValidate="txtProductName" Display="Dynamic"></asp:RequiredFieldValidator>
                    <asp:CustomValidator ID="CustomValidator1" runat="server" ErrorMessage="Product Name Exist! Please try others" Display="Dynamic" CssClass="error" ControlToValidate="txtProductName" OnServerValidate="CustomValidator1_ServerValidate1"></asp:CustomValidator>  
                </td>
            </tr>
            <tr>
                <td>Category: </td>
                <td>
                    <asp:DropDownList ID="ddlCategory" CssClass="btn btn-outline-info" DataTextField="CategoryName" DataValueField="CategoryID" runat="server">
                    </asp:DropDownList>
                <asp:CustomValidator ID="CustomValidator3" runat="server" ErrorMessage="Please choose a category!" Display="Dynamic" CssClass="error" OnServerValidate="CustomValidator3_ServerValidate"></asp:CustomValidator>
                </td>
            </tr>
            <tr>
                <td>Description: </td>
                <td>
                    <asp:TextBox ID="txtDescription" TextMode="MultiLine" Width="100%" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Please enter product description!" CssClass="error" ControlToValidate="txtDescription" Display="Dynamic"></asp:RequiredFieldValidator>
                </td>
            </tr>   
            <tr>
                <td>Image: </td>
                <td>
                    <div id="my-awesome-dropzone" class="dropzone">
                        <div class="fallback">
                            <input id="uploadFile" name="file" type="file" multiple="multiple" />
                            <input name="btnUpload" type="submit" /><br />
                            <br />
                            <asp:Label ID="lblFallbackMessage" runat="server" />
                        </div>
                    </div>
                     <br />
                    <!--Allocate the image of product have been stored-->
                    <div id="divPreview" class="container" runat="server"></div>
                    <asp:CustomValidator ID="CustomValidator2" runat="server" ErrorMessage="Please choose an product image" Display="Dynamic" CssClass="error"  OnServerValidate="CustomValidator2_ServerValidate" ></asp:CustomValidator>
                </td>
            </tr>
            <tr>
                <td>Price: </td>
                <td>
                    <div class="input-group">
                        <div class="input-group-append">
                            <span class="input-group-text">RM</span>
                            <asp:TextBox ID="txtPrice" CssClass="form-control" MaxLength="10" runat="server"></asp:TextBox>
                            <asp:RangeValidator ID="RangeValidator1" runat="server" Type="double" MinimumValue="1" ControlToValidate="txtPrice" CssClass="error" Display="Dynamic" ErrorMessage="Price must be more than 0" MaximumValue="100000"></asp:RangeValidator>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="Please enter product price" Display="Dynamic" CssClass="error" ControlToValidate="txtPrice"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Invalid Price!" ValidationExpression="\d{1,7}(\.\d{1,2})?" Display="Dynamic" CssClass="error" ControlToValidate="txtPrice"></asp:RegularExpressionValidator>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td>Quantity</td>
                <td>
                    <asp:TextBox ID="txtQuantity" MaxLength="10" TextMode="Number" runat="server"></asp:TextBox>
                    <asp:RangeValidator ID="RangeValidator2" ControlToValidate="txtQuantity" MinimumValue="1" MaximumValue="10000" CssClass="error" Display="Dynamic" runat="server" ErrorMessage="Quantity cannot be less than 0"></asp:RangeValidator>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="Please enter product quantity" Display="Dynamic" CssClass="error" ControlToValidate="txtQuantity"></asp:RequiredFieldValidator>
                </td>   
            </tr>
            <tr>
                <td>Publish</td>
                <td>
                    <label class="switch">
                        <asp:CheckBox ID="chkPublish" Checked="true" runat="server" />
                        <span class="slider round"></span>
                    </label>
                </td>
            </tr>
        </table> 
       <div style="text-align:left">
            <asp:Button ID="btnReset"  CssClass="btn btn-danger" Width="300px" runat="server" Text="Reset" OnClick="btnReset_Click" /> 
        <asp:Button ID="btnProductAdd" CssClass="btn btn-info" runat="server" Width="300px" Text="Add Product"  OnClick="btnProductAdd_Click" />
        <asp:Button ID="btnProductEdit"  CssClass="btn btn-info" runat="server" Width="300px" Text="Edit Product" OnClick="btnProductEdit_Click" />
  
       </div>
        </div>
</asp:Content>