<%@ page import="entity.Order" %>
<%@ page import="java.util.Vector" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.time.LocalDate" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
    <head><title>Manager Dashboard</title>
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

        <style>


        </style>
    </head>

    <body id="page-top">
        <!-- Topbar -->
        <%@ include file="AminHeader.jsp" %>

        <!-- Page Wrapper -->
        <div id="wrapper">
            <!-- Bộ lọc -->
            <div class="w-1/5 bg-white rounded-xl shadow-md p-5 h-full mt-20">
                <form action="manager" id="filter" method="get">
                    <h3 class="text-lg font-semibold mb-4">Bộ lọc</h3>

                    <!-- Filter by Status -->
                    <div class="mb-4">
                        <label class="block text-sm font-medium text-gray-700">Trạng thái</label>
                        <select id="filterStatus" name="status" class="mt-1 w-full border rounded-lg p-2">
                            <option value="" ${empty statusFilters ? 'selected' : ''}>Tất cả</option>
                            <option value="1" ${statusFilters == '1' ? 'selected' : ''}>Chưa tiếp nhận</option>
                            <option value="2" ${statusFilters == '2' ? 'selected' : ''}>Đã tiếp nhận</option>
                            <option value="3" ${statusFilters == '3' ? 'selected' : ''}>Đã lấy hàng</option>
                            <option value="4" ${statusFilters == '4' ? 'selected' : ''}>Đang giao hàng</option>
                            <option value="5" ${statusFilters == '5' ? 'selected' : ''}>Đã giao hàng</option>
                            <option value="7" ${statusFilters == '7' ? 'selected' : ''}>Không lấy được hàng</option>
                            <option value="-1" ${statusFilters == '-1' ? 'selected' : ''}>Đã hủy</option>
                        </select>
                    </div>

                    <!-- Filter by Date -->
                    <div class="mb-4">
                        <label class="block text-sm font-medium text-gray-700">Ngày bắt đầu</label>
                        <input type="date" name="startDate" id="startDate" value="${not empty startDate ? startDate : ''}" class="mt-1 w-full border rounded-lg p-2">

                        <span id="errorMessage" class="text-red-500 text-sm hidden"></span>
                    </div>
                    <div class"mb-4">
                        <label class="block text-sm font-medium text-gray-700">Ngày kết thúc</label>
                        <input type="date" name="endDate" id="endDate" value="${not empty endDate ? endDate : ''}" class="mt-1 w-full border rounded-lg p-2">
                        <span id="errorMessage" class="text-red-500 text-sm hidden"></span>
                    </div>

                    <!-- Filter by Payment Method -->
                    <div class="mb-4">
                        <label class="block text-sm font-medium text-gray-700">Phương thức thanh toán</label>
                        <select id="filterPayment" name="paymentMethod" class="mt-1 w-full border rounded-lg p-2">
                            <option value="" ${empty paymentMethod ? 'selected' : ''}>Tất cả</option>
                            <option value="COD" ${paymentMethod == 'COD' ? 'selected' : ''}>Thanh toán khi nhận hàng</option>
                            <option value="VNPAY" ${paymentMethod == 'VNPAY' ? 'selected' : ''}>VNPAY</option>
                        </select>
                    </div>

                    <!-- Filter Button -->
                    <button type="submit">Lọc</button>
                </form>
            </div>



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
                                    <th style="border: 1px solid black; padding: 8px;">
                                        Mã đơn hàng
                                        <a href="manager?sortBy=orderCode&sortOrder=asc" class="sort-link">▲</a>
                                        <a href="manager?sortBy=orderCode&sortOrder=desc" class="sort-link">▼</a>
                                    </th>
                                    <th style="border: 1px solid black; padding: 8px;">Tên sản phẩm</th>
                                    <th style="border: 1px solid black; padding: 8px;">
                                        Số lượng
                                        <a href="manager?sortBy=Quantity&sortOrder=asc" class="sort-link">▲</a>
                                        <a href="manager?sortBy=Quantity&sortOrder=desc" class="sort-link">▼</a>
                                    </th>
                                    <th style="border: 1px solid black; padding: 8px;">Kho</th>
                                    <th style="border: 1px solid black; padding: 8px;">
                                        Giá sản phẩm
                                        <a href="manager?sortBy=UnitPrice&sortOrder=asc" class="sort-link">▲</a>
                                        <a href="manager?sortBy=UnitPrice&sortOrder=desc" class="sort-link">▼</a>
                                    </th>
                                    <th style="border: 1px solid black; padding: 8px;">Địa chỉ</th>
                                    <th style="border: 1px solid black; padding: 8px;">
                                        Tổng tiền
                                        <a href="manager?sortBy=TotalAmount&sortOrder=asc" class="sort-link">▲</a>
                                        <a href="manager?sortBy=TotalAmount&sortOrder=desc" class="sort-link">▼</a>
                                    </th>
                                    <th style="border: 1px solid black; padding: 8px;">Tình trạng</th>
                                    <th style="border: 1px solid black; padding: 8px;">Phương thức thanh toán</th>
                                    <th style="border: 1px solid black; padding: 8px;">Hành động</th>
                                </tr>
                            </thead>

                            <tbody>
                                <c:set var="currentOrderID" value="" />
                                <c:set var="pageSize" value="10" />
                                <c:set var="currentPage" value="${param.page != null ? param.page : 1}" />
                                <c:set var="startIndex" value="${(currentPage - 1) * pageSize}" />
                                <c:set var="endIndex" value="${startIndex + pageSize - 1}" />

                                <c:forEach var="order" items="${orderList}" varStatus="loop">
                                    <c:if test="${loop.index >= startIndex && loop.index <= endIndex}">
                                        <c:if test="${currentOrderID != order.OrderID}">
                                            <c:set var="currentOrderID" value="${order.OrderID}" />
                                            <c:set var="rowspan" value="0" />
                                            <!-- Calculate rowspan for this OrderID -->
                                            <c:forEach var="innerOrder" items="${orderList}">
                                                <c:if test="${innerOrder.OrderID == currentOrderID}">
                                                    <c:set var="rowspan" value="${rowspan + 1}" />
                                                </c:if>
                                            </c:forEach>
                                        </c:if>

                                        <tr>
                                            <!-- Columns displayed only once per OrderID -->
                                            <c:if test="${loop.index == startIndex || order.OrderID != orderList[loop.index - 1].OrderID}">
                                                <td style="border: 1px solid black; padding: 8px; text-align: center;" rowspan="${rowspan}">${order.orderCode}</td>
                                            </c:if>

                                            <!-- Columns displayed for every product -->
                                            <td style="border: 1px solid black; padding: 8px;">${order.ProductName}</td>
                                            <td style="border: 1px solid black; padding: 8px; text-align: center;">${order.Quantity}</td>
                                            <td style="border: 1px solid black; padding: 8px; text-align: center;">${order.Stock}</td>
                                            <td style="border: 1px solid black; padding: 8px; text-align: right;">
                                                <fmt:formatNumber type="currency" currencyCode="VND" value="${order.UnitPrice}" />
                                            </td>

                                            <!-- Columns displayed only once per OrderID -->
                                            <c:if test="${loop.index == startIndex || order.OrderID != orderList[loop.index - 1].OrderID}">
                                                <td style="border: 1px solid black; padding: 8px; text-align: center;" rowspan="${rowspan}">${order.ShipAddress}</td>
                                                <td style="border: 1px solid black; padding: 8px; text-align: right;" rowspan="${rowspan}">
                                                    <fmt:formatNumber type="currency" currencyCode="VND" value="${order.TotalCost}" />
                                                </td>
                                                <td style="border: 1px solid black; padding: 8px; text-align: center;" rowspan="${rowspan}">
                                                    <c:choose>
                                                        <c:when test="${order.OrderStatus == 1}">Đang lấy hàng</c:when>
                                                        <c:when test="${order.OrderStatus == 2}">Đang giao hàng</c:when>
                                                        <c:when test="${order.OrderStatus == 3}">Đã giao hàng thành công</c:when>
                                                        <c:when test="${order.OrderStatus == 4}">Giao hàng thất bại</c:when>
                                                        <c:when test="${order.OrderStatus == 5}">Đang hoàn hàng</c:when>
                                                        <c:when test="${order.OrderStatus == 6}">Đã hoàn hàng thành công</c:when>
                                                        <c:when test="${order.OrderStatus == 7}">Hủy đơn hàng</c:when>
                                                        <c:when test="${order.OrderStatus == 8}">Chờ xác nhận</c:when>
                                                        <c:otherwise>Không xác định</c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td style="border: 1px solid black; padding: 8px; text-align: center;" rowspan="${rowspan}">${order.PaymentMethod}</td>
                                                <td style="border: 1px solid black; padding: 8px; text-align: center;" rowspan="${rowspan}">
                                                    <c:if test="${order.OrderStatus == 1}">
                                                        <form action="ghtkservlet" method="get" style="display: inline;">
                                                            <input type="hidden" name="action" value="register" />
                                                            <input type="hidden" name="orderID" value="${order.OrderID}" />
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
                                            </c:if>
                                        </tr>
                                    </c:if>
                                </c:forEach>
                            </tbody>
                        </table>

                        <!-- Phần phân trang -->
                        <div class="pagination mt-4 d-flex justify-content-center align-items-center">
                            <c:set var="pageSize" value="10" />
                            <c:set var="currentPage" value="${param.page != null ? param.page : 1}" />
                            <c:set var="totalPages" value="${(orderList.size() + pageSize - 1) / pageSize}" />

                            <c:set var="sortBy" value="${param.sortBy != null ? param.sortBy : 'orderCode'}" />
                            <c:set var="sortOrder" value="${param.sortOrder != null ? param.sortOrder : 'asc'}" />

                            <c:if test="${currentPage > 1}">
                                <a href="manager?page=${currentPage - 1}&sortBy=${sortBy}&sortOrder=${sortOrder}" class="btn btn-outline-primary mx-1">Trước</a>
                            </c:if>

                            <c:forEach begin="1" end="${totalPages}" var="i">
                                <c:choose>
                                    <c:when test="${i == currentPage}">
                                        <span class="btn btn-primary mx-1">${i}</span>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="manager?page=${i}&sortBy=${sortBy}&sortOrder=${sortOrder}" class="btn btn-outline-primary mx-1">${i}</a>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>

                            <c:if test="${currentPage < totalPages}">
                                <a href="manager?page=${currentPage + 1}&sortBy=${sortBy}&sortOrder=${sortOrder}" class="btn btn-outline-primary mx-1">Sau</a>
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

        <!-- JavaScript cho toggle sidebar và chatbox -->
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

                // Gắn sự kiện toggle cho header chatbox
                $("#chatbox-toggle").on("click", function () {
                    toggleChatbox();
                });
            });


        </script>
    </body>
</html>