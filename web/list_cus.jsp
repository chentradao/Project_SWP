<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    </head>
    <style>
        .super_container {
            padding-top: 100px;
        }
        .search-sort-container {
            margin-bottom: 20px;
            display: flex;
            gap: 20px;
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
                    <div class="search-sort-container">
                        <!-- Thanh search -->
                        <form action="ListCus" method="get" class="form-inline">
                            <input type="text" name="search" value="${sessionScope.search}" class="form-control mr-2" placeholder="Tìm theo tên, số điện thoại, email...">
                            <button type="submit" class="btn btn-primary">Tìm kiếm</button>
                        </form>

                        <!-- Dropdown sort -->
                        <form action="ListCus" method="get" class="form-inline">
                            <select name="sortBy" class="form-control mr-2" onchange="this.form.submit()">
                                <option value="OrderQuality" ${sessionScope.sortBy == 'OrderQuality' ? 'selected' : ''}>Số lượng đơn</option>
                                <option value="TotalSpending" ${sessionScope.sortBy == 'TotalSpending' ? 'selected' : ''}>Tổng tiền</option>
                            </select>
                            <select name="sortOrder" class="form-control mr-2" onchange="this.form.submit()">
                                <option value="asc" ${sessionScope.sortOrder == 'asc' ? 'selected' : ''}>Tăng dần</option>
                                <option value="desc" ${sessionScope.sortOrder == 'desc' ? 'selected' : ''}>Giảm dần</option>
                            </select>
                            <input type="hidden" name="search" value="${sessionScope.search}">
                        </form>
                    </div>

                    <div class="card shadow-lg">
                        <div class="card-header bg-secondary text-white text-center">
                            <h4>Danh Sách Khách Hàng</h4>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-bordered table-striped table-hover">
                                    <thead class="thead-dark text-center">
                                        <tr>
                                            <th>Họ tên</th>
                                            <th>Giới tính</th>
                                            <th>Số điện thoại</th>
                                            <th>Email</th>
                                            <th>Địa chỉ</th>
                                            <th>Đơn đã order</th>
                                            <th>Tổng số tiền</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:if test="${empty sessionScope.data}">
                                            <tr>
                                                <td colspan="7" class="text-center">Không có dữ liệu khách hàng.</td>
                                            </tr>
                                        </c:if>
                                        <c:forEach items="${sessionScope.data}" var="e">
                                            <tr class="text-center">
                                                <td>
                                                    <a href="ListOrdersByCustomer?customerID=${e.accountID}">${e.fullName}</a>
                                                </td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${e.gender == 'M'}">Nam</c:when>
                                                        <c:when test="${e.gender == 'F'}">Nữ</c:when>
                                                        <c:otherwise>${e.gender}</c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>${e.phone}</td>
                                                <td>${e.email}</td>
                                                <td>${e.address}</td>
                                                <td>${e.orderQuality}</td>
                                                <td>${e.totalSpending}</td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>

                                <!-- Phân trang: Trước | Số trang / Tổng số trang | Tiếp -->
                                <div class="flex justify-end space-x-1 mt-3">
                                    <!-- Nút Trước -->
                                    <c:choose>
                                        <c:when test="${sessionScope.currentPage > 1}">
                                            <a href="ListCus?page=${sessionScope.currentPage - 1}&search=${sessionScope.search}&sortBy=${sessionScope.sortBy}&sortOrder=${sessionScope.sortOrder}" class="px-3 py-1 rounded border border-gray-300 text-gray-600 hover:bg-gray-50">
                                                Trước
                                            </a>
                                        </c:when>
                                        <c:otherwise>
                                            <button class="px-3 py-1 rounded border border-gray-300 text-gray-400 cursor-not-allowed" disabled>
                                                Trước
                                            </button>
                                        </c:otherwise>
                                    </c:choose>

                                    <!-- Hiển thị Số trang / Tổng số trang -->
                                    <span class="px-3 py-1 rounded bg-gray-200 text-gray-800">
                                        ${sessionScope.currentPage}/${sessionScope.totalPages}
                                    </span>

                                    <!-- Nút Tiếp -->
                                    <c:choose>
                                        <c:when test="${sessionScope.currentPage < sessionScope.totalPages}">
                                            <a href="ListCus?page=${sessionScope.currentPage + 1}&search=${sessionScope.search}&sortBy=${sessionScope.sortBy}&sortOrder=${sessionScope.sortOrder}" class="px-3 py-1 rounded border border-gray-300 text-gray-600 hover:bg-gray-50">
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