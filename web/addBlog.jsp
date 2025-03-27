<%-- 
    Document   : addBlog
    Created on : Feb 18, 2025, 9:11:02 PM
    Author     : admin
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="description" content="Wish shop project">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" type="text/css" href="styles/bootstrap4/bootstrap.min.css">
        <link href="plugins/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
        <link rel="stylesheet" type="text/css" href="styles/cart.css">
        <link rel="stylesheet" type="text/css" href="styles/cart_responsive.css">
        <script src="https://cdn.tiny.cloud/1/6djxe59qtpyo7xk3et7sh1jayfb6gg079a4kiqdoa06oqut4/tinymce/7/tinymce.min.js" referrerpolicy="origin"></script>

    </head>
    <style>
            .container {
                display: flex;
                gap: 20px;
                padding: 20px;
            }


            .main-content {
                flex: 1;
                background: white;
                padding: 100px;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
            }

            .form-group {
                margin-bottom: 15px;
            }

            .form-group label {
                display: block;
                margin-bottom: 5px;
            }

            .form-group input,
            .form-group select,
            .form-group textarea {
                width: 100%;
                padding: 8px;
                border: 1px solid #ddd;
                border-radius: 4px;
            }

            .crud-btn {
                background: #4CAF50;
                color: white;
                padding: 10px 15px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                margin-bottom: 15px;
            }

            .toolbar {
                border: 1px solid #ccc;
                padding: 10px;
                background: #f9f9f9;
                margin-bottom: 10px;
            }

            .toolbar button {
                margin-right: 5px;
                padding: 5px 10px;
                cursor: pointer;
            }

            .editor {
                width: 100%;
                height: 400px;
                border: 1px solid #ccc;
                padding: 15px;
                overflow-y: auto;
            }
            #homePageButton {
                background-color: #45a049;
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
        </style>
    <body>
        <div class="container">
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
                        <div class="shopping"></div>
                    </div>
                </div>
            </header>

            <!-- Form thêm blog -->
            <div class="main-content">
                <form action="BlogManager" method="post" enctype="multipart/form-data"> 
                    <input type="hidden" name="service" value="add">
                    <a href="Blog?service=listAllBlogs" id="homePageButton">Trang chủ</a>
                    <div class="form-group">
                        <label>Tiêu đề:</label>
                        <input type="text" id="blogTitle" name="blogTitle" required>
                    </div>
                    <div class="form-group">
                        <label>Mô tả:</label>
                        <textarea id="blogDescription" name="blogDescription"></textarea>
                    </div>
                    <div class="form-group">
                        <label>Thumbnail:</label>
                        <input type="file" id="blogThumbnail" name="blogThumbnail" required>
                    </div>
                    <div class="form-group">
                        <label>Danh mục:</label>
                        <select id="blogCategory" name="blogCategoryID" required>
                            <option value="1">Làm đẹp</option>
                            <option value="2">Bảo vệ môi trường</option>
                            <option value="3">Sức khỏe</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Tác giả:</label>
                        <input type="number" id="blogAuthor" name="blogAuthor" required>
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
        </div>

        <script>
            tinymce.init({
                selector: '#blogDescription',
                language: 'vi',
                plugins: 'advlist autolink lists link image charmap print preview hr anchor pagebreak',
                toolbar_mode: 'floating',
                entity_encoding: "raw"
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
