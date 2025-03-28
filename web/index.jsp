<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<link rel="stylesheet" type="text/css" href="css/style.css">

<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Esée Lauder</title>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="description" content="Wish shop project">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" type="text/css" href="styles/bootstrap4/bootstrap.min.css">
        <link href="plugins/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
        <link rel="stylesheet" type="text/css" href="plugins/OwlCarousel2-2.2.1/owl.carousel.css">
        <link rel="stylesheet" type="text/css" href="plugins/OwlCarousel2-2.2.1/owl.theme.default.css">
        <link rel="stylesheet" type="text/css" href="plugins/OwlCarousel2-2.2.1/animate.css">
        <link href="plugins/colorbox/colorbox.css" rel="stylesheet" type="text/css">
        <link rel="stylesheet" type="text/css" href="styles/main_styles.css">
        <link rel="stylesheet" type="text/css" href="styles/responsive.css">

    </head>
    <body>

        <div class="super_container">

            <!-- Header -->

            <%@ include file="header.jsp" %>

            <!-- Menu -->

            <%@ include file="menu.jsp" %>

            <!-- Home -->

            <div class="home">

                <!-- Home Slider -->

                <div class="home_slider_container">
                    <div class="owl-carousel owl-theme home_slider">

                        <!-- Home Slider Item -->
                        <c:forEach var="s" items="${slider}">
                            <div class="owl-item">
                                <a href="product.html">
                                    <div class="home_slider_background" style="background-image:url('<c:out value='img/${s.imageURL}' />')"></div>
                                    <div class="home_slider_content">
                                        <div class="home_slider_content_inner">
                                            <div class="home_slider_title"><c:out value="${s.sliderTitle}"/></div>
                                        </div>  
                                    </div>
                                </a>
                            </div>
                        </c:forEach>
                    </div>
                    <!-- Home Slider Nav -->
                    <div class="home_slider_next d-flex flex-column align-items-center justify-content-center"><img src="images/arrow_r.png" alt=""></div>
                    <!-- Home Slider Dots -->
                    <div class="home_slider_dots_container">
                        <div class="container">
                            <div class="row">
                                <div class="col">
                                    <div class="home_slider_dots">
                                        <ul id="home_slider_custom_dots" class="home_slider_custom_dots">
                                            <li class="home_slider_custom_dot active">01.<div></div></li>
                                            <li class="home_slider_custom_dot">02.<div></div></li>
                                            <li class="home_slider_custom_dot">03.<div></div></li>
                                            <li class="home_slider_custom_dot">04.<div></div></li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>		
                    </div>
                </div>
            </div>
            <!-- Promo -->
            <div class="promo">
                <div class="container">
                    <div class="row">
                        <div class="col">
                            <div class="section_title_container text-center">
                                <div class="section_subtitle">BÁN CHẠY NHẤT</div>
                                <div class="section_title">GIÁ KHUYẾN MÃI</div>
                            </div>
                        </div>
                    </div>
                    <div class="row promo_container">

                        <!-- Promo Item -->
                        <div class="col-lg-4 promo_col">
                            <div class="promo_item">
                                <div class="promo_image">
                                    <img src="images/lipstick.jpg" alt="">
                                    <div class="promo_content promo_content_1">
                                        <div class="promo_title">Giảm 30%</div>
                                        <div class="promo_subtitle">Cho son môi</div>
                                    </div>
                                </div>
                                <div class="promo_link"><a href="categories.jsp">Mua ngay</a></div>
                            </div>
                        </div>
                        <!-- Promo Item -->
                        <div class="col-lg-4 promo_col">
                            <div class="promo_item">
                                <div class="promo_image">
                                    <img src="images/serum.jpg" alt="">
                                    <div class="promo_content promo_content_2">
                                        <div class="promo_title">Giảm 30%</div>
                                        <div class="promo_subtitle">Cho Serum</div>
                                    </div>
                                </div>
                                <div class="promo_link"><a href="categories.jsp">Mua ngay</a></div>
                            </div>
                        </div>

                        <!-- Promo Item -->
                        <div class="col-lg-4 promo_col">
                            <div class="promo_item">
                                <div class="promo_image">
                                    <img src="images/perfume.jpg" alt="">
                                    <div class="promo_content promo_content_3">
                                        <div class="promo_title">-25% off</div>
                                        <div class="promo_subtitle">Cho nước hoa</div>
                                    </div>
                                </div>
                                <div class="promo_link"><a href="product.html">Mua ngay</a></div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>

            <!-- New Arrivals -->

            <div class="arrivals">
                <div class="container">
                    <div class="row">
                        <div class="col">
                            <div class="section_title_container text-center">
                                <div class="section_subtitle">CHỈ CÓ NHỮNG GÌ TỐT NHẤT</div>
                                <div class="section_title">Mặt hàng mới nhất</div>
                            </div>
                        </div>
                    </div>
                    <div class="product-container">
                        <c:choose>
                            <c:when test="${empty products}">
                                <p>No products found.</p>
                            </c:when>
                            <c:otherwise>
                                <c:forEach items="${products}" var="product">
                                    <div class="product">
                                        <div class="product_image">
                                            <img src="${not empty product.productImage ? product.productImage : 'images/default-product.jpg'}" 
                                                 alt="">
                                        </div>
                                        <div class="product_content">
                                            <div class="product_name">
                                                <a href="${pageContext.request.contextPath}/ProductDetail?productId=${product.productId}">
                                                    ${product.productName}
                                                </a>
                                            </div>
                                            <div class="product_price">

                                                <fmt:formatNumber value="${product.productPrice}" pattern="#,##0" /> VND

                                            </div>
                                            <div class="product_details">
                                                <c:if test="${not empty product.productSize}">
                                                    <span>Size: ${product.productSize}</span>
                                                </c:if>
                                                <c:if test="${not empty product.productColor}">
                                                    <span>Màu sắc: ${product.productColor}</span>
                                                </c:if>
                                            </div>
                                        </div>
                                        <div class="product_options">
                                            <a href="${pageContext.request.contextPath}/CartURL?service=add2cart&id=${product.id}">
                                                <div class="product_buy product_option">
                                                    <img src="images/shopping-bag-white.svg" alt="">
                                                </div>
                                            </a>
                                            <form action="${pageContext.request.contextPath}/addToWishlist" method="post">
                                                <input type="hidden" name="productId" value="${product.productId}" />
                                                <button type="submit" class="product_fav product_option" style="border: none; background: none; cursor: pointer;">
                                                    +
                                                </button>
                                            </form>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </div>  
                </div>
            </div>

            <!-- Extra -->

            <div class="extra clearfix">
                <div class="extra_promo extra_promo_1">
                    <div class="extra_promo_image" style="background-image:url(images/serum2.jpg)"></div>
                    <div class="extra_1_content d-flex flex-column align-items-center justify-content-center text-center">
                        <div class="extra_1_price">30%<span>Giảm sâu</span></div>
                        <div class="extra_1_title">Dành cho dòng serum mới nhất</div>
                        <div class="extra_1_text">Chăm sóc làn da hoàn hảo mỗi ngày. Hãy trải nghiệm sự thay đổi ngay từ lần đầu sử dụng!</div>
                        <div class="button extra_1_button"><a href="card.jsp">Mua ngay</a></div>
                    </div>
                </div>
                <div class="extra_promo extra_promo_2">
                    <div class="extra_promo_image" style="background-image:url(images/GraceElizabeth.jpg)"></div>
                    <div class="extra_2_content d-flex flex-column align-items-center justify-content-center text-center">
                        <div class="extra_2_title">
                            <div class="extra_2_center">&</div>
                            <div class="extra_2_top">Grace</div>
                            <div class="extra_2_bottom">Superme+</div>
                        </div>
                        <div class="extra_2_text">Làm đẹp cùng GraceElizabeth</div>
                        <div class="button extra_2_button"><a href="card.jsp">Mua ngay</a></div>
                    </div>
                </div>
            </div>

            <!-- Gallery -->

            <div class="gallery">
                <div class="gallery_image" style="background-image:url(images/gallery.jpg)"></div>
                <div class="container">
                    <div class="row">
                        <div class="col">
                            <div class="gallery_title text-center">
                                <ul>
                                    <li><a href="#">#wish</a></li>
                                    <li><a href="#">#wishinstagram</a></li>
                                    <li><a href="#">#wishgirl</a></li>
                                </ul>
                            </div>
                            <div class="gallery_text text-center">Sản phẩm yêu thích của bạn – Hãy khám phá ngay!</div>
                            <div class="button gallery_button">
                                <a href="${pageContext.request.contextPath}/getwishlist">Xem tất cả</a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="gallery_slider_container">
                    <!-- Gallery Slider -->
                    <div class="owl-carousel owl-theme gallery_slider">
                        <c:choose>
                            <c:when test="${empty wishlistItems}">
                                <!-- Hiển thị thông báo khi wishlist trống -->
                                <div class="owl-item gallery_item">
                                    <div class="text-center" style="padding: 20px;">
                                        <p>Danh sách yêu thích của bạn đang trống. Thêm sản phẩm ngay!</p>
                                        <a href="${pageContext.request.contextPath}/ProductListServlet" class="button">Khám phá sản phẩm</a>
                                    </div>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <!-- Lặp qua các sản phẩm trong wishlist và chỉ hiển thị ảnh -->
                                <c:forEach var="wishlistItem" items="${wishlistItems}">
                                    <div class="owl-item gallery_item">
                                        <a class="colorbox" href="${wishlistItem.product.productDetail.image}">
                                            <img src="${wishlistItem.product.productDetail.image}" 
                                                 alt="${wishlistItem.product.productName}" 
                                                 onerror="this.src='images/default-product.jpg'" />
                                        </a>
                                    </div>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>  
            </div>



            <!-- Testimonials -->



            <!-- Newsletter -->

            

            <!-- Footer -->

            <footer class="footer">
                <div class="container">
                    <div class="row">
                        <div class="col text-center">
                            <div class="footer_logo"><a href="ProductListServlet">Estée Lauder</a></div>
                            <nav class="footer_nav">
                                <ul>
                                    <li><a href="ProductListServlet">Trang chủ</a></li>
                                    <li><a href="categories.jsp">Chăm sóc da</a></li>
                                    <li><a href="categories.jsp">Trang điểm</a></li>
                                    <li><a href="categories.jsp">Nước hoa</a></li>
                                    <li><a href="contact.html">Chăm sóc mắt</a></li>
                                </ul>
                            </nav>
                            <div class="footer_social">
                                <ul>
                                    <li><a href="#"><i class="fa fa-pinterest" aria-hidden="true"></i></a></li>
                                    <li><a href="#"><i class="fa fa-linkedin" aria-hidden="true"></i></a></li>
                                    <li><a href="#"><i class="fa fa-instagram" aria-hidden="true"></i></a></li>
                                    <li><a href="#"><i class="fa fa-reddit-alien" aria-hidden="true"></i></a></li>
                                    <li><a href="#"><i class="fa fa-twitter" aria-hidden="true"></i></a></li>
                                </ul>
                            </div>
                            <div class="copyright"><!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
                                Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved | This template is made with <i class="fa fa-heart-o" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">Colorlib</a>
                                <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. --></div>
                        </div>
                    </div>
                </div>
            </footer>
        </div>
        <style>
            
            .product-container {
                margin-top: 20px;
                display: flex;
                flex-wrap: wrap;
                justify-content: center;
            }

            .product {
                width: calc(33.33% - 20px); /* Ensures 3 items per row */
                max-width: 300px; /* Limits the max size */
                height: 350px; /* Set a fixed height for consistency */
                display: flex;
                flex-direction: column;
                align-items: center;
                margin-bottom: 20px;
            }

            .product_image {
                display: flex;
                justify-content: center;
                align-items: center;
                height: 250px; /* Fixed image container height */
                overflow: hidden;
                width: 100%; /* Ensure full width */
            }

            .product_image img {
                width: 100%;
                height: 100%;
                object-fit: contain; /* Ensures full image is displayed */
            }

            .product_content {
                flex-grow: 1;
                padding: 10px;
                text-align: center;
            }

            .product_name a {
                font-size: 16px;
                font-weight: bold;
                color: #333;
                text-decoration: none;
            }

            .product_price {
                font-size: 18px;
                color: #e60023;
                font-weight: bold;
                margin: 10px 0;
            }

            .product_details {
                font-size: 14px;
                color: #666;
            }

            .product_options {
                display: flex;
                justify-content: center;
                margin-bottom: 10px;
            }

            /* Đảm bảo các ảnh trong gallery có kích thước đồng đều */
            /* Đảm bảo các ảnh trong gallery có kích thước đồng đều */
            .gallery_slider .owl-item {
                display: flex;
                justify-content: center;
                align-items: center;
                margin-right: 10px; /* Giảm khoảng cách giữa các ảnh */
            }

            /* Đảm bảo các hình ảnh không bị méo và có kích thước đồng đều */
            .gallery_item img {
                width: 100%;
                height: 200px; /* Đặt chiều cao cố định cho ảnh */
                object-fit: cover; /* Đảm bảo ảnh không bị méo và luôn đầy đủ */
                border-radius: 8px; /* Thêm bo góc nếu muốn */
            }

            /* Giảm khoảng cách giữa các ảnh trong carousel */
            .owl-carousel .owl-item {
                margin-right: 10px;  /* Giảm khoảng cách giữa các item */
            }



        </style>
        <script src="js/jquery-3.2.1.min.js"></script>
        <script src="styles/bootstrap4/popper.js"></script>
        <script src="styles/bootstrap4/bootstrap.min.js"></script>
        <script src="plugins/OwlCarousel2-2.2.1/owl.carousel.js"></script>
        <script src="plugins/easing/easing.js"></script>
        <script src="plugins/parallax-js-master/parallax.min.js"></script>
        <script src="plugins/colorbox/jquery.colorbox-min.js"></script>
        <script src="js/custom.js"></script>
    </body>
</html>