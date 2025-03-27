<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Đăng nhập</title>
        <link rel="stylesheet" href="fonts/material-design-iconic-font/css/material-design-iconic-font.min.css">
        <link rel="stylesheet" href="css/style.css">
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
         
        <div class="super_container">
            <div class="wrapper" style="background-image: url('P_images/login.jpg');">
                
                <div class="inner">
                    
                    <form action="login" method="POST">
                        <h3>Đăng nhập</h3>

                        <div class="form-group">
                            <label for="UserName">Tên đăng nhập:</label>
                            <div class="form-holder">
                                <i class="zmdi zmdi-account-o"></i>
                                <input type="text" class="form-control" id="UserName" name="UserName" value="${UserName}" required>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="Password">Mật khẩu:</label>
                            <div class="form-holder">
                                <i class="zmdi zmdi-lock-outline"></i>
                                <input type="password" class="form-control" id="Password" name="Password" value="${Password}" placeholder="********" required>
                            </div>
                        </div>

                        <p class="text-danger" style="color: red;">${mess}</p>

                        <div class="button-container">
                            <button type="submit">Đăng nhập</button>
                        </div>

                        <div class="text-center container" style="margin-top: 15px;">
                            Chưa có tài khoản? <a href="signup.jsp" class="link-to-help">Đăng ký</a>
                        </div>
                        <a href="forgotPassword.jsp">Quên mật khẩu?</a>
                    </form>
                </div>
            </div>
        </div>
    </body>
</html>