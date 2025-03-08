<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        
    </head>
    <style>
        .cart_bar {
            display: grid;
            grid-template-columns: 100px 1fr 2fr 1fr 100px; /* Điều chỉnh tỉ lệ các cột */
            text-align: center;
            font-weight: bold;
            background-color: #f8f9fa;
            padding: 10px 0;
            border-bottom: 2px solid #ddd;
        }

        .cart_product {
            display: grid;
            grid-template-columns: 100px 1fr 2fr 1fr 100px; /* Giữ nguyên tỷ lệ cột với header */
            align-items: center;
            text-align: center;
            padding: 10px 0;
            border-bottom: 1px solid #ddd;
        }

    </style>
    <body>

        <div class="super_container">

            <!-- Header -->

            <header class="header">
                <div class="header_inner d-flex flex-row align-items-center justify-content-start">
                    <div class="logo"><a href="ProductListServlet">Estée Lauder</a></div>
                    <nav class="main_nav">
                        <ul>
                            <li><a href="ProductListServlet">Home</a></li>
                            <li><a href="categories.html">Chăm sóc da</a></li>
                            <li><a href="categories.html">Trang điểm</a></li>
                            <li><a href="categories.html">Nước Hoa</a></li>
                            <li><a href="contact.html">Chăm sóc mắt</a></li>
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
                            <a href="CartURL?service=showCart">
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
                            <a href="${pageContext.request.contextPath}/getwishlist">
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
                        <li class="menu_mm"><a href="ProductListServlet">Home</a></li>
                        <li class="menu_mm"><a href="categories.html">Chăm sóc da</a></li>
                        <li class="menu_mm"><a href="categories.html">Trang điểm</a></li>
                        <li class="menu_mm"><a href="#">Nuoc hoa</a></li>
                        <li class="menu_mm"><a href="#">Cham soc mat</a></li>
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
                                    <div class="home_title">Yêu thích</div>
                                    <div class="breadcrumbs">
                                        <ul>
                                            <li><a href="${pageContext.request.contextPath}/ProductListServlet">Home</a></li>
                                            <li>yêu thích</li>
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
                            <div class="cart_title">Sản phẩm yêu thích  </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col">
                            <!-- Header của bảng -->
                            <div class="cart_bar">
                                <div>Hình ảnh</div>
                                <div>Tên sản phẩm</div>
                                <div>Mô tả</div>
                                <div>Giá</div>
                                <div>Hành động</div>
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

                                            <!-- Cart Description -->
                                            <div class="cart_product_description" style="width: 300px;">
                                                ${wishlistItem.product.description}
                                            </div>

                                            <!-- Cart Description -->
                                            <div class="cart_product_description" style="width: 300px;">
                                                ${wishlistItem.product.productDetail.price}
                                            </div>

                                            <!-- Cart Action -->
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
                            <c:if test="${empty wishlistItems}">
                                <div class="py-12 mt-5 flex flex-col items-center justify-center text-center">
                                    <div class="w-16 h-16 rounded-full bg-blue-100 flex items-center justify-center mb-4">
                                        <i class="fas fa-star text-yellow-500 text-xl"></i>
                                    </div>
                                    <h3 class="text-lg font-medium text-gray-700 mb-2">Danh sách yêu thích trống</h3>
                                    <p class="text-gray-500 max-w-md">Bạn chưa thêm sản phẩm nào vào danh sách yêu thích. Hãy duyệt sản phẩm và thêm vào danh sách để dễ dàng tìm lại.</p>
                                    <a href="ProductListServlet" class="mt-4 text-blue-600 hover:text-blue-800 font-medium">
                                        <i class="fas fa-plus mr-1"></i> Khám phá sản phẩm ngay
                                    </a>
                                </div>
                            </c:if>

                        </div>
                    </div>
                </div>
            </div>
        </div>


        <footer class="footer">
            <div class="container">
                <div class="row">
                    <div class="col text-center">
                        <div class="footer_logo"><a href="ProductListServlet">Estée Lauder</a></div>
                        <nav class="footer_nav">
                            <ul>
                                <li><a href="ProductListServlet">Home</a></li>
                                <li><a href="categories.html">Chăm sóc da</a></li>
                                <li><a href="categories.html">Trang Điểm</a></li>
                                <li><a href="categories.html">Nước Hoa</a></li>
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



        <script src="js/jquery-3.2.1.min.js"></script>
        <script src="styles/bootstrap4/popper.js"></script>
        <script src="styles/bootstrap4/bootstrap.min.js"></script>
        <script src="plugins/easing/easing.js"></script>
        <script src="plugins/parallax-js-master/parallax.min.js"></script>
        <script src="js/cart_custom.js"></script>
    </body>
</html>