<%@ page import="entity.Order" %>
<%@ page import="java.util.Vector" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.time.LocalDate" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>



<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="description" content="Wish shop project">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" type="text/css" href="styles/bootstrap4/bootstrap.min.css">
        <link href="plugins/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
        <link rel="stylesheet" type="text/css" href="styles/cart.css">
        <link rel="stylesheet" type="text/css" href="styles/cart_responsive.css">
        <title>Admin Dashboard</title>
        <style>
            * {
                box-sizing: border-box;
                margin: 0;
                padding: 0;
            }

            body {
                font-family: 'Arial', sans-serif;
                background-color: #f5f5f5;
                display: flex;
                min-height: 100vh;
            }

            /* Main content */
            .main-content {
                flex: 1;
                padding: 100px;
                background-color: #f9f9f9;
                display: flex;
                flex-direction: column;
                gap: 20px;
            }

            .chart-container {
                display: flex;
                width: 100%;
            }

            .chart {
                flex: 1;
                padding: 50px;
            }

            .blog-list {
                display: grid;
                gap: 15px;
            }

            .blog-item {
                display: flex;
                background-color: white;
                padding: 15px;
                border-radius: 6px;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
                cursor: pointer;
                transition: transform 0.2s;
            }

            .blog-item:hover {
                transform: translateY(-2px);
            }

            .selected {
                background-color: #f0f9ff;
                border: 2px solid #3498db;
            }

            .post-image {
                width: 80px;
                height: 80px;
                object-fit: cover;
                margin-right: 15px;
            }
            .filter-container {
                display: flex;
                justify-content: center;
                align-items: center;
                margin-top: 20px;
                margin-left: 100px;
            }

            .filter-container label,
            .filter-container input,
            .filter-container button {
                margin-right: 10px;
            }
        </style>
    </head>
    <body>
        <div class="super_container">
            <div class="main-content">
                <div class="row justify-content: center">
                    <!-- filter lọc data -->
                    <div class="filter-container ">
                        <form action="admin" method="post">
                            <label for="start-date">Ngày bắt đầu:</label>
                            <input type="date" id="start-date" name="start-date" value="2025-01-01">

                            <label for="end-date">Ngày kết thúc:</label>
                            <input type="date" id="end-date" name="end-date" value="<%=java.sql.Date.valueOf(LocalDate.now()).toString()%>">

                            <button name="submit" type="submit" value="sumbit">Lọc</button>
                        </form>
                    </div>

                    <!-- Số liệu thống kê -->
                    <div class="col-xl-2 col-md-4 mb-3">
                        <div class="card border-left-primary shadow h-100 py-2">
                            <div class="card-body">
                                <div class="row no-gutters align-items-center">
                                    <div class="col mr-2">
                                        <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">
                                            <a href="#" >Tổng doanh thu đã nhận </a> </div>
                                        <div class="h5 mb-0 font-weight-bold text-gray-800">${EarnedRevenue}</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-xl-2 col-md-4 mb-3">
                        <div class="card border-left-primary shadow h-100 py-2">
                            <div class="card-body">
                                <div class="row no-gutters align-items-center">
                                    <div class="col mr-2">
                                        <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">
                                            <a href="#" >Tổng doanh thu dự kiến </a> </div>
                                        <div class="h5 mb-0 font-weight-bold text-gray-800">${UpcomingRevunue}</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-xl-2 col-md-4 mb-3">
                        <div class="card border-left-success shadow h-100 py-2">
                            <div class="card-body">
                                <div class="row no-gutters align-items-center">

                                    <div class="col mr-2">
                                        <div class="text-xs font-weight-bold text-success text-uppercase mb-1">
                                            <a href="#" >Tổng đơn</a>    
                                        </div>
                                        <div class="h5 mb-0 font-weight-bold text-gray-800">${OrderCount}</div>
                                    </div>
                                    <div class="col-auto">
                                        <i class="fas fa-dollar-sign fa-2x text-gray-300"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- xuất file excel -->
                    <div class="d-sm-flex align-items-center justify-content-between mb-4">
                        <form action="admin" method="post">
                            <input type="hidden" name="action" value="export">
                            <button type="submit">Xuất ra Excel</button>
                        </form>
                    </div>

                </div>
                <div class="chart-container">
                    <div class="chart">
                        <canvas id="sale-revenue"></canvas>
                    </div>

                </div>
                                    
                                    
                <h2>Đơn hàng gần nhất</h2>
        <table style="border-collapse: collapse; width: 100%;">
        <thead>
            <tr>
                <th style="border: 1px solid black; padding: 8px; background-color: #f2f2f2;">Customer Name</th>
                <th style="border: 1px solid black; padding: 8px; background-color: #f2f2f2;">Order Date</th>
                <th style="border: 1px solid black; padding: 8px; background-color: #f2f2f2;">Total Cost</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="order" items="${latestOrders}">
                <tr>
                    <td style="border: 1px solid black; padding: 8px;"><a href="#">${order.getCustomerName()}</a></td>
                    <td style="border: 1px solid black; padding: 8px;"><a href="#">${order.getOrderDate()}</td>
                    <td style="border: 1px solid black; padding: 8px;"><a href="#">${order.getTotalCost()}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
                <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.js"></script>
                <script type="text/javascript">
                    // Lấy dữ liệu JSON từ request attribute
                    var salesData = '${jsonData}';

                    // Chuyển đổi chuỗi JSON thành đối tượng JavaScript
                    var data = JSON.parse(salesData);

                    // Tạo mảng labels và mảng data từ salesData
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
                            responsive: true
                        }
                    });
                </script>

            </div>
            <header class="header">
                <div class="header_inner d-flex flex-row align-items-center justify-content-start">
                    <div class="logo"><a href="index.jsp">Estée Lauder</a></div>
                    <nav class="main_nav">
                        <ul>
                            <li><a href="index.jsp">Quản lý nhân viên</a></li>
                            <li><a href="index.jsp">Quản lý mã giảm giá</a></li>
                            <li><a href="index.jsp">Quản lý danh mục hàng</a></li>
                            <li><a href="index.jsp">Quản lý khách hàng</a></li>
                        </ul>
                    </nav>
                    <div class="header_content ml-auto">
                    </div>
                    <div class="nav-item dropdown no-arrow">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            Tên tài khoản
                        </a>
                        <div id="collapsePages" class="dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="userDropdown">
                            <a class="collapse-item" href="manager.html">Thông tin tài khoản</a>
                            <a class="collapse-item" href="blank.html">Đăng xuất</a>
                        </div>
                    </div>
                </div>
            </header>
        </div>

        <script src="js/jquery-3.2.1.min.js"></script>
        <script src="styles/bootstrap4/popper.js"></script>
        <script src="styles/bootstrap4/bootstrap.min.js"></script>
        <script src="plugins/easing/easing.js"></script>
        <script src="plugins/parallax-js-master/parallax.min.js"></script>
        <script src="js/cart_custom.js"></script>
    </body>

</html>