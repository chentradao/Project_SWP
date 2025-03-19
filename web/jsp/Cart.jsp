<%-- 
    Document   : Cart
    Created on : Feb 5, 2025, 11:36:24 PM
    Author     : nguye
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Vector,entity.Cart,entity.Voucher,entity.Accounts" %>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.DecimalFormatSymbols"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
        <style>
           .newsletter_button {
    display: block; /* Đảm bảo button chiếm toàn bộ chiều ngang của container cha nếu cần */
    margin: 0 auto; /* Căn giữa theo chiều ngang */
    width: 142px; /* Giữ nguyên chiều rộng */
    height: 46px;
    background: #937c6f;
    color: #FFFFFF;
    font-size: 12px;
    letter-spacing: 0.2em;
    text-transform: uppercase;
    border: none;
    outline: none;
    cursor: pointer;
    -webkit-transition: all 200ms ease;
    -moz-transition: all 200ms ease;
    -ms-transition: all 200ms ease;
    -o-transition: all 200ms ease;
    transition: all 200ms ease;
}

.newsletter_button:hover {
    background: #e0e3e4;
    color: #232323;
}

/* Đảm bảo container cha hỗ trợ căn giữa */
.newsletter_form_container {
    text-align: center; /* Căn giữa các phần tử con */
}

/* Nếu cần căn giữa trong trường hợp button nằm trong section_subtitle */
.section_subtitle .newsletter_button {
    display: inline-block; /* Đảm bảo button không chiếm toàn bộ dòng */
    margin: 0 auto; /* Căn giữa */
}
        </style>
    </head>
    <body>
        <%
                    Vector<Cart> vector=(Vector<Cart>)request.getAttribute("vectorCart");
                    Vector<Voucher> voucherlist=(Vector<Voucher>)request.getAttribute("voucherlist");
                    Voucher voucher = (Voucher)request.getAttribute("voucher");
                    Accounts acc = (Accounts)request.getAttribute("acc");
                    String error = (String)request.getAttribute("error");
                    DecimalFormatSymbols symbols = new DecimalFormatSymbols();
                    symbols.setGroupingSeparator('.');
                    DecimalFormat formatter = new DecimalFormat("#,###", symbols);
        %>
        <div class="super_container">

            <!-- Header -->

            <%@ include file="/header.jsp" %>

            <!-- Menu -->

            <%@ include file="/menu.jsp" %>

            <!-- Home -->

            <div class="home">
                <div class="home_background parallax-window" data-parallax="scroll" data-image-src="P_images/Cart_header.jpg" data-speed="0.8"></div>
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
                            int subTotal = 0;
                        
                            for(Cart cart : vector){
                            int total = cart.getPrice() * cart.getQuantity();
                            subTotal += total;
                        %>
                        <div class="row">
                            <div class="col">
                                <div class="cart_products">
                                    <ul>
                                        <li class=" cart_product d-flex flex-md-row flex-column align-items-md-center align-items-start justify-content-start">
                                            <!-- Product Image -->
                                            <div class="cart_product_image" style="display: flex; justify-content: center; align-items: center; height: 140px; overflow: hidden; width: 110px">
                                                <img src="<%= cart.getImage() != null ? cart.getImage() : "images/default-product.jpg" %>" alt=""style="object-fit: contain; width: auto; max-height: 150px;">
                                            </div>
                                            <!-- Product Name -->
                                            <div class="cart_product_name"><a href="<%= request.getContextPath() %>/ProductDetail?productId=<%= cart.getID() %>"><%=cart.getProductName()%></a></div>
                                            <div class="product_details">
                                                <%if(cart.getSize() != null){%>
                                                <span>Size: <%= cart.getSize() %></span> <%}%> |
                                                <%if(cart.getColor() != null){%>     
                                                <span>Màu Sắc: <%= cart.getColor() %></span><%}%>
                                            </div>
                                            <div class="cart_product_info ml-auto">
                                                <div class="cart_product_info_inner d-flex flex-row align-items-center justify-content-md-end justify-content-start">
                                                    <!-- Product Price -->
                                                    <div class="cart_product_price"><%=formatter.format(cart.getPrice())%>₫</div>
                                                    <!-- Product Quantity -->
                                                    <div class="product_quantity_container">
                                                        <div class="product_quantity clearfix">
                                                            <input id="quantity_input" type="number" name="Quantity_<%=cart.getID()%>"  value="<%=cart.getQuantity()%>">

                                                        </div>
                                                    </div>
                                                    <!-- Products Total Price -->
                                                    <div class="cart_product_total"><%=formatter.format(total)%>₫</div>
                                                    <!-- Product Cart Trash Button -->
                                                    <div class="cart_product_button">
                                                        <button type="button" class="cart_product_remove" title="Xóa sản phẩm" onclick="window.location.href = 'CartURL?service=removeCart&id=<%=cart.getID()%>'"><img src="images/trash.png" alt=""></button>
                                                    </div>
                                                </div>
                                            </div>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <%
                            }
                                if(subTotal == 0){
                                    session.removeAttribute("voucher");
                        %>

                        <div class="py-12 flex flex-col items-center justify-center text-center">
                            <div class="w-16 h-16 rounded-full bg-blue-100 flex items-center justify-center mb-4">
                                <img src="P_images/cart.png" width="300px" height="250px" alt="Không tìm thấy ảnh"/>
                            </div>
                            <h3 class="text-lg font-medium text-gray-700 mb-2">Không có sản phẩm nào được tìm thấy</h3>
                            <p class="text-gray-500 max-w-md">Bạn chưa thêm bất kỳ sản phẩm nào vào giỏ hàng. Hãy đặt đơn ngay hôm nay để nhận ưu đãi đặc biệt!</p>
                            <a href="categories.jsp" class="mt-4 text-blue-600 hover:text-blue-800 font-medium">
                                <i class="fas fa-plus mr-1"></i> Thêm sản phẩm vào giỏ hàng
                            </a>
                        </div>
                        <%}else{%>
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
                                    <form action="CartURL" class="cart_coupon_form d-flex flex-row align-items-start justify-content-start" id="cart_coupon_form" method="post">
                                        <input type="hidden" name="service" value="addVoucher">
                                        <input type="text" name="VoucherID" class="cart_coupon_input" placeholder="Mã Giảm Giá" value="${sessionScope.voucher.getVoucherName()}"  id="voucherInput">
                                        <button type="submit" class="button_clear cart_button_2">Áp Dụng</button>
                                        <%if(acc != null){%>
                                        <!-- Danh sách đề xuất voucher -->
                                        <div id="voucherSuggestions" class="voucher-suggestions" style="display: none;">
                                            <%for(Voucher voucherin4 : voucherlist){%>
                                            <label><input type="radio" name="voucherOption" value="<%=voucherin4.getVoucherName()%>"> <%=voucherin4.getVoucherName()%> - Giảm <%=voucherin4.getDiscount()%>% -Giảm Tối Đa <%=formatter.format(voucherin4.getMaxDiscount())%>₫</label><br>
                                                <%}%>
                                        </div>
                                        <%}%>
                                    </form>
                                    <%if(error != null){%>
                                    <div class="error-message" style="color: red;"><%=error%></div>
                                    <%session.removeAttribute("error");
                                            }%>
                                </div>
                            </div>
                            <%
                                int discount = 0;
                                if(voucher != null){
                                       int rawDiscount = (voucher.getDiscount() * subTotal)/100;
                                       if(voucher.getMaxDiscount() > 0){
                                       if(rawDiscount <= voucher.getMaxDiscount()){
                                       discount = rawDiscount;
                                }else{
                                        discount = voucher.getMaxDiscount();
                                    }
                                }else{
                                discount = rawDiscount;
                                }
                                }
                                int total = subTotal - discount;
                            %>
                            <!-- Cart Total -->
                            <div class="col-lg-5 offset-lg-1">
                                <div class="cart_total">
                                    <div class="cart_title">Tổng Thanh Toán</div>
                                    <ul>
                                        <li class="d-flex flex-row align-items-center justify-content-start">
                                            <div class="cart_total_title">Tổng Tiền Hàng</div>
                                            <div class="cart_total_price ml-auto"><%=formatter.format(subTotal)%>₫</div>
                                        </li>
                                        <li class="d-flex flex-row align-items-center justify-content-start">
                                            <div class="cart_total_title">Giảm Giá</div>
                                            <div class="cart_total_price ml-auto"><%=formatter.format(discount)%>₫</div>
                                        </li>
                                        <li class="d-flex flex-row align-items-center justify-content-start">
                                            <div class="cart_total_title">Tổng Thanh Toán</div>
                                            <div class="cart_total_price ml-auto"><%=formatter.format(total)%>₫</div>
                                        </li>
                                    </ul>
                                    <button type="button" class="cart_total_button" onclick="window.location.href = 'OrderURL?service=checkout'">Mua Hàng</button>
                                </div>
                            </div>
                        </div>
                        <%}%>
                    </div>
                </div>
                <!-- Footer -->

                <%@ include file="/Footer.jsp" %>
        </div>
        <script>
            function removeDiacritics(str) {
                return str.normalize("NFD").replace(/[\u0300-\u036f]/g, ""); // Loại bỏ dấu
            }

            document.getElementById("voucherInput").addEventListener("input", function (event) {
                let inputValue = this.value;
                inputValue = removeDiacritics(inputValue); // Chuyển chữ có dấu thành không dấu
                inputValue = inputValue.replace(/[^a-zA-Z0-9]/g, ''); // Loại bỏ ký tự đặc biệt và dấu cách
                this.value = inputValue.toUpperCase(); // Chuyển thành chữ in hoa
            });

            document.addEventListener("DOMContentLoaded", function () {
                const voucherInput = document.getElementById("voucherInput");
                const voucherSuggestions = document.getElementById("voucherSuggestions");
                const radioButtons = voucherSuggestions.querySelectorAll('input[type="radio"]');

                // Hiển thị danh sách khi nhấp vào ô input
                voucherInput.addEventListener("focus", function () {
                    voucherSuggestions.style.display = "block";
                });

                // Điền giá trị voucher vào input khi chọn radio button
                radioButtons.forEach(radio => {
                    radio.addEventListener("change", function () {
                        voucherInput.value = this.value;
                        voucherSuggestions.style.display = "none"; // Ẩn danh sách sau khi chọn
                    });
                });

                // Ẩn danh sách khi nhấp ra ngoài
                document.addEventListener("click", function (e) {
                    if (!voucherInput.contains(e.target) && !voucherSuggestions.contains(e.target)) {
                        voucherSuggestions.style.display = "none";
                    }
                });
            });
        </script>
        <script src="js/jquery-3.2.1.min.js"></script>
        <script src="styles/bootstrap4/popper.js"></script>
        <script src="styles/bootstrap4/bootstrap.min.js"></script>
        <script src="plugins/easing/easing.js"></script>
        <script src="plugins/parallax-js-master/parallax.min.js"></script>
        <script src="js/cart_custom.js"></script>
    </body>
</html>
