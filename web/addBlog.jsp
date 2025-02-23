<%-- 
    Document   : addBlog
    Created on : Feb 18, 2025, 9:11:02 PM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="description" content="Wish shop project">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" type="text/css" href="styles/bootstrap4/bootstrap.min.css">
        <link href="plugins/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
        <link rel="stylesheet" type="text/css" href="styles/cart.css">
        <link rel="stylesheet" type="text/css" href="styles/cart_responsive.css">
    </head>
    <body>
        <div class="container">
            <header class="header">
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

            <!-- Form thêm blog -->
            <div class="main-content">
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
                        <div class="toolbar">
                            <button onclick="formatText('bold')"><b>B</b></button>
                            <button onclick="formatText('italic')"><i>I</i></button>
                            <button onclick="formatText('underline')"><u>U</u></button>
                            <button onclick="formatText('strikeThrough')">S</button>
                        </div>
                        <textarea id="textArea"></textarea>

                    </div>

                    <div class="form-group">
                        <label>Thumbnail:</label>
                        <input type="file" id="blogThumbnail" name="blogThumbnail" required>
                    </div>

                    <div class="form-group">
                        <label>Danh mục:</label>
                        <select id="blogCategory" name="blogCategoryID" required>
                            <option value="1">Làm đẹp</option>
                            <option value="2">Môi trường</option>
                            <option value="3">Sức khỏe</option>
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
        </div>

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
        </style>

       <script>
        function formatText(command) {
            document.execCommand(command, false, null);
        }
    </script>
    </body>
</html>
