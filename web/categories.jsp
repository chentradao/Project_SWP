<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
    </head>
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
                                    <div class="home_title">Woman</div>
                                    <div class="breadcrumbs">
                                        <ul>
                                            <li><a href="index.html">Home</a></li>
                                            <li>Woman</li>
                                            <li>Accessories</li>
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
                        <div class="col-12">
                            <!-- Sidebar Left -->
                            <div class="sidebar_left clearfix">
                                <!-- Size Filter -->
                                <div class="sidebar_section">
                                    <div class="sidebar_title">Size</div>
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
                            <div class="current_page">Woman's Fashion</div>
                        </div>
                        <div class="col-12">
                            <div class="product_sorting clearfix">
                                <div class="view">
                                    <div class="view_box box_view"><i class="fa fa-th-large" aria-hidden="true"></i></div>
                                    <div class="view_box detail_view"><i class="fa fa-bars" aria-hidden="true"></i></div>
                                </div>

                            </div>
                        </div>
                    </div>
                    <div class="row products_container">
                        <div class="col">
                            <!-- Include the list of products -->
                            <%@ include file="listProduct.jsp" %>
                        </div>
                    </div>
                    <div class="sorting">
                        <ul class="item_sorting">
                            <li>
                                            <span class="sorting_text">Sắp xếp </span>
                                <i class="fa fa-caret-down" aria-hidden="true"></i>
                                <ul>
                                    <!-- Updated sorting options -->
                                    <li class="product_sorting_btn" data-isotope-option='{"sortBy": "Price"}'><span>giá</span></li>
                                    <li class="product_sorting_btn" data-isotope-option='{"sortBy": "Size"}'><span>kích cỡ</span></li>
                                </ul>
                            </li>
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
                    <%
                        // Generate pagination links based on total pages
                        int totalPages = productResponse.getTotalPages();

                        // Build base query string (excluding the "page" parameter) to preserve filters, sorting, etc.
                        StringBuilder baseQuery = new StringBuilder();
                        java.util.Enumeration<String> parameterNames = request.getParameterNames();
                        while (parameterNames.hasMoreElements()) {
                            String paramName = parameterNames.nextElement();
                            if (!"page".equals(paramName)) {
                                String[] values = request.getParameterValues(paramName);
                                for (String value : values) {
                                    if (baseQuery.length() > 0) {
                                        baseQuery.append("&");
                                    }
                                    baseQuery.append(paramName).append("=").append(value);
                                }
                            }
                        }
                        String baseQueryString = baseQuery.toString();
                    %>

                    <!-- Pagination -->
                    <div class="row page_num_container">
                        <div class="col text-right">
                            <ul class="page_nums">
                                <% for (int i = 1; i <= totalPages; i++) { %>
                                <li class="<%= (i == currentPage) ? "active" : "" %>">
                                    <a href="categories.jsp?<%= (baseQueryString != null && !baseQueryString.isEmpty()) ? "&" + baseQueryString : "" %>&page=<%= i %>">
                                        <%= (i < 10 ? "0" + i : i) %>
                                    </a>
                                </li>
                                <% } %>
                            </ul>
                        </div>
                    </div>
                </div>
                <!-- Sidebar Right (Promotions) -->
                <div class="sidebar_right clearfix">
                    <!-- Promo 1 -->
                    <div class="sidebar_promo_1 sidebar_promo d-flex flex-column align-items-center justify-content-center">
                        <div class="sidebar_promo_image" style="background-image: url(images/sidebar_promo_1.jpg)"></div>
                        <div class="sidebar_promo_content text-center">
                            <div class="sidebar_promo_title">30%<span>off</span></div>
                            <div class="sidebar_promo_subtitle">On all shoes</div>
                            <div class="sidebar_promo_button"><a href="checkout.html">check out</a></div>
                        </div>
                    </div>
                    <!-- Promo 2 -->
                    <div class="sidebar_promo_2 sidebar_promo">
                        <div class="sidebar_promo_image" style="background-image: url(images/sidebar_promo_2.jpg)"></div>
                        <div class="sidebar_promo_content text-center">
                            <div class="sidebar_promo_title">30%<span>off</span></div>
                            <div class="sidebar_promo_subtitle">On all shoes</div>
                            <div class="sidebar_promo_button"><a href="checkout.html">check out</a></div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Newsletter Section -->
            <div class="newsletter">
                <div class="newsletter_content">
                    <div class="newsletter_image" style="background-image:url(images/newsletter.jpg)"></div>
                    <div class="container">
                        <div class="row">
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
                                <div class="newsletter_text">
                                    Integer ut imperdiet erat. Quisque ultricies lectus tellus, eu tristique magna pharetra nec. 
                                    Fusce vel lorem libero. Integer ex mi, facilisis sed nisi ut, vestibulum ultrices nulla. 
                                    Aliquam egestas tempor leo.
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Footer Section -->
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

                                        // --- Sorting Filter: Update for Price and Size ---
                                        $('.product_sorting_btn').on('click', function (e) {
                                            e.preventDefault();
                                            var isotopeOption = $(this).data('isotope-option');
                                            // Expecting isotopeOption to be an object like { sortBy: "Price" } or { sortBy: "Size" }
                                            var sortBy = isotopeOption.sortBy;
                                            applyFilters({sortBy: sortBy});
                                        });
                                    });

                                    // Function to update the URL query parameters and reload the page
                                    function applyFilters(filters) {
                                        var url = new URL(window.location.href);
                                        var params = new URLSearchParams(url.search);

                                        // Update the size filter parameter
                                        if (filters.size) {
                                            params.set('Size', filters.size);
                                        } else {
                                            params.delete('Size');
                                        }

                                        // Update the price filter parameters (only if both are provided)
                                        if (filters.minPrice != null && filters.maxPrice != null) {
                                            params.set('minPrice', filters.minPrice);
                                            params.set('maxPrice', filters.maxPrice);
                                        } else {
                                            params.delete('minPrice');
                                            params.delete('maxPrice');
                                        }
                                        if (filters.pageSize) {
                                            params.set('pageSize', filters.pageSize);
                                            params.delete('page'); // Reset to first page
                                        } else {
                                            params.delete('pageSize');
                                        }
                                        // Update the sorting parameter
                                        if (filters.sortBy) {
                                            params.set('sortBy', filters.sortBy);
                                        } else {
                                            params.delete('sortBy');
                                        }

                                        // Redirect to the updated URL
                                        window.location.href = url.pathname + "?" + params.toString();
                                    }
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