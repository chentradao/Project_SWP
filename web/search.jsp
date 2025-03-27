<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Tìm kiếm sản phẩm - Estée Lauder</title>
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
        <link href="plugins/malihu-custom-scrollbar/jquery.mCustomScrollbar.css" rel="stylesheet" type="text/css">
        <link rel="stylesheet" type="text/css" href="plugins/jquery-ui-1.12.1.custom/jquery-ui.css">
        <link rel="stylesheet" type="text/css" href="styles/categories.css">
        <link rel="stylesheet" type="text/css" href="styles/categories_responsive.css">
        <style>
            .super_container {
                padding-top: 100px;
            }
            .search-container {
                margin: 60px 0 40px 0;
                text-align: center;
                position: relative;
            }
            .search-container form {
                display: inline-flex;
                align-items: center;
                position: relative;
                width: 100%;
                max-width: 800px;
            }
            .search-container input[type="search"] {
                width: 100%;
                padding: 12px 100px 12px 40px;
                font-size: 16px;
                border: 1px solid #d1d5db;
                border-radius: 25px;
                outline: none;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
                transition: border-color 0.3s ease;
                z-index: 1;
            }
            .search-container input[type="search"]:focus {
                border-color: #a0aec0;
            }
            .search-container .search-icon {
                position: absolute;
                left: 15px;
                top: 50%;
                transform: translateY(-50%);
                width: 20px;
                height: 20px;
                z-index: 2;
            }
            .search-container .clear-button {
                position: absolute;
                right: 15px;
                top: 50%;
                transform: translateY(-50%);
                display: none;
                align-items: center;
                gap: 5px;
                background: none;
                border: none;
                cursor: pointer;
                font-size: 14px;
                color: #4a5568;
                z-index: 2;
            }
            .search-container .clear-button span {
                font-size: 14px;
            }
            .search-container .clear-button img {
                width: 16px;
                height: 16px;
            }
            .suggestions-list {
                position: absolute;
                top: 100%;
                left: 0;
                right: 0;
                max-width: 800px;
                margin: 0 auto;
                background: white;
                border: 1px solid #d1d5db;
                border-radius: 8px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                z-index: 10;
                display: none;
                max-height: 300px;
                overflow-y: auto;
            }
            .suggestions-list li {
                padding: 10px 15px;
                list-style: none;
                cursor: pointer;
                display: flex;
                align-items: center;
                gap: 10px;
                border-bottom: 1px solid #eee;
            }
            .suggestions-list li:last-child {
                border-bottom: none;
            }
            .suggestions-list li:hover {
                background-color: #f5f5f5;
            }
            .suggestions-list li img {
                width: 40px;
                height: 40px;
                object-fit: contain;
            }
            .suggestions-list li span {
                font-size: 14px;
                color: #333;
            }
            .category-list {
                margin-bottom: 40px;
                text-align: left;
                max-width: 800px;
                margin-left: auto;
                margin-right: auto;
            }
            .category-list h3 {
                font-size: 18px;
                margin-bottom: 15px;
                color: #333;
            }
            .category-list ul {
                list-style: none;
                padding: 0;
            }
            .category-list ul li {
                margin-bottom: 10px;
            }
            .category-list ul li a {
                color: #333;
                text-decoration: none;
                font-size: 14px;
                transition: all 0.3s ease;
            }
            .category-list ul li a:hover {
                text-decoration: underline;
            }
        </style>
    </head>
    <body>
        <div class="super_container">
            <!-- Header -->
            <%@ include file="header.jsp" %>

            <!-- Menu -->
            <%@ include file="menu.jsp" %>

            <!-- Thanh tìm kiếm -->
            <div class="search-container">
                <form action="${pageContext.request.contextPath}/SearchProductServlet" method="GET" onsubmit="return validateForm()">
                    <input type="search" name="keyword" id="searchInput" placeholder="Tìm kiếm sản phẩm..." value="${param.keyword}" autocomplete="off">
                    <img src="images/magnifying-glass.svg" alt="Tìm kiếm" class="search-icon">
                    <button type="button" class="clear-button" onclick="clearSearch(event)">
                        <span>Xóa</span>
                        <img src="images/close-icon.svg" alt="X">
                    </button>
                </form>
                <!-- Danh sách gợi ý -->
                <ul class="suggestions-list" id="suggestionsList"></ul>
            </div>

            <!-- Danh mục gợi ý -->
            <div class="category-list">
                <h3>Gợi ý danh mục</h3>
                <ul>
                    <c:forEach var="category" items="${categories}">
                        <li><a href="categories.jsp?category=${category.categoryId}">${category.categoryName}</a></li>
                        </c:forEach>
                </ul>
            </div>

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
                            <div class="copyright">
                                Copyright ©<script>document.write(new Date().getFullYear());</script> All rights reserved | This template is made with <i class="fa fa-heart-o" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">Colorlib</a>
                            </div>
                        </div>
                    </div>
                </div>
            </footer>
        </div>

        <!-- Scripts từ index.jsp -->
        <script src="js/jquery-3.2.1.min.js"></script>
        <script src="styles/bootstrap4/popper.js"></script>
        <script src="styles/bootstrap4/bootstrap.min.js"></script>
        <script src="plugins/OwlCarousel2-2.2.1/owl.carousel.js"></script>
        <script src="plugins/easing/easing.js"></script>
        <script src="plugins/parallax-js-master/parallax.min.js"></script>
        <script src="plugins/colorbox/jquery.colorbox-min.js"></script>
        <script src="js/custom.js"></script>
        <!-- Scripts từ categories.jsp -->
        <script src="plugins/Isotope/isotope.pkgd.min.js"></script>
        <script src="plugins/malihu-custom-scrollbar/jquery.mCustomScrollbar.js"></script>
        <script src="plugins/jquery-ui-1.12.1.custom/jquery-ui.js"></script>
        <script src="js/categories_custom.js"></script>
        <!-- JavaScript tùy chỉnh -->
        <script>
                                    document.addEventListener('DOMContentLoaded', function () {
                                        const searchInput = document.getElementById('searchInput');
                                        const clearButton = document.querySelector('.clear-button');
                                        const suggestionsList = document.getElementById('suggestionsList');

                                        if (searchInput.value.trim() !== '') {
                                            clearButton.style.display = 'flex';
                                        }

                                        searchInput.addEventListener('input', function () {
                                            const query = this.value.trim();
                                            if (query !== '') {
                                                clearButton.style.display = 'flex';
                                                fetchSuggestions(query);
                                            } else {
                                                clearButton.style.display = 'none';
                                                suggestionsList.style.display = 'none';
                                                suggestionsList.innerHTML = '';
                                            }
                                        });

                                        document.addEventListener('click', function (e) {
                                            if (!searchInput.contains(e.target) && !suggestionsList.contains(e.target)) {
                                                suggestionsList.style.display = 'none';
                                            }
                                        });
                                    });

                                    function clearSearch(event) {
                                        event.preventDefault();
                                        const searchInput = document.getElementById('searchInput');
                                        const clearButton = document.querySelector('.clear-button');
                                        const suggestionsList = document.getElementById('suggestionsList');
                                        searchInput.value = '';
                                        clearButton.style.display = 'none';
                                        suggestionsList.style.display = 'none';
                                        suggestionsList.innerHTML = '';
                                    }

                                    function validateForm() {
                                        const searchInput = document.getElementById('searchInput');
                                        if (searchInput.value.trim() === '') {
                                            return false;
                                        }
                                        return true;
                                    }

                                    function fetchSuggestions(query) {
                                        const suggestionsList = document.getElementById('suggestionsList');
                                        fetch(`${window.location.origin}${window.location.pathname.split('/').slice(0, -1).join('/')}/SuggestURL?query=${encodeURIComponent(query)}`)
                                                        .then(response => response.json())
                                                        .then(data => {
                                                            suggestionsList.innerHTML = '';
                                                            if (data.length > 0) {
                                                                data.forEach(product => {
                                                                    const li = document.createElement('li');
                                                                    li.innerHTML = `
                                    <img src="${product.image || 'images/default-product.jpg'}" alt="${product.productName}">
                                    <span>${product.productName}</span>
                                `;
                                                                    li.addEventListener('click', function () {
                                                                        document.getElementById('searchInput').value = product.productName;
                                                                        suggestionsList.style.display = 'none';
                                                                        document.querySelector('form').submit();
                                                                    });
                                                                    suggestionsList.appendChild(li);
                                                                });
                                                                suggestionsList.style.display = 'block';
                                                            } else {
                                                                suggestionsList.style.display = 'none';
                                                            }
                                                        })
                                                        .catch(error => {
                                                            console.error('Error fetching suggestions:', error);
                                                            suggestionsList.style.display = 'none';
                                                        });
                                            }
        </script>
    </body>
</html>