<%@ page import="entity.Order" %>
<%@ page import="java.util.Vector" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.time.LocalDate" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isELIgnored="false" %>
<%@ page import="java.util.Map" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Admin Dashboard - Tổng kết Doanh thu</title>
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
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
        <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">
        <link href="css/sb-admin-2.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

        
    </head>

    <body id="page-top">
         <%@ include file="AminHeader.jsp" %>

        <div id="wrapper">

            <div class="w-1/5 bg-white rounded-xl shadow-md p-5 h-full mt-20">
                <form action="admin" id="filter" method="get">
                    <h3 class="text-lg font-semibold mb-4">Bộ lọc</h3>

                    <!-- Filter Type -->
                    <div class="mb-4">
                        <label class="block text-sm font-medium text-gray-700">Loại bộ lọc</label>
                        <select id="filterType" name="filterType" class="mt-1 w-full border rounded-lg p-2" onchange="toggleFilters()">
                            <option value="day" ${filterType == 'day' ? 'selected' : ''}>Theo ngày</option>
                            <option value="month" ${filterType == 'month' ? 'selected' : ''}>Theo tháng</option>
                            <option value="year" ${filterType == 'year' ? 'selected' : ''}>Theo năm</option>
                        </select>
                    </div>

                    <!-- Filter by Month -->
                    <div class="mb-4" id="monthFilterDiv">
                        <label class="block text-sm font-medium text-gray-700">Tháng</label>
                        <select id="filterMonth" name="month" class="mt-1 w-full border rounded-lg p-2">
                            <option value="" ${empty month ? 'selected' : ''}>Chọn tháng</option>
                            <option value="1" ${month == '1' ? 'selected' : ''}>Tháng 1</option>
                            <option value="2" ${month == '2' ? 'selected' : ''}>Tháng 2</option>
                            <option value="3" ${month == '3' ? 'selected' : ''}>Tháng 3</option>
                            <option value="4" ${month == '4' ? 'selected' : ''}>Tháng 4</option>
                            <option value="5" ${month == '5' ? 'selected' : ''}>Tháng 5</option>
                            <option value="6" ${month == '6' ? 'selected' : ''}>Tháng 6</option>
                            <option value="7" ${month == '7' ? 'selected' : ''}>Tháng 7</option>
                            <option value="8" ${month == '8' ? 'selected' : ''}>Tháng 8</option>
                            <option value="9" ${month == '9' ? 'selected' : ''}>Tháng 9</option>
                            <option value="10" ${month == '10' ? 'selected' : ''}>Tháng 10</option>
                            <option value="11" ${month == '11' ? 'selected' : ''}>Tháng 11</option>
                            <option value="12" ${month == '12' ? 'selected' : ''}>Tháng 12</option>
                        </select>
                    </div>

                    <!-- Filter by Year -->
                    <div class="mb-4" id="yearFilterDiv">
                        <label class="block text-sm font-medium text-gray-700">Năm</label>
                        <select id="filterYear" name="year" class="mt-1 w-full border rounded-lg p-2">
                            <option value="" ${empty year ? 'selected' : ''}>Chọn năm</option>
                            <!-- Giả sử danh sách năm từ 2020 đến 2025, bạn có thể điều chỉnh -->
                            <option value="2020" ${year == '2020' ? 'selected' : ''}>2020</option>
                            <option value="2021" ${year == '2021' ? 'selected' : ''}>2021</option>
                            <option value="2022" ${year == '2022' ? 'selected' : ''}>2022</option>
                            <option value="2023" ${year == '2023' ? 'selected' : ''}>2023</option>
                            <option value="2024" ${year == '2024' ? 'selected' : ''}>2024</option>
                            <option value="2025" ${year == '2025' ? 'selected' : ''}>2025</option>
                        </select>
                    </div>

                    <!-- Filter Button -->
                    <button type="submit">Lọc</button>
                </form>
            </div>
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