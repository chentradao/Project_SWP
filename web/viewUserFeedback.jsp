<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Phản hồi của bạn</title>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="description" content="User Feedback List">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" type="text/css" href="styles/bootstrap4/bootstrap.min.css">
        <link href="plugins/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
        <link rel="stylesheet" type="text/css" href="styles/cart.css">
        <link rel="stylesheet" type="text/css" href="styles/cart_responsive.css">
        <style>
            /* Căn chỉnh bảng phản hồi */
            .cart_bar_title_name {
                width: 150px; /* Cố định chiều rộng cho cột Hình ảnh */
                text-align: center;
            }
            .cart_bar_title_content_inner {
                width: 100%;
            }
            .cart_bar_title_price {
                width: 150px; /* Cố định chiều rộng cho cột Đánh giá */
                text-align: center;
            }
            .cart_bar_title_quantity {
                flex: 1; /* Cột Nội dung chiếm phần còn lại */
                text-align: left;
                padding-left: 20px;
            }
            .cart_bar_title_total {
                width: 120px; /* Cố định chiều rộng cho cột Ngày gửi */
                text-align: center;
            }
            .cart_product_image {
                width: 150px !important; /* Khớp với tiêu đề */
                height: 150px !important;
            }
            .cart_product_info {
                width: 100% !important;
            }
            .cart_product_price {
                width: 150px; /* Khớp với tiêu đề */
                text-align: center;
            }
            .cart_product_quantity {
                flex: 1; /* Khớp với tiêu đề */
                padding-left: 20px;
            }
            .cart_product_total {
                width: 120px; /* Khớp với tiêu đề */
                text-align: center;
            }
        </style>
    </head>
    <body>

        <div class="super_container">

            <!-- Header -->

            <!-- Menu -->

            <!-- Home -->
            <div class="home">
                <div class="home_background parallax-window" data-parallax="scroll" data-image-src="images/cart.jpg" data-speed="0.8"></div>
                <div class="container">
                    <div class="row">
                        <div class="col">
                            <div class="home_container">
                                <div class="home_content">
                                    <div class="home_title">Phản hồi của bạn</div>
                                    <div class="breadcrumbs">
                                        <ul>
                                            <li><a href="ProductListServlet">Trang chủ</a></li>
                                            <li>Phản hồi của bạn</li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Feedback List -->
            <div class="cart_container">
                <div class="container">
                    <div class="row">
                        <div class="col">
                            <div class="cart_title">Danh sách phản hồi của bạn</div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col">
                            <div class="cart_bar d-flex flex-row align-items-center justify-content-start">
                                <div class="cart_bar_title_name">Hình ảnh</div>
                                <div class="cart_bar_title_content ml-auto">
                                    <div class="cart_bar_title_content_inner d-flex flex-row align-items-center justify-content-end">
                                        <div class="cart_bar_title_price">Đánh giá</div>
                                        <div class="cart_bar_title_quantity">Nội dung</div>
                                        <div class="cart_bar_title_total">Ngày gửi</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <c:choose>
                        <c:when test="${empty feedbacks}">
                            <div class="row">
                                <div class="col">
                                    <div class="alert alert-warning text-center" role="alert">
                                        Bạn chưa gửi phản hồi nào.
                                    </div>
                                </div>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="row">
                                <div class="col">
                                    <div class="cart_products">
                                        <ul>
                                            <c:forEach var="feedback" items="${feedbacks}" varStatus="loop">
                                                <li class="cart_product d-flex flex-md-row flex-column align-items-md-center align-items-start justify-content-start">
                                                    <!-- Feedback Image -->
                                                    <div class="cart_product_image" style="display: flex; justify-content: center; align-items: center; height: 150px; overflow: hidden;">
                                                        <c:choose>
                                                            <c:when test="${not empty feedback.imageURL}">
                                                                <img src="${feedback.imageURL}" alt="Feedback Image" style="object-fit: contain; width: auto; max-height: 150px;">
                                                            </c:when>
                                                            <c:otherwise>
                                                                <img src="images/default-feedback.jpg" alt="No Image" style="object-fit: contain; width: auto; max-height: 150px;">
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                    <!-- Feedback Rating -->
                                                    <div class="cart_product_info ml-auto">
                                                        <div class="cart_product_info_inner d-flex flex-row align-items-center justify-content-md-end justify-content-start">
                                                            <div class="cart_product_price">
                                                                <c:forEach begin="1" end="5" var="i">
                                                                    <c:choose>
                                                                        <c:when test="${i <= feedback.rateStar}">
                                                                            <i class="fa fa-star" style="color: gold;"></i>
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <i class="fa fa-star-o"></i>
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </c:forEach>
                                                            </div>
                                                            <!-- Feedback Text -->
                                                            <div class="cart_product_quantity">${feedback.feedbackText}</div>
                                                            <!-- Feedback Date -->
                                                            <div class="cart_product_total">
                                                                <fmt:formatDate value="${feedback.date}" pattern="dd/MM/yyyy" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                </li>
                                            </c:forEach>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </c:otherwise>
                    </c:choose>

                    <div class="row">
                        <div class="col">
                            <div class="cart_control_bar d-flex flex-md-row flex-column align-items-start justify-content-start">
                                <button type="button" class="button_update cart_button" onclick="window.location.href = 'ServiceFeedbackURL?action=add'">Thêm phản hồi mới</button>
                                <button type="button" class="button_update cart_button_2 ml-md-auto" onclick="window.location.href = 'ProductListServlet'">Quay về trang chủ</button>
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
                                    <li><a href="ProductListServlet">Trang chủ</a></li>
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
        <script src="js/cart_custom.js"></script>
    </body>
</html>