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
            .container {
                display: flex;
                justify-content: space-between;
                padding: 20px;
            }
            .left-panel {
                width: 20%; /* Giảm chiều rộng để gọn hơn */
                background-color: #f8f9fa;
                padding: 20px;
                border-right: 1px solid #dee2e6;
                height: calc(100vh - 140px); /* Điều chỉnh chiều cao trừ header */
                position: sticky;
                top: 120px;
                display: flex;
                flex-direction: column; /* Xếp các nút theo chiều dọc */
                gap: 10px; /* Khoảng cách giữa các nút */
            }
            .right-panel {
                width: 78%; /* Điều chỉnh chiều rộng để cân đối */
                padding: 20px;
            }
            .button {
                display: block;
                width: 100%;
                padding: 10px;
                text-align: center;
                background-color: #007bff;
                color: white;
                text-decoration: none;
                border-radius: 5px;
            }
            .button:hover {
                background-color: #0056b3;
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

        <!-- Main Content -->
        <div class="container">    
            <!-- Left Panel (Navigation) -->
            <div class="left-panel">
                <a href="createStaff" class="button">Tạo quản lý</a>
                <a href="ListStaff" class="button">Danh sách quản lý</a>
                <a href="ListUser" class="button">Danh sách tài khoản</a>
            </div>

            <!-- Right Panel (Table Data) -->
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
                                                <th>Status</th>
                                                <th>Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${staffData}" var="e">
                                                <tr class="text-center">
                                                    <td>${e.fullName}</td>

                                                    <td>${e.phone}</td>
                                                    <td>${e.email}</td>
                                                    <td>${e.address}</td>
                                                    <td>${e.role}</td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${e.accountStatus == 1}">Active</c:when>
                                                            <c:when test="${e.accountStatus == 0}">Inactive</c:when>
                                                            <c:otherwise>${e.accountStatus}</c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                        <a href="changeStatus?username=${e.userName}&status=${e.accountStatus}&returnTo=ListStaff" 
                                                           class="btn btn-sm ${e.accountStatus == 1 ? 'btn-warning' : 'btn-success'}"
                                                           onclick="return confirm('Bạn có chắc muốn thay đổi trạng thái?')">
                                                            ${e.accountStatus == 1 ? 'Deactivate' : 'Activate'}
                                                        </a>
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