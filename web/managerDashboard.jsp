<%@ page import="entity.Blog" %>
<%@ page import="java.util.Vector" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>


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
        <title>Manager Dashboard</title>
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

        </style>
    </head>
    <body>
        <div class="super_container">
            <div class="main-content">
                
                <div class="chart-container">
                    
                    <div class="chart">
                        <canvas id="status-pie-chart"></canvas>
                    </div>
                </div>
                <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.js"></script>
                <script type="text/javascript">
                    var pieChart = document.getElementById("status-pie-chart").getContext("2d");

                    var myPieChart = new Chart(pieChart, {
                        type: "pie",
                        data: {
                            labels: ["Đơn Hoàn Thành", "Đơn Chờ Xác Nhận", "Đơn Đang Giao", "Đơn Đã Hủy", "Đơn Hoàn Trả"],
                            datasets: [{
                                    label: "Order Status",
                                    data: [50, 30, 20, 10, 5], // Example data, adjust as needed
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
                            <li><a href="index.jsp">Quản lý đơn hàng</a></li>
                            <li><a href="index.jsp">Quản lý quảng cáo</a></li>
                            <li><a href="index.jsp">Quản lý kho hàng</a></li>
                            <li><a href="index.jsp">Quản lý khách hàng</a></li>
                            <li><a href="Blog?service=listAllBlogs">Quản lý bài đăng</a></li>
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