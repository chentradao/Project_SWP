<%-- 
    Document   : Footer
    Created on : Feb 26, 2025, 10:29:36 AM
    Author     : nguye
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List" %>
<%@page import="entity.Category" %>
<%@page import="model.CategoryRepository" %>
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
                <div class="footer_logo"><a href="#">ESTÉE LAUDER</a></div>
                <nav class="footer_nav">
                    <ul>
                        <li><a href="index.jsp">home</a></li>
                            <% for (Category category : categories) { %>
                        <li><a href="categories.jsp?category=<%= category.getCategoryId() %>">
                                <%= category.getCategoryName() %>
                            </a></li>
                            <% } %>
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
