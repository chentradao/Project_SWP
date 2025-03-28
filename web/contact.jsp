
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Contact</title>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="description" content="Wish shop project">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" type="text/css" href="styles/bootstrap4/bootstrap.min.css">
        <link href="plugins/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
        <link rel="stylesheet" type="text/css" href="styles/contact.css">
        <link rel="stylesheet" type="text/css" href="styles/contact_responsive.css">
    </head>
    <body>

        <div class="super_container">

            <!-- Header -->

            <%@ include file="header.jsp" %>


            <!-- Menu -->

            <%@ include file="menu.jsp" %>

            <!-- Home -->

            <div class="home">
                <div class="home_background parallax-window" data-parallax="scroll" data-image-src="images/contact.jpg" data-speed="0.8"></div>
                <div class="container">
                    <div class="row">
                        <div class="col">
                            <div class="home_container">
                                <div class="home_content">
                                    <div class="home_title">Liên hệ</div>
                                    <div class="breadcrumbs">
                                        <ul>
                                            <li><a href="index.html">Trang chủ</a></li>
                                            <li>Liên hệ</li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Google Map -->

            <div class="map">
                <div id="google_map" class="google_map">
                    <div class="map_container">
                        <div id="map"></div>
                    </div>
                </div>
            </div>

            <!-- Contact Form -->

            <!-- Contact Form -->
            <div class="contact">
                <div class="container">
                    <div class="row">
                        <div class="col">
                            <div class="review_form_container">
                                <div class="review_form_title">Liên hệ với chúng tôi</div>
                                <div class="review_form_content">
                                    <form action="viewUserFeedback.jsp" id="review_form" class="review_form">
                                        <div class="d-flex flex-md-row flex-column align-items-start justify-content-between">
									<input type="text" class="review_form_input" placeholder="Name" required="required">
									<input type="email" class="review_form_input" placeholder="E-mail" required="required">
									<input type="text" class="review_form_input" placeholder="Subject">
								</div>
                                        <textarea class="review_form_text" name="review_form_text" placeholder="Message"></textarea>
                                        <button type="submit" class="review_form_button">Gửi phản hồi về dịch vụ</button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Contact Text -->

            <div class="contact_text">
                <div class="container">
                    <div class="row">

                        <!-- Contact Info -->
                        <div class="col-lg-5">

                            <div class="contact_info">
                                <div class="contact_title">Thông tin liên hệ</div>
                                <div class="contact_info_content">
                                    <ul>
                                        <li>
                                            <div class="contact_info_icon"><img src="images/contact_info_1.png" alt=""></div>
                                            <div class="contact_info_text">267 Đường Quang Trung, P. Quang Trung, Q. Hà Đông</div>
                                        </li>
                                        <li>
                                            <div class="contact_info_icon"><img src="images/contact_info_2.png" alt=""></div>
                                            <div class="contact_info_text">esteelauder@gmail.com</div>
                                        </li>
                                        <li>
                                            <div class="contact_info_icon"><img src="images/contact_info_3.png" alt=""></div>
                                            <div class="contact_info_text">+84 916 016 008</div>
                                        </li>
                                    </ul>
                                </div>
                                <div class="contact_info_social">
                                    <ul>
                                        <li><a href="#"><i class="fa fa-pinterest" aria-hidden="true"></i></a></li>
                                        <li><a href="#"><i class="fa fa-linkedin" aria-hidden="true"></i></a></li>
                                        <li><a href="#"><i class="fa fa-instagram" aria-hidden="true"></i></a></li>
                                        <li><a href="#"><i class="fa fa-reddit-alien" aria-hidden="true"></i></a></li>
                                        <li><a href="#"><i class="fa fa-twitter" aria-hidden="true"></i></a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>

                        <!-- FAQ -->
                        <!-- FAQ -->
                        <div class="col-lg-7">
                            <div class="faq">
                                <div class="contact_title">Câu hỏi thường gặp</div>
                                <div class="faq_content">

                                    <!-- Accordions -->
                                    <div class="accordions">

                                        <div class="accordion_container">
                                            <div class="accordion d-flex flex-row align-items-center"><div>Làm thế nào để liên hệ với bộ phận chăm sóc khách hàng?</div></div>
                                            <div class="accordion_panel">
                                                <p>Trả lời: Bạn có thể liên hệ với chúng tôi qua email tại esteelauder@gmail.com hoặc gọi đến số điện thoại +84 916 016 008. Chúng tôi luôn sẵn sàng hỗ trợ bạn!</p>
                                            </div>
                                        </div>

                                        <div class="accordion_container">
                                            <div class="accordion d-flex flex-row align-items-center"><div>Chính sách đổi trả sản phẩm như thế nào?</div></div>
                                            <div class="accordion_panel">
                                                <p>Trả lời: Chúng tôi chấp nhận đổi trả sản phẩm trong vòng 30 ngày kể từ ngày mua, với điều kiện sản phẩm chưa qua sử dụng và còn nguyên bao bì. Vui lòng liên hệ chúng tôi để biết thêm chi tiết.</p>
                                            </div>
                                        </div>

                                        <div class="accordion_container">
                                            <div class="accordion d-flex flex-row align-items-center active"><div>Làm sao để nhận mã giảm giá 20%?</div></div>
                                            <div class="accordion_panel">
                                                <p>Trả lời: Để nhận mã giảm giá 20%, bạn chỉ cần đăng ký email tại phần "Đăng ký ngay" ở cuối trang web. Mã giảm giá sẽ được gửi trực tiếp đến email của bạn.</p>
                                            </div>
                                        </div>

                                    </div>

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
                        <div class="row newsletter_row">
                            <div class="col">
                                <div class="section_title_container text-center">
                                    <div class="section_subtitle">Đăng kí ngay</div>
                                    <div class="section_title">Đăng kí để nhận mã giảm giá 20%</div>
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
        </div>

        <script src="js/jquery-3.2.1.min.js"></script>
        <script src="styles/bootstrap4/popper.js"></script>
        <script src="styles/bootstrap4/bootstrap.min.js"></script>
        <script src="plugins/easing/easing.js"></script>
        <script src="plugins/parallax-js-master/parallax.min.js"></script>
        <script src="https://maps.googleapis.com/maps/api/js?v=3.exp&key=AIzaSyCIwF204lFZg1y4kPSIhKaHEXMLYxxuMhA"></script>
        <script src="js/contact_custom.js"></script>
    </body>
</html>