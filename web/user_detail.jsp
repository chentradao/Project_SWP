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
            /* Container chính */
            .container {
                padding: 20px;
                max-width: 800px;
                margin: 0 auto;
            }

            /* Định dạng card chứa thông tin chi tiết */
            .card {
                border: 1px solid #dee2e6;
                border-radius: 8px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            }

            .card-header {
                background-color: #007bff;
                color: white;
                padding: 15px;
                border-radius: 8px 8px 0 0;
                font-size: 18px;
                font-weight: bold;
            }

            .card-body {
                padding: 20px;
            }

            /* Định dạng các hàng thông tin */
            .info-row {
                display: flex;
                justify-content: space-between;
                padding: 10px 0;
                border-bottom: 1px solid #dee2e6;
            }

            .info-row:last-child {
                border-bottom: none;
            }

            .info-label {
                font-weight: bold;
                width: 30%;
                color: #333;
            }

            .info-value {
                width: 70%;
                color: #555;
            }

            /* Định dạng hình ảnh */
            .info-value img {
                max-width: 100px;
                height: auto;
                border-radius: 5px;
            }

            /* Định dạng nút Quay lại */
            .back-button {
                display: inline-block;
                margin-top: 20px;
                padding: 10px 20px;
                background-color: #6c757d;
                color: white;
                text-decoration: none;
                border-radius: 5px;
            }

            .back-button:hover {
                background-color: #5a6268;
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
            <div class="card">
                <div class="card-header">
                    Chi tiết tài khoản
                </div>
                <div class="card-body">
                    <div class="info-row">
                        <div class="info-label">Tên đăng nhập:</div>
                        <div class="info-value">${account.userName}</div>
                    </div>
                    <div class="info-row">
                        <div class="info-label">Mật khẩu:</div>
                        <div class="info-value">${account.password}</div>
                    </div>
                    <div class="info-row">
                        <div class="info-label">Họ tên:</div>
                        <div class="info-value">${account.fullName}</div>
                    </div>
                    <div class="info-row">
                        <div class="info-label">Giới tính:</div>
                        <div class="info-value">
                            <c:choose>
                                <c:when test="${account.gender == 'M'}">Nam</c:when>
                                <c:when test="${account.gender == 'F'}">Nữ</c:when>
                                
                                <c:otherwise>Không xác định</c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                    <div class="info-row">
                        <div class="info-label">Số điện thoại:</div>
                        <div class="info-value">${account.phone}</div>
                    </div>
                    <div class="info-row">
                        <div class="info-label">Email:</div>
                        <div class="info-value">${account.email}</div>
                    </div>
                    <div class="info-row">
                        <div class="info-label">Địa chỉ:</div>
                        <div class="info-value">${account.address}</div>
                    </div>
                    <div class="info-row">
                        <div class="info-label">Vai trò:</div>
                        <div class="info-value">${account.role}</div>
                    </div>
                    <div class="info-row">
                        <div class="info-label">Google ID:</div>
                        <div class="info-value">${account.googleID != null ? account.googleID : 'Không có'}</div>
                    </div>
                    <div class="info-row">
                        <div class="info-label">Ngày tạo:</div>
                        <div class="info-value">${account.createDate}</div>
                    </div>
                    <div class="info-row">
                        <div class="info-label">Trạng thái:</div>
                        <div class="info-value">
                            <c:choose>
                                <c:when test="${account.accountStatus == 1}">Đang hoạt động</c:when>
                                <c:when test="${account.accountStatus == 0}">Dừng hoạt động</c:when>
                                <c:otherwise>${account.accountStatus}</c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>
            <a href="ListUser" class="back-button">Quay lại</a>
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