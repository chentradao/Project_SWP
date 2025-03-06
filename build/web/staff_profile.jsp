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
            padding-top: 100px; /* Tạo khoảng cách giữa header và nội dung */
        }
    </style>
    <body>
        <header class="header" >
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
                <div class="header_content ml-auto">
                </div>
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
            <div class="container mt-5" id="myprofile">
                <div class="card shadow p-4">
                    <h3 class="text-center mb-4">Thông tin cá nhân</h3>

                    <form action="profile" method="POST" enctype="multipart/form-data" id="myForm" onsubmit="return validateForm()">

                        <c:if test="${not empty sessionScope.acc.image}">
                            <img src="./P_images/${sessionScope.acc.image}" alt="Profile Image"
                                 class="rounded-circle img-fluid" style="width: 150px; height: 150px;">
                        </c:if>
                        <c:if test="${empty sessionScope.acc.image}">
                            <img src="./P_images/Avatar.png" alt="Default Profile Image"
                                 class="rounded-circle img-fluid" style="width: 150px; height: 150px;">
                        </c:if>
                            
                        <input type="hidden" name="AccountID" value="${sessionScope.acc.accountID}" />

                        <div class="mb-3">
                            <label class="form-label">Họ tên</label>
                            <input type="text" class="form-control" name="FullName" value="${sessionScope.acc.fullName}" required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Giới tính</label>
                            <select id="Gender" name="Gender" class="form-control" required>
                                <option value="F" ${sessionScope.acc.gender == 'F' ? 'selected' : ''}>Nữ</option>
                                <option value="M" ${sessionScope.acc.gender == 'M' ? 'selected' : ''}>Nam</option>
                            </select>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Số điện thoại</label>
                            <input id="mobile" type="text" class="form-control" name="Phone" value="${sessionScope.acc.phone}" oninput="checkPhoneNumber()" required>
                            <div id="phoneError" class="text-danger" style="display:none;">Số điện thoại sai cú pháp.</div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Email</label>
                            <input id="email" type="text" class="form-control" name="Email" value="${sessionScope.acc.email}" oninput="checkEmail()" required>
                            <div id="emailError" class="text-danger" style="display:none;">Email sai cú pháp.</div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Địa chỉ</label>
                            <input type="text" class="form-control" name="Address" value="${sessionScope.acc.address}" required>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label">Ảnh đại diện</label>
                            <input type="file" class="form-control" name="file" accept="image/*">
                        </div>

                        <div class="text-end">
                            <button type="submit" class="btn btn-primary" id="submitBtn">Lưu</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>  


        <script>
            document.getElementById('submitBtn').addEventListener('click', function (event) {
                if (!validateForm()) {
                    event.preventDefault(); // Ngăn chặn form gửi đi nếu dữ liệu không hợp lệ
                }
            });

        </script>

        <script>
            function validateEmail(email) {
                const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                return emailPattern.test(email);
            }

            function isVietnamesePhoneNumber(number) {
                const phonePattern = /^(03|05|07|08|09|01[2689])[0-9]{8}$/;
                return phonePattern.test(number);
            }

            function validateForm(event) {
                const email = document.getElementById("email").value;
                const mobile = document.getElementById("mobile").value;
                let isValid = true; // Biến kiểm tra tổng thể

                // Kiểm tra email
                if (!validateEmail(email)) {
                    document.getElementById("emailError").style.display = "block";
                    isValid = false;
                } else {
                    document.getElementById("emailError").style.display = "none";
                }

                // Kiểm tra số điện thoại
                if (!isVietnamesePhoneNumber(mobile)) {
                    document.getElementById("phoneError").style.display = "block";
                    isValid = false;
                } else {
                    document.getElementById("phoneError").style.display = "none";
                }

                // Nếu có lỗi, ngăn form gửi đi
                if (!isValid) {
                    alert("Vui lòng nhập đúng thông tin trước khi gửi!");
                    return false;
                }

                return true; // Cho phép gửi form nếu hợp lệ
            }

        </script>
        <script src="js/jquery-3.2.1.min.js"></script>
        <script src="styles/bootstrap4/popper.js"></script>
        <script src="styles/bootstrap4/bootstrap.min.js"></script>
        <script src="plugins/easing/easing.js"></script>
        <script src="plugins/parallax-js-master/parallax.min.js"></script>
        <script src="js/cart_custom.js"></script>

    </body>   
</html>
