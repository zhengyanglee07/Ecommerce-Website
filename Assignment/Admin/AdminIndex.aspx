<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="AdminIndex.aspx.cs" Inherits="Assignment.Admin.AdminIndex" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
        <script src="js/main.js" type="text/javascript" ></script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <div class="c-body">
        <main class="c-main">
            <div class="container-fluid">
                <div class="fade-in">
                    <div class="row">
                        <!--New Order Chart-->
                        <div class="col-sm-6 col-lg-3">
                            <div class="card text-white bg-primary">
                                <div class="card-body card-body pb-0 d-flex justify-content-between align-items-start">
                                    <div>
                                        <div class="text-value-lg">
                                            <asp:Label ID="lblTodayOrder" runat="server" Text="0"></asp:Label>
                                        </div>
                                        <div>New Order</div>
                                    </div>
                                </div>
                                <div class="c-chart-wrapper mt-3 mx-3" style="height: 70px;">
                                    <div class="chartjs-size-monitor">
                                        <div class="chartjs-size-monitor-expand">
                                            <div class=""></div>
                                        </div>
                                        <div class="chartjs-size-monitor-shrink">
                                            <div class=""></div>
                                        </div>
                                    </div>
                                    <canvas class="chart chartjs-render-monitor" id="card-chart1" height="87" style="display: block; height: 70px; width: 293px;" width="366"></canvas>
                                </div>
                            </div>
                        </div>

                        <!--Total Sales Chart-->
                        <div class="col-sm-6 col-lg-3">
                            <div class="card text-white bg-info">
                                <div class="card-body card-body pb-0 d-flex justify-content-between align-items-start">
                                    <div>
                                        <div class="text-value-lg">
                                            <asp:Label ID="lblTotalSales" runat="server" Text="Label"></asp:Label>
                                        </div>
                                        <div>Total Sales</div>
                                    </div>
                                </div>
                                <div class="c-chart-wrapper mt-3 mx-3" style="height: 70px;">
                                    <div class="chartjs-size-monitor">
                                        <div class="chartjs-size-monitor-expand">
                                            <div class=""></div>
                                        </div>
                                        <div class="chartjs-size-monitor-shrink">
                                            <div class=""></div>
                                        </div>
                                    </div>
                                    <canvas class="chart chartjs-render-monitor" id="card-chart2" height="87" width="366" style="display: block; height: 70px; width: 293px;"></canvas>
                                </div>
                            </div>
                        </div>

                        <!--Daily Visitors Chart-->
                        <div class="col-sm-6 col-lg-3">
                            <div class="card text-white bg-warning">
                                <div class="card-body card-body pb-0 d-flex justify-content-between align-items-start">
                                    <div>
                                        <div class="text-value-lg">
                                            <asp:Label ID="lblVisitors" runat="server" Text=""></asp:Label>
                                        </div>
                                        <div>Daily Visitors</div>
                                    </div>
                                </div>
                                <div class="c-chart-wrapper mt-3" style="height: 70px;">
                                    <div class="chartjs-size-monitor">
                                        <div class="chartjs-size-monitor-expand">
                                            <div class=""></div>
                                        </div>
                                        <div class="chartjs-size-monitor-shrink">
                                            <div class=""></div>
                                        </div>
                                    </div>
                                    <canvas class="chart chartjs-render-monitor" id="card-chart3" height="87" width="406" style="display: block; height: 70px; width: 325px;"></canvas>
                                </div>
                            </div>
                        </div>

                        <!--New Customers Chart-->
                        <div class="col-sm-6 col-lg-3">
                            <div class="card text-white bg-danger">
                                <div class="card-body card-body pb-0 d-flex justify-content-between align-items-start">
                                    <div>
                                        <div class="text-value-lg">
                                            <asp:Label ID="lblTotalUser" runat="server" Text=""></asp:Label>
                                        </div>
                                        <div>New Customers</div>
                                    </div>
                                </div>
                                <div class="c-chart-wrapper mt-3 mx-3" style="height: 70px;">
                                    <div class="chartjs-size-monitor">
                                        <div class="chartjs-size-monitor-expand">
                                            <div class=""></div>
                                        </div>
                                        <div class="chartjs-size-monitor-shrink">
                                            <div class=""></div>
                                        </div>
                                    </div>
                                    <canvas class="chart chartjs-render-monitor" id="card-chart4" height="87" width="366" style="display: block; height: 70px; width: 293px;"></canvas>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!--Statistics-->
                    <div class="card">
                        <div class="card-body">
                            <div class="d-flex justify-content-between">
                                <div>
                                    <h4 class="card-title mb-0">Statistics</h4>
                                    <div class="small text-muted">
                                        <asp:Label ID="lblDate" runat="server"></asp:Label>
                                    </div>  
                                </div>
                                <div class="btn-toolbar d-none d-md-block" role="toolbar" aria-label="Toolbar with buttons">
                                    <div class="btn-group mr-2" role="group" aria-label="First group">
                                        <asp:Button ID="btnDay" CssClass="btn btn-secondary" runat="server" Text="Day" OnCommand="btnDay_Command" CommandArgument="day"/>
                                        <asp:Button ID="btnMonth" CssClass="btn btn-secondary" runat="server" Text="Month" OnCommand="btnDay_Command" CommandArgument="month"/>
                                        <asp:Button ID="btnYear" CssClass="btn btn-secondary" runat="server" Text="Year" OnCommand="btnDay_Command" CommandArgument="year" />
                                    </div>
                                </div>
                            </div>
                            <div class="c-chart-wrapper" style="height: 300px; margin-top: 40px;">
                                <div class="chartjs-size-monitor">
                                    <div class="chartjs-size-monitor-expand">
                                        <div class=""></div>
                                    </div>
                                    <div class="chartjs-size-monitor-shrink">
                                        <div class=""></div>
                                    </div>
                                </div>
                                <canvas class="chart chartjs-render-monitor" id="main-chart" height="375" width="801" style="display: block; height: 300px; width: 641px;"></canvas>
                            </div>
                        </div>
                        
                    </div>
                </div>
            </div>
        </main>
    </div>

</asp:Content>


<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
        <script>
            chart1(cLabels, "Total Order", c1Data, 0, c1Max);
            chart2(cLabels, "Total Sales", c2Data, 0, c2Max);
            chart3(cLabels, "Total Visitor", c3Data, 0, c3Max);
            chart4(cLabels, "New Customer", c4Data, 0, c4Max);
            chart5(c5Labels, "Total Order", "Total Sales", "Total Customer", c5Data1, c5Data2, c5Data3);
        </script>
</asp:Content>