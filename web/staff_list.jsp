<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="description" content="Wish shop project">
        <link rel="stylesheet" type="text/css" href="styles/bootstrap4/bootstrap.min.css">
        <link href="plugins/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
        <link rel="stylesheet" type="text/css" href="styles/cart.css">
        <link rel="stylesheet" type="text/css" href="styles/cart_responsive.css">
        <style>
            /* Tối ưu header */
            .header_inner {
                height: 80px;
                padding: 0 15px;
            }
            .main_nav ul {
                gap: 15px;
            }
            /* Căn chỉnh bố cục */
            .content-wrapper {
                display: flex;
                justify-content: center;
                align-items: flex-start;
                gap: 40px;
            }
            /* Định dạng panel bên trái */
            .left-panel {
                max-width: 250px;
                flex-shrink: 0;
                text-align: center;
                background-color: #f8f9fa;
                padding: 20px;
                border-radius: 8px;
            }
            .left-panel .btn {
                width: 100%;
                padding: 12px 15px;
                font-size: 14px;
                white-space: nowrap;
                text-align: center;
            }
            /* Định dạng bảng */
            .table-container {
                flex-grow: 1;
                width: 100%;
            }
            .table th, .table td {
                text-align: center;
                vertical-align: middle;
                padding: 12px 8px;
            }
            .page-title {
                text-align: center;
                margin-bottom: 20px;
            }
            .search-container {
                display: flex;
                justify-content: center;
                gap: 20px;
                margin-bottom: 20px;
            }
            .search-container input[type="text"] {
                width: 300px;
                padding: 8px;
                border-radius: 4px;
                border: 1px solid #ccc;
            }
            .search-container select {
                padding: 8px;
                border-radius: 4px;
                border: 1px solid #ccc;
            }
            /* Định dạng nút trong cột Hoạt động */
            .action-buttons {
                display: flex;
                gap: 5px;
                justify-content: center;
            }
        </style>
    </head>
    <body>
        <!-- Header -->
        <header class="header_inner d-flex flex-row align-items-center justify-content-between">
            <div class="logo">
                <a href="index.jsp" class="logo">Estée Lauder</a>
            </div>
            <nav class="main_nav flex-grow-1 text-center">
                <ul class="navbar-nav d-flex flex-row justify-content-start" style="font-size: 18px; font-weight: bold;">
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
        <div class="container-fluid p-3">
            <h2 class="page-title">Danh sách nhân viên</h2>

            <!-- Thanh tìm kiếm -->
            <div class="search-container">
                <form action="ListStaff" method="get">
                    <input type="text" name="search" placeholder="Tìm theo họ tên, số điện thoại, email" value="${param.search}">
                    <select name="status">
                        <option value="">Tất cả trạng thái</option>
                        <option value="1" ${param.status == '1' ? 'selected' : ''}>Đang hoạt động</option>
                        <option value="0" ${param.status == '0' ? 'selected' : ''}>Dừng hoạt động</option>
                    </select>
                    <button type="submit" class="btn btn-primary">Tìm</button>
                </form>
            </div>

            <div class="content-wrapper">
                <!-- Left Panel -->
                <div class="left-panel">
                    <a href="createStaff" class="btn btn-primary mb-2">Tạo nhân viên</a>
                    <a href="ListStaff" class="btn btn-primary mb-2">Danh sách nhân viên</a>
                    <a href="ListCustomer" class="btn btn-primary mb-2">Danh sách khách hàng</a>
                    <a href="ListUser" class="btn btn-primary mb-2">Danh sách tài khoản</a>
                </div>

                <!-- Right Panel -->
                <div class="table-container">
                    <div class="card shadow">
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-bordered table-striped table-hover">
                                    <thead class="thead-dark text-center">
                                        <tr>
                                            <th>
                                                Họ tên 
                                                <a href="?page=${currentPage}&search=${param.search}&status=${param.status}&sortBy=fullName&sortOrder=${param.sortBy == 'fullName' && param.sortOrder == 'asc' ? 'desc' : 'asc'}">
                                                    <i class="fa ${param.sortBy == 'fullName' && param.sortOrder == 'asc' ? 'fa-sort-up' : 'fa-sort-down'}"></i>
                                                </a>
                                            </th>
                                            <th>
                                                Số điện thoại 
                                                <a href="?page=${currentPage}&search=${param.search}&status=${param.status}&sortBy=phone&sortOrder=${param.sortBy == 'phone' && param.sortOrder == 'asc' ? 'desc' : 'asc'}">
                                                    <i class="fa ${param.sortBy == 'phone' && param.sortOrder == 'asc' ? 'fa-sort-up' : 'fa-sort-down'}"></i>
                                                </a>
                                            </th>
                                            <th>
                                                Email 
                                                <a href="?page=${currentPage}&search=${param.search}&status=${param.status}&sortBy=email&sortOrder=${param.sortBy == 'email' && param.sortOrder == 'asc' ? 'desc' : 'asc'}">
                                                    <i class="fa ${param.sortBy == 'email' && param.sortOrder == 'asc' ? 'fa-sort-up' : 'fa-sort-down'}"></i>
                                                </a>
                                            </th>
                                            <th>
                                                Ngày tạo 
                                                <a href="?page=${currentPage}&search=${param.search}&status=${param.status}&sortBy=createDate&sortOrder=${param.sortBy == 'createDate' && param.sortOrder == 'asc' ? 'desc' : 'asc'}">
                                                    <i class="fa ${param.sortBy == 'createDate' && param.sortOrder == 'asc' ? 'fa-sort-up' : 'fa-sort-down'}"></i>
                                                </a>
                                            </th>
                                            <th>Role</th>
                                            <th>Trạng thái</th>
                                            <th>Hoạt động</th>
                                            <th>Chi tiết</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${staffData}" var="e">
                                            <tr class="text-center">
                                                <td>${e.fullName}</td>
                                                <td>${e.phone}</td>
                                                <td>${e.email}</td>
                                                <td>${e.createDate}</td>
                                                <td>${e.role}</td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${e.accountStatus == 1}">Đang hoạt động</c:when>
                                                        <c:when test="${e.accountStatus == 0}">Dừng hoạt động</c:when>
                                                        <c:otherwise>${e.accountStatus}</c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <div class="action-buttons">
                                                        <a href="changeStatus?username=${e.userName}&status=${e.accountStatus}&returnTo=ListStaff" 
                                                           class="btn btn-sm ${e.accountStatus == 1 ? 'btn-warning' : 'btn-success'}"
                                                           onclick="return confirm('Bạn có chắc muốn thay đổi trạng thái?')">
                                                            ${e.accountStatus == 1 ? 'Tắt' : 'Bật'}
                                                        </a>
                                                        <a href="DeleteStaff?username=${e.userName}" 
                                                           class="btn btn-sm btn-danger"
                                                           onclick="return confirm('Bạn có chắc muốn xóa tài khoản này?')">
                                                            Xóa
                                                        </a>
                                                        <a href="EditStaff?username=${e.userName}" 
                                                           class="btn btn-sm btn-success">
                                                            Sửa
                                                        </a>
                                                    </div>
                                                </td>
                                                <td>
                                                    <a href="userDetail?username=${e.userName}" class="btn btn-sm btn-primary">Xem</a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                        <c:if test="${empty staffData}">
                                            <tr>
                                                <td colspan="8" class="text-center">Không có dữ liệu để hiển thị</td>
                                            </tr>
                                        </c:if>
                                    </tbody>
                                </table>
                            </div>

                            
                            <nav aria-label="Page navigation" class="d-flex justify-content-center mt-3">
                                <ul class="pagination">
                                    <li class="page-item ${currentPage <= 1 ? 'disabled' : ''}">
                                        <a class="page-link" href="ListStaff?page=${currentPage - 1}&search=${param.search}&status=${param.status}&sortBy=${param.sortBy}&sortOrder=${param.sortOrder}">Trang trước</a>
                                    </li>
                                    <c:forEach begin="1" end="${totalPages}" var="i">
                                        <li class="page-item ${currentPage == i ? 'active' : ''}">
                                            <a class="page-link" href="ListStaff?page=${i}&search=${param.search}&status=${param.status}&sortBy=${param.sortBy}&sortOrder=${param.sortOrder}">${i}</a>
                                        </li>
                                    </c:forEach>
                                    <li class="page-item ${currentPage >= totalPages ? 'disabled' : ''}">
                                        <a class="page-link" href="ListStaff?page=${currentPage + 1}&search=${param.search}&status=${param.status}&sortBy=${param.sortBy}&sortOrder=${param.sortOrder}">Trang sau</a>
                                    </li>
                                </ul>
                            </nav>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Scripts -->
        <script src="js/jquery-3.2.1.min.js"></script>
        <script src="styles/bootstrap4/popper.js"></script>
        <script src="styles/bootstrap4/bootstrap.min.js"></script>
    </body>
</html>