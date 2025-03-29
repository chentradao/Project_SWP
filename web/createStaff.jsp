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
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create Staff</title>
        <link rel="stylesheet" type="text/css" href="./assets/css/adminpage.css">
        <style>
            .error-message {
                color: red;
                font-size: 0.9em;
                margin-top: 5px;
            }
            .success-message {
                color: green;
                font-size: 0.9em;
                margin-top: 5px;
            }
            .input_type {
                width: 100%;
                padding: 5px;
                margin: 2px 0;
            }
            button[type="submit"] {
                padding: 10px 20px;
                background-color: #4CAF50;
                color: white;
                border: none;
                cursor: pointer;
            }
            button[type="submit"]:hover {
                background-color: #45a049;
            }
            .form-container {
                width: 500px;
                margin: 50px auto; /* Căn giữa theo chiều ngang */
                padding: 20px;
                border-radius: 8px;
                background-color: #f9f9f9;
                box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
                text-align: center; /* Căn giữa nội dung trong form */
            }

            form table {
                width: 100%;
            }

            form table td {
                padding: 10px;
            }

        </style>
    </head>
    <body>

        <%@ include file="/AminHeader.jsp" %>
        <div class="form-container">
            <form action="createStaff" method="post" onsubmit="return validateForm()">
                <h2>Tạo nhân viên</h2>
                <!-- Hiển thị thông báo -->
                <c:if test="${not empty message}">
                    <div class="${message.contains('thành công') ? 'success-message' : 'error-message'}">
                        ${message}
                    </div>
                </c:if>
                <table>
                    <tr>
                        <td><label for="UserName">Tên đăng nhập</label></td>
                        <td>
                            <input class="input_type" type="text" id="UserName" name="UserName" value="${UserName}" required>
                            <div class="error-message">${messU}</div>
                        </td>
                    </tr>
                    <tr>
                        <td><label for="Password">Mật khẩu</label></td>
                        <td>
                            <input class="input_type" id="Password" type="password" name="Password" value="${Password}" required minlength="6">
                            <div class="error-message">${messP}</div>
                        </td>
                    </tr>
                    <tr>
                        <td><label for="ConfirmPassword">Nhập lại mật khẩu</label></td>
                        <td>
                            <input class="input_type" id="ConfirmPassword" type="password" name="ConfirmPassword" value="${ConfirmPassword}" required>
                            <div id="confirmPasswordError" class="error-message" style="display:none">Mật khẩu nhập lại không khớp</div>
                            <div class="error-message">${messConfirmP}</div>
                        </td>
                    </tr>
                    <tr>
                        <td><label for="FullName">Họ tên</label></td>
                        <td>
                            <input class="input_type" id="FullName" type="text" name="FullName" value="${FullName}" required>
                            <div class="error-message">${messFuName}</div>
                        </td>
                    </tr>

                    <tr>
                        <td><label>Giới tính</label></td>
                        <td>
                            <input type="radio" id="Gender" name="Gender" value="M" ${Gender == 'M' ? 'checked' : ''} required>
                            <label for="male">Nam</label>
                            <input type="radio" id="Gender" name="Gender" value="F" ${Gender == 'F' ? 'checked' : ''} required>
                            <label for="female">Nữ</label>
                            <div class="error-message">${messGender}</div>
                        </td>
                    </tr>
                    <tr>
                        <td><label for="email">Email</label></td>
                        <td>
                            <input class="input_type" id="email" type="email" name="Email" value="${Email}" required oninput="checkEmail()">
                            <div id="emailError" class="error-message" style="display:none">Invalid email format</div>
                            <div class="error-message">${messEmail}</div>
                        </td>
                    </tr>
                    <tr>
                        <td><label for="mobile">Số điện thoại</label></td>
                        <td>
                            <input class="input_type" id="mobile" type="tel" name="Phone" value="${Phone}" required oninput="checkPhoneNumber()">
                            <div id="phoneError" class="error-message" style="display:none">Invalid Vietnamese phone number format (e.g., 0912345678)</div>
                            <div class="error-message">${messPhone}</div>
                        </td>
                    </tr>

                    <tr>
                        <td colspan="2">
                            <input type="hidden" name="Role" value="staff">
                            <input type="hidden" name="AccountStatus" value="1">
                            <div class="button-container" style="display: flex; justify-content: space-between;">
                                <button type="submit">Tạo tài khoản</button>
                                <button type="button" onclick="goBack()" style="padding: 10px 20px; background-color: #f44336; color: white; border: none; cursor: pointer;">
                                    Quay lại
                                </button>
                            </div>
                        </td>
                    </tr>
                </table>
            </form>
        </div>
        <script>
            function goBack() {
                window.location.href = 'ListUser';
            }

            function validateEmail(email) {
                const emailPattern = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
                return emailPattern.test(email);
            }

            function isVietnamesePhoneNumber(number) {
                const phonePattern = /^(03|05|07|08|09|01[2|6|8|9])[0-9]{8}$/;
                return phonePattern.test(number);
            }

            function checkEmail() {
                const email = document.getElementById("email").value;
                const emailError = document.getElementById("emailError");
                emailError.style.display = validateEmail(email) ? "none" : "block";
            }

            function checkPhoneNumber() {
                const mobile = document.getElementById("mobile").value;
                const phoneError = document.getElementById("phoneError");
                phoneError.style.display = isVietnamesePhoneNumber(mobile) ? "none" : "block";
            }

            function checkConfirmPassword() {
                const password = document.getElementById("Password").value;
                const confirmPassword = document.getElementById("ConfirmPassword").value;
                const confirmPasswordError = document.getElementById("confirmPasswordError");
                confirmPasswordError.style.display = (password === confirmPassword) ? "none" : "block";
            }

            function validateForm() {
                const email = document.getElementById("email").value;
                const mobile = document.getElementById("mobile").value;
                const password = document.getElementById("Password").value;
                const confirmPassword = document.getElementById("ConfirmPassword").value;
                const gender = document.querySelector('input[name="Gender"]:checked');
                let isValid = true;

                if (!validateEmail(email)) {
                    document.getElementById("emailError").style.display = "block";
                    isValid = false;
                }

                if (!isVietnamesePhoneNumber(mobile)) {
                    document.getElementById("phoneError").style.display = "block";
                    isValid = false;
                }

                if (password.length < 6) {
                    alert("Password must be at least 6 characters long");
                    isValid = false;
                }

                if (password !== confirmPassword) {
                    document.getElementById("confirmPasswordError").style.display = "block";
                    isValid = false;
                }

                if (!gender) {
                    alert("Vui lòng chọn giới tính (Nam hoặc Nữ)");
                    isValid = false;
                }

                if (!isValid) {
                    alert("Please fix the errors in the form before submitting");
                }
                return isValid;
            }
        </script>
    </body>
</html>