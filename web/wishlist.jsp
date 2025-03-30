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

        .product_buy {
            background: #f0f0f0; /* Màu nền xám nhạt để làm nổi biểu tượng */
            padding: 5px;
            border-radius: 5px; /* Bo góc cho đẹp */
        }

        .product_buy img {
            display: block;
            width: 24px;
            height: 24px;
        }

        .sort_filter select {
            padding: 5px;
            border-radius: 5px;
            border: 1px solid #ddd;
            cursor: pointer;
        }

        /* CSS cho phân trang */
        .pagination {
            display: flex;
            justify-content: center;
            margin-top: 20px;
        }

        .pagination a {
            padding: 8px 12px;
            margin: 0 5px;
            border: 1px solid #ddd;
            border-radius: 5px;
            text-decoration: none;
            color: #333;
        }

        .pagination a.active {
            background-color: #007bff;
            color: white;
            border-color: #007bff;
        }

        .pagination a.disabled {
            color: #ccc;
            cursor: not-allowed;
        }
    </style>
    <body>
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
                                    <div class="home_title">Yêu thích</div>
                                    <div class="breadcrumbs">
                                        <ul>
                                            <li><a href="${pageContext.request.contextPath}/ProductListServlet">Home</a></li>
                                            <li>Yêu thích</li>
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
                            <div class="cart_title">Sản phẩm yêu thích</div>
                            <!-- Dropdown để sắp xếp theo giá -->
                            <div class="sort_filter" style="margin-bottom: 20px; text-align: right;">
                                <form action="${pageContext.request.contextPath}/getwishlist" method="GET">
                                    <input type="hidden" name="page" value="${currentPage}">
                                    <label for="sort_price">Sắp xếp theo giá: </label>
                                    <select id="sort_price" name="sort" onchange="this.form.submit()">
                                        <option value="default" ${sortOption == 'default' ? 'selected' : ''}>Mặc định</option>
                                        <option value="asc" ${sortOption == 'asc' ? 'selected' : ''}>Tăng dần</option>
                                        <option value="desc" ${sortOption == 'desc' ? 'selected' : ''}>Giảm dần</option>
                                    </select>
                                </form>
                            </div>
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
                                <ul id="product_list">
                                    <c:forEach var="wishlistItem" items="${wishlistItems}">
                                        <li class="cart_product d-flex flex-row align-items-center justify-content-between">
                                            <!-- Cột Image -->
                                            <div class="cart_product_image" style="width: 100px;">
                                                <img src="${wishlistItem.product.productDetail.image}" 
                                                     alt="${wishlistItem.product.productDetail.image}" 
                                                     style="width: 100px; height: 100px;">
                                            </div>
                                            <!-- Cột Product Name -->
                                            <div class="cart_product_name" style="width: 200px;">
                                                <a href="product-detail.jsp?productId=${wishlistItem.product.productId}">
                                                    ${wishlistItem.product.productName}
                                                </a>
                                            </div>
                                            <!-- Cột Description -->
                                            <div class="cart_product_description" style="width: 300px;">
                                                ${wishlistItem.product.description}
                                            </div>
                                            <!-- Cột Price -->
                                            <div class="cart_product_description" style="width: 300px;">
                                                ${wishlistItem.product.productDetail.price}
                                            </div>
                                            <!-- Cột Action -->
                                            <div class="cart_product_button" style="width: 100px; display: flex; justify-content: space-between;">
                                                <!-- Nút Xóa khỏi Wishlist -->
                                                <form action="DeleteFromWishlistServlet" method="POST">
                                                    <input type="hidden" name="productId" value="${wishlistItem.product.productId}">
                                                    <button class="cart_product_remove" style="border: none; background: none; cursor: pointer;">
                                                        <img src="images/trash.png" alt="Remove" style="width: 20px;">
                                                    </button>
                                                </form>
                                                <!-- Nút Thêm vào Cart -->
                                                <a href="${pageContext.request.contextPath}/CartURL?service=add2cart&id=${wishlistItem.product.productId}">
                                                    <div class="product_buy product_option">
                                                        <img src="images/shopping-bag-white.svg" alt="Add to Cart">
                                                    </div>
                                                </a>
                                            </div>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </div>
                            <c:if test="${empty wishlistItems}">
                                <div class="py-12 mt-5 flex flex-col items-center justify-content-center text-center">
                                    <div class="w-16 h-16 rounded-full bg-blue-100 flex items-center justify-content-center mb-4">
                                        <i class="fas fa-star text-yellow-500 text-xl"></i>
                                    </div>
                                    <h3 class="text-lg font-medium text-gray-700 mb-2">Danh sách yêu thích trống</h3>
                                    <p class="text-gray-500 max-w-md">Bạn chưa thêm sản phẩm nào vào danh sách yêu thích. Hãy duyệt sản phẩm và thêm vào danh sách để dễ dàng tìm lại.</p>
                                    <a href="ProductListServlet" class="mt-4 text-blue-600 hover:text-blue-800 font-medium">
                                        <i class="fas fa-plus mr-1"></i> Khám phá sản phẩm ngay
                                    </a>
                                </div>
                            </c:if>

                            <!-- Phân trang -->
                            <c:if test="${not empty wishlistItems}">
                                <div class="pagination">
                                    <!-- Nút Trang trước -->
                                    <c:if test="${currentPage > 1}">
                                        <a href="${pageContext.request.contextPath}/getwishlist?page=${currentPage - 1}&sort=${sortOption}">&laquo; Trang trước</a>
                                    </c:if>
                                    <c:if test="${currentPage <= 1}">
                                        <a href="#" class="disabled">&laquo; Trang trước</a>
                                    </c:if>

                                    <!-- Các số trang -->
                                    <c:forEach begin="1" end="${totalPages}" var="i">
                                        <a href="${pageContext.request.contextPath}/getwishlist?page=${i}&sort=${sortOption}" class="${i == currentPage ? 'active' : ''}">${i}</a>
                                    </c:forEach>

                                    <!-- Nút Trang sau -->
                                    <c:if test="${currentPage < totalPages}">
                                        <a href="${pageContext.request.contextPath}/getwishlist?page=${currentPage + 1}&sort=${sortOption}">Trang sau &raquo;</a>
                                    </c:if>
                                    <c:if test="${currentPage >= totalPages}">
                                        <a href="#" class="disabled">Trang sau &raquo;</a>
                                    </c:if>
                                </div>
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