<%@ page import="entity.Blog" %>
<%@ page import="java.util.Vector" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="description" content="Wish shop project">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" type="text/css" href="styles/bootstrap4/bootstrap.min.css">
        <link href="plugins/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
        <link rel="stylesheet" type="text/css" href="styles/cart.css">
        <link rel="stylesheet" type="text/css" href="styles/cart_responsive.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

        <title>Quản lý bài viết</title>
        <style>
            * {
                box-sizing: border-box;
                margin: 0;
                padding: 0;
            }

            body {
                font-family: 'Arial', sans-serif;
                background-color: #f5f5f5;
                display: flex;
                min-height: 100vh;
            }

            /* Main content */
            .main-content {
                flex: 1;
                padding: 180px;
                background-color: #f9f9f9;
                display: flex;
                flex-direction: column;
                gap: 20px;
            }

            .blog-list {
                display: grid;
                gap: 15px;
            }

            .blog-item {
                display: flex;
                background-color: white;
                padding: 15px;
                border-radius: 6px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
                cursor: pointer;
                transition: transform 0.2s;
            }

            .blog-item:hover {
                transform: translateY(-2px);
            }



            .selected {
                background-color: #f0f9ff;
                border: 2px solid #3498db;
            }
            .post-image {
                width: 80px;
                height: 80px;
                object-fit: cover;
                margin-right: 15px;
            }



        </style>
    </head>
    <body>

        <div class="super_container">
            <%@ include file="AminHeader.jsp" %>
            <!-- Main Content -->
            <div class="main-content">

                <h1>Danh sách bài viết</h1>

                <!-- Nút thêm bài viết & xuất Excel -->
                <div class="button-container">
                    <button onclick="location.href = 'addBlog.jsp'">Thêm bài viết</button>
                </div>
                <!-- Thêm phần lọc -->
                <div class="filter-section">
                    <form action="Blog" method="get" class="filter-group">
                        <input type="hidden" name="service" value="listAllBlogs">

                        <label class="filter-label">Sắp xếp theo:</label>
                        <select name="filterDate" class="filter-select">
                            <option value="newest" ${param.filterDate == 'newest' ? 'selected' : ''}>Mới nhất</option>
                            <option value="oldest" ${param.filterDate == 'oldest' ? 'selected' : ''}>Cũ nhất</option>
                        </select>

                        <label class="filter-label">Danh mục:</label>
                        <select name="filterCategory" class="filter-select">
                            <option value="all" ${param.filterCategory == 'all' ? 'selected' : ''}>Tất cả</option>
                            <option value="1" ${param.filterCategory == '1' ? 'selected' : ''}>Làm đẹp</option>
                            <option value="2" ${param.filterCategory == '2' ? 'selected' : ''}>Bảo vệ môi trường</option>
                            <option value="3" ${param.filterCategory == '3' ? 'selected' : ''}>Sức khỏe</option>
                        </select>

                        <button type="submit" class="filter-button">Lọc</button>
                    </form>
                </div>
                <div class="blog-list" id="blogList">
                    <%      
                        Vector<Blog> vectorBlog = (Vector<Blog>) request.getAttribute("vectorBlog");
                        if (vectorBlog != null) {
                            for (Blog blog : vectorBlog) {
                    %>
                    <div class="blog-item" onclick="selectBlog(<%= blog.getBlogID() %>)">
                        <div class="col-1">
                            <img src="<%= blog.getBlogThumbnail() %>" class="post-image" alt="<%= blog.getBlogThumbnail() %>">
                        </div>
                        <div class="col-11">
                            <div class="col-12">
                                <h3><a href="BlogManager?service=displayBlog&id=<%=blog.getBlogID()%>"><%= blog.getBlogTitle() %></a></h3>
                            </div>
                            <div class="col-12">
                                <p><%= blog.getBlogDescription() %></p>  
                            </div>
                            <div class="col-12">
                                <p>Ngày đăng: <%= blog.getDate() %></p>
                            </div>
                        </div>
                    </div>
                    <% 
                            }
                        }
                    %>
                </div>
            </div>
        </div>
        <script src="js/jquery-3.2.1.min.js"></script>
        <script src="styles/bootstrap4/popper.js"></script>
        <script src="styles/bootstrap4/bootstrap.min.js"></script>
        <script src="plugins/easing/easing.js"></script>
        <script src="plugins/parallax-js-master/parallax.min.js"></script>
        <script src="js/cart_custom.js"></script>



    </body>
</html>