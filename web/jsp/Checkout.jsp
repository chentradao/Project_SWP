<%-- 
    Document   : Checkout
    Created on : Feb 26, 2025, 10:07:54 AM
    Author     : nguye
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="entity.Accounts,java.sql.ResultSet,java.util.Vector" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Checkout</title>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="description" content="Wish shop project">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" type="text/css" href="styles/bootstrap4/bootstrap.min.css">
        <link href="plugins/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
        <link rel="stylesheet" type="text/css" href="styles/checkout.css">
        <link rel="stylesheet" type="text/css" href="styles/checkout_responsive.css">
    </head>
    <body>
        <%Accounts acc = (Accounts)request.getAttribute("acc");%>
        <div class="super_container">

            <!-- Header -->

            <%@ include file="/header.jsp" %>


            <!-- Menu -->

            <%@ include file="/menu.jsp" %>

            <!-- Home -->

            <div class="home">
                <div class="home_background parallax-window" data-parallax="scroll" data-image-src="images/categories.jpg" data-speed="0.8"></div>
                <div class="container">
                    <div class="row">
                        <div class="col">
                            <div class="home_container">
                                <div class="home_content">
                                    <div class="home_title">Checkout</div>
                                    <div class="breadcrumbs">
                                        <ul>
                                            <li><a href="index.html">Home</a></li>
                                            <li><a href="index.html">Shopping Cart</a></li>
                                            <li>Shopping Cart</li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Checkout -->
            <form action="OrderURL" method="post">
                <input type="hidden" name="service" value="checkout">
                <div class="checkout">
                    <div class="container">
                        <div class="row">

                            <!-- Billing Details -->
                            <div class="col-lg-6">
                                <div class="billing">
                                    <div class="checkout_title">billing details</div>
                                    <div class="checkout_form_container">
                                        <form action="#" id="checkout_form">
                                            <%if(acc != null){%>
                                            <!--                                            <div class="d-flex flex-lg-row flex-column align-items-start justify-content-between">
                                                                                            <input type="text" class="checkout_input checkout_input_50" placeholder="First Name" required="required">
                                                                                            <input type="text" class="checkout_input checkout_input_50" placeholder="Last Name" required="required">
                                                                                        </div>-->
                                            <input type="text" class="checkout_input" placeholder="Họ Tên" required="required"  name="CustomerName" value="<%=acc.getUserName()%>">
                                            <input type="text" class="checkout_input" placeholder="E-mail" required="required" name="Email" value="<%=acc.getEmail()%>">
                                            <select name="ShipCity" id="ShipCity" class="country_select checkout_input">
                                                <option value="Hà Nội">Hà Nội</option>
                                                <option value="Thành phố Hồ Chí Minh">Thành phố Hồ Chí Minh</option>
                                            </select>
                                            <input type="text" class="checkout_input" placeholder="Địa Chỉ" required="required" name="ShipAddress" value="<%=acc.getAddress()%>">
                                            <input type="text" class="checkout_input" placeholder="Số Điện Thoại" required="required" name="ShipCity" value="<%=acc.getPhone()%>">
                                            <!--                                            <input type="text" class="checkout_input" placeholder="Town" required="required">
                                                                                        <div class="d-flex flex-lg-row flex-column align-items-start justify-content-between">
                                                                                            <input type="text" class="checkout_input checkout_input_50" placeholder="Zipcode" required="required">
                                                                                            <input type="text" class="checkout_input checkout_input_50" placeholder="Phone No" required="required">
                                                                                        </div>-->
                                            <textarea name="checkout_comment" id="checkout_comment" class="checkout_comment" placeholder="Leave a comment about your order"></textarea>
                                            <div class="billing_options">
                                                <div class="billing_account">
                                                    <input type="checkbox" id="checkbox_account" name="regular_checkbox" class="regular_checkbox checkbox_account">
                                                    <label for="checkbox_account"><img src="images/checked.png" alt=""></label>
                                                    <span>Create an account</span>
                                                </div>
                                                <div class="billing_shipping">
                                                    <input type="checkbox" id="checkbox_shipping" name="regular_checkbox" class="regular_checkbox checkbox_shipping">
                                                    <label for="checkbox_shipping"><img src="images/checked.png" alt=""></label>
                                                    <span>Ship to a different address</span>
                                                </div>
                                            </div>
                                            <%}else{%>
                                            <input type="text" class="checkout_input" placeholder="Họ Tên" name="CustomerName">
                                            <input type="text" class="checkout_input" placeholder="E-mail" required="required" name="Email">
                                            <select name="city" id="city" onchange='getProvinces(event)' class="country_select checkout_input">
                                                <option value="">Tỉnh / Thành phố</option>
                                            </select>
                                            <div class="d-flex flex-lg-row flex-column align-items-start justify-content-between">
                                                <select name="district" id="district" class="country_select checkout_input">
                                                    <option value="">Quận / Huyện</option>
                                                </select>
                                                <select name="ward" id="ward" class="country_select checkout_input">
                                                    <option value="">Phường / Xã</option>
                                                </select>
                                            </div>
                                            <input type="text" class="checkout_input" placeholder="Địa Chỉ" required="required" name="ShipAddress">
                                            <input type="text" class="checkout_input" placeholder="Số Điện Thoại" required="required" name="Phone">

                                            <textarea name="checkout_comment" id="checkout_comment" class="checkout_comment" placeholder="Lưu ý về đơn hàng"></textarea>
                                            <div class="billing_options">
                                                <div class="billing_account">
                                                    <input type="checkbox" id="checkbox_account" name="regular_checkbox" class="regular_checkbox checkbox_account">
                                                    <label for="checkbox_account"><img src="images/checked.png" alt=""></label>
                                                    <span>Create an account</span>
                                                </div>
                                                <div class="billing_shipping">
                                                    <input type="checkbox" id="checkbox_shipping" name="regular_checkbox" class="regular_checkbox checkbox_shipping">
                                                    <label for="checkbox_shipping"><img src="images/checked.png" alt=""></label>
                                                    <span>Ship to a different address</span>
                                                </div>
                                            </div>
                                            <%}%>
                                        </form>
                                    </div>
                                </div>
                            </div>

                            <!-- Cart Details -->
                            <div class="col-lg-6">
                                <div class="cart_details">
                                    <div class="checkout_title">cart total</div>
                                    <div class="cart_total">
                                        <ul>
                                            <li class="d-flex flex-row align-items-center justify-content-start">
                                                <div class="cart_total_title">Product</div>
                                                <div class="cart_total_price ml-auto">Total</div>
                                            </li>
                                            <li class="d-flex flex-row align-items-center justify-content-start">
                                                <div class="cart_total_title">2 Piece Swimsuit x1</div>
                                                <div class="cart_total_price ml-auto">$35.00</div>
                                            </li>
                                            <li class="d-flex flex-row align-items-center justify-content-start">
                                                <div class="cart_total_title">Subtotal</div>
                                                <div class="cart_total_price ml-auto">$35.00</div>
                                            </li>
                                            <li class="d-flex flex-row align-items-center justify-content-start">
                                                <div class="cart_total_title">Shipping</div>
                                                <div class="cart_total_price ml-auto">$5.00</div>
                                            </li>
                                            <li class="d-flex flex-row align-items-start justify-content-start total_row">
                                                <div class="cart_total_title">Total</div>
                                                <div class="cart_total_price ml-auto">$40.00</div>
                                            </li>
                                        </ul>
                                    </div>
                                    <div class="payment_options">
                                        <div>
                                            <input type="radio" id="radio_payment_1" name="regular_radio" class="regular_radio">
                                            <label for="radio_payment_1">cash on delivery</label>
                                        </div>
                                        <div>
                                            <input type="radio" id="radio_payment_2" name="regular_radio" class="regular_radio" checked>
                                            <label for="radio_payment_2">paypal</label>
                                            <div class="visa payment_option"><a href="#"><img src="images/visa.jpg" alt=""></a></div>
                                            <div class="master payment_option"><a href="#"><img src="images/master.jpg" alt=""></a></div>
                                        </div>
                                        <button type="submit" name="submit" value="purchase" class="cart_total_button">place order</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
            <!-- Footer -->

            <%@ include file="/Footer.jsp" %>
        </div>

        <script src="js/jquery-3.2.1.min.js"></script>
        <script src="styles/bootstrap4/popper.js"></script>
        <script src="styles/bootstrap4/bootstrap.min.js"></script>
        <script src="plugins/easing/easing.js"></script>
        <script src="plugins/parallax-js-master/parallax.min.js"></script>
        <script src="js/checkout_custom.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" referrerpolicy="no-referrer"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/axios/0.21.1/axios.min.js"></script>
        <script src="js/checkout_provinces.js"></script>
    </body>
</html>
