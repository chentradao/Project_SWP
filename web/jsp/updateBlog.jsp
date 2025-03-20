<!DOCTYPE html>

<html lang="vi">
    <head><%@ page import="entity.Blog" %>
        <%@ page import="java.util.Vector" %>
        <%@page contentType="text/html" pageEncoding="UTF-8"%>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="description" content="Wish shop project">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" type="text/css" href="styles/bootstrap4/bootstrap.min.css">
        <link href="plugins/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
        <link rel="stylesheet" type="text/css" href="styles/cart.css">
        <link rel="stylesheet" type="text/css" href="styles/cart_responsive.css">
        <title>Quản lý bài viết</title>
                <script src="https://cdn.tiny.cloud/1/6djxe59qtpyo7xk3et7sh1jayfb6gg079a4kiqdoa06oqut4/tinymce/7/tinymce.min.js" referrerpolicy="origin"></script>

        <style>
            * {
                box-sizing: border-box;
                font-family: 'Segoe UI', sans-serif;
            }

            .card {
                max-width: 800px;
                margin: 2rem auto;
                padding: 80px;
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
            * {
                box-sizing: border-box;
                margin: 0;
                padding: 0;
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
        <header class="header">
                <div class="header_inner d-flex flex-row align-items-center justify-content-start">
                    <div class="logo"><a href="ProductListServlet">Estée Lauder</a></div>
                    <nav class="main_nav">
                        <ul>
                            <li><a href="index.jsp">Quản lý đơn hàng</a></li>
                            <li><a href="index.jsp">Quản lý kho hàng</a></li>
                            <li><a href="index.jsp">Quản lý nhân viên</a></li>
                            <li><a href="Blog?service=listAllBlogs">Quản lý bài đăng</a></li>
                        </ul>
                    </nav>
                    <div class="header_content ml-auto">

                        <div class="shopping">

                        </div>
                    </div>
                    <div class="nav-item dropdown">
                        <span class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            Tên tài khoản
                        </span>
                        <div id="collapsePages" class="dropdown-menu bg-white py-2 collapse-inner rounded" aria-labelledby="navbarDropdown">
                            <a class="collapse-item" href="manager.html">Thông tin tài khoản</a>
                            <a class="collapse-item" href="blank.html">Đăng xuất</a>
                        </div>
                    </div>
                </div>
            </header>
        <%      
            Vector<Blog> blogList = (Vector<Blog>) request.getAttribute("selectedBlog");
            for (Blog blog : blogList) {
        %>

        <!-- Show update form -->
        <div class="card">
            <form action="Blog" method="post" enctype="multipart/form-data">
                <input type="hidden" name="service" value="updateBlog">
                
                <input type="hidden" id="blogID" name="blogID" value="<%=blog.getBlogID()%>">
                <div class="title">
                    <label>Tiêu đề:</label>
                    <input type="text" id="blogTitle" name="blogTitle" required value="<%=blog.getBlogTitle()%>">
                </div>

                <div class="meta-info">
                    <div class="meta-item">
                        Tác giả:
                        <input type="number" id="blogAuthor" name="blogAuthor" required value="<%=blog.getBlogAuthor()%>">

                    </div>
                    <div class="meta-item">
                        Danh mục: <select id="blogCategoryID" name="blogCategoryID" required value="<%=blog.getBlogCategoryID()%> ">
                            <option value="1">Làm đẹp</option>
                            <option value="2">Bảo vệ môi trường</option>
                            <option value="3">Sức khỏe</option>
                        </select>
                    </div>
                    <div class="meta-item">
                        Ngày đăng: <%=blog.getDate()%>
                    </div>
                    <div class="meta-item">
                        Trạng thái: <select id="blogStatus" name="blogStatus" required value="<%=blog.getBlogStatus()%>">
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
                </div>
                <div class="content">
                    Mô tả 
                    <textarea id="blogDescription" name="blogDescription" rows="7" cols="100"><%= blog.getBlogDescription() %></textarea>
                </div>
                <button type="submit" class="btn btn-update" name="submit" value="updateBlog">Luu Blog</button>
            </form>
        </div>
        <%     }
        %>
        <script>
    document.addEventListener("DOMContentLoaded", function () {
        tinymce.init({
            selector: "textarea#blogDescription",
            height: 300,
            menubar: false,
            plugins: [
                "advlist autolink lists link image charmap preview",
                "searchreplace visualblocks code fullscreen",
                "insertdatetime media table paste code help wordcount"
            ],
            toolbar:
                "undo redo | formatselect | bold italic backcolor | \
                alignleft aligncenter alignright alignjustify | \
                bullist numlist outdent indent | removeformat | help",
            branding: false,
            setup: function (editor) {
                editor.on('init', function () {
                    console.log("TinyMCE đã khởi động!");
                });
            }
        });
    });
</script>

        <script>
            document.addEventListener("DOMContentLoaded", function () {
                const fileInput = document.querySelector("input[name='blogThumbnail']");
                fileInput.addEventListener("change", function () {
                    const file = this.files[0];
                    if (file) {
                        const fileName = file.name.toLowerCase();
                        if (!fileName.endsWith(".jpg") && !fileName.endsWith(".jpeg") && !fileName.endsWith(".png")) {
                            alert("Chỉ chấp nhận file ảnh .jpg, .jpeg, .png!");
                            this.value = ""; // Xóa file đã chọn
                        }
                    }
                });
            });
        </script>

        <script>
            document.addEventListener("DOMContentLoaded", function () {
                const form = document.querySelector("form");
                form.addEventListener("submit", function (event) {
                    const blogTitle = document.getElementById("blogTitle").value.trim();
                    const blogDescription = tinymce.get("blogDescription").getContent({ format: 'text' }).trim();

                    if (blogTitle === "" || blogDescription === "") {
                        alert("Tiêu đề và Mô tả không được để trống hoặc chỉ chứa khoảng trắng!");
                        event.preventDefault(); // Ngăn form gửi đi
                    }
                });
            });
        </script>
        
        <script>
    document.addEventListener("DOMContentLoaded", function () {
        const form = document.querySelector("form");
        form.addEventListener("submit", function () {
            tinymce.triggerSave(); // Đồng bộ nội dung TinyMCE vào textarea trước khi submit
        });
    });
</script>

    </body>
</html>