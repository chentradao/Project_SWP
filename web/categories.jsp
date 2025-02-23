<!DOCTYPE html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
                                            <li><a href="index.jsp">Home</a></li>
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
                                            <li><a href="#" data-size="15ml">15ML</a></li>
                                            <li><a href="#" data-size="30ml">30ML</a></li>
                                            <li><a href="#" data-size="50ml">50ML</a></li>
                                            <li><a href="#" data-size="75ml">75ML</a></li>
                                            <li><a href="#" data-size="100ml">100ML</a></li>
                                        </ul>
                                    </div>
                                </div>
                                <!-- Price Filter -->
                                <div class="sidebar_section">
                                    <div class="sidebar_title">Khoảng Giá</div>
                                    <div class="sidebar_section_content">
                                        <div class="filter_price">
                                            <!-- Two input fields for min and max price -->
                                            <input type="number" id="minPriceInput" placeholder="Từ" style="width:45%; display:inline-block; margin-right:5%;">
                                            <input type="number" id="maxPriceInput" placeholder="Đến" style="width:45%; display:inline-block;">
                                            <br/><br/>
                                            <button id="applyPriceBtn">Áp Dụng</button>
                                            <button id="clearPriceBtn">Xóa</button>
                                        </div>
                                    </div>
                                </div>
                                <!-- (Additional filter options can be added here) -->
                            </div>
                            <div class="current_page">Woman's Fashion</div>
                        </div>
                        <div class="col-12">
                            <div class="product_sorting clearfix">
                                <div class="view">
                                    <div class="view_box box_view"><i class="fa fa-th-large" aria-hidden="true"></i></div>
                                    <div class="view_box detail_view"><i class="fa fa-bars" aria-hidden="true"></i></div>
                                </div>
                                <div class="sorting">
                                    <ul class="item_sorting">
                                        <li>
                                            <span class="sorting_text">Sort by</span>
                                            <i class="fa fa-caret-down" aria-hidden="true"></i>
                                            <ul>
                                                <!-- Updated sorting options -->
                                                <li class="product_sorting_btn" data-isotope-option='{"sortBy": "original-order"}'><span>Default</span></li>
                                                <li class="product_sorting_btn" data-isotope-option='{"sortBy": "Price"}'><span>Price</span></li>
                                                <li class="product_sorting_btn" data-isotope-option='{"sortBy": "Size"}'><span>Size</span></li>
                                            </ul>
                                        </li>
                                        <li>
                                            <span class="sorting_text">Show</span>
                                            <span class="num_sorting_text">12</span>
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
                        </div>
                    </div>
                    <div class="row products_container">
                        <div class="col">
                            <!-- Include the list of products -->
                            <%@ include file="listProduct.jsp" %>
                        </div>
                    </div>
                    <div class="row page_num_container">
                        <div class="col text-right">
                            <ul class="page_nums">
                                <li><a href="#">01</a></li>
                                <li class="active"><a href="#">02</a></li>
                                <li><a href="#">03</a></li>
                                <li><a href="#">04</a></li>
                                <li><a href="#">05</a></li>
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

        <script src="js/categories_custom.js"></script>
    </body>
</html>
