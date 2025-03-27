<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
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
        <title>Thông tin tác giả</title>
        <style>
            * {
                box-sizing: border-box;
                margin: 0;
                padding: 0;
                font-family: 'Segoe UI', sans-serif;
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

            .blog-content {
                padding: 2.5rem;
                display: flex;
                flex-direction: column;
                align-items: center; /* Căn giữa theo chiều ngang */
                text-align: center; /* Căn giữa text */
            }

            .blog-content img {
                max-width: 500px; /* Tăng kích thước ảnh */
                width: 100%; /* Đảm bảo ảnh responsive */
                height: 20%;
                border-radius: 50%;
                margin-bottom: 1.5rem; /* Khoảng cách dưới ảnh */
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1); /* Thêm bóng nhẹ */
            }

            .blog-content h1 {
                font-size: 2rem;
                color: #2c3e50;
                margin-bottom: 1.5rem;
            }

            .blog-content p {
                font-size: 1.1rem;
                color: #34495e;
                margin: 0.5rem 0;
            }

            .blog-content a {
                color: #007bff;
                text-decoration: none;
                font-size: 1.1rem;
                margin-top: 1rem;
            }

            .blog-content a:hover {
                text-decoration: underline;
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

            /* Responsive Design */
            @media (max-width: 992px) {
                .content-wrapper {
                    grid-template-columns: 1fr; /* Xếp chồng trên màn nhỏ */
                }

                .sidebar-section {
                    margin-top: 0;
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

            <!-- Main Content and Sidebar Wrapper -->
            <div class="content-wrapper">
                <div class="blog-container">
                    <div class="main-content">
                        <!-- Nội dung chính -->
                        <div class="blog-content">
                            <h1>Thông tin tác giả</h1>
                            <c:choose>
                                <c:when test="${not empty author.image}">
                                    <img src="${author.image}" alt="Ảnh tác giả">
                                </c:when>
                                <c:otherwise>
                                    <img src="./P_images/Avatar.png" alt="Ảnh tác giả mặc định">
                                </c:otherwise>
                            </c:choose>
                            <p><strong>Tên:</strong> ${author.fullName}</p>
                            <p><strong>Giới tính:</strong> 
                                <c:choose>
                                    <c:when test="${author.gender == 'M'}">Nam</c:when>
                                    <c:when test="${author.gender == 'F'}">Nữ</c:when>
                                    <c:otherwise>${author.gender}</c:otherwise>
                                </c:choose>
                            </p>
                            <p><strong>Vai trò:</strong> ${author.role}</p>
                            <p><strong>Tham gia từ:</strong> ${author.createDate}</p>
                            <p><strong>Số bài viết:</strong> ${authorBlogCount}</p>
                            <a href="Blog?service=listAllBlogs">Quay lại</a>
                        </div>
                    </div>
                </div>

                <!-- Sidebar Section -->
                <div class="sidebar-section">
                    <div class="sidebar">
                        <h2>Top bài viết nổi bật</h2> 
                        <c:forEach var="blog" items="${topPosts}">
                            <div class="top-post-item">
                                <img src="${blog.blogThumbnail}" alt="${blog.blogTitle}">
                                <h3>${blog.blogTitle}</h3>
                            </div>
                        </c:forEach>                        
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>