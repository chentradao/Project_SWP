<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Login Form</title>
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
            .google-login{
                border-radius: 10px;
                background-color: whitesmoke;
                
            }
        </style>
    </head>
    <body>
        <div class="wrapper" style="background-image: url('images/bg-registration-form-3.jpg');">
            <div class="inner">
                <form action="login" method="POST">
                    <h3>SIGN IN</h3>

                    <div class="form-group">
                        <label for="UserName">Username:</label>
                        <div class="form-holder">
                            <i class="zmdi zmdi-account-o"></i>
                            <input type="text" class="form-control" id="UserName" name="UserName" value="${UserName}"required>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="Password">Password:</label>
                        <div class="form-holder">
                            <i class="zmdi zmdi-lock-outline"></i>
                            <input type="password" class="form-control" id="Password" name="Password" value="${Password}" placeholder="********" required>
                        </div>

                    </div>

                    <p class="text-danger" style="color: red;" >${mess}</p>

                    <div class="button-container">
                        <button type="submit">LOGIN</button>
                        <!--<button class="google-login"><a href="https:/accounts.google.com/o/oauth2/auth?scope=email profile openid&redirect_uri=http:/localhost:9999/ProjectSWP/login&response_type=code&client_id=544358352643-kqs8iv9ej4s52ni1vg8qhmfg18mghfl2.apps.googleusercontent.com&approval_prompt=force">LOGIN with Google</a></button>-->
                    </div>

                    <div class="text-center" style="margin-top: 15px;">
                        Don't have an account? <a href="signup.jsp" class="link-to-help">Sign up</a>
                    </div>
                </form>
            </div>
        </div>
    </body>
</html>
