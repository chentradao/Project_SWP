<%@ page import="entity.Blog" %>
<%@ page import="java.util.Vector" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Quản lý Blog</title>
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

            /* Sidebar */
            .sidebar {
                width: 300px;
                background-color: #fff;
                padding: 20px;
                box-shadow: 2px 0 5px rgba(0,0,0,0.1);
                display: flex;
                flex-direction: column;
                gap: 15px;
            }

            .crud-actions {
                display: flex;
                flex-direction: column;
                gap: 10px;
            }

            .crud-btn {
                padding: 12px;
                background-color: #4CAF50;
                color: white;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                transition: background-color 0.3s;
            }

            .crud-btn:hover {
                background-color: #45a049;
            }

            .task-form {
                display: none;
                flex-direction: column;
                gap: 15px;
            }

            .form-group {
                display: flex;
                flex-direction: column;
                gap: 5px;
            }

            input, select, textarea {
                padding: 10px;
                border: 1px solid #ddd;
                border-radius: 4px;
                font-size: 14px;
            }

            /* Main content */
            .main-content {
                flex: 1;
                padding: 20px;
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

            .blog-detail {
                background-color: white;
                padding: 20px;
                border-radius: 6px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
                display: none;
            }

            .selected {
                background-color: #f0f9ff;
                border: 2px solid #3498db;
            }
        </style>
    </head>
    <body>
        <!-- Sidebar -->
        <div class="sidebar">
            <div class="crud-actions">
                <button class="crud-btn" onclick="showForm('add')">Thêm Blog</button>
            </div>

            <!-- Add Form -->
            <form action="Blog?service=add" method="post" enctype="multipart/form-data">
                <input type="hidden" name="service" value="add">
                <h3 id="formTitle">Thêm Blog mới</h3>
                <input type="hidden" id="blogID" name="blogID">
                <div class="form-group">
                    <label>Tiêu đề:</label>
                    <input type="text" id="blogTitle" name="blogTitle" required>
                </div>
                <div class="form-group">
                    <label>Mô tả:</label>
                    <textarea id="blogDescription" name="blogDescription" rows="3"></textarea>
                </div>
                <div class="form-group">
                    <label>Thumbnail:</label>
                    <input type="file" id="blogThumbnail" name="blogThumbnail" required>
                </div>
                <div class="form-group">
                    <label>Danh mục:</label>
                    <select id="blogCategory" name="blogCategory" required>
                        <option value="1">Công nghệ</option>
                        <option value="2">Giáo dục</option>
                        <option value="3">Giải trí</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>Tác giả:</label>
                    <input type="number" id="blogAuthor" name="blogAuthor" required>
                </div>

                <div class="form-group">
                    <label>Ảnh:</label>
                    <input type="file" id="image" name="image" required>
                </div>
                <div class="form-group">
                    <label>Trạng thái:</label>
                    <select id="blogStatus" name="blogStatus" required>
                        <option value="1">Đang chờ</option>
                        <option value="2">Đã đăng</option>
                        <option value="3">Đã ẩn</option>
                    </select>
                </div>
                <button type="submit" class="crud-btn" name="submit" value="add">Lưu Blog</button>
            </form>
        </div>

        <!-- Main Content -->
        <div class="main-content">
            <h1>Danh sách Blog</h1>
            
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
                        <option value="1" ${param.filterCategory == '1' ? 'selected' : ''}>Công nghệ</option>
                        <option value="2" ${param.filterCategory == '2' ? 'selected' : ''}>Giáo dục</option>
                        <option value="3" ${param.filterCategory == '3' ? 'selected' : ''}>Giải trí</option>
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
                    <h3><a href="Blog?service=displayBlog&id=<%=blog.getBlogID()%>"><%= blog.getBlogTitle() %></a></h3>
                    <p><%= blog.getBlogDescription() %></p>
                    <p>Ngày đăng: <%= blog.getDate() %></p>

                </div>
                <% 
                        }
                    }
                %>
            </div>
        </div>

    </body>
</html>