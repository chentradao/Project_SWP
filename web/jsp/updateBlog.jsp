<html lang="vi">
    <head><%@ page import="entity.Blog" %>
        <%@ page import="java.util.Vector" %>
        <%@page contentType="text/html" pageEncoding="UTF-8"%>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Quản lý bài viết</title>
        <style>
            * {
                box-sizing: border-box;
                font-family: 'Segoe UI', sans-serif;
            }

            .card {
                max-width: 800px;
                margin: 2rem auto;
                padding: 2rem;
                border-radius: 12px;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                background: white;
            }

            .title {
                font-size: 2rem;
                color: #2c3e50;
                margin-bottom: 1.5rem;
                border-bottom: 3px solid #3498db;
                padding-bottom: 0.5rem;
            }

            .meta-info {
                display: flex;
                gap: 2rem;
                margin-bottom: 1.5rem;
                padding: 1rem;
                background: #f8f9fa;
                border-radius: 8px;
            }

            .meta-item {
                display: flex;
                align-items: center;
                gap: 0.5rem;
                color: #7f8c8d;
            }

            .content {
                color: #34495e;
                line-height: 1.6;
                margin: 1.5rem 0;
                padding: 1rem;
                background: #f8f9fa;
                border-radius: 8px;
            }

            .action-buttons {
                display: flex;
                gap: 1rem;
                margin-top: 2rem;
            }

            .btn {
                padding: 0.8rem 1.5rem;
                border: none;
                border-radius: 6px;
                cursor: pointer;
                font-weight: 500;
                transition: 0.3s;
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
                opacity: 0.9;
                transform: translateY(-2px);
            }
            .thumbnail {
                position: relative;
                border-radius: 12px;
                overflow: hidden;
                box-shadow: 0 3px 6px rgba(0, 0, 0, 0.1);
                transition: all 0.3s ease;
                background: #f8f9fa;
                cursor: pointer;
            }


            .upload-overlay {
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(0, 0, 0, 0.5);
                display: none;
                align-items: center;
                justify-content: center;
                flex-direction: column;
                color: white;
            }

            .thumbnail:hover .upload-overlay {
                display: flex;
            }

            .upload-label {
                position: relative;
                width: 100%;
                height: 100%;
            }

            .upload-icon {
                font-size: 1.5rem;
                margin-bottom: 0.5rem;
            }

            .file-input {
                position: absolute;
                opacity: 0;
                width: 100%;
                height: 100%;
                cursor: pointer;
                top: 0;
                left: 0;
            }

            .preview-image {
                width: 100%;
                height: 100%;
                object-fit: cover;
                object-position: center;
                transition: opacity 0.3s ease;
            }

            .thumbnail:hover .preview-image {
                opacity: 0.8;
            }

            .upload-instruction {
                text-align: center;
                padding: 0 1rem;
                font-size: 0.9rem;
            }

            @media (max-width: 480px) {
                .thumbnail-section {
                    grid-template-columns: repeat(auto-fill, minmax(150px, 1fr));
                    gap: 1rem;
                }
            }
        </style>
    </head>
    <body>
        <%      
            Vector<Blog> blogList = (Vector<Blog>) request.getAttribute("selectedBlog");
            for (Blog blog : blogList) {
        %>

        <!-- Show update form -->
        <div class="card">
            <form action="Blog" method="post" enctype="multipart/form-data">
                <input type="hidden" name="service" value="updateBlog">
                <h3 id="formTitle">Chỉnh sửa Blog</h3>
                <input type="hidden" id="blogID" name="blogID" value="<%=blog.getBlogID()%>">
                <div class="title">
                    <label>Tiêu đề:</label>
                    <input type="text" id="blogTitle" name="blogTitle" required value="<%=blog.getBlogTitle()%>">
                </div>

                <div class="meta-info">
                    <div class="meta-item">
                        Tac gia:
                        <input type="number" id="blogAuthor" name="blogAuthor" required value="<%=blog.getBlogAuthor()%>">

                    </div>
                    <div class="meta-item">
                        Danh muc: <select id="blogCategory" name="blogCategory" required value="<%=blog.getBlogCategory()%> ">
                            <option value="1">Công nghệ</option>
                            <option value="2">Giáo dục</option>
                            <option value="3">Giải trí</option>
                        </select>
                    </div>
                    <div class="meta-item">
                        Ngay dang: <%=blog.getDate()%>
                    </div>
                    <div class="meta-item">
                        Trang thai: <select id="blogStatus" name="blogStatus" required value="<%=blog.getBlogStatus()%>">
                            <option value="1">Đang chờ</option>
                            <option value="2">Đã đăng</option>
                            <option value="3">Đã ẩn</option>
                        </select>
                    </div>
                </div>
                <div class="thumbnail-section">
                    <div class="thumbnail">
                        <img src="<%=blog.getBlogThumbnail()%>" alt="Thumbnail" class="blog-thumbnail">
                        <input type="file" name="blogThumbnail">
                    </div>
                    <div class="thumbnail">
                        <img src="<%=blog.getImage()%>" alt="Thumbnail" class="main-image">
                        <input type="file" name="image">
                    </div>
                </div>
                <div class="content">
                    Blog Description
                    <textarea id="blogDescription" name="blogDescription" rows="3" value="<%=blog.getBlogDescription()%>"></textarea>
                </div>
                <button type="submit" class="btn btn-update" name="submit" value="updateBlog">Luu Blog</button>
            </form>
        </div>
        <%     }
        %>
    </body>
</html>