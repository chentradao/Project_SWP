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
        .table th {
            text-align: center;
            vertical-align: middle;
            padding: 12px 8px;
        }
        .table td {
            text-align: center;
            vertical-align: middle;
        }
        .search-container {
            margin-bottom: 20px;
            display: flex;
            gap: 10px;
            justify-content: center;
            align-items: center;
        }
        .search-container input[type="text"] {
            width: 500px; /* Tăng chiều dài thanh search */
            padding: 8px;
            border-radius: 4px;
            border: 1px solid #ccc;
        }
        .pagination-container {
            display: flex;
            justify-content: flex-end;
            align-items: center;
            gap: 10px;
            margin-top: 20px;
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

    </style>
    <body>
        <header class="header_inner d-flex flex-row align-items-center justify-content-between" style="height: 120px; font-size: 16px; padding: 0px 64px 0px 60px">
            <div class="logo">
                <a href="index.jsp" class="logo">Estée Lauder</a>
            </div>

            <nav class="main_nav flex-grow-1 text-center">
                <ul class="navbar-nav d-flex flex-row justify-content-center" style="font-size: 18px; font-weight: bold; gap: 20px;">
                    <li class="nav-item"><a class="nav-link text-dark" href="ghtkservlet?action=order">Quản lý đơn hàng</a></li>
                    <li class="nav-item"><a class="nav-link text-dark" href="index.jsp">Quản lý quảng cáo</a></li>
                    <li class="nav-item"><a class="nav-link text-dark" href="index.jsp">Quản lý kho hàng</a></li>
                    <li class="nav-item"><a class="nav-link text-dark" href="ListCus">Quản lý khách hàng</a></li>
                    <li class="nav-item"><a class="nav-link text-dark" href="BlogManager?service=listAllBlogs">Quản lý bài đăng</a></li>
                </ul>
            </nav>

            <div class="nav-item dropdown">
                <a class="nav-link dropdown-toggle text-dark" href="#" id="userDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    ${sessionScope.acc.fullName}
                </a>
                <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="userDropdown">
                    <a class="dropdown-item" href="profile">Thông tin tài khoản</a>
                    <c:choose>
                        <c:when test="${not empty sessionScope.acc}">
                            <a id="dropdown-item" class="dropdown-item" href="login?ac=logout">Đăng xuất</a>
                        </c:when>
                    </c:choose>

                </div>
            </div>
        </header>

        <div class="super_container">
            <div class="body">
                <div class="container mt-4">
                    <div class="card shadow-lg">
                        <div class="card-header bg-secondary text-white text-center">
                            <h4>Danh Sách Khách Hàng</h4>
                        </div>
                        <div class="card-body">
                            <!-- Thanh search trong bảng -->
                            <div class="search-container">
                                <form action="ListCus" method="get" class="form-inline">
                                    <input type="text" name="search" value="${sessionScope.search}" class="form-control" placeholder="Tìm theo tên, số điện thoại, email...">
                                    <button type="submit" class="btn btn-primary">Tìm kiếm</button>
                                    <input type="hidden" name="sortBy" value="${sessionScope.sortBy}">
                                    <input type="hidden" name="sortOrder" value="${sessionScope.sortOrder}">
                                    <input type="hidden" name="page" value="${sessionScope.currentPage}">
                                </form>
                            </div>

                            <div class="table-responsive">
                                <table class="table table-bordered table-striped table-hover">
                                    <thead class="thead-dark text-center">
                                        <tr>
                                            <th>
                                                Họ tên 
                                                <a href="ListCus?page=${sessionScope.currentPage}&search=${sessionScope.search}&sortBy=FullName&sortOrder=${sessionScope.sortBy == 'FullName' && sessionScope.sortOrder == 'asc' ? 'desc' : 'asc'}">
                                                    <i class="fa ${sessionScope.sortBy == 'FullName' && sessionScope.sortOrder == 'asc' ? 'fa-sort-up' : 'fa-sort-down'}"></i>
                                                </a>
                                            </th>
                                            <th>Giới tính</th>
                                            <th>
                                                Số điện thoại 
                                                <a href="ListCus?page=${sessionScope.currentPage}&search=${sessionScope.search}&sortBy=Phone&sortOrder=${sessionScope.sortBy == 'Phone' && sessionScope.sortOrder == 'asc' ? 'desc' : 'asc'}">
                                                    <i class="fa ${sessionScope.sortBy == 'Phone' && sessionScope.sortOrder == 'asc' ? 'fa-sort-up' : 'fa-sort-down'}"></i>
                                                </a>
                                            </th>
                                            <th>
                                                Email 
                                                <a href="ListCus?page=${sessionScope.currentPage}&search=${sessionScope.search}&sortBy=Email&sortOrder=${sessionScope.sortBy == 'Email' && sessionScope.sortOrder == 'asc' ? 'desc' : 'asc'}">
                                                    <i class="fa ${sessionScope.sortBy == 'Email' && sessionScope.sortOrder == 'asc' ? 'fa-sort-up' : 'fa-sort-down'}"></i>
                                                </a>
                                            </th>
                                            <th>
                                                Đơn đã order 
                                                <a href="ListCus?page=${sessionScope.currentPage}&search=${sessionScope.search}&sortBy=OrderQuality&sortOrder=${sessionScope.sortBy == 'OrderQuality' && sessionScope.sortOrder == 'asc' ? 'desc' : 'asc'}">
                                                    <i class="fa ${sessionScope.sortBy == 'OrderQuality' && sessionScope.sortOrder == 'asc' ? 'fa-sort-up' : 'fa-sort-down'}"></i>
                                                </a>
                                            </th>
                                            <th>
                                                Tổng số tiền 
                                                <a href="ListCus?page=${sessionScope.currentPage}&search=${sessionScope.search}&sortBy=TotalSpending&sortOrder=${sessionScope.sortBy == 'TotalSpending' && sessionScope.sortOrder == 'asc' ? 'desc' : 'asc'}">
                                                    <i class="fa ${sessionScope.sortBy == 'TotalSpending' && sessionScope.sortOrder == 'asc' ? 'fa-sort-up' : 'fa-sort-down'}"></i>
                                                </a>
                                            </th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:if test="${empty sessionScope.data}">
                                            <tr>
                                                <td colspan="6" class="text-center">Không có dữ liệu khách hàng.</td>
                                            </tr>
                                        </c:if>
                                        <c:forEach items="${sessionScope.data}" var="e">
                                            <tr class="text-center">
                                                <td>${e.fullName}</td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${e.gender == 'M'}">Nam</c:when>
                                                        <c:when test="${e.gender == 'F'}">Nữ</c:when>
                                                        <c:otherwise>${e.gender}</c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>${e.phone}</td>
                                                <td>${e.email}</td>
                                                <td>${e.orderQuality}</td>
                                                <td>${e.totalSpending}</td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>

                                <!-- Phân trang -->
                                <div class="pagination-container">
                                    <c:choose>
                                        <c:when test="${sessionScope.currentPage > 1}">
                                            <a href="ListCus?page=${sessionScope.currentPage - 1}&search=${sessionScope.search}&sortBy=${sessionScope.sortBy}&sortOrder=${sessionScope.sortOrder}" class="btn btn-sm btn-outline-primary">
                                                Trước
                                            </a>
                                        </c:when>
                                        <c:otherwise>
                                            <button class="btn btn-sm btn-outline-secondary" disabled>Trước</button>
                                        </c:otherwise>
                                    </c:choose>

                                    <span>
                                        Trang ${sessionScope.currentPage} / ${sessionScope.totalPages}
                                    </span>

                                    <c:choose>
                                        <c:when test="${sessionScope.currentPage < sessionScope.totalPages}">
                                            <a href="ListCus?page=${sessionScope.currentPage + 1}&search=${sessionScope.search}&sortBy=${sessionScope.sortBy}&sortOrder=${sessionScope.sortOrder}" class="btn btn-sm btn-outline-primary">
                                                Tiếp
                                            </a>
                                        </c:when>
                                        <c:otherwise>
                                            <button class="btn btn-sm btn-outline-secondary" disabled>Tiếp</button>
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