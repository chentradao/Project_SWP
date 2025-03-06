<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Profile</title>
        <link rel="stylesheet" href="styles/bootstrap4/bootstrap.min.css">
        <link rel="stylesheet" href="plugins/font-awesome-4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="styles/main_styles.css">
        <link rel="stylesheet" href="styles/responsive.css">

        <style>
            .super_container {
                padding-top: 100px; /* Tạo khoảng cách giữa header và nội dung */
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
                            <input id="mobile" type="text" class="form-control" name="Phone" value="${sessionScope.acc.phone}"required>
                            <div id="phoneError" class="text-danger" style="display:none;">Số điện thoại sai cú pháp.</div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Email</label>
                            <input id="email" type="text" class="form-control" name="Email" value="${sessionScope.acc.email}" required>
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


            <footer class="footer">
                <div class="container">
                    <div class="row">
                        <div class="col text-center">
                            <div class="footer_logo"><a href="#">Estée Lauder</a></div>
                            <nav class="footer_nav">
                                <ul>
                                    <li><a href="index.html">home</a></li>
                                    <li><a href="categories.html">clothes</a></li>
                                    <li><a href="categories.html">accessories</a></li>
                                    <li><a href="categories.html">lingerie</a></li>
                                    <li><a href="contact.html">contact</a></li>
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
                                Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved | This template is made with <i class="fa fa-heart-o" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">Colorlib</a>
                            </div>
                        </div>
                    </div>
                </div>
            </footer>
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
        <script src="plugins/OwlCarousel2-2.2.1/owl.carousel.js"></script>
        <script src="plugins/easing/easing.js"></script>
        <script src="plugins/parallax-js-master/parallax.min.js"></script>
        <script src="plugins/colorbox/jquery.colorbox-min.js"></script>
        <script src="js/custom.js"></script>
    </body>
</html>
