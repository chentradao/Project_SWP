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
        <style>
            /* Container chứa hai panel */
            .container {
                display: flex;
                justify-content: space-between;
                padding: 20px 0;
                align-items: stretch; /* Đảm bảo các panel con có chiều cao bằng nhau */
            }

            /* Panel bên trái chứa các nút */
            .left-panel {
                width: 15%; /* Chiều rộng của panel trái */
                background-color: #f8f9fa;
                padding: 20px 10px;
                margin-left: 0;
                border-right: 1px solid #dee2e6;
                display: flex;
                flex-direction: column;
                gap: 10px;
            }

            /* Panel bên phải chứa bảng dữ liệu */
            .right-panel {
                width: 83%; /* Chiều rộng của panel phải */
                padding: 20px;
                display: flex;
                flex-direction: column;
            }

            /* Định dạng nút */
            .button {
                display: block;
                width: 100%;
                padding: 10px;
                text-align: center;
                background-color: #007bff;
                color: white;
                text-decoration: none;
                border-radius: 5px;
                font-size: 14px;
                white-space: nowrap;
            }

            .button:hover {
                background-color: #0056b3;
            }

            /* Định dạng bảng dữ liệu */
            .table-responsive {
                overflow-x: hidden; /* Ẩn thanh cuộn ngang */
                /* Bỏ max-height và overflow-y để không có thanh cuộn */
            }

            .table {
                width: 100%;
                font-size: 13px;
                table-layout: auto;
            }

            .table th, .table td {
                padding: 6px;
                text-align: center;
                vertical-align: middle;
                white-space: nowrap;
            }

            /* Điều chỉnh chiều rộng của các cột trong bảng */
            .table th:nth-child(1), .table td:nth-child(1) { /* Cột Họ tên */
                width: 15%;
            }

            .table th:nth-child(2), .table td:nth-child(2) { /* Cột Số điện thoại */
                width: 12%;
            }

            .table th:nth-child(3), .table td:nth-child(3) { /* Cột Email */
                width: 20%;
                max-width: 200px;
                overflow: hidden;
                text-overflow: ellipsis;
            }

            .table th:nth-child(4), .table td:nth-child(4) { /* Cột Địa chỉ */
                width: 20%;
                max-width: 200px;
                overflow: hidden;
                text-overflow: ellipsis;
            }

            .table th:nth-child(5), .table td:nth-child(5) { /* Cột Role */
                width: 10%;
            }

            .table th:nth-child(6), .table td:nth-child(6) { /* Cột Trạng thái */
                width: 10%;
            }

            .table th:nth-child(7), .table td:nth-child(7) { /* Cột Hoạt động */
                width: 13%;
            }

            /* Hiển thị đầy đủ nội dung khi hover vào cột Email và Địa chỉ */
            .table td:nth-child(3):hover, .table td:nth-child(4):hover {
                white-space: normal;
                overflow: visible;
                background-color: #f8f9fa;
                position: relative;
                z-index: 1;
            }

            /* Định dạng nút trong cột Hoạt động */
            .btn-sm {
                padding: 4px 8px;
                font-size: 12px;
            }

            /* Định dạng phân trang */
            .pagination {
                display: flex;
                justify-content: center;
                margin-top: 20px;
            }

            .pagination a {
                color: #007bff;
                padding: 8px 12px;
                text-decoration: none;
                border: 1px solid #dee2e6;
                margin: 0 4px;
                border-radius: 4px;
            }

            .pagination a:hover {
                background-color: #007bff;
                color: white;
            }

            .pagination .active {
                background-color: #007bff;
                color: white;
                border: 1px solid #007bff;
            }

            .pagination .disabled {
                color: #6c757d;
                pointer-events: none;
                border: 1px solid #dee2e6;
            }
        </style>
    </head>
    <body>
        <!-- Header -->
        <header class="header_inner d-flex flex-row align-items-center justify-content-between" style="height: 120px; font-size: 16px; padding: 0px 64px 0px 60px">
            <div class="logo">
                <a href="index.jsp" class="logo">Estée Lauder</a>
            </div>
            <nav class="main_nav flex-grow-1 text-center">
                <ul class="navbar-nav d-flex flex-row justify-content-start" style="font-size: 18px; font-weight: bold; gap: 20px;">
                    <li class="nav-item"><a class="nav-link text-dark" href="index.jsp">Doanh thu</a></li>
                    <li class="nav-item"><a class="nav-link text-dark" href="index.jsp">Quảng cáo</a></li>
                    <li class="nav-item"><a class="nav-link text-dark" href="index.jsp">Kho hàng</a></li>
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

        <!-- Nội dung chính -->
        <div class="container">    
            <!-- Panel bên trái (Điều hướng) -->
            <div class="left-panel">
                <a href="createStaff" class="button">Tạo quản lý</a>
                <a href="ListStaff" class="button">Danh sách quản lý</a>
                <a href="ListUser" class="button">Danh sách tài khoản</a>
            </div>

            <!-- Panel bên phải (Bảng dữ liệu) -->
            <div class="right-panel">
                <div class="body">
                    <div class="container mt-4">
                        <div class="card shadow-lg">
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-bordered table-striped table-hover">
                                        <thead class="thead-dark text-center">
                                            <tr>
                                                <th>Họ tên</th>
                                                <th>Số điện thoại</th>
                                                <th>Email</th>
                                                <th>Địa chỉ</th>
                                                <th>Role</th>
                                                <th>Trạng thái</th>
                                                <th>Hoạt động</th>
                                                <th>Chi tiết</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${data}" var="e">
                                                <tr class="text-center">
                                                    <td>${e.fullName}</td>
                                                    <td>${e.phone}</td>
                                                    <td>${e.email}</td>
                                                    <td>${e.address}</td>
                                                    <td>${e.role}</td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${e.accountStatus == 1}">Đang hoạt động</c:when>
                                                            <c:when test="${e.accountStatus == 0}">Dừng hoạt động</c:when>
                                                            <c:otherwise>${e.accountStatus}</c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                        <a href="changeStatus?username=${e.userName}&status=${e.accountStatus}" 
                                                           class="btn btn-sm ${e.accountStatus == 1 ? 'btn-warning' : 'btn-success'}"
                                                           onclick="return confirm('Bạn có chắc muốn thay đổi trạng thái?')">
                                                            ${e.accountStatus == 1 ? 'Tắt' : 'Bật'}
                                                        </a>
                                                    </td>
                                                    <td>
                                                        <a href="userDetail?username=${e.userName}" class="btn btn-sm btn-primary">Xem</a>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                            <c:if test="${empty data}">
                                                <tr>
                                                    <td colspan="8" class="text-center">Không có dữ liệu để hiển thị</td>
                                                </tr>
                                            </c:if>
                                        </tbody>
                                    </table>
                                </div>

                                <!-- Phân trang -->
                                <div class="pagination">
                                    <!-- Nút Trang trước -->
                                    <c:if test="${currentPage > 1}">
                                        <a href="ListUser?page=${currentPage - 1}">Trang trước</a>
                                    </c:if>
                                    <c:if test="${currentPage <= 1}">
                                        <a href="#" class="disabled">Trang trước</a>
                                    </c:if>

                                    <!-- Hiển thị số trang -->
                                    <c:forEach begin="1" end="${totalPages}" var="i">
                                        <a href="ListUser?page=${i}" class="${currentPage == i ? 'active' : ''}">${i}</a>
                                    </c:forEach>

                                    <!-- Nút Trang sau -->
                                    <c:if test="${currentPage < totalPages}">
                                        <a href="ListUser?page=${currentPage + 1}">Trang sau</a>
                                    </c:if>
                                    <c:if test="${currentPage >= totalPages}">
                                        <a href="#" class="disabled">Trang sau</a>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div> 

        <!-- Scripts -->
        <script src="js/jquery-3.2.1.min.js"></script>
        <script src="styles/bootstrap4/popper.js"></script>
        <script src="styles/bootstrap4/bootstrap.min.js"></script>
        <script src="plugins/easing/easing.js"></script>
        <script src="plugins/parallax-js-master/parallax.min.js"></script>
        <script src="js/cart_custom.js"></script>
    </body>
</html>