<!doctype html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>
        <meta charset='utf-8'>
        <meta name='viewport' content='width=device-width, initial-scale=1'>
        <title>Forgot password</title>
        <link href='https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css' rel='stylesheet'>
        <link href='' rel='stylesheet'>
        <script type='text/javascript' src='https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js'></script>
        <style>
            body {
                background-position: center;
                background-repeat: no-repeat;
                background-size: cover;
                color: #505050;
                font-family: "Rubik", Helvetica, Arial, sans-serif;
                font-size: 14px;
                font-weight: normal;
                line-height: 1.5;
                text-transform: none;
                height: 100vh; /* Đảm bảo body chiếm toàn bộ chiều cao màn hình */
                margin: 0; /* Loại bỏ margin mặc định */
            }

            .forgot {
                background-color: #fff;
                padding: 12px;
                border: 1px solid #dfdfdf;
            }

            .padding-bottom-3x {
                padding-bottom: 72px !important;
            }

            .card-footer {
                background-color: #fff;
            }

            .btn {
                font-size: 13px;
            }

            .form-control:focus {
                color: #495057;
                background-color: #fff;
                border-color: #76b7e9;
                outline: 0;
                box-shadow: 0 0 0 0px #28a745;
            }

            /* Đảm bảo container chính không vượt quá chiều cao màn hình */
            html, body {
                height: 100%;
            }
        </style>
    </head>
    <body oncontextmenu='return false' class='snippet-body' style="background-image: url('P_images/login.jpg');">
        <div class="container padding-bottom-3x mb-2 mt-5">
            <div class="row justify-content-center">
                <div class="col-lg-8 col-md-10">
                    <div class="forgot">
                        <h2>Quên mật khẩu?</h2>
                        <p>Thay đổi mật khẩu của bạn theo ba bước đơn giản. Điều này sẽ giúp bạn bảo mật mật khẩu của mình!</p>
                        <ol class="list-unstyled">
                            <li><span class="text-primary text-medium">1. </span>Nhập địa chỉ email của bạn bên dưới.</li>
                            <li><span class="text-primary text-medium">2. </span>Hệ thống của chúng tôi sẽ gửi cho bạn một OTP đến email của bạn</li>
                            <li><span class="text-primary text-medium">3. </span>Nhập OTP vào trang tiếp theo</li>
                        </ol>
                    </div>
                    <form class="card mt-4" action="forgotPassword" method="POST">
                        <div class="card-body">
                            <div class="form-group">
                                <label for="email-for-pass">Nhập địa chỉ email của bạn</label>
                                <input class="form-control" type="text" name="email" id="email-for-pass" required="">
                                <small class="form-text text-muted">Nhập địa chỉ email đã đăng ký. Sau đó, chúng tôi sẽ gửi mã OTP đến địa chỉ này.</small>
                            </div>
                        </div>
                        <div class="card-footer">
                            <button class="btn btn-success" type="submit">Nhận mật khẩu mới</button>
                            <button class="btn btn-danger" onclick="window.location.href='login.jsp'">Quay lại Đăng nhập</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <script type='text/javascript' src='https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.bundle.min.js'></script>
        <script type='text/javascript' src=''></script>
        <script type='text/javascript' src=''></script>
        <script type='text/Javascript'></script>
    </body>
</html>