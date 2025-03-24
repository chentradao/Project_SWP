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
        <title>Admin Dashboard - Tổng kết Doanh thu</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="description" content="">
        <meta name="author" content="">
        <link rel="stylesheet" type="text/css" href="styles/bootstrap4/bootstrap.min.css">
        <link href="plugins/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
        <link rel="stylesheet" type="text/css" href="styles/cart.css">
        <link rel="stylesheet" type="text/css" href="styles/cart_responsive.css">      
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
        <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">
        <link href="css/sb-admin-2.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

        <style>
            .sidebar {
                transition: all 0.3s ease-in-out;
            }
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
                }
                #content-wrapper {
                    margin-left: 250px;
                    transition: all 0.3s ease-in-out;
                    padding-top: 0;
                    min-height: calc(100vh - 120px);
                }
            }
            #sidebarToggleTop {
                position: fixed;
                left: 10px;
                top: 150px;
                z-index: 1000;
                display: none;
                background-color: #4e73df;
                color: white;
                border: none;
                padding: 10px;
                border-radius: 5px;
                cursor: pointer;
                transition: all 0.3s ease;
            }
            #sidebarToggleTop:hover {
                background-color: #375ab5;
            }
            .sidebar.toggled ~ #sidebarToggleTop {
                display: block;
            }
            #sidebarToggle {
                background-color: rgba(255, 255, 255, 0.2);
                width: 40px;
                height: 40px;
                line-height: 40px;
                text-align: center;
                border-radius: 50%;
                transition: all 0.3s ease;
            }
            #sidebarToggle:hover {
                background-color: rgba(255, 255, 255, 0.3);
            }
            .filter-section {
                padding: 15px;
                border-radius: 5px;
                margin-bottom: 20px;
                color: #fff;
            }

            .filter-section .btn-primary {
                background-color: #4e73df;
                border-color: #4e73df;
            }
            .filter-section .btn-primary:hover {
                background-color: #375ab5;
                border-color: #375ab5;
            }
            .card {
                margin-bottom: 20px;
                border: none;
                border-radius: 10px;
                box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.15);
            }
            .card-body {
                padding: 1.5rem;
            }
            .chart-container {
                position: relative;
                height: 400px;
                margin-bottom: 20px;
            }
            .table th, .table td {
                vertical-align: middle;
            }
            .header_inner {
                position: relative;
                height: 120px;
                padding: 0 64px;
                background-color: #fff;
                box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.15);
            }
        </style>
    </head>

    <body id="page-top">
        <header class="header_inner d-flex flex-row align-items-center justify-content-between">
            <div class="logo">
                <a href="index.jsp" class="logo">Estée Lauder</a>
            </div>
            <nav class="main_nav flex-grow-1 text-center">
                <ul class="navbar-nav d-flex flex-row justify-content-start" style="font-size: 18px; font-weight: bold; gap: 20px;">
                    <li class="nav-item"><a class="nav-link text-dark" href="revenue">Doanh thu</a></li>
                    <li class="nav-item"><a class="nav-link text-dark" href="orderManagement.jsp">Quản lý Đơn hàng</a></li>
                    <li class="nav-item"><a class="nav-link text-dark" href="inventory">Kho hàng</a></li>
                    <li class="nav-item"><a class="nav-link text-dark" href="ListUser">Tài khoản</a></li>
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

        <div id="wrapper">
            <ul class="navbar-nav bg-dark sidebar sidebar-dark accordion" id="accordionSidebar" style="font-family: Arial, sans-serif; font-weight: normal;">
                <li class="nav-item">
                    <form action="admin" method="post" class="filter-section">
                        <label for="filter-type">Loại lọc:</label>
                        <select id="filter-type" name="filter-type">
                            <option value="day">Theo ngày</option>
                            <option value="month">Theo tháng</option>
                            <option value="year">Theo năm</option>
                        </select>
                        <label for="start-date">Ngày bắt đầu:</label>
                        <input type="date" id="start-date" name="start-date" value="${start_date}">
                        <label for="end-date">Ngày kết thúc:</label>
                        <input type="date" id="end-date" name="end-date" value="${end_date}">
                        <button type="submit" class="btn btn-primary mt-3 w-100">Lọc</button>
                    </form>
                </li>
                <hr class="sidebar-divider d-none d-md-block">
                <div class="text-center d-none d-md-inline">
                    <button class="rounded-circle border-0" id="sidebarToggle"><i class="fas fa-bars"></i></button>
                </div>
            </ul>

            <button id="sidebarToggleTop" class="btn"><i class="fas fa-bars"></i></button>

            <div id="content-wrapper" class="d-flex flex-column">
                <div id="content">
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-xl-4 col-md-6 mb-4">
                                <div class="card border-left-primary shadow h-100 py-2">
                                    <div class="card-body">
                                        <div class="row no-gutters align-items-center">
                                            <div class="col mr-2">
                                                <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">
                                                    Tổng doanh thu
                                                </div>
                                                <div class="h5 mb-0 font-weight-bold text-gray-800">
                                                    <c:out value="${not empty totalRevenue ? totalRevenue : 0}"/> VND
                                                </div>
                                            </div>
                                            <div class="col-auto">
                                                <i class="fas fa-dollar-sign fa-2x text-gray-300"></i>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xl-4 col-md-6 mb-4">
                                <div class="card border-left-success shadow h-100 py-2">
                                    <div class="card-body">
                                        <div class="row no-gutters align-items-center">
                                            <div class="col mr-2">
                                                <div class="text-xs font-weight-bold text-success text-uppercase mb-1">
                                                    Số lượng bán
                                                </div>
                                                <div class="h5 mb-0 font-weight-bold text-gray-800">
                                                    <c:out value="${not empty totalSold ? totalSold : 0}"/>
                                                </div>
                                            </div>
                                            <div class="col-auto">
                                                <i class="fas fa-shopping-cart fa-2x text-gray-300"></i>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xl-4 col-md-6 mb-4">
                                <div class="card border-left-info shadow h-100 py-2">
                                    <div class="card-body">
                                        <div class="row no-gutters align-items-center">
                                            <div class="col mr-2">
                                                <div class="text-xs font-weight-bold text-info text-uppercase mb-1">
                                                    Tồn kho còn lại
                                                </div>
                                                <div class="h5 mb-0 font-weight-bold text-gray-800">
                                                    <c:out value="${not empty totalStock ? totalStock : 0}"/>
                                                </div>
                                            </div>
                                            <div class="col-auto">
                                                <i class="fas fa-warehouse fa-2x text-gray-300"></i>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-xl-6 col-lg-6">
                                <div class="card shadow mb-4">
                                    <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                        <h6 class="m-0 font-weight-bold text-primary">Biểu đồ Doanh thu</h6>
                                        <form action="admin" method="post" class="filter-form">                                    
                                            <select id="filter-type" name="filter-type" onchange="this.form.submit()">
                                                <option value="year" ${filterType == 'year' ? 'selected' : ''}>Theo năm</option>
                                                <option value="month" ${filterType == 'month' ? 'selected' : ''}>Theo tháng</option>
                                            </select>                                    
                                        </form>
                                    </div>
                                    <div class="card-body">
                                        <div class="chart-container">
                                            <canvas id="revenueChart"></canvas>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xl-6 col-lg-6">
                                <div class="card shadow mb-4">
                                    <div class="card-header py-3">
                                        <h6 class="m-0 font-weight-bold text-primary">Doanh thu theo Danh mục</h6>
                                    </div>
                                    <div class="card-body">
                                        <div class="chart-container">
                                            <canvas id="categoryRevenueChart"></canvas>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-xl-6 col-lg-6">
                                <div class="card shadow mb-4">
                                    <div class="card-header py-3">
                                        <h6 class="m-0 font-weight-bold text-primary">Số Khách hàng Đăng ký mới</h6>
                                    </div>
                                    <div class="card-body">
                                        <div class="chart-container">
                                            <canvas id="newCustomerChart"></canvas>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xl-6 col-lg-6">
                                <div class="card shadow mb-4">
                                    <div class="card-header py-3">
                                        <h6 class="m-0 font-weight-bold text-primary">Tồn kho</h6>
                                    </div>
                                    <div class="card-body">
                                        <div class="chart-container">
                                            <canvas id="inventoryChart"></canvas>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-xl-6 col-lg-6">
                                <div class="card shadow mb-4">
                                    <div class="card-header py-3">
                                        <h6 class="m-0 font-weight-bold text-primary">Top Sản phẩm Bán chạy</h6>
                                    </div>
                                    <div class="card-body">
                                        <div class="table-responsive">
                                            <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                                <thead>
                                                    <tr>
                                                        <th>Tên sản phẩm</th>
                                                        <th>Kích thước</th>
                                                        <th>Màu sắc</th>
                                                        <th>Số lượng bán</th>
                                                        <th>Doanh thu</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="item" items="${topSellingProducts}" varStatus="loop">
                                                        <tr>
                                                            <td>${item.productName}</td>
                                                            <td>${item.size}</td>
                                                            <td>${item.color}</td>
                                                            <td>${item.soldQuantity}</td>
                                                            <td><c:out value="${item.soldQuantity * item.price}"/> VND</td>
                                                        </tr>
                                                    </c:forEach>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xl-6 col-lg-6">
                                <div class="card shadow mb-4">
                                    <div class="card-header py-3">
                                        <h6 class="m-0 font-weight-bold text-primary">Sản phẩm Sắp hết hàng</h6>
                                    </div>
                                    <div class="card-body">
                                        <div class="table-responsive">
                                            <table class="table table-bordered" id="lowStockTable" width="100%" cellspacing="0">
                                                <thead>
                                                    <tr>
                                                        <th>Tên sản phẩm</th>
                                                        <th>Kích thước</th>
                                                        <th>Màu sắc</th>
                                                        <th>Số lượng tồn</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="item" items="${lowStockProducts}" varStatus="loop">
                                                        <tr>
                                                            <td>${item.productName}</td>
                                                            <td>${item.size}</td>
                                                            <td>${item.color}</td>
                                                            <td>${item.quantity}</td>
                                                        </tr>
                                                    </c:forEach>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script src="js/jquery-3.2.1.min.js"></script>
        <script src="styles/bootstrap4/popper.js"></script>
        <script src="styles/bootstrap4/bootstrap.min.js"></script>
        <script src="plugins/easing/easing.js"></script>
        <script src="plugins/parallax-js-master/parallax.min.js"></script>
        <script src="js/cart_custom.js"></script>

        <script>
                $(document).ready(function () {
                const $sidebar = $("#accordionSidebar");
                const $contentWrapper = $("#content-wrapper");
                const $toggleBtn = $("#sidebarToggle");
                const $toggleBtnTop = $("#sidebarToggleTop");

                function toggleSidebar() {
                $sidebar.toggleClass("toggled");
                $contentWrapper.toggleClass("toggled");
                $toggleBtnTop.toggle($sidebar.hasClass("toggled"));
                }

                $toggleBtn.add($toggleBtnTop).on("click", function (e) {
                e.preventDefault();
                toggleSidebar();
                });

                // Biểu đồ Doanh thu
                const revenueLabels = '${revenueLabels}' ? JSON.parse('${revenueLabels}') : [];
                const revenueData = '${revenueData}' ? JSON.parse('${revenueData}') : [];
                const revenueChart = new Chart(document.getElementById('revenueChart'), {
                type: 'bar',
                data: {
                labels: revenueLabels,
                datasets: [{
                label: 'Doanh thu (VND)',
                data: revenueData,
                backgroundColor: 'rgba(54, 162, 235, 0.2)',
                borderColor: 'rgba(54, 162, 235, 1)',
                borderWidth: 1
                }]
                },
                options: {
                responsive: true,
                maintainAspectRatio: false,
                scales: {
                y: {beginAtZero: true, ticks: {callback: value => value.toLocaleString('vi-VN') + ' VND'}},
                x: {ticks: {maxRotation: 45, minRotation: 45}}
                }
                }
                });

                // Biểu đồ Doanh thu theo Danh mục
                const categoryLabels = '${categoryRevenueData}' ? JSON.parse('${categoryRevenueData}').categories : [];
                const categoryData = '${categoryRevenueData}' ? JSON.parse('${categoryRevenueData}').categoryRevenue : [];
                const categoryRevenueChart = new Chart(document.getElementById('categoryRevenueChart'), {
                type: 'pie',
                 data: {
                 labels: categoryLabels,
                datasets: [{
                 label: 'Doanh thu (VND)',
                 data: categoryData,
                 backgroundColor: ['#4e73df', '#1cc88a', '#36b9cc', '#f6c23e'],
                borderColor: '#fff',
                 borderWidth: 1
            }]
               },
               options: {
                 responsive: true,
                 maintainAspectRatio: false,
                plugins: {
                tooltip: {callbacks: {label: context => `${context.label}: ${context.parsed.toLocaleString('vi-VN')} VND`}}
                }
                }
                });

                // Biểu đồ Số khách hàng mới
                const newCustomerLabels = '${newCustomerData}' ? JSON.parse('${newCustomerData}').timeLabels : [];
                const newCustomerData = '${newCustomerData}' ? JSON.parse('${newCustomerData}').newCustomers : [];
                const newCustomerChart = new Chart(document.getElementById('newCustomerChart'), {
                type: 'bar',
                data: {
                labels: newCustomerLabels,
                datasets: [{
                label: 'Khách hàng mới',
                data: newCustomerData,
                backgroundColor: 'rgba(28, 200, 138, 0.2)',
                borderColor: '#1cc88a',
                borderWidth: 2,
                fill: true
                }]
                },
                options: {
                responsive: true,
                maintainAspectRatio: false,
                scales: {
                y: {beginAtZero: true},
                x: {ticks: {maxRotation: 45, minRotation: 45}}
                }
                }
                });

                // Biểu đồ Tồn kho
                const inventoryLabels = '${inventoryData}' ? JSON.parse('${inventoryData}').productNames : [];
                const inventoryData = '${inventoryData}' ? JSON.parse('${inventoryData}').stockQuantities : [];
                const inventoryChart = new Chart(document.getElementById('inventoryChart'), {
                type: 'bar',
                data: {
                labels: inventoryLabels,
                datasets: [{
                label: 'Số lượng tồn',
                data: inventoryData,
                backgroundColor: 'rgba(246, 194, 62, 0.2)',
                borderColor: '#f6c23e',
                borderWidth: 1
                }]
                },
                 options: {
                 responsive: true,
                  maintainAspectRatio: false,
                  scales: {
                 y: {beginAtZero: true},
                 x: {ticks: {maxRotation: 45, minRotation: 45}}
                }
                }
                  });

                 $(".filter-form select").on("change", function () {
                 $(this).closest("form").submit();
                });

                $("#content").css("opacity", 1);
                 });
        </script>
    </body>
</html>