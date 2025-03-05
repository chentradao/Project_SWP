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

        <div class="super_container">


            <!-- Header -->

            <%@ include file="header.jsp" %>


            <!-- Menu -->

            <%@ include file="menu.jsp" %>


            <!-- Home -->

            <div class="home">
                <div class="home_background parallax-window" data-parallax="scroll" data-image-src="images/product.jpg" data-speed="0.8"></div>
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
                                            <li>Swimsuits</li>
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
                                    <li><a href="categories.html">Woman's Fashion</a></li>
                                    <li><a href="categories.html">Swimsuits</a></li>
                                    <li>2 Piece Swimsuits</li>
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
                                <div class="product_price">$${productDetail.price}</div>
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
                            </div>
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
        <script src="plugins/easing/easing.js"></script>
        <script src="plugins/parallax-js-master/parallax.min.js"></script>
        <script src="js/product_custom.js"></script>
    </body>
</html>