<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Thông tin cá nhân</title>
        <link rel="stylesheet" href="styles/bootstrap4/bootstrap.min.css">
        <link rel="stylesheet" href="plugins/font-awesome-4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="styles/main_styles.css">
        <link rel="stylesheet" href="styles/responsive.css">

        <style>
            .super_container {
                padding-top: 100px;
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
    </head>
    <body>

        <% 
            if (session.getAttribute("acc") == null) { 
                response.sendRedirect("login.jsp"); 
            } 
        %>

        <div class="super_container">
            <%@ include file="header.jsp" %>
            <%@ include file="menu.jsp" %>

            <div class="container mt-5" id="myprofile">
                <div class="card shadow p-4">
                    <h3 class="text-center mb-4">Thông tin khách hàng</h3>

                    <c:if test="${not empty successMessage}">
                        <div class="alert alert-success">${successMessage}</div>
                    </c:if>
                    <c:if test="${not empty errorMessage}">
                        <div class="alert alert-danger">${errorMessage}</div>
                    </c:if>

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
                        </div>

                        <div class="text-end">
                            <button type="submit" class="btn btn-primary" id="submitBtn">Lưu</button>
                        </div>
                    </form>
                </div>
            </div>

            <footer class="footer">
                <div class="container">
                    <div class="row">
                        <div class="col text-center">
                            <div class="footer_logo"><a href="#">Estée Lauder</a></div>
                            <nav class="footer_nav">
                                <ul>
                                    <li><a href="index.html">trang chủ</a></li>
                                    <li><a href="categories.html">quần áo</a></li>
                                    <li><a href="categories.html">phụ kiện</a></li>
                                    <li><a href="categories.html">đồ lót</a></li>
                                    <li><a href="contact.html">liên hệ</a></li>
                                </ul>
                            </nav>
                            <div class="footer_social">
                                <ul>
                                    <li><a href="#"><i class="fa fa-pinterest" aria-hidden="true"></i></a></li>
                                    <li><a href="#"><i class="fa fa-linkedin" aria-hidden="true"></i></a></li>
                                    <li><a href="#"><i class="fa fa-instagram" aria-hidden="true"></i></a></li>
                                    <li><a href="#"><i class="fa fa-reddit-alien" aria-hidden="true"></i></a></li>
                                    <li><a href="#"><i class="fa fa-twitter" aria-hidden="true"></i></a></li>
                                </ul>
                            </div>
                            <div class="copyright">
                                Bản quyền ©<script>document.write(new Date().getFullYear());</script> Mọi quyền được bảo lưu | Mẫu này được tạo bởi <i class="fa fa-heart-o" aria-hidden="true"></i> <a href="https://colorlib.com" target="_blank">Colorlib</a>
                            </div>
                        </div>
                    </div>
                </div>
            </footer>
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
        <script src="plugins/OwlCarousel2-2.2.1/owl.carousel.js"></script>
        <script src="plugins/easing/easing.js"></script>
        <script src="plugins/parallax-js-master/parallax.min.js"></script>
        <script src="plugins/colorbox/jquery.colorbox-min.js"></script>
        <script src="js/custom.js"></script>
    </body>
</html>