<%@ page import="entity.Order" %>
<%@ page import="java.util.Vector" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.time.LocalDate" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

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

        <title>Manager Dashboard</title>

        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
        <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">
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
        </style>
    </head>

    <body id="page-top">
        <!-- Topbar -->
        <header class="header_inner d-flex flex-row align-items-center justify-content-between" style="height: 120px; font-size: 16px; padding: 0px 64px 0px 60px">
            <div class="logo">
                <a href="index.jsp" class="logo">Estée Lauder</a>
            </div>

            <nav class="main_nav flex-grow-1 text-center">
                <ul class="navbar-nav d-flex flex-row justify-content-center" style="font-size: 18px; font-weight: bold; gap: 20px;">
                    <li class="nav-item"><a class="nav-link text-dark" href="index.jsp">Đơn hàng</a></li>
                    <li class="nav-item"><a class="nav-link text-dark" href="index.jsp">Quảng cáo</a></li>
                    <li class="nav-item"><a class="nav-link text-dark" href="index.jsp">Kho hàng</a></li>
                    <li class="nav-item"><a class="nav-link text-dark" href="ListCus">Khách hàng</a></li>
                    <li class="nav-item"><a class="nav-link text-dark" href="Blog?service=listAllBlogs">Bài đăng</a></li>
                </ul>
            </nav>

            <div class="nav-item dropdown">
                <a class="nav-link dropdown-toggle text-dark" href="#" id="userDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    ${sessionScope.acc.fullName}
                </a>
                <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="userDropdown">
                    <a class="dropdown-item" href="manager.html">Thông tin tài khoản</a>
                    <a class="dropdown-item" href="login?ac=logout">Đăng xuất</a>
                </div>
            </div>
        </header>

        <!-- Page Wrapper -->
        <div id="wrapper">
            <!--start sidebar -->
            <ul class="navbar-nav bg-dark sidebar sidebar-dark accordion toggled" id="accordionSidebar" style="font-family: Arial, sans-serif; font-weight: normal">
                <li class="nav-item">
                    <form action="manager" method="post" class="p-3">
                        <div class="mt-4 text-white" style="font-size: 16px;">Lọc theo trạng thái</div>
                        <ul class="list-unstyled" style="font-size: 16px; font-weight: normal;">
                            <li><input type="checkbox" name="status" value="1"> Hoàn thành</li>
                            <li><input type="checkbox" name="status" value="2"> Chờ xử lý</li>
                            <li><input type="checkbox" name="status" value="3"> Đang giao hàng</li>
                            <li><input type="checkbox" name="status" value="4"> Đã hủy</li>
                            <li><input type="checkbox" name="status" value="5"> Đã hoàn</li>
                        </ul>

                        <div class="mt-4 text-white" style="font-size: 16px;">Lọc theo thời gian</div>
                        <ul class="list-unstyled" style="font-size: 16px; font-weight: normal;">
                            <li><input type="radio" name="time-filter" value="all"> Toàn thời gian</li>
                            <li><input type="radio" name="time-filter" value="today"> Hôm nay</li>
                            <li><input type="radio" name="time-filter" value="week"> Tuần này</li>
                            <li><input type="radio" name="time-filter" value="month"> Tháng này</li>
                        </ul>

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
            <!-- End of Sidebar -->

            <!-- Nút kéo sidebar ra -->
            <button id="sidebarToggleTop" class="btn"><i class="fas fa-bars"></i></button>

            <!-- Content Wrapper -->
            <div id="content-wrapper" class="d-flex flex-column toggled" style="padding: 10px">
                <!-- Main Content -->
                <div id="content">               
                    <!-- Begin Page Content -->
                    <div class="container-fluid">
                        <!-- Content Row -->
                        <div class="row">
                            <div class="col-xl-4 col-md-6 mb-4">
                                <div class="card border-left-primary shadow h-100 py-2">
                                    <div class="card-body">
                                        <div class="row no-gutters align-items-center">
                                            <div class="col mr-2">
                                                <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">
                                                    Đơn cần xác nhận</div>
                                                <div class="h5 mb-0 font-weight-bold text-gray-800">${waiting.size()}</div>
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
                                                    Đơn bị hủy</div>
                                                <div class="h5 mb-0 font-weight-bold text-gray-800">${cancelled.size()}</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="col-xl-4 col-md-6 mb-4">
                                <div class="card border-left-warning shadow h-100 py-2">
                                    <div class="card-body">
                                        <div class="row no-gutters align-items-center">
                                            <div class="col mr-2">
                                                <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">
                                                    Tổng đơn</div>
                                                <div class="h5 mb-0 font-weight-bold text-gray-800">${OrderCount}</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <table style="width: 100%; border-collapse: collapse;">
                            <thead>
                                <tr style="background-color: #f2f2f2;">
                                    <th style="border: 1px solid black; padding: 8px;">Mã đơn hàng</th>
                                    <th style="border: 1px solid black; padding: 8px;">Tên sản phẩm</th>
                                    <th style="border: 1px solid black; padding: 8px;">Số lượng</th>
                                    <th style="border: 1px solid black; padding: 8px;">Giá sản phẩm</th>
                                    <th style="border: 1px solid black; padding: 8px;">Tổng tiền</th>
                                    <th style="border: 1px solid black; padding: 8px;">Tình trạng</th>
                                    <th style="border: 1px solid black; padding: 8px;">Hành động</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:set var="currentOrderID" value="" />
                                <c:set var="pageSize" value="5" />
                                <c:set var="currentPage" value="${param.page != null ? param.page : 1}" />
                                <c:set var="startIndex" value="${(currentPage - 1) * pageSize}" />
                                <c:set var="endIndex" value="${startIndex + pageSize - 1}" />
                                
                                <c:forEach var="order" items="${orderList}" varStatus="loop">
                                    <c:if test="${loop.index >= startIndex && loop.index <= endIndex}">
                                        <c:if test="${currentOrderID != order.OrderID}">
                                            <c:set var="currentOrderID" value="${order.OrderID}" />
                                        </c:if>
                                        <tr>
                                            <td style="border: 1px solid black; padding: 8px; text-align: center;">${order.OrderID}</td>
                                            <td style="border: 1px solid black; padding: 8px;">${order.ProductName}</td>
                                            <td style="border: 1px solid black; padding: 8px; text-align: center;">${order.Quantity}</td>
                                            <td style="border: 1px solid black; padding: 8px; text-align: right;">
                                                <fmt:formatNumber type="currency" currencyCode="VND" value="${order.Price}" />
                                            </td>
                                            <td style="border: 1px solid black; padding: 8px; text-align: right;">
                                                <c:if test="${currentOrderID == order.OrderID}">
                                                    <fmt:formatNumber type="currency" currencyCode="VND" value="${order.TotalAmount}" />
                                                </c:if>
                                            </td>
                                            <td style="border: 1px solid black; padding: 8px; text-align: center;">
                                                <c:choose>
                                                    <c:when test="${order.OrderStatus == 1}">Đã hoàn thành</c:when>
                                                    <c:when test="${order.OrderStatus == 2}">Chờ xử lý</c:when>
                                                    <c:when test="${order.OrderStatus == 3}">Đang giao</c:when>
                                                    <c:when test="${order.OrderStatus == 4}">Đã hủy</c:when>
                                                    <c:when test="${order.OrderStatus == 5}">Đã hoàn</c:when>
                                                    <c:otherwise>Không xác định</c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td style="border: 1px solid black; padding: 8px; text-align: center;">
                                                <c:if test="${order.OrderStatus == 2}">
                                                    <form action="OrderManagementServlet" method="post" style="display: inline;">
                                                        <input type="hidden" name="orderId" value="${order.OrderID}" />
                                                        <input type="hidden" name="action" value="confirm" />
                                                        <input type="hidden" name="page" value="${currentPage}" />
                                                        <button type="submit" style="padding: 5px 10px; background-color: #4CAF50; color: white; border: none; cursor: pointer;">Xác nhận</button>
                                                    </form>
                                                    <form action="OrderManagementServlet" method="post" style="display: inline;">
                                                        <input type="hidden" name="orderId" value="${order.OrderID}" />
                                                        <input type="hidden" name="action" value="cancel" />
                                                        <input type="hidden" name="page" value="${currentPage}" />
                                                        <button type="submit" style="padding: 5px 10px; background-color: #f44336; color: white; border: none; cursor: pointer;">Hủy đơn</button>
                                                    </form>
                                                </c:if>
                                            </td>
                                        </tr>
                                    </c:if>
                                </c:forEach>
                            </tbody>
                        </table>

                        <!-- Phần phân trang -->
                        <div class="pagination mt-4 d-flex justify-content-center align-items-center">
                            <c:set var="pageSize" value="5" />
                            <c:set var="currentPage" value="${param.page != null ? param.page : 1}" />
                            <c:set var="totalPages" value="${(orderList.size() + pageSize - 1) / pageSize}" />

                            <c:if test="${currentPage > 1}">
                                <a href="manager?page=${currentPage - 1}" class="btn btn-outline-primary mx-1">Trước</a>
                            </c:if>

                            <c:forEach begin="1" end="${totalPages}" var="i">
                                <c:choose>
                                    <c:when test="${i == currentPage}">
                                        <span class="btn btn-primary mx-1">${i}</span>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="manager?page=${i}" class="btn btn-outline-primary mx-1">${i}</a>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>

                            <c:if test="${currentPage < totalPages}">
                                <a href="manager?page=${currentPage + 1}" class="btn btn-outline-primary mx-1">Sau</a>
                            </c:if>

                            <span class="ml-3">
                                Trang ${currentPage} / ${totalPages} 
                                
                                (Tổng ${orderList.size()} đơn hàng)
                            </span>
                        </div>

                    </div>
                    <!-- /.container-fluid -->
                </div>
                <!-- End of Main Content -->
            </div>
            <!-- End of Content Wrapper -->
        </div>
        <!-- End of Page Wrapper -->

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