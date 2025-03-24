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
        .error-message {
            color: #dc3545;
            font-size: 0.9em;
            margin-top: 5px;
        }
        .client-error {
            color: #dc3545;
            font-size: 0.9em;
            margin-top: 5px;
            display: none;
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
                        <a class="collapse-item" href="profile">Thông tin nhân viên</a>
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
                    <h3 class="text-center mb-4">Thông tin nhân viên</h3>

                    <form action="profile" method="POST" enctype="multipart/form-data" id="myForm" onsubmit="return validateForm(event)">

                        <c:if test="${not empty sessionScope.acc.image}">
                            <img src="./P_images/${sessionScope.acc.image}" alt="Ảnh đại diện"
                                 class="rounded-circle img-fluid" style="width: 150px; height: 150px;">
                        </c:if>
                        <c:if test="${empty sessionScope.acc.image}">
                            <img src="./P_images/Avatar.png" alt="Ảnh đại diện mặc định"
                                 class="rounded-circle img-fluid" style="width: 150px; height: 150px;">
                        </c:if>
                            
                        <input type="hidden" name="AccountID" value="${sessionScope.acc.accountID}" />

                        <div class="mb-3">
                            <label class="form-label">Họ tên</label>
                            <input type="text" class="form-control" name="FullName" id="fullName"
                                   value="${empty FullName ? sessionScope.acc.fullName : FullName}" required>
                            <div id="fullNameError" class="client-error">Họ tên phải có ít nhất 10 ký tự và không chứa số</div>
                            <c:if test="${not empty messFuName}">
                                <div class="error-message">${messFuName}</div>
                            </c:if>
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
                            <input id="mobile" type="text" class="form-control" name="Phone" 
                                   value="${empty Phone ? sessionScope.acc.phone : Phone}" required>
                            <div id="phoneFormatError" class="client-error">Số điện thoại phải có 10 số, bắt đầu bằng 03, 05, 07, 08, 09 hoặc 01[2,6,8,9]</div>
                            <div id="phoneDuplicateError" class="error-message" style="display:none;">${messPhone}</div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Email</label>
                            <input id="email" type="text" class="form-control" name="Email" 
                                   value="${empty Email ? sessionScope.acc.email : Email}" required>
                            <div id="emailFormatError" class="client-error">Email phải có định dạng hợp lệ (ví dụ: ten@domain.com)</div>
                            <div id="emailDuplicateError" class="error-message" style="display:none;">${messEmail}</div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Địa chỉ</label>
                            <input type="text" class="form-control" name="Address" 
                                   value="${empty Address ? sessionScope.acc.address : Address}" required>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label">Ảnh đại diện</label>
                            <input type="file" class="form-control" name="file" accept="image/*">
                            <c:if test="${not empty errorMessage}">
                                <div class="text-danger">${errorMessage}</div>
                            </c:if>
                        </div>

                        <div class="text-end">
                            <button type="submit" class="btn btn-primary" id="submitBtn">Lưu</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>  

        <script>
            function validateEmail(email) {
                const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                return emailPattern.test(email);
            }

            function isVietnamesePhoneNumber(number) {
                const phonePattern = /^(03|05|07|08|09|01[2689])[0-9]{8}$/;
                return phonePattern.test(number);
            }

            function validateFullName(fullName) {
                if (fullName.length < 10) return false;
                return !/\d/.test(fullName);
            }

            function validateForm(event) {
                event.preventDefault(); // Ngăn gửi form mặc định
                
                const email = document.getElementById("email").value.trim();
                const mobile = document.getElementById("mobile").value.trim();
                const fullName = document.getElementById("fullName").value.trim();
                let isValid = true;

                // Đặt lại tất cả thông báo lỗi client-side
                document.getElementById("fullNameError").style.display = "none";
                document.getElementById("phoneFormatError").style.display = "none";
                document.getElementById("emailFormatError").style.display = "none";

                // Kiểm tra họ tên
                if (!validateFullName(fullName)) {
                    document.getElementById("fullNameError").style.display = "block";
                    isValid = false;
                }

                // Kiểm tra số điện thoại định dạng
                if (!isVietnamesePhoneNumber(mobile)) {
                    document.getElementById("phoneFormatError").style.display = "block";
                    isValid = false;
                }

                // Kiểm tra email định dạng
                if (!validateEmail(email)) {
                    document.getElementById("emailFormatError").style.display = "block";
                    isValid = false;
                }

                // Kiểm tra lỗi từ client-side
                if (!isValid) {
                    alert("Vui lòng kiểm tra và sửa các lỗi trước khi lưu!");
                    return false;
                }

                // Gửi form nếu hợp lệ
                document.getElementById("myForm").submit();
                return true;
            }

            // Kiểm tra và hiển thị popup khi có lỗi từ server
            window.onload = function() {
                <c:if test="${not empty messPhone || not empty messEmail}">
                    alert("localhost:9999 cho biết\nVui lòng kiểm tra và sửa các lỗi trước khi gửi!");
                    <c:if test="${not empty messPhone}">
                        document.getElementById("phoneDuplicateError").style.display = "block";
                    </c:if>
                    <c:if test="${not empty messEmail}">
                        document.getElementById("emailDuplicateError").style.display = "block";
                    </c:if>
                </c:if>
            };
        </script>
        <script src="js/jquery-3.2.1.min.js"></script>
        <script src="styles/bootstrap4/popper.js"></script>
        <script src="styles/bootstrap4/bootstrap.min.js"></script>
        <script src="plugins/easing/easing.js"></script>
        <script src="plugins/parallax-js-master/parallax.min.js"></script>
        <script src="js/cart_custom.js"></script>
    </body>   
</html>