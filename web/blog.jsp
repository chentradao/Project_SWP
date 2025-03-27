
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <title>JSP Page</title>

        <style>
    /* Home Section */
    .home {
        padding: 150px 0;
        margin-bottom: 120px; /* Khoảng cách dưới */
    }

    .home h1 {
        font-size: 2.8rem;
        font-weight: 700;
        color: #1a2b49;
        margin-bottom: 40px;
        text-align: center;
        letter-spacing: 0.5px;
        position: relative;
    }

    
    /* Blog Container */
    .blog-container {
        display: flex;
        flex-wrap: wrap;
        overflow: hidden; /* Ngăn tràn nội dung */
    }

    /* Article Card */
    .article-card {
        margin-bottom: 30px;
        transition: all 0.3s ease;
    }

    .article-card .card {
        border: none;
        border-radius: 12px;
        overflow: hidden;
        background: #fff;
        height: 100%; /* Đảm bảo thẻ đồng đều */
    }

    .card-image-wrapper {
        overflow: hidden;
    }

    .article-card img {
        width: 100%;
        height: 200px;
        object-fit: cover;
        transition: transform 0.4s ease;
    }

    .article-card:hover img {
        transform: scale(1.08);
    }

    .article-card .card-body {
        padding: 20px;
    }

    .article-card .card-title {
        font-size: 1.3rem;
        font-weight: 600;
        color: #1a2b49;
        margin-bottom: 12px;
    }

    .article-card .card-title a {
        text-decoration: none;
        color: inherit;
        transition: color 0.3s ease;
    }

    .article-card .card-text {
        font-size: 0.9rem;
        color: #6b7280;
        line-height: 1.5;
        margin-bottom: 10px;
    }

    .article-card .read-more {
        font-size: 0.85rem;
        color: #ff6b6b;
        text-decoration: none;
        font-weight: 500;
        transition: color 0.3s ease;
    }
    /* Sidebar */
    .sidebar-section {
        background: #fff;
        padding: 20px;
        border-radius: 12px;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
        position: sticky;
        top: 20px;
    }

    .sidebar h2 {
        font-size: 1.5rem;
        font-weight: 600;
        color: #1a2b49;
        margin-bottom: 20px;
        padding-bottom: 8px;
        border-bottom: 2px solid #ff6b6b;
    }

    .top-post-item {
        display: flex;
        gap: 12px;
        margin-bottom: 20px;
        align-items: center;
        transition: all 0.3s ease;
    }

    .top-post-item:hover {
        transform: translateX(5px);
    }

    .top-post-item img {
        width: 70px;
        height: 70px;
        object-fit: cover;
        border-radius: 8px;
        border: 1px solid #eee;
    }

    .top-post-item h3 {
        font-size: 0.95rem;
        font-weight: 500;
        color: #1a2b49;
        margin: 0;
        line-height: 1.4;
    }

    .top-post-item h3 a {
        text-decoration: none;
        color: inherit;
        transition: color 0.3s ease;
    }

    .top-post-item h3 a:hover {
        color: #ff6b6b;
    }

    /* Extra Section */
    .extra {
        clear: both; /* Đảm bảo phần extra không bị tràn lên */
    }

    /* Responsive Adjustments */
    @media (max-width: 1000px) {
        .home {
            padding: 60px 0;
        }

        .article-card img {
            height: 180px;
        }

        .sidebar-section {
            margin-top: 30px;
            position: static;
        }
    }

    @media (max-width: 576px) {
        .home h1 {
            font-size: 2rem;
        }

        .article-card {
            margin-bottom: 20px;
        }

        .article-card img {
            height: 160px;
        }
    }
</style>

    </head>
    <body>
        <div class="super_container">
            <!-- Header -->
            <%@ include file="header.jsp" %>

            <!-- Menu -->
            <%@ include file="menu.jsp" %>

            <!-- Main Content -->
           <!-- Main Content -->
<!-- Main Content -->
<div class="home">
    <div class="container">
        <h1 class="text-center">Khám phá câu chuyện của chúng tôi</h1>
        <div class="row blog-container">
            <!-- Bài viết (Nội dung chính) -->
            <div class="col-lg-9 col-md-8">
                <div class="row">
                    <c:forEach var="blog" items="${vectorBlog}">
                        <div class="col-md-6 col-sm-12 article-card">
                            <div class="card">
                                <div class="card-image-wrapper">
                                    <img src="${blog.getBlogThumbnail()}" class="card-img-top" alt="${blog.getBlogTitle()}">
                                </div>
                                <div class="card-body">
                                    <h5 class="card-title">
                                        <a href="Blog?service=displayBlog&id=${blog.getBlogID()}">${blog.getBlogTitle()}</a>
                                    </h5>
                                    <p class="card-text">
                                        <c:choose>
                                            <c:when test="${fn:length(blog.getBlogDescription()) > 60}">
                                                ${fn:substring(blog.getBlogDescription(), 0, 60)}...
                                            </c:when>
                                            <c:otherwise>
                                                ${blog.getBlogDescription()}
                                            </c:otherwise>
                                        </c:choose>
                                    </p>
                                    <a href="Blog?service=displayBlog&id=${blog.getBlogID()}" class="read-more">Đọc thêm</a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>

            <!-- Sidebar (Bên phải) -->
            <div class="col-lg-3 col-md-4">
                <div class="sidebar-section">
                    <div class="sidebar">
                        <h2>Top bài viết nổi bật</h2>
                        <c:forEach var="blog" items="${topPosts}">
                            <div class="top-post-item">
                                <img src="${blog.getBlogThumbnail()}" alt="${blog.getBlogTitle()}">
                                <h3>
                                    <a href="Blog?service=displayBlog&id=${blog.getBlogID()}">${blog.getBlogTitle()}</a>
                                </h3>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


            <!-- Extra -->

            <div class="extra clearfix">
                <div class="extra_promo extra_promo_1">
                    <div class="extra_promo_image" style="background-image:url(images/extra_1.jpg)"></div>
                    <div class="extra_1_content d-flex flex-column align-items-center justify-content-center text-center">
                        <div class="extra_1_price">30%<span>off</span></div>
                        <div class="extra_1_title">On all shoes</div>
                        <div class="extra_1_text">ABCXYZ</div>
                        <div class="button extra_1_button"><a href="checkout.html">Mua ngay</a></div>
                    </div>
                </div>
                <div class="extra_promo extra_promo_2">
                    <div class="extra_promo_image" style="background-image:url(images/extra_2.jpg)"></div>
                    <div class="extra_2_content d-flex flex-column align-items-center justify-content-center text-center">
                        <div class="extra_2_title">
                            <div class="extra_2_center">&</div>
                            <div class="extra_2_top">Mix</div>
                            <div class="extra_2_bottom">Match</div>
                        </div>
                        <div class="extra_2_text">ABCXYZ</div>
                        <div class="button extra_2_button"><a href="checkout.html">Mua ngay</a></div>
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
                                    <div class="section_title">Giảm giá</div>
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

                        </div>
                    </div>
                </div>
            </footer>
        </div>
        <script src="js/jquery-3.2.1.min.js"></script>
        <script src="styles/bootstrap4/popper.js"></script>
        <script src="styles/bootstrap4/bootstrap.min.js"></script>
        <script src="plugins/OwlCarousel2-2.2.1/owl.carousel.js"></script>
        <script src="plugins/easing/easing.js"></script>
        <script src="plugins/parallax-js-master/parallax.min.js"></script>
        <script src="plugins/colorbox/jquery.colorbox-min.js"></script>
        <script src="js/custom.js"></script>
    </body>
</html>
