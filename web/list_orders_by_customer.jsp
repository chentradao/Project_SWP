<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
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
        <title>Danh sách đơn hàng</title>
    </head>
    <style>
        .super_container {
            padding-top: 100px;
        }
    </style>
    <body>
        <header class="header">
            <div class="header_inner d-flex flex-row align-items-center justify-content-start">
                <div class="logo"><a href="index.jsp">Estée Lauder</a></div>
                <nav class="main_nav">
                    <ul>
                        <li><a href="index.jsp">Đơn hàng</a></li>
                        <li><a href="index.jsp">Quảng cáo</a></li>
                        <li><a href="index.jsp">Kho hàng</a></li>
                        <li><a href="ListCus">Khách hàng</a></li>
                        <li><a href="Blog?service=listAllBlogs">Bài đăng</a></li>
                    </ul>
                </nav>
                <div class="header_content ml-auto"></div>
                <div class="nav-item dropdown no-arrow">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        ${sessionScope.acc.fullName}
                    </a>
                    <div id="collapsePages" class="dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="userDropdown">
                        <a class="collapse-item" href="profile">Thông tin tài khoản</a>
                        <c:choose>
                            <c:when test="${not empty sessionScope.acc}">
                                <a id="logout-btn" class="logout-btn" href="login?ac=logout">Đăng xuất</a>
                            </c:when>
                        </c:choose>
                    </div>
                </div>
            </div>
        </header>

        <div class="super_container">
            <div class="body">
                <div class="container mt-4">
                    <div class="card shadow-lg">
                        <div class="card-header bg-secondary text-white text-center">
                            <h4>Danh Sách Đơn Hàng Của Khách Hàng</h4>
                        </div>
                        <div class="card-body">
                            <!-- Form tìm kiếm -->
                            <form action="ListOrdersByCustomer" method="get" class="mb-3">
                                <input type="hidden" name="customerID" value="${sessionScope.customerID}">
                                <input type="hidden" name="page" value="1">
                                <input type="hidden" name="sortBy" value="${sessionScope.sortBy}">
                                <input type="hidden" name="sortOrder" value="${sessionScope.sortOrder}">
                                <div class="input-group">
                                    <input type="text" name="searchTerm" class="form-control" 
                                           placeholder="Tìm theo phương thức thanh toán, email, số điện thoại hoặc địa chỉ giao hàng" 
                                           value="${sessionScope.searchTerm}">
                                    <button type="submit" class="btn btn-primary">Tìm kiếm</button>
                                </div>
                            </form>

                            <div class="table-responsive">
                                <table class="table table-bordered table-striped table-hover">
                                    <thead class="thead-dark text-center">
                                        <tr>
                                            <th>Tên khách hàng</th>
                                            <th>
                                                Ngày đặt hàng
                                                <a href="ListOrdersByCustomer?customerID=${sessionScope.customerID}&sortBy=orderDate&sortOrder=${sessionScope.sortOrder == 'asc' ? 'desc' : 'asc'}&searchTerm=${sessionScope.searchTerm}&page=${sessionScope.orderCurrentPage}" 
                                                   class="text-white">${sessionScope.sortBy == 'orderDate' && sessionScope.sortOrder == 'asc' ? '↑' : '↓'}</a>
                                            </th>
                                            <th>
                                                Tổng chi phí
                                                <a href="ListOrdersByCustomer?customerID=${sessionScope.customerID}&sortBy=totalCost&sortOrder=${sessionScope.sortOrder == 'asc' ? 'desc' : 'asc'}&searchTerm=${sessionScope.searchTerm}&page=${sessionScope.orderCurrentPage}" 
                                                   class="text-white">${sessionScope.sortBy == 'totalCost' && sessionScope.sortOrder == 'asc' ? '↑' : '↓'}</a>
                                            </th>
                                            <th>Email</th>
                                            <th>Số điện thoại</th>
                                            <th>Địa chỉ giao hàng</th>
                                            <th>Thông báo hủy</th>
                                            <th>Ghi chú</th>
                                            <th>Phương thức thanh toán</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:if test="${empty sessionScope.orderData}">
                                            <tr>
                                                <td colspan="9" class="text-center">Không có đơn hàng nào.</td>
                                            </tr>
                                        </c:if>
                                        <c:forEach items="${sessionScope.orderData}" var="order">
                                            <tr class="text-center">
                                                <td>${order.customerName}</td>
                                                <td><fmt:formatDate value="${order.orderDate}" pattern="dd-MM-yyyy"/></td>
                                                <td>${order.totalCost}</td>
                                                <td>${order.email}</td>
                                                <td>${order.phone}</td>
                                                <td>${order.shipAddress}</td>
                                                <td>${order.cancelNotification}</td>
                                                <td>${order.note}</td>
                                                <td>${order.paymentMethod}</td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>

                                <!-- Phân trang -->
                                <div class="flex justify-end space-x-1 mt-3">
                                    <c:choose>
                                        <c:when test="${sessionScope.orderCurrentPage > 1}">
                                            <a href="ListOrdersByCustomer?page=${sessionScope.orderCurrentPage - 1}&customerID=${sessionScope.customerID}&sortBy=${sessionScope.sortBy}&sortOrder=${sessionScope.sortOrder}&searchTerm=${sessionScope.searchTerm}" 
                                               class="px-3 py-1 rounded border border-gray-300 text-gray-600 hover:bg-gray-50">
                                                Trước
                                            </a>
                                        </c:when>
                                        <c:otherwise>
                                            <button class="px-3 py-1 rounded border border-gray-300 text-gray-400 cursor-not-allowed" disabled>
                                                Trước
                                            </button>
                                        </c:otherwise>
                                    </c:choose>
                                    <span class="px-3 py-1 rounded bg-gray-200 text-gray-800">
                                        ${sessionScope.orderCurrentPage}/${sessionScope.orderTotalPages}
                                    </span>
                                    <c:choose>
                                        <c:when test="${sessionScope.orderCurrentPage < sessionScope.orderTotalPages}">
                                            <a href="ListOrdersByCustomer?page=${sessionScope.orderCurrentPage + 1}&customerID=${sessionScope.customerID}&sortBy=${sessionScope.sortBy}&sortOrder=${sessionScope.sortOrder}&searchTerm=${sessionScope.searchTerm}" 
                                               class="px-3 py-1 rounded border border-gray-300 text-gray-600 hover:bg-gray-50">
                                                Tiếp
                                            </a>
                                        </c:when>
                                        <c:otherwise>
                                            <button class="px-3 py-1 rounded border border-gray-300 text-gray-400 cursor-not-allowed" disabled>
                                                Tiếp
                                            </button>
                                        </c:otherwise>
                                    </c:choose>
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
    </body>
</html>