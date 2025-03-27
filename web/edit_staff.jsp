<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Sửa thông tin nhân viên</title>
        <link rel="stylesheet" type="text/css" href="styles/bootstrap4/bootstrap.min.css">
        <style>
            .container {
                max-width: 500px;
                margin: 50px auto;
            }
            .form-group {
                margin-bottom: 15px;
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
            .general-error {
                color: #dc3545;
                text-align: center;
                margin-bottom: 15px;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h2 class="text-center">Sửa thông tin nhân viên</h2>
            <c:if test="${not empty error}">
                <p class="general-error">${error}</p>
            </c:if>
            <form action="EditStaff" method="post" id="editForm" onsubmit="return validateForm(event)">
                <input type="hidden" name="username" value="${staff.userName}">
                <div class="form-group">
                    <label for="fullName">Họ tên:</label>
                    <input type="text" class="form-control" id="fullName" name="fullName" 
                           value="${not empty fullName ? fullName : staff.fullName}" required>
                    <div id="fullNameError" class="client-error">Họ tên phải có ít nhất 10 ký tự và không chứa số</div>
                    <c:if test="${not empty messFuName}">
                        <div class="error-message">${messFuName}</div>
                    </c:if>
                </div>
                <div class="form-group">
                    <label for="phone">Số điện thoại:</label>
                    <input type="text" class="form-control" id="phone" name="phone" 
                           value="${not empty phone ? phone : staff.phone}" required>
                    <div id="phoneFormatError" class="client-error">Số điện thoại phải có 10 số, bắt đầu bằng 03, 05, 07, 08, 09 hoặc 01[2,6,8,9]</div>
                    <c:if test="${not empty messPhone}">
                        <div class="error-message">${messPhone}</div>
                    </c:if>
                </div>
                <div class="form-group">
                    <label for="email">Email:</label>
                    <input type="email" class="form-control" id="email" name="email" 
                           value="${not empty email ? email : staff.email}" required>
                    <div id="emailFormatError" class="client-error">Email phải có định dạng hợp lệ (ví dụ: ten@domain.com)</div>
                    <c:if test="${not empty messEmail}">
                        <div class="error-message">${messEmail}</div>
                    </c:if>
                </div>
                <button type="submit" class="btn btn-primary btn-block">Cập nhật</button>
                <a href="ListStaff" class="btn btn-secondary btn-block">Hủy</a>
            </form>
        </div>
        <script src="js/jquery-3.2.1.min.js"></script>
        <script src="styles/bootstrap4/popper.js"></script>
        <script src="styles/bootstrap4/bootstrap.min.js"></script>
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
                event.preventDefault();

                const fullName = document.getElementById("fullName").value.trim();
                const phone = document.getElementById("phone").value.trim();
                const email = document.getElementById("email").value.trim();
                let isValid = true;

                // Reset lỗi phía client
                document.getElementById("fullNameError").style.display = "none";
                document.getElementById("phoneFormatError").style.display = "none";
                document.getElementById("emailFormatError").style.display = "none";

                // Kiểm tra FullName
                if (!validateFullName(fullName)) {
                    document.getElementById("fullNameError").style.display = "block";
                    isValid = false;
                }

                // Kiểm tra Phone
                if (!isVietnamesePhoneNumber(phone)) {
                    document.getElementById("phoneFormatError").style.display = "block";
                    isValid = false;
                }

                // Kiểm tra Email
                if (!validateEmail(email)) {
                    document.getElementById("emailFormatError").style.display = "block";
                    isValid = false;
                }

                if (!isValid) {
                    alert("Vui lòng kiểm tra và sửa các lỗi trước khi lưu!");
                    return false;
                }

                document.getElementById("editForm").submit();
                return true;
            }

            // Hiển thị thông báo lỗi từ server nếu có
            window.onload = function() {
                <c:if test="${not empty messFuName || not empty messPhone || not empty messEmail}">
                    alert("Vui lòng kiểm tra và sửa các lỗi trước khi gửi!");
                </c:if>
            };
        </script>
    </body>
</html>