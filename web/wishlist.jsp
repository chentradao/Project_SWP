<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html lang="en">
    <head>
        <title>Wishlist</title>
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

        <div class="super_container">

            <!-- Header -->

            <header class="header">
                <div class="header_inner d-flex flex-row align-items-center justify-content-start">
                    <div class="logo"><a href="homepage.jsp">Estée Lauder</a></div>
                    <nav class="main_nav">
                        <ul>
                            <li><a href="${pageContext.request.contextPath}/ProductListServlet">Home</a></li>
                            <li><a href="${pageContext.request.contextPath}/ProductListServlet">Product</a></li>
                            <li><a href="categories.html">categories</a></li>
                            <li><a href="categories.html">lingerie</a></li>
                            <li><a href="contact.html">contact</a></li>
                        </ul>
                    </nav>
                    <div class="header_content ml-auto">
                        <div class="search header_search">
                            <form action="#">
                                <input type="search" class="search_input" required="required">
                                <button type="submit" id="search_button" class="search_button"><img src="images/magnifying-glass.svg" alt=""></button>
                            </form>
                        </div>
                        <div class="shopping">
                            <!-- Cart -->
                            <a href="cart.html">
                                <div class="cart">
                                    <img src="images/shopping-bag.svg" alt="">
                                    <div class="cart_num_container">
                                        <div class="cart_num_inner">
                                            <div class="cart_num">1</div>
                                        </div>
                                    </div>
                                </div>
                            </a>
                            <!-- Star -->
                            <a href="wishlist.jsp">
                                <div class="star">
                                    <img src="images/star.svg" alt="">
                                    <div class="star_num_container">
                                        <div class="star_num_inner">
                                            <div class="star_num">0</div>
                                        </div>
                                    </div>
                                </div>
                            </a>
                            <!-- Avatar -->
                            <a href="login.jsp">
                                <div class="avatar">
                                    <img src="images/avatar.svg" alt="">
                                </div>
                            </a>
                        </div>
                    </div>

                    <div class="burger_container d-flex flex-column align-items-center justify-content-around menu_mm"><div></div><div></div><div></div></div>
                </div>
            </header>

            <!-- Menu -->

            <div class="menu d-flex flex-column align-items-end justify-content-start text-right menu_mm trans_400">
                <div class="menu_close_container"><div class="menu_close"><div></div><div></div></div></div>
                <div class="logo menu_mm"><a href="homepage.jsp">Estée lauder</a></div>
                <div class="search">
                    <form action="product.html">
                        <input type="search" class="search_input menu_mm" required="required">
                        <button type="submit" id="search_button_menu" class="search_button menu_mm"><img class="menu_mm" src="images/magnifying-glass.svg" alt=""></button>
                    </form>
                </div>
                <nav class="menu_nav">
                    <ul class="menu_mm">
                        <li class="menu_mm"><a href="index.html">home</a></li>
                        <li class="menu_mm"><a href="${pageContext.request.contextPath}/ProductListServlet">Product</a></li>
                        <li class="menu_mm"><a href="categories.html">Categories</a></li>
                        <li class="menu_mm"><a href="#">lingerie</a></li>
                        <li class="menu_mm"><a href="#">contact</a></li>
                    </ul>
                </nav>
            </div>

            <!-- Home -->

            <div class="home">
                <div class="home_background parallax-window" data-parallax="scroll" data-image-src="images/cart.jpg" data-speed="0.8"></div>
                <div class="container">
                    <div class="row">
                        <div class="col">
                            <div class="home_container">
                                <div class="home_content">
                                    <div class="home_title">Shopping Cart</div>
                                    <div class="breadcrumbs">
                                        <ul>
                                            <li><a href="index.html">Home</a></li>
                                            <li>Shopping Cart</li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Cart -->

            <div class="cart_container">
                <div class="container">
                    <div class="row">
                        <div class="col">
                            <div class="cart_title">your wishlist</div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col">
                            <!-- Header c?a b?ng -->
                            <div class="cart_bar d-flex align-items-center justify-content-between">
                                <div class="cart_bar_title_image flex-shrink-0" style="width: 100px;"></div>
                                <div class="cart_bar_title_name flex-grow-1 text-center">Name</div>
                                <div class="cart_bar_title_description flex-grow-2 text-center">Description</div>
                                <div class="cart_bar_title_price flex-grow-1 text-center">Price</div>
                                <div class="cart_bar_title_button flex-shrink-0 text-center" style="width: 100px;">Action</div>
                            </div>

                        </div>
                    </div>
                    <div class="row">
                        <div class="col">
                            <div class="cart_products">
                                <ul>
                                    <c:forEach var="wishlistItem" items="${wishlistItems}">
                                        <!-- M?i s?n ph?m -->
                                        <li class="cart_product d-flex flex-row align-items-center justify-content-between">
                                            <!-- C?t Image -->
                                            <div class="cart_product_image" style="width: 100px;">
                                                <img src="${wishlistItem.product.productDetail.image}" 
                                                     alt="${wishlistItem.product.productDetail.image}" 
                                                     style="width: 100px; height: 100px;">
                                            </div>

                                            <!-- C?t Product Name -->
                                            <div class="cart_product_name" style="width: 200px;">
                                                <a href="product-detail.jsp?productId=${wishlistItem.product.productId}">
                                                    ${wishlistItem.product.productName}
                                                </a>
                                            </div>

                                            <!-- C?t Description -->
                                            <div class="cart_product_description" style="width: 300px;">
                                                ${wishlistItem.product.description}
                                            </div>

                                            <!-- C?t Description -->
                                            <div class="cart_product_description" style="width: 300px;">
                                                ${wishlistItem.product.productDetail.price}
                                            </div>

                                            <!-- C?t Action -->
                                            <div class="cart_product_button" style="width: 100px;">
                                                <form action="DeleteFromWishlistServlet" method="POST">
                                                    <input type="hidden" name="productId" value="${wishlistItem.product.productId}">
                                                    <button class="cart_product_remove">
                                                        <img src="images/trash.png" alt="Remove">
                                                    </button>
                                                </form>
                                            </div>

                                        </li>
                                    </c:forEach>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Newsletter -->

        <div class="newsletter">
            <div class="newsletter_content">
                <div class="newsletter_image parallax-window" data-parallax="scroll" data-image-src="images/cart_nl.jpg" data-speed="0.8"></div>
                <div class="container">
                    <div class="row options">

                        <!-- Options Item -->
                        <div class="col-lg-3">
                            <div class="options_item d-flex flex-row align-items-center justify-content-start">
                                <div class="option_image"><img src="images/option_1.png" alt=""></div>
                                <div class="option_content">
                                    <div class="option_title">30 Days Returns</div>
                                    <div class="option_subtitle">No questions asked</div>
                                </div>
                            </div>
                        </div>

                        <!-- Options Item -->
                        <div class="col-lg-3">
                            <div class="options_item d-flex flex-row align-items-center justify-content-start">
                                <div class="option_image"><img src="images/option_2.png" alt=""></div>
                                <div class="option_content">
                                    <div class="option_title">Free Delivery</div>
                                    <div class="option_subtitle">On all orders</div>
                                </div>
                            </div>
                        </div>

                        <!-- Options Item -->
                        <div class="col-lg-3">
                            <div class="options_item d-flex flex-row align-items-center justify-content-start">
                                <div class="option_image"><img src="images/option_3.png" alt=""></div>
                                <div class="option_content">
                                    <div class="option_title">Secure Payments</div>
                                    <div class="option_subtitle">No need to worry</div>
                                </div>
                            </div>
                        </div>

                        <!-- Options Item -->
                        <div class="col-lg-3">
                            <div class="options_item d-flex flex-row align-items-center justify-content-start">
                                <div class="option_image"><img src="images/option_4.png" alt=""></div>
                                <div class="option_content">
                                    <div class="option_title">24/7 Support</div>
                                    <div class="option_subtitle">Just call us</div>
                                </div>
                            </div>
                        </div>

                    </div>
                    <div class="row newsletter_row">
                        <div class="col">
                            <div class="section_title_container text-center">
                                <div class="section_subtitle">only the best</div>
                                <div class="section_title">subscribe for a 20% discount</div>
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
                        <div class="footer_logo"><a href="#">Est?e Lauder</a></div>
                        <nav class="footer_nav">
                            <ul>
                                <li><a href="homepage.jsp">Home</a></li>
                                <li><a href="${pageContext.request.contextPath}/ProductListServlet">Product</a></li>
                                <li><a href="categories.html">Categories</a></li>
                                <li><a href="categories.html">Categories</a></li>
                                <li><a href="contact.html">Contact</a></li>
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
    <script src="plugins/easing/easing.js"></script>
    <script src="plugins/parallax-js-master/parallax.min.js"></script>
    <script src="js/cart_custom.js"></script>
</body>
</html>