<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Product</title>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="description" content="Wish shop project">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" type="text/css" href="styles/bootstrap4/bootstrap.min.css">
        <link href="plugins/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
        <link rel="stylesheet" type="text/css" href="styles/product.css">
        <link rel="stylesheet" type="text/css" href="styles/product_responsive.css">
    </head>
    <body>
        <style>
            /* Modern styling for the review statistics */
            .review-statistics-container {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: #fff;
                border-radius: 10px;
                padding: 20px;
                box-shadow: 0 2px 15px rgba(0, 0, 0, 0.1);
                max-width: 650px;
                margin: 0 auto;
            }

            .section-title {
                color: #333;
                font-size: 24px;
                margin-bottom: 20px;
                border-bottom: 2px solid #f0f0f0;
                padding-bottom: 10px;
            }

            .stats-grid {
                display: flex;
                flex-direction: column;
                gap: 12px;
                margin-bottom: 25px;
            }

            .rating-row {
                display: flex;
                align-items: center;
                gap: 15px;
            }

            .rating-label {
                width: 80px;
                display: flex;
                align-items: center;
                gap: 5px;
                font-weight: 500;
            }

            .star-icon {
                color: #FFD700;
            }

            .rating-bar-container {
                flex-grow: 1;
                height: 12px;
                background-color: #f0f0f0;
                border-radius: 6px;
                overflow: hidden;
            }

            .rating-bar {
                height: 100%;
                border-radius: 6px;
                transition: width 0.5s ease;
            }

            .five-star {
                background-color: #4CAF50;
            }

            .four-star {
                background-color: #8BC34A;
            }

            .three-star {
                background-color: #FFC107;
            }

            .two-star {
                background-color: #FF9800;
            }

            .one-star {
                background-color: #F44336;
            }

            .rating-count {
                width: 90px;
                text-align: right;
                color: #666;
                font-size: 14px;
            }

            .average-rating {
                display: flex;
                flex-direction: column;
                align-items: center;
                background-color: #f9f9f9;
                padding: 15px;
                border-radius: 8px;
            }

            .average-stars {
                font-size: 28px;
                color: #FFD700;
                margin-bottom: 5px;
            }

            .star-full, .star-half {
                color: #FFD700;
                display: inline-block;
            }

            .star-empty {
                color: #e0e0e0;
                display: inline-block;
            }

            .average-value {
                font-size: 16px;
                color: #333;
            }

            .review-count {
                color: #666;
                font-size: 14px;
                margin-left: 5px;
            }

            @media (max-width: 600px) {
                .rating-row {
                    flex-wrap: wrap;
                }

                .rating-label {
                    width: 70px;
                    font-size: 14px;
                }

                .rating-count {
                    width: 80px;
                    font-size: 13px;
                }
            }
            /* Brown theme custom styling */
            :root {
                --brown-primary: #8B5A2B;
                --brown-secondary: #A67C52;
                --brown-light: #D2B48C;
                --brown-very-light: #F5F0E7;
                --brown-dark: #654321;
            }

            .text-brown {
                color: var(--brown-primary);
            }

            .bg-brown {
                background-color: var(--brown-primary);
            }

            .btn-brown {
                background-color: var(--brown-primary);
                color: white;
                border: none;
                transition: all 0.3s;
            }

            .btn-brown:hover, .btn-brown:focus {
                background-color: var(--brown-dark);
                color: white;
            }

            .btn-outline-brown {
                color: var(--brown-secondary);
                border-color: var(--brown-light);
                background-color: white;
            }

            .btn-outline-brown:hover {
                background-color: var(--brown-very-light);
                color: var(--brown-dark);
                border-color: var(--brown-secondary);
            }

            .btn-check:checked + .btn-outline-brown {
                background-color: var(--brown-primary);
                color: white;
                border-color: var(--brown-primary);
            }

            .brown-focus:focus {
                border-color: var(--brown-light);
                box-shadow: 0 0 0 0.25rem rgba(139, 90, 43, 0.25);
            }

            .feedback-form {
                border-color: var(--brown-light);
                background-color: white;
                border-radius: 10px;
            }

            .input-group-text {
                border: none;
            }

            .form-control {
                border: 1px solid #E5D3B9;
            }

            .rating-stars .btn {
                min-width: 45px;
            }

            /* Better hover effect for stars */
            .rating-stars .btn-outline-brown:hover {
                transform: scale(1.1);
            }


            .rating-stars {
                display: flex;
                flex-direction: row-reverse;
            }

            .rating-stars .star {
                font-size: 24px;
                color: #ccc;
                cursor: pointer;
                transition: color 0.2s;
            }

            .rating-stars .star:hover,
            .rating-stars .star.hovered,
            .rating-stars .star.selected {
                color: gold;
            }


            .review_image1 img {
                width: 100px;
                height: 100px;
                object-fit: cover;
            }

            .review_reply {
                margin-top: 10px;
                padding: 10px;
                background-color: #f9f9f9;
                border-left: 3px solid #007bff;
                border-radius: 5px;
            }

            .reply_header {
                font-weight: bold;
                color: #333;
                display: flex;
                justify-content: space-between;
                font-size: 14px;
            }

            .reply_text {
                margin-top: 5px;
                font-size: 14px;
                color: #555;
            }

            .admin-badge {
                font-size: 0.8rem;
                background-color: var(--brown-primary);
            }

            .reply-content {
                position: relative;
                background-color: var(--brown-very-light) !important;
            }

            .reply-content:before {
                content: "";
                position: absolute;
                top: -8px;
                left: 20px;
                border-left: 8px solid transparent;
                border-right: 8px solid transparent;
                border-bottom: 8px solid white;
            }

            .brown-focus:focus {
                border-color: var(--brown-light);
                box-shadow: 0 0 0 0.25rem rgba(139, 90, 43, 0.25);
            }

            .border-brown {
                border-color: var(--brown-primary) !important;
            }

            .admin-reply {
                animation: fadeIn 0.5s ease;
            }

            @keyframes fadeIn {
                from {
                    opacity: 0;
                    transform: translateY(10px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

        </style>
        <div class="super_container">


            <!-- Header -->

            <%@ include file="header.jsp" %>


            <!-- Menu -->

            <%@ include file="menu.jsp" %>

            <c:set var="currentUser" value="${sessionScope.acc}" />

            <!-- Home -->

            <div class="home">
                <div class="home_background parallax-window" data-parallax="scroll" data-image-src="images/product.jpg" data-speed="0.8"></div>
                <div class="container">
                    <div class="row">
                        <div class="col">
                            <div class="home_container">
                                <div class="home_content">
                                    <div class="home_title">Product detail</div>
                                    <div class="breadcrumbs">
                                        <ul>
                                            <li><a href="ProductListServlet">Home</a></li>
                                            <li>${productDetail.productName}</li>
                                        </ul>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Product -->

            <div class="product">
                <div class="container">
                    <div class="row">
                        <div class="col">
                            <div class="current_page">
                                <ul>
                                    <li><a href="ProductListSevlet">Home</a></li>
                                    <li><a href="listProduct.jsp">Danh sách sản phẩm</a></li>
                                    <li>${productDetail.productName}</li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="row product_row">

                        <!-- Product Image -->
                        <div class="col-lg-7">
                            <div class="product_image">
                                <div class="product_image_large">
                                    <!-- Use the dynamic product image -->
                                    <img src="${productDetail.image}" alt="${productDetail.productName}">
                                </div>
                                <!-- Optionally, add thumbnails if available -->
                            </div>
                        </div>

                        <!-- Product Content -->
                        <div class="col-lg-5">
                            <div class="product_content">
                                <!-- Dynamic product name -->
                                <div class="product_name">${productDetail.productName}</div>
                                <!-- Dynamic product price (format as needed) -->
                                <div class="product_price">${productDetail.price} VND</div>
                                <div class="rating rating_4" data-rating="4">
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                </div>
                                <!-- In Stock -->
                                <div class="in_stock_container">
                                    <div class="in_stock in_stock_true"></div>
                                    <span>in stock</span>
                                </div>
                                <!-- Dynamic product description -->
                                <div class="product_text">
                                    <p>${productDetail.description}</p>
                                </div>
                                <!-- Display product details such as size and color -->
                                <div class="product_details">
                                    <p><strong>Size:</strong> ${productDetail.size}</p>
                                    <p><strong>Color:</strong> ${productDetail.color}</p>
                                </div>
                                <!-- Product Quantity -->
                                <div class="product_quantity_container">
                                    <span>Quantity</span>
                                    <div class="product_quantity clearfix">
                                        <input id="quantity_input" type="text" pattern="[0-9]*" value="1">
                                        <div class="quantity_buttons">
                                            <div id="quantity_inc_button" class="quantity_inc quantity_control">
                                                <i class="fa fa-caret-up" aria-hidden="true"></i>
                                            </div>
                                            <div id="quantity_dec_button" class="quantity_dec quantity_control">
                                                <i class="fa fa-caret-down" aria-hidden="true"></i>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- Link to add the product to cart -->
                                <div class="button cart_button">
                                    <a href="CartURL?service=add2cart&id=${productDetail.productId}">add to cart</a>
                                </div>
                                <div class="button cart_button">
                                    <a href="FeedbackDisplayController?productId=${productDetail.productId}">View Feedback</a>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col">

                        </div>
                    </div>

                    <!-- Reviews -->

			<div class="row">
				<div class="col">
					<div class="reviews">
						<div class="reviews_title">reviews</div>
						<div class="reviews_container">
							<ul>
								<!-- Review -->
								<li class=" review clearfix">
									<div class="review_image"><img src="images/review_1.jpg" alt=""></div>
									<div class="review_content">
										<div class="review_name"><a href="#">Maria Smith</a></div>
										<div class="review_date">Nov 29, 2017</div>
										<div class="rating rating_4 review_rating" data-rating="4">
											<i class="fa fa-star"></i>
											<i class="fa fa-star"></i>
											<i class="fa fa-star"></i>
											<i class="fa fa-star"></i>
											<i class="fa fa-star"></i>
										</div>
										<div class="review_text">
											<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla quis quam ipsum. Pellentesque consequat tellus non tortor tempus, id egestas elit iaculis. Proin eu dui porta, pretium metus vitae, pharetra odio. Sed ac mi commodo, pellentesque erat eget, accumsan justo. Etiam sed placerat felis. Proin non rutrum ligula. </p>
										</div>
									</div>
								</li>
								<!-- Review -->
								<li class=" review clearfix">
									<div class="review_image"><img src="images/review_2.jpg" alt=""></div>
									<div class="review_content">
										<div class="review_name"><a href="#">Maria Smith</a></div>
										<div class="review_date">Nov 29, 2017</div>
										<div class="rating rating_4 review_rating" data-rating="4">
											<i class="fa fa-star"></i>
											<i class="fa fa-star"></i>
											<i class="fa fa-star"></i>
											<i class="fa fa-star"></i>
											<i class="fa fa-star"></i>
										</div>
										<div class="review_text">
											<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla quis quam ipsum. Pellentesque consequat tellus non tortor tempus, id egestas elit iaculis. Proin eu dui porta, pretium metus vitae, pharetra odio. Sed ac mi commodo, pellentesque erat eget, accumsan justo. Etiam sed placerat felis. Proin non rutrum ligula. </p>
										</div>
									</div>
								</li>
							</ul>
						</div>
					</div>
				</div>
			</div>

			<!-- Leave a Review -->

			<div class="row">
				<div class="col">
					<div class="review_form_container">
						<div class="review_form_title">leave a review</div>
						<div class="review_form_content">
							<form action="#" id="review_form" class="review_form">
								<div class="d-flex flex-md-row flex-column align-items-start justify-content-between">
									<input type="text" class="review_form_input" placeholder="Name" required="required">
									<input type="email" class="review_form_input" placeholder="E-mail" required="required">
									<input type="text" class="review_form_input" placeholder="Subject">
								</div>
								<textarea class="review_form_text" name="review_form_text" placeholder="Message"></textarea>
								<button type="submit" class="review_form_button">leave a review</button>
							</form>
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
                            <div class="footer_logo"><a href="ProductListServlet">Estée Lauder</a></div>
                            <nav class="footer_nav">
                                <ul>
                                    <li><a href="ProductListServlet">Home</a></li>
                                    <li><a href="categories.html">Chăm sóc da</a></li>
                                    <li><a href="categories.html">Trang điểm</a></li>
                                    <li><a href="categories.html">Nước hoa</a></li>
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
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Include Bootstrap Icons -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css" rel="stylesheet">
        <script src="js/jquery-3.2.1.min.js"></script>
        <script src="styles/bootstrap4/popper.js"></script>
        <script src="styles/bootstrap4/bootstrap.min.js"></script>
        <script src="plugins/easing/easing.js"></script>
        <script src="plugins/parallax-js-master/parallax.min.js"></script>
        <script src="js/product_custom.js"></script>
        <script>

                                    document.addEventListener("DOMContentLoaded", function () {
                                        const stars = document.querySelectorAll(".rating-stars .star");
                                        const ratingDisplay = document.getElementById("selected-rating");
                                        let selectedRating = 0;

                                        stars.forEach(star => {
                                            star.addEventListener("mouseover", function () {
                                                highlightStars(this.dataset.value);
                                            });

                                            star.addEventListener("mouseout", function () {
                                                highlightStars(selectedRating);
                                            });

                                            star.addEventListener("click", function () {
                                                selectedRating = this.dataset.value;
                                                ratingDisplay.textContent = selectedRating;
                                            });
                                        });

                                        function highlightStars(rating) {
                                            stars.forEach(star => {
                                                if (star.dataset.value <= rating) {
                                                    star.classList.add("hovered");
                                                } else {
                                                    star.classList.remove("hovered");
                                                }
                                            });
                                        }
                                    });


                                    function previewImage(event) {
                                        const input = event.target;
                                        const preview = document.getElementById('imagePreview');

                                        if (input.files && input.files[0]) {
                                            const reader = new FileReader();
                                            reader.onload = function (e) {
                                                preview.src = e.target.result;
                                                preview.classList.remove('d-none');
                                            };
                                            reader.readAsDataURL(input.files[0]);
                                        }
                                    }


        </script>
    </body>
</html>