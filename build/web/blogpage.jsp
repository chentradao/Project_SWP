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
                padding: 100px;
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

            <<header class="header">
                <div class="header_inner d-flex flex-row align-items-center justify-content-start">
                    <div class="logo"><a href="index.jsp">Estée Lauder</a></div>
                    <nav class="main_nav">
                        <ul>
                            <li><a href="index.jsp">Quản lý đơn hàng</a></li>
                            <li><a href="index.jsp">Quản lý kho hàng</a></li>
                            <li><a href="index.jsp">Quản lý nhân viên</a></li>
                            <li><a href="Blog?service=listAllBlogs">Quản lý bài đăng</a></li>
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


            <!-- Main Content -->
            <div class="main-content">
                <h1>Danh sách bài viết</h1>

                <!-- Nút thêm bài viết & xuất Excel -->
                <div class="button-container">
                    <button onclick="location.href = 'addBlog.jsp'">Thêm bài viết</button>
                    <button onclick="exportToExcel()">Xuất ra Excel</button>
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
                            <option value="2" ${param.filterCategory == '2' ? 'selected' : ''}>Môi trường</option>
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
                            <img src="<%= blog.getBlogThumbnail() %>" class="post-image">
                        </div>
                        <div class="col-11">
                            <div class="col-12">
                                <h3><a href="Blog?service=displayBlog&id=<%=blog.getBlogID()%>"><%= blog.getBlogTitle() %></a></h3>
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
            <script src="js/jquery-3.2.1.min.js"></script>
            <script src="styles/bootstrap4/popper.js"></script>
            <script src="styles/bootstrap4/bootstrap.min.js"></script>
            <script src="plugins/easing/easing.js"></script>
            <script src="plugins/parallax-js-master/parallax.min.js"></script>
            <script src="js/cart_custom.js"></script>
    </body>
</html>