<%-- 
    Document   : Cart
    Created on : Feb 5, 2025, 11:36:24 PM
    Author     : nguye
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Vector,entity.Cart" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Cart</title>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="description" content="Wish shop project">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" type="text/css" href="styles/bootstrap4/bootstrap.min.css">
        <link href="plugins/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
        <link rel="stylesheet" type="text/css" href="styles/cart.css">
        <link rel="stylesheet" type="text/css" href="styles/cart_responsive.css">
    </head>
    <body>
        <%
                    Vector<Cart> vector=(Vector<Cart>)request.getAttribute("vectorCart");
        %>
        <div class="super_container">

            <!-- Header -->

            <%@ include file="/header.jsp" %>

            <!-- Menu -->

            <%@ include file="/menu.jsp" %>

            <!-- Home -->

            <div class="home">
                <div class="home_background parallax-window" data-parallax="scroll" data-image-src="images/cart.jpg" data-speed="0.8"></div>
                <div class="container">
                    <div class="row">
                        <div class="col">
                            <div class="home_container">
                                <div class="home_content">
                                    <div class="home_title">Giỏ hàng</div>
                                    <div class="breadcrumbs">
                                        <ul>
                                            <li><a href="index.jsp">Home</a></li>
                                            <li>Giỏ hàng</li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Cart -->
            <form action="CartURL" method="POST">
                <input type="hidden" name="service" value="updateCart" />
                <div class="cart_container">
                    <div class="container">
                        <div class="row">
                            <div class="col">
                                <div class="cart_title">Giỏ hàng của bạn</div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col">
                                <div class="cart_bar d-flex flex-row align-items-center justify-content-start">
                                    <div class="cart_bar_title_name">Sản Phẩm</div>
                                    <div class="cart_bar_title_content ml-auto">
                                        <div class="cart_bar_title_content_inner d-flex flex-row align-items-center justify-content-end">
                                            <div class="cart_bar_title_price">Đơn Giá</div>
                                            <div class="cart_bar_title_quantity">Số Lượng</div>
                                            <div class="cart_bar_title_total">Số Tiền</div>
                                            <div class="cart_bar_title_button"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <%
                            int grandTotal = 0;
                        
                            for(Cart cart : vector){
                            int total = cart.getPrice() * cart.getQuantity();
                            grandTotal += total;
                        %>
                        <div class="row">
                            <div class="col">
                                <div class="cart_products">
                                    <ul>
                                        <li class=" cart_product d-flex flex-md-row flex-column align-items-md-center align-items-start justify-content-start">
                                            <!-- Product Image -->
                                            <div class="cart_product_image" style="display: flex; justify-content: center; align-items: center; height: 150px; overflow: hidden; width: 90px">
                                                <img src="<%= cart.getImage() != null ? cart.getImage() : "images/default-product.jpg" %>" alt=""style="object-fit: contain; width: auto; max-height: 150px;">
                                            </div>
                                            <!-- Product Name -->
                                            <div class="cart_product_name"><a href="product.html"><%=cart.getProductName()%></a></div>
                                            <div class="product_details">
                                                <%if(cart.getSize() != null){%>
                                                <span>Size: <%= cart.getSize() %></span> <%}%> |
                                                <%if(cart.getColor() != null){%>     
                                                <span>Màu Sắc: <%= cart.getColor() %></span><%}%>
                                            </div>
                                            <div class="cart_product_info ml-auto">
                                                <div class="cart_product_info_inner d-flex flex-row align-items-center justify-content-md-end justify-content-start">
                                                    <!-- Product Price -->
                                                    <div class="cart_product_price"><%=cart.getPrice()%>₫</div>
                                                    <!-- Product Quantity -->
                                                    <div class="product_quantity_container">
                                                        <div class="product_quantity clearfix">
                                                            <input id="quantity_input" type="number" name="Quantity_<%=cart.getID()%>"  value="<%=cart.getQuantity()%>">
                                                            <div class="quantity_buttons">
                                                                <div id="quantity_inc_button" class="quantity_inc quantity_control"><i class="fa fa-caret-up" aria-hidden="true"></i></div>
                                                                <div id="quantity_dec_button" class="quantity_dec quantity_control"><i class="fa fa-caret-down" aria-hidden="true"></i></div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <!-- Products Total Price -->
                                                    <div class="cart_product_total"><%=total%>₫</div>
                                                    <!-- Product Cart Trash Button -->
                                                    <div class="cart_product_button">
                                                        <div class="cart_product_remove"><a href="CartURL?service=removeCart&id=<%=cart.getID()%>"><img src="images/trash.png" alt=""></a></div>
<!--                                                                                    <button class="cart_product_remove" onclick="window.location.href='CartURL?service=removeCart&id=<%=cart.getID()%>'"><img src="images/trash.png" alt=""></button>-->
                                                    </div>
                                                </div>
                                            </div>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <%}%>
                        <div class="row">
                            <div class="col">
                                <div class="cart_control_bar d-flex flex-md-row flex-column align-items-start justify-content-start">
                                    <button type="button" class="button_clear cart_button" id="clearCartBtn">Xóa Giỏ Hàng</button>
                                    <button class="button_update cart_button" type="submit" name="submit" value="Update Cart">Cập Nhật</button>
                                    <button type="button" class="button_update cart_button_2 ml-md-auto" onclick="window.location.href = 'categories.jsp?'">Xem Thêm Sản Phẩm</button>					</div>
                            </div>
                        </div>
                        <div class="popup_clear">
                            <div class="popup_content">
                                <h3>Bạn muốn xóa toàn bộ sản phẩm?</h3>
                                <button type="button" class="button_clear cart_button" id="closePopup">Trở Về</button>
                                <button type="button" class="button_clear cart_button" onclick="window.location.href = 'CartURL?service=clearCart'" id="closePopup">Xóa</button>
                            </div>
                        </div>
                        <script>
                            document.getElementById("clearCartBtn").addEventListener("click", function () {
                                document.querySelector(".popup_clear").style.display = "flex";
                            });
                            // Ẩn popup khi nhấn "Trở Về"
                            document.getElementById("closePopup").addEventListener("click", function () {
                                document.querySelector(".popup_clear").style.display = "none";
                            });

                            // Ẩn popup khi click ra ngoài
                            document.querySelector(".popup_clear").addEventListener("click", function (event) {
                                if (event.target === this) {
                                    this.style.display = "none";
                                }
                            });
                        </script> 
                        </form>

                        <div class="row cart_extra">
                            <!-- Cart Coupon -->
                            <div class="col-lg-6">
                                <div class="cart_coupon">
                                    <div class="cart_title">Mã Giảm Giá</div>
                                    <form action="#" class="cart_coupon_form d-flex flex-row align-items-start justify-content-start" id="cart_coupon_form">
                                        <input type="text" class="cart_coupon_input" placeholder="Mã Giảm Giá" required="required">
                                        <button class="button_clear cart_button_2">Áp Dụng</button>
                                    </form>
                                </div>
                            </div>

                            <!-- Cart Total -->
                            <div class="col-lg-5 offset-lg-1">
                                <div class="cart_total">
                                    <div class="cart_title">Tổng Thanh Toán</div>
                                    <ul>
                                        <li class="d-flex flex-row align-items-center justify-content-start">
                                            <div class="cart_total_title">Tổng Tiền Hàng</div>
                                            <div class="cart_total_price ml-auto"><%=grandTotal%>₫</div>
                                        </li>
                                        <li class="d-flex flex-row align-items-center justify-content-start">
                                            <div class="cart_total_title">Giảm Giá</div>
                                            <div class="cart_total_price ml-auto">$5.00₫</div>
                                        </li>
                                        <li class="d-flex flex-row align-items-center justify-content-start">
                                            <div class="cart_total_title">Tổng Thanh Toán</div>
                                            <div class="cart_total_price ml-auto"><%=grandTotal%>₫</div>
                                        </li>
                                    </ul>
                                        <button type="button" class="cart_total_button" onclick="window.location.href = 'OrderURL?service=checkout'">Mua Hàng</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Footer -->

                <%@ include file="/Footer.jsp" %>
        </div>

        <script src="js/jquery-3.2.1.min.js"></script>
        <script src="styles/bootstrap4/popper.js"></script>
        <script src="styles/bootstrap4/bootstrap.min.js"></script>
        <script src="plugins/easing/easing.js"></script>
        <script src="plugins/parallax-js-master/parallax.min.js"></script>
        <script src="js/cart_custom.js"></script>
    </body>
</html>
