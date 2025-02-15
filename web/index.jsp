<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Es�e Lauder</title>
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
                        <div class="owl-item">
                            <a href="product.html">
                            <div class="home_slider_background" style="background-image:url(images/home_slider_1.jpg)"></div>
                            <div class="home_slider_content">
                                <div class="home_slider_content_inner">
                                    <div class="home_slider_subtitle">Promo Prices</div>
                                    <div class="home_slider_title">New Collection</div>
                                </div>	
                            </div>
                            </a>
                        </div>

                        <!-- Home Slider Item -->
                        <div class="owl-item">
                            <a href="product.html">
                            <div class="home_slider_background" style="background-image:url(images/home_slider_1.jpg)"></div>
                            <div class="home_slider_content">
                                <div class="home_slider_content_inner">
                                    <div class="home_slider_subtitle">Promo Prices</div>
                                    <div class="home_slider_title">New Collection</div>
                                </div>	
                            </div>
                            </a>
                        </div>

                        <!-- Home Slider Item -->
                        <div class="owl-item">
                            <a href="product.html">
                            <div class="home_slider_background" style="background-image:url(images/home_slider_1.jpg)"></div>
                            <div class="home_slider_content">
                                <div class="home_slider_content_inner">
                                    <div class="home_slider_subtitle">Promo Prices</div>
                                    <div class="home_slider_title">New Collection</div>
                                </div>	
                            </div>
                            </a>
                        </div>

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
                                <div class="section_subtitle">only the best</div>
                                <div class="section_title">promo prices</div>
                            </div>
                        </div>
                    </div>
                    <div class="row promo_container">

                        <!-- Promo Item -->
                        <div class="col-lg-4 promo_col">
                            <div class="promo_item">
                                <div class="promo_image">
                                    <img src="images/promo_1.jpg" alt="">
                                    <div class="promo_content promo_content_1">
                                        <div class="promo_title">-30% off</div>
                                        <div class="promo_subtitle">on all bags</div>
                                    </div>
                                </div>
                                <div class="promo_link"><a href="#">Shop Now</a></div>
                            </div>
                        </div>

                        <!-- Promo Item -->
                        <div class="col-lg-4 promo_col">
                            <div class="promo_item">
                                <div class="promo_image">
                                    <img src="images/promo_2.jpg" alt="">
                                    <div class="promo_content promo_content_2">
                                        <div class="promo_title">-30% off</div>
                                        <div class="promo_subtitle">coats & jackets</div>
                                    </div>
                                </div>
                                <div class="promo_link"><a href="product.html">Shop Now</a></div>
                            </div>
                        </div>

                        <!-- Promo Item -->
                        <div class="col-lg-4 promo_col">
                            <div class="promo_item">
                                <div class="promo_image">
                                    <img src="images/promo_3.jpg" alt="">
                                    <div class="promo_content promo_content_3">
                                        <div class="promo_title">-25% off</div>
                                        <div class="promo_subtitle">on Sandals</div>
                                    </div>
                                </div>
                                <div class="promo_link"><a href="product.html">Shop Now</a></div>
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
                                <div class="section_subtitle">only the best</div>
                                <div class="section_title">new arrivals</div>
                            </div>
                        </div>
                    </div>
                    <div class="row products_container">
                        <!-- Product -->
                        <c:forEach var="productDetail" items="${productDetails}">
                                <div class="col-lg-4 product_col">
                                    <div class="product">
                                        <div class="product_image">
                                            <img src="${productDetail.product.productImage}" alt="${productDetail.product.productImage}">
                                        </div>

                                        <div class="rating rating_4">
                                            <i class="fa fa-star"></i>
                                            <i class="fa fa-star"></i>
                                            <i class="fa fa-star"></i>
                                            <i class="fa fa-star"></i>
                                            <i class="fa fa-star"></i>
                                        </div>
                                        <div class="product_content clearfix">
                                            <div class="product_info">
                                                <div class="product_name">
                                                    <a href="product-detail.jsp?productId=${productDetail.product.productId}">${productDetail.product.productName}</a>
                                                </div>
                                                ${productDetail.product.description}
                                                <div class="product_price">Gi�: ${productDetail.price} VND</div>

                                            </div>
                                            <div class="product_options">
                                                <div class="product_buy product_option">
                                                    <img src="images/shopping-bag-white.svg" alt="">
                                                </div>
                                                <div class="product_fav product_option">
                                                    <form action="${pageContext.request.contextPath}/addToWishlist" method="post">
                                                        <input type="hidden" name="productId" value="${productDetail.product.productId}" />
                                                        <button type="submit" class="wishlist_button" style="background: none; border: none; font-size: 24px; color: inherit; padding: 0;">+</button>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                    </div>
                </div>
            </div>

            <!-- Extra -->

            <div class="extra clearfix">
                <div class="extra_promo extra_promo_1">
                    <div class="extra_promo_image" style="background-image:url(images/extra_1.jpg)"></div>
                    <div class="extra_1_content d-flex flex-column align-items-center justify-content-center text-center">
                        <div class="extra_1_price">30%<span>off</span></div>
                        <div class="extra_1_title">On all shoes</div>
                        <div class="extra_1_text">*Integer ut imperdiet erat. Quisque ultricies lectus tellus, eu tristique magna pharetra.</div>
                        <div class="button extra_1_button"><a href="checkout.html">check out</a></div>
                    </div>
                </div>
                <div class="extra_promo extra_promo_2">
                    <div class="extra_promo_image" style="background-image:url(images/extra_2.jpg)"></div>
                    <div class="extra_2_content d-flex flex-column align-items-center justify-content-center text-center">
                        <div class="extra_2_title">
                            <div class="extra_2_center">&</div>
                            <div class="extra_2_top">Mix</div>
                            <div class="extra_2_bottom">Match</div>
                        </div>
                        <div class="extra_2_text">*Integer ut imperdiet erat. Quisque ultricies lectus tellus, eu tristique magna pharetra.</div>
                        <div class="button extra_2_button"><a href="checkout.html">check out</a></div>
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
                            <div class="gallery_text text-center">*Integer ut imperdiet erat. Quisque ultricies lectus tellus, eu tristique magna pharetra.</div>
                            <div class="button gallery_button"><a href="#">submit</a></div>
                        </div>
                    </div>
                </div>	
                <div class="gallery_slider_container">

                    <!-- Gallery Slider -->
                    <div class="owl-carousel owl-theme gallery_slider">

                        <!-- Gallery Item -->
                        <div class="owl-item gallery_item">
                            <a class="colorbox" href="images/gallery_1.jpg">
                                <img src="images/gallery_1.jpg" alt="">
                            </a>
                        </div>

                        <!-- Gallery Item -->
                        <div class="owl-item gallery_item">
                            <a class="colorbox" href="images/gallery_2.jpg">
                                <img src="images/gallery_2.jpg" alt="">
                            </a>
                        </div>

                        <!-- Gallery Item -->
                        <div class="owl-item gallery_item">
                            <a class="colorbox" href="images/gallery_3.jpg">
                                <img src="images/gallery_3.jpg" alt="">
                            </a>
                        </div>

                        <!-- Gallery Item -->
                        <div class="owl-item gallery_item">
                            <a class="colorbox" href="images/gallery_4.jpg">
                                <img src="images/gallery_4.jpg" alt="">
                            </a>
                        </div>

                        <!-- Gallery Item -->
                        <div class="owl-item gallery_item">
                            <a class="colorbox" href="images/gallery_5.jpg">
                                <img src="images/gallery_5.jpg" alt="">
                            </a>
                        </div>

                        <!-- Gallery Item -->
                        <div class="owl-item gallery_item">
                            <a class="colorbox" href="images/gallery_6.jpg">
                                <img src="images/gallery_6.jpg" alt="">
                            </a>
                        </div>

                    </div>
                </div>	
            </div>

            <!-- Testimonials -->

            <div class="testimonials">
                <div class="container">
                    <div class="row">
                        <div class="col">
                            <div class="section_title_container text-center">
                                <div class="section_subtitle">only the best</div>
                                <div class="section_title">testimonials</div>
                            </div>
                        </div>
                    </div>
                    <div class="row test_slider_container">
                        <div class="col">

                            <!-- Testimonials Slider -->
                            <div class="owl-carousel owl-theme test_slider text-center">

                                <!-- Testimonial Item -->
                                <div class="owl-item">
                                    <div class="test_text">“Integer ut imperdiet erat. Quisque ultricies lectus tellus, eu tristique magna pharetra nec. Fusce vel lorem libero. Integer ex mi, facilisis sed nisi ut, vestibulum ultrices nulla. Aliquam egestas tempor leo.”</div>
                                    <div class="test_content">
                                        <div class="test_image"><img src="images/testimonials.jpg" alt=""></div>
                                        <div class="test_name">Christinne Smith</div>
                                        <div class="test_title">client</div>
                                    </div>
                                </div>

                                <!-- Testimonial Item -->
                                <div class="owl-item">
                                    <div class="test_text">“Integer ut imperdiet erat. Quisque ultricies lectus tellus, eu tristique magna pharetra nec. Fusce vel lorem libero. Integer ex mi, facilisis sed nisi ut, vestibulum ultrices nulla. Aliquam egestas tempor leo.”</div>
                                    <div class="test_content">
                                        <div class="test_image"><img src="images/testimonials.jpg" alt=""></div>
                                        <div class="test_name">Christinne Smith</div>
                                        <div class="test_title">client</div>
                                    </div>
                                </div>

                                <!-- Testimonial Item -->
                                <div class="owl-item">
                                    <div class="test_text">“Integer ut imperdiet erat. Quisque ultricies lectus tellus, eu tristique magna pharetra nec. Fusce vel lorem libero. Integer ex mi, facilisis sed nisi ut, vestibulum ultrices nulla. Aliquam egestas tempor leo.”</div>
                                    <div class="test_content">
                                        <div class="test_image"><img src="images/testimonials.jpg" alt=""></div>
                                        <div class="test_name">Christinne Smith</div>
                                        <div class="test_title">client</div>
                                    </div>
                                </div>

                            </div>

                        </div>
                    </div>
                </div>
            </div>

            <!-- Newsletter -->

            <div class="newsletter">
                <div class="newsletter_content">
                    <div class="newsletter_image" style="background-image:url(images/newsletter.jpg)"></div>
                    <div class="container">
                        <div class="row">
                            <div class="col">
                                <div class="section_title_container text-center">
                                    <div class="section_subtitle">only the best</div>
                                    <div class="section_title">đăng ký để được giảm giá 20%</div>
                                </div>
                            </div>
                        </div>
                        <div class="row newsletter_container">
                            <div class="col-lg-10 offset-lg-1">
                                <div class="newsletter_form_container">
                                    <form action="#">
                                        <input type="email" class="newsletter_input" required="required" placeholder="E-mail here">
                                        <button type="submit" class="newsletter_button">subscribe</button>
                                    </form>
                                </div>
                                <div class="newsletter_text">Integer ut imperdiet erat. Quisque ultricies lectus tellus, eu tristique magna pharetra nec. Fusce vel lorem libero. Integer ex mi, facilisis sed nisi ut, vestib ulum ultrices nulla. Aliquam egestas tempor leo.</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Footer -->

            <footer class="footer">
                <div class="container">
                    <div class="row">
                        <div class="col text-center">
                            <div class="footer_logo"><a href="#">Wish</a></div>
                            <nav class="footer_nav">
                                <ul>
                                    <li><a href="index.html">home</a></li>
                                    <li><a href="categories.html">clothes</a></li>
                                    <li><a href="categories.html">accessories</a></li>
                                    <li><a href="categories.html">lingerie</a></li>
                                    <li><a href="contact.html">contact</a></li>
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