<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Registration Form</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <!-- MATERIAL DESIGN ICONIC FONT -->
        <link rel="stylesheet" href="fonts/material-design-iconic-font/css/material-design-iconic-font.min.css">

        <!-- STYLE CSS -->
        <link rel="stylesheet" href="css/style.css">
    </head>

    <body>
        <div class="wrapper" style="background-image: url('images/bg-registration-form-3.jpg');">
            <div class="inner">
                <form action="signup" method="POST">
                    <h3>SIGN UP</h3>

                    <div class="form-group">
                        <div class="form-wrapper">
                            <label for="UserName">Username:</label>
                            <div class="form-holder">
                                <i class="zmdi zmdi-account-o"></i>
                                <input type="text" class="form-control" id="UserName" name="UserName" value="${UserName}" required>
                                <p class="text-danger">${messU}</p>
                            </div>
                        </div>
                        <div class="form-wrapper">
                            <label for="Password">Password:</label>
                            <div class="form-holder">
                                <i class="zmdi zmdi-lock-outline"></i>
                                <input type="password" class="form-control" id="Password" name="Password" placeholder="********" required>
                                <p class="text-danger">${messP}</p>
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="form-wrapper">
                            <label for="FullName">Full Name:</label>
                            <div class="form-holder">
                                <i class="zmdi zmdi-account"></i>
                                <input type="text" class="form-control" id="FullName" name="FullName" value="${FullName}" required>
                            </div>
                        </div>
                        <div class="form-wrapper">
                            <label for="ConfirmPassword">Repeat Password:</label>
                            <div class="form-holder">
                                <i class="zmdi zmdi-lock-outline"></i>
                                <input type="password" class="form-control" id="ConfirmPassword" name="ConfirmPassword" placeholder="********" required>
                                <p class="text-danger">${messCp}</p>
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="form-wrapper">
                            <label for="Phone">Phone:</label>
                            <div class="form-holder">
                                <i class="zmdi zmdi-phone"></i>
                                <input type="tel" class="form-control" id="Phone" name="Phone" value="${Phone}" required pattern="[0-9]{10}">
                                <p class="text-danger">${messPhone}</p>
                            </div>
                        </div>
                        <div class="form-wrapper">
                            <label for="Email">Email:</label>
                            <div class="form-holder">
                                <i class="zmdi zmdi-email"></i>
                                <input type="email" class="form-control" id="Email" name="Email" value="${Email}" required>
                                <p class="text-danger">${messEmail}</p>
                            </div>
                        </div>
                    </div>

                    <div class="form-end">
                        <div class="button-holder">
                            <button type="submit">Register</button>
                        </div>
                        <div class="text-center" style="margin-left:25px;">
                            Already have an account? <a href="login.jsp" class="link-to-help">Log in</a>
                        </div>
                    </div>


                </form>
            </div>
        </div>

    </body>
</html>
