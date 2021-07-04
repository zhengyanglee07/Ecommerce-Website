<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="OrderEdit.aspx.cs" Inherits="Assignment.Admin.OrderEdit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   <div id="alertSuccess" class="alert alert-success alert-dismissible fade show" role="alert" runat="server">
            <%=successMessage %>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>

        <div id="alertFail" class="alert alert-warning alert-dismissible fade show" role="alert" runat="server">
            <%=errorMessage %>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>

   <div class="container">
            <h2>Order #<asp:Label ID="lblOrderID" runat="server" Text="Label"></asp:Label>&nbsp;details</h2>

            <div class="row bg-white p-3 mt-3 mb-2 rounded ">
                <div class="col-4">
                <h3>General Details</h3>
                    <b>Order Date: </b><br />
                    <asp:Label ID="lblOrderDate" runat="server"></asp:Label>
                    <br />
                    <br />
                    <b>Order Status: </b><br />
                    <asp:DropDownList ID="ddlOrderStatus" OnSelectedIndexChanged="ddlOrderStatus_SelectedIndexChanged" CssClass="btn btn-outline-info" AutoPostBack="true" runat="server">
                            <asp:ListItem Text="Pending" Value="pending"></asp:ListItem>
                            <asp:ListItem Text="Processing" Value="processing"></asp:ListItem>
                            <asp:ListItem Text="Shipped" Value="shipped"></asp:ListItem>
                            <asp:ListItem Text="Completed" Value="completed"></asp:ListItem>
                            <asp:ListItem Text="Cancelled" Value="cancelled"></asp:ListItem>
                        </asp:DropDownList>
                    <br />
                    <br />
                    <b>Customer: </b><br />
                    <asp:Label ID="lblCustomerName" runat="server"></asp:Label>
                </div>
                <div class="col-4">
                    <h3>Shpping Address</h3>
                    <b>Address: </b><br />
                    <asp:Label ID="lblAddress" runat="server" Text="-"></asp:Label>
                    <br />
                    <br />
                    <b>Email</b><br />
                    <asp:Label ID="lblEmail" runat="server" Text="-"></asp:Label>
                </div>
                <div class="col-4">
                    <h3>Payment</h3>
                    <b>Bank: </b><br />
                    <asp:Label ID="lblBank" runat="server" Text="-"></asp:Label>
                    <br />
                    <br />
                    <b>Type: </b><br />
                    <asp:Label ID="lblType" runat="server" Text="-"></asp:Label>
                </div>
            </div>

           <div class="row bg-white p-3 mb-2 rounded">
               <h3>Order Item</h3>
               <div class="container-fluid">
                   <asp:GridView ID="gvOrderItem" Width="100%" runat="server" AutoGenerateColumns="false" EmptyDataText="No Record Found!" HorizontalAlign="Center">
                       <Columns>
                           <asp:BoundField HeaderText="Product Id" DataField="c.ProductID" Visible="true" />
                           <asp:TemplateField HeaderText="Item">
                               <ItemTemplate>
                                   <asp:Image ID="imgProductImage" Width="120" Height="100" runat="server" />
                                   <asp:Label ID="lblProductName" runat="server"></asp:Label>
                               </ItemTemplate>
                           </asp:TemplateField>
                           <asp:BoundField HeaderText="Cost"  DataField="c.ProductPrice" />
                           <asp:BoundField HeaderText="Quantity" DataField="c.Quantity"  />
                           <asp:BoundField HeaderText="Total" DataField="c.TotalPrice" DataFormatString="{0:0.00}" />
                       </Columns>
                       <HeaderStyle HorizontalAlign="Center" />    
                       <RowStyle HorizontalAlign="Center"></RowStyle>
                   </asp:GridView>

               </div>
           </div>

           <div class="row bg-white p-3 mb-2 rounded">
               <div class="container-fluid">
                   <div class="row">
                       <div class="col-6">
                           <b>Shipping Fees</b>
                       </div>
                       <div class="col-6 text-right" style="padding-right:80px">
                           <asp:Label ID="lblShippingFees" runat="server" Text="0.00"></asp:Label>
                       </div>
                   </div> 
                   <br />
                   Delivery By: <asp:Label ID="lblDeliveryBy" runat="server" Text="-"></asp:Label>
               </div>
           </div>

            <div class="row bg-white p-3 mb-2 rounded">
                <div class="container-fluid">
                   <div class="row">
                       <div class="col-6">
                           <b>Total</b>
                       </div>
                       <div class="col-6 text-right" style="padding-right:80px">
                           <asp:Label ID="lblOrderTotal" runat="server" Text="0.00"></asp:Label>
                       </div>
                   </div>
                </div>
            </div>

            <div class="container-fluid">
                <asp:Button ID="btnInvoice" CssClass="btn btn-info w-100" runat="server" Text="Invoice" OnClick="btnInvoice_Click" />
            </div>
        </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
