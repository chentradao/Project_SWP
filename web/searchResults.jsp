<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html lang="en">
    <head>
        <title>Kết quả tìm kiếm</title>
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
        .product-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 20px;
            padding: 20px;
        }

        .product-item {
            border: 1px solid #ddd;
            border-radius: 5px;
            padding: 10px;
            text-align: center;
        }

        .product-item img {
            max-width: 100%;
            height: 200px;
            object-fit: cover;
        }

        .product-item h3 {
            font-size: 16px;
            margin: 10px 0;
        }

        .product-item p {
            font-size: 14px;
            color: #555;
        }
    </style>
    <body>
        <div class="super_container">
            <!-- Header -->
            <%@ include file="header.jsp" %>

            <!-- Menu -->
            <%@ include file="menu.jsp" %>

            <!-- Home -->
            <div class="home">
                <div class="home_background parallax-window" data-parallax="scroll" data-image-src="images/cart.jpg" data-speed="0.8"></div>
                <div class="container">
                    <div class="row">
                        <div class="col">
                            <div class="home_container">
                                <div class="home_content">
                                    <div class="home_title">Kết quả tìm kiếm</div>
                                    <div class="breadcrumbs">
                                        <ul>
                                            <li><a href="${pageContext.request.contextPath}/ProductListServlet">Trang chủ</a></li>
                                            <li><a href="search.jsp">Tìm kiếm sản phẩm</a></li>
                                            <li>Kết quả tìm kiếm cho "${keyword}"</li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Search Results -->
            <div class="cart_container">
                <div class="container">
                    <div class="row">
                        <div class="col">
                            <div class="cart_title">Kết quả tìm kiếm cho "${keyword}"</div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col">
                            <c:if test="${not empty message}">
                                <div class="text-center py-5">
                                    <h3 class="text-lg font-medium text-gray-700 mb-2">${message}</h3>
                                    <a href="${pageContext.request.contextPath}/ProductListServlet" class="mt-4 text-blue-600 hover:text-blue-800 font-medium">
                                        <i class="fas fa-arrow-left mr-1"></i> Quay lại trang chủ
                                    </a>
                                </div>
                            </c:if>
                            <c:if test="${empty message}">
                                <c:if test="${empty searchResults}">
                                    <div class="text-center py-5">
                                        <h3 class="text-lg font-medium text-gray-700 mb-2">Không tìm thấy sản phẩm nào phù hợp với "${keyword}"</h3>
                                        <a href="${pageContext.request.contextPath}/ProductListServlet" class="mt-4 text-blue-600 hover:text-blue-800 font-medium">
                                            <i class="fas fa-arrow-left mr-1"></i> Quay lại trang chủ
                                        </a>
                                    </div>
                                </c:if>
                                <c:if test="${not empty searchResults}">
                                    <div class="product-grid">
                                        <c:forEach var="product" items="${searchResults}">
                                            <div class="product-item">
                                                <a href="product-detail.jsp?productId=${product.product.productId}">
                                                    <img src="${product.image != null ? product.image : 'images/default-image.jpg'}" alt="${product.product.productName}">
                                                    <h3>${product.product.productName}</h3>
                                                    <p>${product.product.description}</p>
                                                    <p class="price">${product.price != null ? product.price : 'N/A'} VND</p>
                                                </a>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </c:if>
                            </c:if>
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
                        <div class="footer_logo"><a href="${pageContext.request.contextPath}/ProductListServlet">Estée Lauder</a></div>
                        <nav class="footer_nav">
                            <ul>
                                <li><a href="${pageContext.request.contextPath}/ProductListServlet">Trang chủ</a></li>
                                    <c:forEach var="category" items="${categories}">
                                    <li><a href="categories.jsp?category=${category.categoryId}">${category.categoryName}</a></li>
                                    </c:forEach>
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
                        <div class="copyright">
                            Copyright ©<script>document.write(new Date().getFullYear());</script> All rights reserved | This template is made with <i class="fa fa-heart-o" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">Colorlib</a>
                        </div>
                    </div>
                </div>
            </div>
        </footer>

        <!-- Scripts -->
        <script src="js/jquery-3.2.1.min.js"></script>
        <script src="styles/bootstrap4/popper.js"></script>
        <script src="styles/bootstrap4/bootstrap.min.js"></script>
        <script src="plugins/easing/easing.js"></script>
        <script src="plugins/parallax-js-master/parallax.min.js"></script>
        <script src="js/cart_custom.js"></script>
    </body>
</html>