<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="DeliveryCompany.aspx.cs" Inherits="Assignment.Admin.DeliveryCompany1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="css/style.css" rel="stylesheet" />
    <link href="css/Common.css" rel="stylesheet" />
    <script src="https://code.jquery.com/jquery-1.10.2.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        function showpreview(input) {

            if (input.files && input.files[0]) {

                var reader = new FileReader();
                reader.onload = function (e) {
                    $('#imgpreview').css('visibility', 'visible');
                    $('#imgpreview').attr('src', e.target.result);
                }
                reader.readAsDataURL(input.files[0]);
            }

        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!--Div alert to show action result-->
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


    <div class="row mt-2 ">
        <div class="col-6">
            <h1 class="font-weight-bold">Product List</h1>
        </div>
        <div class="col-6 text-right">
            <asp:Button ID="btnBackUp" CssClass="btn btn-info" CausesValidation="false" runat="server" Text="Backup" OnClick="btnBackUp_Click" />
            <asp:Button ID="btnRestore" CssClass="btn btn-success" CausesValidation="false" runat="server" Text="Restore" OnClick="btnRestore_Click" />
        </div>
    </div>
    <br />

    <h1>Delivery Company</h1>
    <div class="text-right m-3">
        <button type="button" class="btn btn-primary" style="width: 100px" data-toggle="modal" data-target="#imageView">Add</button>
    </div>
    <asp:ValidationSummary ID="ValidationSummary1" CssClass="error" runat="server" />
    <asp:LinqDataSource ID="dsDelivery" runat="server" ContextTypeName="Assignment.AssignmentDBDataContext"  OnDeleting="dsDelivery_Deleting" EnableDelete="True" EnableInsert="True" EnableUpdate="True" EntityTypeName="" TableName="DeliveryCompanies">
    </asp:LinqDataSource>
    <asp:GridView ID="gvDelivery" Width="100%" runat="server" CssClass="gridview" AutoGenerateColumns="False" AllowPaging="True" PageSize="3" DataKeyNames="CompanyID" DataSourceID="dsDelivery" OnRowDataBound="gvDelivery_RowDataBound" OnRowCreated="gvDelivery_RowCreated" OnSorting="gvDelivery_Sorting" OnRowEditing="gvDelivery_RowEditing" OnRowUpdating="gvDelivery_RowUpdating"  OnRowUpdated="gvDelivery_RowUpdated" AllowSorting="True">
        <Columns>
             <asp:TemplateField HeaderText="No" >
                    <ItemTemplate>
                        <asp:Label ID="lblItemIndex" Text="<%# Container.DataItemIndex + 1 %>" runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
             <asp:TemplateField HeaderText="CompanyName" SortExpression="CompanyName">
                 <EditItemTemplate>
                     <asp:HiddenField ID="hfCompanyID" Value='<%#Eval("CompanyID") %>' runat="server" />
                     <asp:TextBox ID="TextBox1" runat="server" MaxLength="50" Text='<%# Bind("CompanyName") %>'></asp:TextBox>
                     <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="Please enter Company Name" ControlToValidate="TextBox1" Display="Dynamic" ForeColor="Red">*</asp:RequiredFieldValidator>
                     <asp:CustomValidator ID="CustomValidator1" runat="server" ErrorMessage="Company Name exists!" OnServerValidate="CustomValidator1_ServerValidate" ControlToValidate="TextBox1" Display="Dynamic" ForeColor="Red">*</asp:CustomValidator>
                     </EditItemTemplate>
                 <ItemTemplate>
                     <asp:Label ID="Label1" runat="server" Text='<%# Bind("CompanyName") %>'></asp:Label>
                 </ItemTemplate>
             </asp:TemplateField>
            <asp:TemplateField HeaderText="Logo">
                <EditItemTemplate>
                    <asp:FileUpload ID="fulLogo" runat="server" onchange="showpreview(this);" />
                    <br />
                    <img id="imgpreview" height="100" width="120" src='<%# Eval("CompanyLogo") %>' style="border-width: 0px;" />
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Image ID="Image1" runat="server" Width="120px" Height="100px" ImageUrl='<%# Eval("CompanyLogo") %>' />
                </ItemTemplate>
            </asp:TemplateField>
             <asp:TemplateField HeaderText="PricePerKG" SortExpression="PricePerKG  ">
                 <EditItemTemplate>
                     <asp:TextBox ID="TextBox2" MaxLength="10" runat="server" Text='<%# Eval("PricePerKG", "{0:0.00}") %>'></asp:TextBox>
                     <asp:RangeValidator ID="RangeValidator1" runat="server" MinimumValue="1" MaximumValue="100" CssClass="error" ControlToValidate="TextBox2" Display="Dynamic" ErrorMessage="Price must be more than 0"></asp:RangeValidator>
                     <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="TextBox2" Display="Dynamic" ErrorMessage="Price per KG cannot be empty!" ForeColor="Red">*</asp:RequiredFieldValidator>
                     <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="TextBox2" ValidationExpression="\d{1,7}(\.\d{1,2})?" Display="Dynamic" ErrorMessage="Invalid price!" ForeColor="Red">*</asp:RegularExpressionValidator>
                 </EditItemTemplate>
                 <ItemTemplate>
                     <asp:Label ID="Label2" runat="server" Text='<%# Eval("PricePerKG", "{0:0.00}") %>'></asp:Label>
                 </ItemTemplate>
             </asp:TemplateField>
            <asp:TemplateField HeaderText="Status" SortExpression="Status">
                <EditItemTemplate>
                    <asp:CheckBox ID="chkStatus" runat="server" Checked='<%# Bind("Status") %>' />
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Button ID="btnStatus" runat="server" Text='<%#Eval("Status") %>' CausesValidation="false" OnCommand="btnStatus_Command" CommandName='<%#Eval("CompanyID") %>' CommandArgument='<%#Eval("Status") %>' />
                </ItemTemplate>
            </asp:TemplateField>
             <asp:TemplateField HeaderText="Action" ShowHeader="False">
                 <EditItemTemplate>
                     <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" CommandName="Update" Text="Update"></asp:LinkButton>
                     &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel"></asp:LinkButton>
                 </EditItemTemplate>
                 <ItemTemplate>
                     <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CssClass="btn btn-info" CommandName="Edit" Text="Edit">
                         <img src="../Images/Admin/Icons/edit%20(1).png" width="24" height="24" />
                     </asp:LinkButton>
                     &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CssClass="btn btn-danger" CommandName="Delete" Text="Delete">
                         <svg class="c-icon">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <use xlink:href="icons/free.svg#cil-trash"></use>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </svg>
                     </asp:LinkButton>
                 </ItemTemplate>
             </asp:TemplateField>
        </Columns>
        <PagerStyle CssClass="pager" HorizontalAlign="Right"  />
            <PagerSettings Mode="NumericFirstLast" PageButtonCount="5"  FirstPageText="First" LastPageText="Last"/>
            <RowStyle CssClass="rowStyle" />
            <SortedAscendingHeaderStyle CssClass="sort-asc" />
            <SortedDescendingHeaderStyle CssClass="sort-desc" />
    </asp:GridView>



    <!-- Delivery Company Add Modal -->
    <div class="modal fade" id="imageView" tabindex="-1" role="dialog" aria-labelledby="imageViewTitle" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="imageViewTitle">Delivery Company Add</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <table id="Table1" class="table" style="width: 70%" runat="server">
                        <tr>
                            <td style="width: 20%">
                                <label for="txtCompanyName" class="col-form-label-lg">Company Name: </label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtCompanyName" CssClass="form-control" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Please enter company name" CssClass="error" ControlToValidate="txtCompanyName" Display="Dynamic"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 20%">
                                <label for="fulCompanyLogo" class="col-form-label-lg">Company Logo: </label>
                            </td>
                            <td>
                                <asp:FileUpload ID="fulCompanyLogo" runat="server" onchange="showpreview(this);" />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Please choose an company logo" ControlToValidate="fulCompanyLogo" CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
                                <img id="imgpreview" height="100" width="150" src="../Images/Admin/NoImage.png" style="border-width: 0px;" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label for="txtPricePerKG" class="col-form-label-lg w-100">Price Per KG: </label>
                            </td>
                            <td>
                                <div class="input-group">
                                    <div class="input-group-append">
                                        <span class="input-group-text">RM</span>
                                        <asp:TextBox ID="txtPricePerKG" CssClass="form-control" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" CssClass="error" Display="Dynamic" ControlToValidate="txtPricePerKG" ErrorMessage="Please enter price per KG"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Invalid Price!" ValidationExpression="\d{1,7}(\.\d{1,2})?" Display="Dynamic"  ControlToValidate="txtPricePerKG"></asp:RegularExpressionValidator>
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label for="chkStatus" class="col-form-label-lg">Status:  </label>
                            </td>
                            <td>
                                <label class="switch">
                                    <asp:CheckBox ID="chkStatus" Checked="true" runat="server" />
                                    <span class="slider round"></span>
                                </label>
                            </td>
                        </tr>
                    </table>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <asp:Button ID="Button1" CssClass="btn btn-outline-info" runat="server" Text="Add" OnClick="Button1_Click" />
                </div>
            </div>
        </div>
    </div>

</asp:Content>