<%@ page import="entity.Blog" %>
<%@ page import="java.util.Vector" %>
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
        <title>Display Blog</title>
        <style>
            * {
                box-sizing: border-box;
                margin: 0;
                padding: 0;
                font-family: 'Segoe UI', sans-serif;
            }

            body {
                background-color: #f8f9fa;
                padding: 2rem;
                line-height: 1.6;
            }

            .content-wrapper {
                max-width: 1200px;
                margin: 0 auto;
                display: grid;
                grid-template-columns: 3fr 1fr; /* Blog bên trái, Sidebar bên phải */
                gap: 2rem;
                padding-top: 100px;
            }

            .blog-container {
                background: white;
                border-radius: 16px;
                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
                overflow: hidden;
            }

            .blog-header {
                padding: 2.5rem;
                border-bottom: 1px solid #eee;
                background: linear-gradient(135deg, #f8f9fa 0%, #ffffff 100%);
            }

            .blog-title {
                font-size: 2.5rem;
                color: #2c3e50;
                margin-bottom: 1.2rem;
                font-weight: 700;
                letter-spacing: -0.5px;
            }

            .blog-meta {
                display: flex;
                gap: 2rem;
                color: #7f8c8d;
                font-size: 0.95rem;
                flex-wrap: wrap;
            }

            .blog-meta span {
                display: flex;
                align-items: center;
                gap: 0.5rem;
                padding: 0.5rem 1rem;
                background: rgba(236, 240, 241, 0.5);
                border-radius: 6px;
            }

            .blog-thumbnail {
                width: 100%;
                height: 500px;
                object-fit: cover;
                object-position: center;
                display: block;
                border-bottom: 1px solid #eee;
            }

            .blog-content {
                padding: 2.5rem;
            }

            .blog-description {
                font-size: 1.1rem;
                color: #34495e;
                max-width: 800px;
                margin: 0 auto;
            }

            /* Sidebar */
            .sidebar-section {
                padding: 2.5rem;
                background: #f8f9fa;
                border-radius: 8px;
                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
            }

            .sidebar h2 {
                font-size: 1.5rem;
                color: #2c3e50;
                margin-bottom: 1.5rem;
            }

            .top-post-item {
                display: flex;
                gap: 1rem;
                margin-bottom: 1.5rem;
                align-items: center;
            }

            .top-post-item img {
                width: 80px;
                height: 80px;
                object-fit: cover;
                border-radius: 8px;
            }

            .top-post-item h3 {
                font-size: 1rem;
                color: #34495e;
                margin: 0;
            }

            /* Related Posts Section */
            .related-posts-section {
                max-width: 1200px;
                margin: 2rem auto;
                padding: 2.5rem;
                background: #fff;
                border-radius: 16px;
                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
            }

            .related-posts h2 {
                font-size: 1.8rem;
                color: #2c3e50;
                margin-bottom: 1.5rem;
            }

            .related-posts-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
                gap: 1.5rem;
            }

            .related-post-item {
                background: #fff;
                border-radius: 8px;
                overflow: hidden;
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
                transition: transform 0.3s ease;
            }

            .related-post-item:hover {
                transform: translateY(-5px);
            }

            .related-post-item img {
                width: 100%;
                height: 150px;
                object-fit: cover;
            }

            .related-post-item h3 {
                font-size: 1.1rem;
                color: #2c3e50;
                padding: 1rem;
                margin: 0;
            }

            /* Responsive Design */
            @media (max-width: 992px) {
                .content-wrapper {
                    grid-template-columns: 1fr; /* Xếp chồng trên màn nhỏ */
                }

                .sidebar-section {
                    margin-top: 0;
                }

                .blog-thumbnail {
                    height: 400px;
                }
            }

            @media (max-width: 768px) {
                body {
                    padding: 1rem;
                }

                .blog-header, .blog-content, .related-posts-section, .sidebar-section {
                    padding: 1.5rem;
                }

                .blog-title {
                    font-size: 2rem;
                }

                .blog-thumbnail {
                    height: 300px;
                }
            }

            @media (max-width: 480px) {
                .blog-title {
                    font-size: 1.6rem;
                }

                .blog-meta {
                    gap: 1rem;
                }

                .related-posts-grid {
                    grid-template-columns: 1fr;
                }
            }

            /* Breadcrumb Navigation */
            .breadcrumb-nav {
                padding: 1rem 2.5rem; /* Cùng padding với blog-header */
                font-size: 0.95rem;
                color: #7f8c8d;
                background: #f8f9fa;
                border-bottom: 1px solid #eee;
            }

            .breadcrumb-nav a {
                color: #007bff; /* Màu xanh cho liên kết */
                text-decoration: none;
                transition: color 0.3s ease;
            }

            .breadcrumb-nav a:hover {
                color: #0056b3; /* Màu xanh đậm khi hover */
                text-decoration: underline;
            }

            .breadcrumb-nav .separator {
                margin: 0 0.5rem;
                color: #7f8c8d; /* Màu xám cho dấu phân cách */
            }

            .breadcrumb-nav .current {
                color: #2c3e50; /* Màu tối cho tiêu đề hiện tại */
                font-weight: 500;
            }
            .comment-section {
                width: 100%;
                max-width: 800px;
                margin: 30px auto;
                padding: 20px;
                background: #f9f9f9;
                border-radius: 10px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            }

            .comment-section h2 {
                font-size: 22px;
                color: #333;
                border-bottom: 2px solid #ddd;
                padding-bottom: 5px;
                margin-bottom: 15px;
            }

            .comment-list {
                margin-bottom: 20px;
                padding: 50px;
                border: 10px;
            }

            .comment-item {
                background: white;
                padding: 12px;
                margin-bottom: 10px;
                border-radius: 8px;
                border-left: 4px solid #007bff;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            }

            .comment-item p {
                margin: 5px 0;
            }

            .comment-item strong {
                color: #007bff;
            }

            .comment-item span {
                font-size: 12px;
                color: #777;
            }

            .comment-form h3 {
                font-size: 18px;
                margin-bottom: 10px;
            }

            .comment-form textarea {
                width: 100%;
                height: 100px;
                padding: 10px;
                border: 1px solid #ddd;
                border-radius: 8px;
                resize: none;
            }

            .comment-form button {
                display: block;
                margin-top: 10px;
                padding: 10px 15px;
                background: #007bff;
                color: white;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                transition: background 0.3s ease;
            }

            .comment-form button:hover {
                background: #0056b3;
            }


        </style>
    </head>
    <body>

        <div class="super_container">
            <!-- Header -->
            <%@ include file="header.jsp" %>

            <!-- Menu -->
            <%@ include file="menu.jsp" %>

            <!-- Main Content and Sidebar Wrapper -->
            <div class="content-wrapper">
                <!-- Detail Blog -->
                <div class="blog-container">
                    <!-- Breadcrumb -->
                    <nav class="breadcrumb-nav">
                        <a href="ProductListServlet">Trang chủ</a>
                        <span class="separator">></span>
                        <a href="Blog?service=listAllBlogs">Bài đăng</a>
                        <span class="separator">></span>
                        <span class="current">
                            <c:choose>
                                <c:when test="${fn:length(blog.getBlogTitle()) > 10}">
                                    ${fn:substring(blog.getBlogTitle(), 0, 10)}...
                                </c:when>
                                <c:otherwise>
                                    ${blog.getBlogTitle()}
                                </c:otherwise>
                            </c:choose>
                        </span>
                    </nav>
                    <div class="main-content">
                        <!-- Header -->
                        <div class="blog-header">
                            <h1 class="blog-title">${blog.getBlogTitle()}</h1>
                            <div class="blog-meta"> 
                                <span>📝 Đăng bởi: <a href="AuthorServlet?service=authorDetails&id=${blog.getBlogAuthor()}">${author.getFullName()}</a></span>
                                <span>📁 Danh mục: 
                                    <c:choose>
                                        <c:when test="${blog.getBlogCategoryID() == 1}">
                                            Làm đẹp
                                        </c:when>
                                        <c:when test="${blog.getBlogCategoryID() == 2}">
                                            Bảo vệ môi trường
                                        </c:when>
                                        <c:when test="${blog.getBlogCategoryID() == 3}">
                                            Sức khỏe
                                        </c:when>
                                        <c:otherwise>
                                            Không xác định
                                        </c:otherwise>
                                    </c:choose>
                                </span>
                                <span>📅 Ngày đăng: ${blog.getDate()}</span>
                            </div>
                        </div>

                        <!-- Thumbnail -->
                        <img src="${blog.getBlogThumbnail()}" alt="Thumbnail" class="blog-thumbnail">

                        <!-- Nội dung chính -->
                        <div class="blog-content">
                            <div class="blog-description">
                                <p>${blog.getBlogDescription()}</p>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Sidebar Section -->
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

                <!-- Comment Section -->
                <div class="comment-section">
                    <h2>Bình luận</h2>

                    <!-- Hiển thị danh sách bình luận -->
                    <div class="comment-list">
                        <c:forEach var="comment" items="${comments}">
                            <div class="comment-item">
                                <p>${comment.getAccountName()} - <span>${comment.getDate()}</span></p> 
                                <p>${comment.getComment()}</p>
                            </div>
                        </c:forEach> 
                    </div>

                    <!-- Form thêm bình luận -->
                    <div class="comment-form">
                        <h3>Để lại bình luận</h3>
                        <form action="comment" method="post">
                            <input type="hidden" name="id" value="${blog.getBlogID()}">
                            <textarea name="comment" placeholder="Nhập bình luận của bạn..." required></textarea>
                            <button type="submit">Gửi</button>
                        </form>
                    </div>
                </div>

                <!-- Related Posts Section -->
                <div class="related-posts-section">
                    <div class="related-posts">
                        <h2>Bài viết liên quan</h2>
                        <div class="related-posts-grid">
                            <c:forEach var="blog" items="${relatedPosts}">
                                <div class="related-post-item">
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