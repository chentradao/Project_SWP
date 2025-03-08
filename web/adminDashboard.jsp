<%@ page import="entity.Order" %>
<%@ page import="java.util.Vector" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.time.LocalDate" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isELIgnored="false" %>
<%@ page import="java.util.Map" %>
<%
    Map<String, Integer> productSales = (Map<String, Integer>) request.getAttribute("productSales");
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="description" content="">
        <meta name="author" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" type="text/css" href="styles/bootstrap4/bootstrap.min.css">
        <link href="plugins/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
        <link rel="stylesheet" type="text/css" href="styles/cart.css">
        <link rel="stylesheet" type="text/css" href="styles/cart_responsive.css">
        <title>Admin Dashboard</title>

        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
        <link
            href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
            rel="stylesheet">
        <!-- Custom styles for this template-->
        <link href="css/sb-admin-2.min.css" rel="stylesheet">

        <style>
            /* CSS cho toggle sidebar */
            .sidebar.toggled {
                width: 0 !important;
                overflow: hidden;
            }
            #content-wrapper.toggled {
                margin-left: 0 !important;
            }
            @media (min-width: 768px) {
                .sidebar {
                    width: 250px !important;
                    transition: all 0.3s;
                }
                #content-wrapper {
                    margin-left: 250px;
                    transition: all 0.3s;
                }
            }
            /* CSS cho nút kéo sidebar ra */
            #sidebarToggleTop {
                position: fixed;
                left: 10px;
                top: 150px;
                z-index: 1000;
                display: none; /* Ẩn mặc định */
                background-color: #4e73df;
                color: white;
                border: none;
                padding: 10px;
                border-radius: 5px;
                cursor: pointer;
            }
            /* Hiện nút khi sidebar đã ẩn */
            .sidebar.toggled ~ #sidebarToggleTop {
                display: block;
            }
            .responsive-chart {
                width: 100% !important;
                height: auto !important;
                max-width: 100%;
            }
        </style>
    </head>

    <body id="page-top">
        <!-- Topbar -->
        <header class="header_inner d-flex flex-row align-items-center justify-content-between" style="height: 120px; font-size: 16px; padding: 0px 64px 0px 60px">
            <div class="logo">
                <a href="index.jsp" class="logo">Estée Lauder</a>
            </div>
            <nav class="main_nav flex-grow-1 text-center">
                <ul class="navbar-nav d-flex flex-row justify-content-start" style="font-size: 18px; font-weight: bold; gap: 20px;">
                    <li class="nav-item"><a class="nav-link text-dark" href="index.jsp">Doanh thu</a></li>
                    <li class="nav-item"><a class="nav-link text-dark" href="index.jsp">Quảng cáo</a></li>
                    <li class="nav-item"><a class="nav-link text-dark" href="index.jsp">Kho hàng</a></li>
                    <li class="nav-item"><a class="nav-link text-dark" href="index.jsp">Tài khoản</a></li>
                </ul>
            </nav>
            <div class="nav-item dropdown">
                <a class="nav-link dropdown-toggle text-dark" href="#" id="userDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    ${sessionScope.acc.fullName}
                </a>
                <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="userDropdown">
                    <a class="dropdown-item" href="login?ac=logout">Đăng xuất</a>
                </div>
            </div>
        </header>

        <!-- Page Wrapper -->
        <div id="wrapper">
            <!--start sidebar -->
            <ul class="navbar-nav bg-dark sidebar sidebar-dark accordion toggled" id="accordionSidebar" style="font-family: Arial, sans-serif; font-weight: normal;">
                <li class="nav-item">
                    <form action="admin" method="post" class="p-3">
                        <label for="start-date">Ngày bắt đầu:</label>
                        <input type="date" id="start-date" name="start-date" value="${start_date}">
                        <label for="end-date">Ngày kết thúc:</label>
                        <input type="date" id="end-date" name="end-date" value="${end_date}">
                        <button type="submit" class="btn btn-primary mt-3 w-100">Lọc</button>
                    </form>
                </li>        
                <!-- Divider -->
                <hr class="sidebar-divider d-none d-md-block">
                <!-- Sidebar Toggler (Sidebar) -->
                <div class="text-center d-none d-md-inline">
                    <button class="rounded-circle border-0" id="sidebarToggle"><i class="fas fa-bars"></i></button>
                </div>
            </ul>
            <!-- End of Sidebar -->

            <!-- Nút kéo sidebar ra -->
            <button id="sidebarToggleTop" class="btn"><i class="fas fa-bars"></i></button>

            <!-- Content Wrapper -->
            <div id="content-wrapper" class="d-flex flex-column toggled">
                <!-- Main Content -->
                <div id="content">               
                    <!-- Begin Page Content -->
                    <div class="container-fluid">
                        <!-- Content Row -->
                        <div class="row">
                            <!-- Earnings (Monthly) Card Example -->
                            <div class="col-xl-4 col-md-6 mb-4">
                                <div class="card border-left-primary shadow h-100 py-2">
                                    <div class="card-body">
                                        <div class="row no-gutters align-items-center">
                                            <div class="col mr-2">
                                                <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">
                                                    Tổng doanh thu đã nhận</div>
                                                <div class="h5 mb-0 font-weight-bold text-gray-800">${EarnedRevenue}</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Earnings (Monthly) Card Example -->
                            <div class="col-xl-4 col-md-6 mb-4">
                                <div class="card border-left-success shadow h-100 py-2">
                                    <div class="card-body">
                                        <div class="row no-gutters align-items-center">
                                            <div class="col mr-2">
                                                <div class="text-xs font-weight-bold text-success text-uppercase mb-1">
                                                    Tổng doanh thu dự kiến</div>
                                                <div class="h5 mb-0 font-weight-bold text-gray-800">${UpcomingRevunue}</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Pending Requests Card Example -->
                            <div class="col-xl-4 col-md-6 mb-4">
                                <div class="card border-left-warning shadow h-100 py-2">
                                    <div class="card-body">
                                        <div class="row no-gutters align-items-center">
                                            <div class="col mr-2">
                                                <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">
                                                    Tổng đơn đã hoàn thành</div>
                                                <div class="h5 mb-0 font-weight-bold text-gray-800">${OrderCount}</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Content Row -->
                        <div class="row">
                            <!-- Area Chart -->
                            <div class="col-xl-8 col-lg-7">
                                <div class="card shadow mb-4">
                                    <!-- Card Header - Dropdown -->
                                    <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                        <h6 class="m-0 font-weight-bold text-primary">Biểu đồ doanh thu</h6>
                                    </div>
                                    <!-- Card Body -->
                                    <div class="card-body">
                                        <canvas id="sale-revenue" class="responsive-chart"></canvas>
                                    </div>
                                </div>
                            </div>

                            <!-- Pie Chart -->
                            <div class="col-xl-4 col-lg-5">
                                <div class="card mb-4">
                                    <!-- Card Header - Dropdown -->
                                    <div class="card-header py-3 justify-content-between">
                                        <h6 class="m-0 font-weight-bold text-primary">Biểu đồ đơn</h6>
                                    </div>
                                    <!-- Card Body -->
                                    <div class="card-body">
                                        <canvas id="order-pie-chart" class="responsive-chart"></canvas>                                 
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Content Row -->
                        <div class="row">
                            <!-- Content Column -->
                            <div class="col-lg-6 mb-4">
                                <!-- Project Card Example -->
                                <div class="card shadow mb-4">
                                    <div class="card-header py-3">
                                        <h6 class="m-0 font-weight-bold text-primary">Doanh thu đã nhận</h6>
                                    </div>
                                    <div class="card-body">
                                        <canvas id="revenue-pie-chart" class="responsive-chart"></canvas>
                                    </div>
                                </div>
                            </div>

                            <div class="col-lg-6 mb-4">
                                <!-- Illustrations -->
                                <div class="card shadow mb-4">
                                    <div class="card-header py-3">
                                        <h6 class="m-0 font-weight-bold text-primary">Bán chạy</h6>
                                    </div>
                                    <div class="card-body">
                                        <canvas id="bestSoldChart" class="responsive-chart"></canvas>
                                    </div>
                                </div>                           
                            </div>
                        </div>
                    </div>
                    <!-- /.container-fluid -->
                </div>
                <!-- End of Main Content -->
            </div>
            <!-- End of Content Wrapper -->
        </div>
        <!-- End of Page Wrapper -->

        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.js"></script>
        <script type="text/javascript">
            // Biểu đồ đường doanh thu
            var salesData = '${jsonData}';
            var data = JSON.parse(salesData);
            var labels = data.map(function (sale) {
                return sale.yearMonth;
            });
            var totalCosts = data.map(function (sale) {
                return sale.totalCost;
            });

            var lineChart = document.getElementById("sale-revenue").getContext("2d");
            var myLineChart = new Chart(lineChart, {
                type: "line",
                data: {
                    labels: labels,
                    datasets: [{
                            label: "Doanh thu",
                            data: totalCosts,
                            backgroundColor: "rgba(0, 156, 255, 0.5)",
                            borderColor: "rgba(0, 156, 255, 1)",
                            borderWidth: 1
                        }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false
                }
            });

            // Biểu đồ tròn số đơn
            var pieChart = document.getElementById("order-pie-chart").getContext("2d");
            var myPieChart = new Chart(pieChart, {
                type: "pie",
                data: {
                    labels: ["Đơn Hoàn Thành", "Đơn Chờ Xác Nhận", "Đơn Đang Giao", "Đơn Đã Hủy", "Đơn Hoàn Trả"],
                    datasets: [{
                            label: "Order Status",
                            data: [${completed.size()}, ${waiting.size()}, ${shipping.size()}, ${cancelled.size()}, ${returned.size()}],
                            backgroundColor: [
                                "rgba(75, 192, 192, 0.5)",
                                "rgba(255, 206, 86, 0.5)",
                                "rgba(54, 162, 235, 0.5)",
                                "rgba(255, 99, 132, 0.5)",
                                "rgba(153, 102, 255, 0.5)"
                            ],
                            borderColor: [
                                "rgba(75, 192, 192, 1)",
                                "rgba(255, 206, 86, 1)",
                                "rgba(54, 162, 235, 1)",
                                "rgba(255, 99, 132, 1)",
                                "rgba(153, 102, 255, 1)"
                            ],
                            borderWidth: 1
                        }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    onClick: function (event, elements) {
                        if (elements.length > 0) {
                            var index = elements[0]._index;
                            var urls = [
                                "http://example.com/don-hoan-thanh",
                                "http://example.com/don-cho-xac-nhan",
                                "http://example.com/don-dang-giao",
                                "http://example.com/don-da-huy",
                                "http://example.com/don-hoan-tra"
                            ];
                            window.location.href = urls[index];
                        }
                    }
                }
            });

            // Biểu đồ tròn doanh thu
            var pieChart = document.getElementById("revenue-pie-chart").getContext("2d");
            var myPieChart = new Chart(pieChart, {
                type: "pie",
                data: {
                    labels: ["Doanh thu đã nhận", "Danh thu chưa nhận"],
                    datasets: [{
                            label: "Order Status",
                            data: [${EarnedRevenue}, ${UpcomingRevunue}],
                            backgroundColor: [
                                "rgba(75, 192, 192, 0.5)",
                                "rgba(255, 206, 86, 0.5)",
                            ],
                            borderColor: [
                                "rgba(75, 192, 192, 1)",
                                "rgba(255, 206, 86, 1)",
                            ],
                            borderWidth: 1
                        }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    onClick: function (event, elements) {
                        if (elements.length > 0) {
                            var index = elements[0]._index;
                            var urls = [
                                "http://example.com/don-hoan-thanh",
                                "http://example.com/don-cho-xac-nhan",
                            ];
                            window.location.href = urls[index];
                        }
                    }
                }
            });

            // Lấy dữ liệu cho bestSold
            var labels = [];
            var dataValues = [];
            <c:forEach var="entry" items="${productSales}">
                labels.push("${entry.key}");
                dataValues.push(${entry.value});
            </c:forEach>
            labels.push("");
            dataValues.push(0);

            document.addEventListener("DOMContentLoaded", function () {
                var ctx = document.getElementById('bestSoldChart').getContext('2d');
                var salesChart = new Chart(ctx, {
                    type: 'bar',
                    data: {
                        labels: labels,
                        datasets: [{
                                label: 'Số lượng bán ra',
                                data: dataValues,
                                backgroundColor: ['#36A2EB', '#36A2EB', '#36A2EB', '#36A2EB', '#36A2EB'],
                                borderColor: '#333',
                                borderWidth: 1
                            }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        plugins: {
                            legend: {
                                display: false
                            }
                        },
                        scales: {
                            x: {
                                ticks: {
                                    autoSkip: false,
                                    maxRotation: 90,
                                    minRotation: 90
                                }
                            },
                            y: {
                                beginAtZero: true,
                                suggestedMin: 0,
                                ticks: {
                                    stepSize: 1,
                                    precision: 0
                                }
                            }
                        }
                    }
                });
            });
        </script>
        <script src="js/jquery-3.2.1.min.js"></script>
        <script src="styles/bootstrap4/popper.js"></script>
        <script src="styles/bootstrap4/bootstrap.min.js"></script>
        <script src="plugins/easing/easing.js"></script>
        <script src="plugins/parallax-js-master/parallax.min.js"></script>
        <script src="js/cart_custom.js"></script>

        <!-- JavaScript cho toggle sidebar -->
        <script>
            $(document).ready(function () {
                // Nút trong sidebar để ẩn
                $("#sidebarToggle").on("click", function (e) {
                    e.preventDefault();
                    $(".sidebar").toggleClass("toggled");
                    $("#content-wrapper").toggleClass("toggled");
                });

                // Nút ngoài để kéo sidebar ra
                $("#sidebarToggleTop").on("click", function (e) {
                    e.preventDefault();
                    $(".sidebar").toggleClass("toggled");
                    $("#content-wrapper").toggleClass("toggled");
                });
            });
        </script>
    </body>
</html>