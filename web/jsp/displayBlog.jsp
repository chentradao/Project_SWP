<%@ page import="entity.Blog" %>
<%@ page import="java.util.Vector" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Display Blog</title>
        <link rel="stylesheet" type="text/css" href="styles/bootstrap4/bootstrap.min.css">
        <link href="plugins/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
        <link rel="stylesheet" type="text/css" href="styles/cart.css">
        <link rel="stylesheet" type="text/css" href="styles/cart_responsive.css">
        <script src="https://cdn.tiny.cloud/1/6djxe59qtpyo7xk3et7sh1jayfb6gg079a4kiqdoa06oqut4/tinymce/7/tinymce.min.js" referrerpolicy="origin"></script>

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

            .blog-container {
                padding-top: 80px;
                max-width: 1200px;
                margin: 0 auto;
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
                display: grid;
                grid-template-columns: 1fr;
                gap: 3rem;
            }

            .blog-description {
                font-size: 1.1rem;
                color: #34495e;
                max-width: 800px;
                margin: 0 auto;
            }

            .main-image {
                width: 100%;
                border-radius: 12px;
                margin: 2.5rem 0;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            }

            .action-buttons {
                display: flex;
                gap: 1.5rem;
                margin-top: 2rem;
                flex-wrap: wrap;
            }

            .btn {
                padding: 0.8rem 1.8rem;
                border: none;
                border-radius: 8px;
                cursor: pointer;
                font-weight: 600;
                transition: all 0.3s ease;
                text-decoration: none;
                display: inline-flex;
                align-items: center;
                gap: 0.5rem;
                font-size: 0.95rem;
            }

            .btn-update {
                background: #3498db;
                color: white;
            }

            .btn-delete {
                background: #e74c3c;
                color: white;
            }

            .btn:hover {
                transform: translateY(-2px);
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
                opacity: 0.95;
            }

            /* Responsive Design */
            @media (max-width: 992px) {
                .blog-thumbnail {
                    height: 400px;
                }
            }

            @media (max-width: 768px) {
                body {
                    padding: 1rem;
                }

                .blog-header {
                    padding: 1.5rem;
                }

                .blog-title {
                    font-size: 2rem;
                }

                .blog-thumbnail {
                    height: 300px;
                }

                .blog-content {
                    padding: 1.5rem;
                }

                .blog-description {
                    font-size: 1rem;
                }
            }

            @media (max-width: 480px) {
                .blog-title {
                    font-size: 1.6rem;
                }

                .blog-meta {
                    gap: 1rem;
                }

                .blog-meta span {
                    font-size: 0.85rem;
                    padding: 0.4rem 0.8rem;
                }

                .btn {
                    padding: 0.7rem 1.5rem;
                    width: 100%;
                    justify-content: center;
                }
            }
            #homePageButton {
                top: 10px;
                left: 10px;
                padding: 10px 20px;
                background-color: #4CAF50; /* Màu nền nút */
                color: white; /* Màu chữ */
                text-decoration: none; /* Loại bỏ gạch chân */
                border: none;
                border-radius: 5px;
                cursor: pointer;
                font-size: 16px;
                display: inline-block;
                text-align: center;
            }

            
            #homePageButton {
                background-color: #45a049;
            }
            .container {
                display: flex;
                gap: 20px;
                padding: 20px;
            }
        </style>
    </head>
    <body>
        <div class="container">
        <%      
            Vector<Blog> blogList = (Vector<Blog>) request.getAttribute("blog");
            for (Blog blog : blogList) {
        %>

        <header class="header">
                <div class="header_inner d-flex flex-row align-items-center justify-content-start">
                    <div class="logo"><a href="index.jsp">Estée Lauder</a></div>
                    <nav class="main_nav">
                        <ul>
                            <li><a href="manager">Quản lý đơn hàng</a></li>
                            <li><a href="index.jsp">Quản lý kho hàng</a></li>
                            <li><a href="index.jsp">Quản lý nhân viên</a></li>
                            <li><a href="BlogManager?service=listAllBlogs">Quản lý bài đăng</a></li>
                        </ul>
                    </nav>
                    <div class="header_content ml-auto">


                    </div>
                    <div class="nav-item dropdown no-arrow">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            Tên tài khoản
                        </a>
                        <div id="collapsePages" class="dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="userDropdown">
                            <a class="collapse-item" href="manager.html">Thông tin tài khoản</a>
                            <a class="collapse-item" href="blank.html">Đăng xuất</a>
                        </div>
                    </div>
                </div>
            </header>
        <div class="blog-container">
            <a href="BlogManager?service=listAllBlogs" id="homePageButton">Trang chủ</a>
            <!-- Header -->
            <div class="blog-header">
                <h1 class="blog-title"><%=blog.getBlogTitle()%></h1>
                <div class="blog-meta">
                    <span>📝 Đăng bởi: <%=blog.getBlogAuthor()%></span>
                    <span>📁 Danh mục: <%=blog.getBlogCategoryID()%></span>
                    <span>📅 Ngày đăng: <%=blog.getDate()%></span>
                </div>
            </div>

            <!-- Thumbnail -->
            <img src="<%=blog.getBlogThumbnail()%>" alt="Thumbnail" class="blog-thumbnail">

            <!-- Nội dung chính -->
            <div class="blog-content">
                <!-- Mô tả -->
                <div class="blog-description">
                    <p><%=blog.getBlogDescription()%></p>
                </div>

                <div class="action-buttons">
                    <a href="BlogManager?service=updateBlog&blogID=<%=blog.getBlogID()%>" class="btn btn-update">✏️ Cập nhật</a>
                    <a href="BlogManager?service=deleteBlog&blogID=<%=blog.getBlogID()%>" class="btn btn-delete">🗑️ Xóa bài</a>
                </div>
            </div>
        </div>
        <%     }
        %>
        </div>
    </body>
</html>