<%@page import="service.ProductService"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Categories</title>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="description" content="Wish shop project">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" type="text/css" href="styles/bootstrap4/bootstrap.min.css">
        <link href="plugins/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
        <link href="plugins/malihu-custom-scrollbar/jquery.mCustomScrollbar.css" rel="stylesheet" type="text/css">
        <link rel="stylesheet" type="text/css" href="plugins/jquery-ui-1.12.1.custom/jquery-ui.css">
        <link rel="stylesheet" type="text/css" href="styles/categories.css">
        <link rel="stylesheet" type="text/css" href="styles/categories_responsive.css">
        <link rel="stylesheet" type="text/css" href="css/style.css">
    </head>
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
        .category-item a {
            font-weight: bold;
            text-decoration: none;
            color: #333;
            padding-left: 10px;
        }

        .category-item a:hover {
            color: #007bff; /* Thêm màu khi hover vào liên kết */
        }

        .category-item {
            padding: 5px 0;
        }
        .category-itemA button {
            font-weight: bold;
            text-decoration: none;
            color: #333;
            padding-left: 10px;
            text-align: center
        }

        .category-itemA button:hover {
            color: #007bff; /* Thêm màu khi hover vào liên kết */
        }

        .category-itemA {
            padding: 5px 0;
        }

        .sidebar_section_content ul {
            list-style-type: none;
        }
        .filter-sorting{
            display: flex;
            float: left;
            padding-left: 176px;
        }
        .item_sorting li{
            width: 200px;
        }
        .sorting{
            margin-right: 45px;
        }
        .current_page
{
	
}
.current_page ul li
{
	display: inline-block;
	position: relative;
	font-family: 'Lucida', serif;
	font-size: 16px;
	color: #232323;
}
.current_page ul li::after
{
	display: inline-block;
	content: '/';
	margin-left: 10px;
	margin-right: 6px;
}
.current_page ul li:last-child::after
{
	display: none;
}
.current_page ul li a
{
	font-family: 'Lucida', serif;
	font-size: 16px;
	color: #232323;
	-webkit-transition: all 200ms ease;
	-moz-transition: all 200ms ease;
	-ms-transition: all 200ms ease;
	-o-transition: all 200ms ease;
	transition: all 200ms ease;
}
.current_page ul li a:hover
{
	color: #937c6f;
}
.products{
    padding-top: 20px;
}
.sidebar_left {
    top: 0;
}
.text-header{
    padding-bottom: 26px;
    padding-top: 13px;
}
    </style>
    <body>
        <div class="super_container">
            <!-- Header -->
            <%@ include file="header.jsp" %>
            <!-- Menu -->
            <%@ include file="menu.jsp" %>
            <!-- Home Section -->
            <div class="home">
                <div class="home_background parallax-window" data-parallax="scroll" data-image-src="images/categories.jpg" data-speed="0.8"></div>
                <div class="container">
                    <div class="row">
                        <div class="col">
                            <div class="home_container">
                                <div class="home_content">
                                    <div class="home_title">Danh mục sản phẩm</div>
                                    <div class="breadcrumbs">
                                        <ul>
                                            <li><a href="index.html">Trang chủ</a></li>
                                            <li>Danh mục sản phẩm</li>
                                            <li>Mỹ phẩm</li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Products Section -->
            <div class="products">
                <div class="container">
                                <div class="row">
                        <div class="col">
                            <div class="current_page">
                                <ul>
                                    <li><a href="ProductListSevlet">Trang chủ</a></li>
                                    <li><a href="listProduct.jsp">Danh sách sản phẩm</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
            <h2 class="text-header">KHÁM PHÁ SẢN PHẨM BÁN CHẠY NHẤT</h2>
                    <div class="row">
                        <div class="col-12">
                            <!-- Sidebar Left -->
                            <div class="sidebar_left clearfix">
                                <div class="sidebar_section">
                                    <div class="sidebar_title">Danh mục</div>
                                    <div class="sidebar_section_content">
                                        <ul id="category-filter">
                                            <% 
                                                // Duyệt qua tất cả các danh mục (bao gồm cả cha và con)
                                                int count = 0;  // Đếm số danh mục đã hiển thị
                                                for (Category category : categories) {
                                            %>
                                            <li class="category-item" id="category_<%= category.getCategoryId() %>">
                                                <!-- Liên kết đến danh mục (cha hoặc con) -->
                                                <a href="product-list?categoryId=<%= category.getCategoryId() %>">
                                                    <%= category.getCategoryName() %>
                                                </a>
                                            </li>
                                            <% 
                                                count++;  // Tăng số lượng mục đã hiển thị
                                                // Lấy danh mục con của danh mục hiện tại nếu có
                                                List<Category> subCategories = categoryRepository.getAllCategoriesByParentCategory(String.valueOf(category.getCategoryId()));
                                                if (subCategories != null && !subCategories.isEmpty()) {
                                                    for (Category subCategory : subCategories) {
                                            %>
                                            <li class="category-item" id="category_<%= subCategory.getCategoryId() %>">
                                                <!-- Liên kết đến danh mục con -->
                                                <a href="product-list?categoryId=<%= subCategory.getCategoryId() %>">
                                                    <%= subCategory.getCategoryName() %>
                                                </a>
                                            </li>
                                            <% 
                                                        count++;  // Tăng số lượng mục đã hiển thị
                                                    }
                                                }
                                            %>
                                            <% 
                                                }
                                            %>
                                            <li  class="category-itemA"><button id="loadMore"  style="display: <% if (count > 4) { %>block<% } else { %>none<% } %>;margin: 0px 66px;">Xem thêm</button></li>
                                        </ul>



                                    </div>
                                </div>
                                <!-- Price Filter -->
                                <!--<div class="sidebar_section">
                                    <div class="sidebar_title">Sắp xếp theo giá</div>
                                    <div class="sidebar_section_content">
                                        <ul id="price-filter">
                                            <li><a id="sortPriceDesc" href="#" data-price="asc">Giá từ cao đến thấp</a></li>
                                            <li><a id="sortPriceAsc" href="#" data-price="desc">Giá từ thấp đến cao</a></li>
                                        </ul>
                                    </div>
                                </div>

                                <!-- Size Sorting Filter -->
                                <!-- <div class="sidebar_section">
                                    <div class="sidebar_title">Sắp xếp theo kích cỡ</div>
                                    <div class="sidebar_section_content">
                                        <ul id="size-sorting">
                                            <li><a id="sortSizeAsc" href="#" data-size-sort="asc">Kích cỡ từ bé tới lớn</a></li>
                                            <li><a id="sortSizeDesc" href="#" data-size-sort="desc">Kích cỡ từ lớn tới bé</a></li>
                                        </ul>
                                    </div>
                                </div>




                                <!-- Size Filter -->
                                <div class="sidebar_section">
                                    <div class="sidebar_title">Kích cỡ</div>
                                    <div class="sidebar_section_content">
                                        <ul id="size-filter">
                                            <%
                                                ProductService productService = new ProductService();
                                                List<String> availableSizes = productService.getAvailableSizes();
                                                for (String size : availableSizes) {
                                            %>
                                            <li><a href="#" data-size="<%=size%>"><%= size %></a></li>
                                                <% } %>
                                        </ul>
                                    </div>
                                </div>
                                <!-- Color Filter -->
                                <div class="sidebar_section">
                                    <div class="sidebar_title">Màu sắc</div>
                                    <div class="sidebar_section_content">
                                        <ul id="color-filter">
                                            <%
                                                // Lấy danh sách các màu có sẵn từ productService
                                                List<String> availableColor = productService.getAvailableColors();
                                                for (String color : availableColor) {
                                                    // Kiểm tra nếu màu không phải null và không phải là chuỗi rỗng
                                                    if (color != null && !color.trim().isEmpty()) {
                                            %>
                                            <li><a href="#" data-color="<%= color %>"><%= color %></a></li>
                                                <% 
                                                        }
                                                    }
                                                %>
                                        </ul>
                                    </div>
                                </div>
                                <!-- Price Filter -->
                                <div class="sidebar_section">
                                    <div class="sidebar_title">Giá</div>
                                    <div class="sidebar_section_content">
                                        <div class="filter_price">
                                            <!-- Hai ô nhập giá trị tối thiểu và tối đa -->
                                            <input type="number" id="minPriceInput" placeholder="Giá tối thiểu">
                                            <input type="number" id="maxPriceInput" placeholder="Giá tối đa">
                                            <br/><br/>
                                            <div class="price-buttons">
                                                <button id="applyPriceBtn">Áp dụng giá</button>
                                                <button id="clearPriceBtn">Xóa giá</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="filter-sorting">
                        <div class="sorting">
                        <ul class="item_sorting">

                            <li>
                                <span class="sorting_text">Sắp xếp theo giá</span>
                                <i class="fa fa-caret-down" aria-hidden="true"></i>
                                <ul>
                                    <li><a id="sortPriceDesc" href="#" data-price="asc">Giá từ cao đến thấp</a></li>
                                    <li><a id="sortPriceAsc" href="#" data-price="desc">Giá từ thấp đến cao</a></li>
                                </ul>
                            </li>
                        </ul>
                        </div>
                        <div class="sorting">
                        <ul class="item_sorting">

                            <li>
                                <span class="sorting_text">Sắp xếp theo kích cỡ</span>
                                <i class="fa fa-caret-down" aria-hidden="true"></i>
                                <ul>
                                    <li><a id="sortSizeAsc" href="#" data-size-sort="asc">Kích cỡ từ bé tới lớn</a></li>
                                    <li><a id="sortSizeDesc" href="#" data-size-sort="desc">Kích cỡ từ lớn tới bé</a></li>
                                </ul>
                            </li>
                        </ul>
                        </div>
                        <div class="sorting">
                        <ul class="item_sorting">

                            <li>
                                <span class="sorting_text">Hiển thị</span>
                                <i class="fa fa-caret-down" aria-hidden="true"></i>
                                <ul>
                                    <li class="num_sorting_btn"><span>3</span></li>
                                    <li class="num_sorting_btn"><span>6</span></li>
                                    <li class="num_sorting_btn"><span>12</span></li>
                                </ul>
                            </li>
                        </ul>
                        </div>
                    </div>                    
                    <div class="row products_container">
                        <div class="col">
                            <!-- Include the list of products -->
                            <div class="product-container">
                                <c:if test="${empty requestScope.products}">
                                    <p>No products found.</p>
                                </c:if>
                                <c:forEach items="${requestScope.products}" var="product">


                                    <div class="product">
                                        <div class="product_image">
                                            <img src="${product.getProductImage() != null ? product.getProductImage() : "images/default-product.jpg" }" alt="">
                                        </div>
                                        <div class="product_content">
                                            <div class="product_name">
                                                <a href="<%= request.getContextPath() %>/ProductDetail?productId=${product.getId()}">
                                                    ${product.getProductName() }
                                                </a>
                                            </div>
                                            <div class="product_price"><fmt:formatNumber value="${product.getProductPrice()}" type="number" groupingUsed="true" /> VND</div>
                                            <div class="product_details">
                                                <c:if test="${not empty product.productSize}">
                                                    <span>Kích cỡ: ${product.productSize}</span>
                                                </c:if>

                                                <c:if test="${not empty product.productColor}">
                                                    <c:if test="${not empty product.productSize}">
                                                        | 
                                                    </c:if>
                                                    <span>Màu Sắc: ${product.productColor}</span>
                                                </c:if>

                                            </div>

                                        </div>
                                        <div class="product_options">
                                            <a href="CartURL?service=add2cart&id=${product.getId()}">
                                                <div class="product_buy product_option">
                                                    <img src="images/shopping-bag-white.svg" alt="">
                                                </div>
                                            </a>
                                            <div class="product_fav product_option">+</div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </div>


                    <div class="row page_num_container">
                        <div class="col text-right">
                            <ul class="page_nums">
                                <!-- Previous Button -->
                                <li class="${pageIndex == 1 ? 'disabled' : ''}">
                                    <a href="product-list?pageIndex=${pageIndex - 1 <= 0 ? 1 : pageIndex - 1}&pageSize=${pageSize}">Trước</a>
                                </li>

                                <!-- Page Numbers -->
                                <c:choose>
                                    <c:when test="${pageIndex > 1}">
                                        <!-- Show the previous page if current page > 1 -->
                                        <li><a href="product-list?pageIndex=${pageIndex - 1}&pageSize=${pageSize}">${pageIndex - 1}</a></li>
                                        </c:when>
                                        <c:otherwise>
                                        <!-- If on the first page, no previous page -->
                                    </c:otherwise>
                                </c:choose>

                                <!-- Current page -->
                                <li class="active">
                                    <a href="product-list?pageIndex=${pageIndex}&pageSize=${pageSize}">${pageIndex}</a>
                                </li>

                                <c:choose>
                                    <c:when test="${pageIndex < totalPage}">
                                        <!-- Show the next page if current page < totalPage -->
                                        <li><a href="product-list?pageIndex=${pageIndex + 1}&pageSize=${pageSize}">${pageIndex + 1}</a></li>
                                        </c:when>
                                        <c:otherwise>
                                        <!-- If on the last page, no next page -->
                                    </c:otherwise>
                                </c:choose>

                                <!-- Next Button -->
                                <li class="${pageIndex == totalPage ? 'disabled' : ''}">
                                    <a href="product-list?pageIndex=${pageIndex + 1 > totalPage ? totalPage : pageIndex + 1}&pageSize=${pageSize}">Sau</a>
                                </li>
                            </ul>
                        </div>
                    </div>


                    <!-- Pagination -->


                </div>
                <!-- Sidebar Right (Promotions) -->
                <div class="sidebar_right clearfix">
                    <!-- Promo 1 -->
                    <div class="sidebar_promo_1 sidebar_promo d-flex flex-column align-items-center justify-content-center">
                        <div class="sidebar_promo_image" style="background-image: url(https://bizweb.dktcdn.net/100/444/220/products/271788774-5009527345776043-2758650243059975080-n.png?v=1646657071240)"></div>
                        <div class="sidebar_promo_content text-center">
                            <span>Giảm tới</span>
                            <div class="sidebar_promo_title" style="padding-top: 8px;">30%</div>
                            <div class="sidebar_promo_button"><a href="checkout.html">Mua ngay</a></div>
                        </div>
                    </div>
                    <!-- Promo 2 -->
                    <div class="sidebar_promo_2 sidebar_promo">
                        <div class="sidebar_promo_image" style="background-image: url(https://images.unsplash.com/photo-1503104834685-7205e8607eb9?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8N3x8ZmVtYWxlJTIwbW9kZWx8ZW58MHx8MHx8fDA%3D)"></div>
                        <div class="sidebar_promo_content text-center">
                            <span>Giảm tới</span>
                            <div class="sidebar_promo_title" style="padding-top: 8px;">50%</div>
                            <div class="sidebar_promo_button"><a href="checkout.html">Mua ngay</a></div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Newsletter Section -->
            
            <!-- Footer Section -->
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
                            <div class="copyright">
                                Copyright &copy;
                                <script>document.write(new Date().getFullYear());</script> 
                                All rights reserved | This template is made with 
                                <i class="fa fa-heart-o" aria-hidden="true"></i> by 
                                <a href="https://colorlib.com" target="_blank">Colorlib</a>
                            </div>
                        </div>
                    </div>
                </div>
            </footer>
        </div>

        <!-- Include jQuery and other plugin scripts BEFORE your custom inline script -->
        <script src="js/jquery-3.2.1.min.js"></script>
        <script src="styles/bootstrap4/popper.js"></script>
        <script src="styles/bootstrap4/bootstrap.min.js"></script>
        <script src="plugins/easing/easing.js"></script>
        <script src="plugins/parallax-js-master/parallax.min.js"></script>
        <script src="plugins/Isotope/isotope.pkgd.min.js"></script>
        <script src="plugins/malihu-custom-scrollbar/jquery.mCustomScrollbar.js"></script>
        <script src="plugins/jquery-ui-1.12.1.custom/jquery-ui.js"></script>

        <!-- Inline Script to handle filters and sorting -->
        <script>
                                    $(document).ready(function () {
                                        // --- Size Filter ---
                                        $('#size-filter li a').on('click', function (e) {
                                            e.preventDefault();
                                            var selectedSize = $(this).data('size');
                                            applyFilters({size: selectedSize});
                                        });

                                        // --- Color Filter ---
                                        $('#color-filter li a').on('click', function (e) {
                                            e.preventDefault();
                                            var selectedColor = $(this).data('color');
                                            applyFilters({color: selectedColor});
                                        });

                                        // --- Page Size Filter ---
                                        $('.num_sorting_btn').on('click', function (e) {
                                            e.preventDefault();
                                            var selectedPageSize = $(this).find('span').text();
                                            applyFilters({pageSize: selectedPageSize});
                                        });

                                        // --- Price Filter: Apply Button ---
                                        $('#applyPriceBtn').on('click', function (e) {
                                            e.preventDefault();
                                            var minPrice = $('#minPriceInput').val();
                                            var maxPrice = $('#maxPriceInput').val();
                                            if (minPrice && maxPrice && !isNaN(minPrice) && !isNaN(maxPrice)) {
                                                applyFilters({minPrice: minPrice, maxPrice: maxPrice});
                                            } else {
                                                alert('Please enter valid numbers for both minimum and maximum price.');
                                            }
                                        });

                                        // --- Price Filter: Clear Button ---
                                        $('#clearPriceBtn').on('click', function (e) {
                                            e.preventDefault();
                                            $('#minPriceInput').val('');
                                            $('#maxPriceInput').val('');
                                            applyFilters({minPrice: null, maxPrice: null});
                                        });

                                        // --- Sorting Filter: Price Sort ---
                                        $('#sortPriceAsc').on('click', function (e) {
                                            e.preventDefault();
                                            applyFilters({orderByPrice: 'asc'});
                                        });
                                        $('#sortPriceDesc').on('click', function (e) {
                                            e.preventDefault();
                                            applyFilters({orderByPrice: 'desc'});
                                        });

                                        // --- Sorting Filter: Size Sort ---
                                        $('#sortSizeAsc').on('click', function (e) {
                                            e.preventDefault();
                                            applyFilters({orderBySize: 'asc'});
                                        });
                                        $('#sortSizeDesc').on('click', function (e) {
                                            e.preventDefault();
                                            applyFilters({orderBySize: 'desc'});
                                        });
                                    });

// Function to update the URL query parameters and reload the page
                                    function applyFilters(filters) {
                                        var url = new URL(window.location.href);
                                        var params = new URLSearchParams(url.search);

                                        // Update the size filter parameter
                                        if (filters.size) {
                                            params.set('size', filters.size);
                                        } else {
                                            params.delete('size');
                                        }

                                        // Update the color filter parameter
                                        if (filters.color) {
                                            params.set('color', filters.color);
                                        } else {
                                            params.delete('color');
                                        }

                                        // Update the price filter parameters (only if both are provided)
                                        if (filters.minPrice != null && filters.maxPrice != null) {
                                            params.set('minPrice', filters.minPrice);
                                            params.set('maxPrice', filters.maxPrice);
                                        } else {
                                            params.delete('minPrice');
                                            params.delete('maxPrice');
                                        }

                                        // Update the page size filter
                                        if (filters.pageSize) {
                                            params.set('pageSize', filters.pageSize);
                                            params.delete('pageIndex'); // Reset to first page
                                        } else {
                                            params.delete('pageSize');
                                        }

                                        // Update sorting filters (orderByPrice and orderBySize)
                                        if (filters.orderByPrice) {
                                            params.set('orderByPrice', filters.orderByPrice);
                                        } else {
                                            params.delete('orderByPrice');
                                        }

                                        if (filters.orderBySize) {
                                            params.set('orderBySize', filters.orderBySize);
                                        } else {
                                            params.delete('orderBySize');
                                        }

                                        // Redirect to the updated URL
                                        window.location.href = url.pathname + "?" + params.toString();
                                    }

        </script>

        <script>
            // Hàm để hiển thị thêm 4 mục khi nhấp vào "Xem thêm"
            document.addEventListener("DOMContentLoaded", function () {
                var allItems = document.querySelectorAll("#category-filter .category-item");
                var loadMoreButton = document.getElementById("loadMore");
                var visibleCount = 4;  // Số mục hiển thị mỗi lần

                // Ẩn tất cả các mục, chỉ hiển thị 4 mục đầu tiên
                for (var i = visibleCount; i < allItems.length; i++) {
                    allItems[i].style.display = "none";
                }

                // Khi nhấp vào nút "Xem thêm", hiển thị 4 mục tiếp theo
                loadMoreButton.addEventListener("click", function () {
                    var hiddenItems = document.querySelectorAll("#category-filter .category-item[style='display: none;']");

                    // Hiển thị 4 mục tiếp theo
                    for (var i = 0; i < visibleCount && i < hiddenItems.length; i++) {
                        hiddenItems[i].style.display = "block";
                    }

                    // Nếu không còn mục nào ẩn nữa, ẩn nút "Xem thêm"
                    if (hiddenItems.length <= visibleCount) {
                        loadMoreButton.style.display = "none";

                    }
                });
            });
        </script>
        <style>
            .filter_price input {
                width: 48%;
                display: inline-block;
                margin-bottom: 10px;
                padding: 8px;
                font-size: 16px;
            }

            .price-buttons {
                display: flex;
                gap: 10px; /* Khoảng cách giữa các nút */
                flex-wrap: wrap;
            }

            .price-buttons button {
                flex: 1; /* Chia đều chiều rộng */
                min-width: 120px; /* Đảm bảo nút không quá bé */
                padding: 10px;
                font-size: 16px;
                border: none;
                color: white;
                cursor: pointer;
                border-radius: 5px;
            }
        </style>
        <script src="js/categories_custom.js"></script>
    </body>
</html>

