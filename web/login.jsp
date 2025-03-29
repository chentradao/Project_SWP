<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Đăng nhập</title>
        <link rel="stylesheet" href="fonts/material-design-iconic-font/css/material-design-iconic-font.min.css">
        <link rel="stylesheet" href="css/style.css">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" type="text/css" href="styles/bootstrap4/bootstrap.min.css">
        <link href="plugins/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
        <link rel="stylesheet" type="text/css" href="styles/cart.css">
        <link rel="stylesheet" type="text/css" href="styles/cart_responsive.css">
        <style>
            .form-group {
                margin-bottom: 20px;
            }
            .form-holder {
                display: flex;
                align-items: center;
                gap: 10px;
            }
            .form-holder input {
                flex: 1;
            }
            .button-container {
                display: flex;
                justify-content: center;
                gap: 20px;
                margin-top: 20px;
            }
            .google-login {
                border-radius: 10px;
                background-color: whitesmoke;
            }
            /* Thêm style cho tiêu đề Đăng nhập */
            h3 {
                font-family: 'Arial', sans-serif; /* Phông chữ */
                font-size: 28px; /* Kích thước chữ */
                font-weight: 700; /* Độ đậm */
                color: #333; /* Màu chữ */
                text-align: center; /* Căn giữa */
                margin-bottom: 25px; /* Khoảng cách dưới */
                letter-spacing: 1px; /* Khoảng cách giữa các chữ cái */
            }
        </style>
    </head>
    <body>
        <!-- Header -->

        <%@ include file="/header.jsp" %>

        <!-- Menu -->

        <%@ include file="/menu.jsp" %>

        <!-- Home -->
        <div class="super_container">
            <div class="wrapper" style="background-image: url('P_images/login.jpg');">

                <div class="inner">

                    <form action="login" method="POST">
                        <h3>Đăng nhập</h3>

                        <div class="form-group">
                            <label for="UserName">Tên đăng nhập:</label>
                            <div class="form-holder">
                                
                                <input style="margin-left: 5px" type="text" class="form-control" id="UserName" name="UserName" value="${UserName}" required>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="Password">Mật khẩu:</label>
                            <div class="form-holder">
                                
                                <input style="margin-left: 41px" type="password" class="form-control" id="Password" name="Password" value="${Password}" placeholder="********" required>
                            </div>
                        </div>

                        <p class="text-danger" style="color: red;">${mess}</p>

                        <div class="button-container">
                            <button type="submit">Đăng nhập</button>
                        </div>

                        <div class="text-center container" style="margin-top: 15px;">
                            Chưa có tài khoản? <a href="signup.jsp" class="link-to-help">Đăng ký</a>
                        </div>
                        <div class="text-center container" style="margin-top: 15px;">
                            <a  href="forgotPassword.jsp">Quên mật khẩu?</a>
                        </div>
                        
                    </form>
                </div>
            </div>
        </div>
        <script src="js/jquery-3.2.1.min.js"></script>
        <script src="styles/bootstrap4/popper.js"></script>
        <script src="styles/bootstrap4/bootstrap.min.js"></script>
        <script src="plugins/easing/easing.js"></script>
        <script src="plugins/parallax-js-master/parallax.min.js"></script>
        <script src="js/cart_custom.js"></script>
    </body>
</html>