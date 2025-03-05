<%@ page import="entity.Voucher" %>
<%@ page import="java.util.List" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <link rel="stylesheet" type="text/css" href="styles/bootstrap4/bootstrap.min.css">
        <link href="plugins/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet">
        <title>Quản lý Voucher</title>
        <style>
            .main-content {
                padding: 20px;
                background-color: #f9f9f9;
            }

            .table-container {
                background: white;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            }

            .status-active {
                color: green;
                font-weight: bold;
            }

            .status-inactive {
                color: red;
                font-weight: bold;
            }
        </style>
    </head>
    <body>
        <div class="super_container">
            <header class="header">
                <div class="header_inner d-flex flex-row align-items-center justify-content-start">
                    <div class="logo"><a href="index.jsp">Estée Lauder</a></div>
                    <nav class="main_nav">
                        <ul>
                            <li><a href="index.jsp">Quản lý đơn hàng</a></li>
                            <li><a href="index.jsp">Quản lý kho hàng</a></li>
                            <li><a href="index.jsp">Quản lý nhân viên</a></li>
                            <li><a href="VoucherController">Quản lý Voucher</a></li>
                        </ul>
                    </nav>
                    <!-- User dropdown -->
                </div>
            </header>

            <div class="main-content">
                <h1>Danh sách Voucher</h1>

                <div class="button-container mb-3">
                    <a href="VoucherController?action=create" class="btn btn-primary">
                        <i class="fa fa-plus"></i> Thêm Voucher
                    </a>
                </div>

                <div class="table-container">
                    <table class="table table-striped">
                        <thead class="thead-dark">
                            <tr>
                                <th>ID</th>
                                <th>Tên Voucher</th>
                                <th>Giảm giá (%)</th>
                                <th>Số lượng</th>
                                <th>Ngày bắt đầu</th>
                                <th>Ngày kết thúc</th>
                                <th>Trạng thái</th>
                                <th>Hành động</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (Voucher voucher : (List<Voucher>) request.getAttribute("vouchers")) { %>
                            <tr>
                                <td><%= voucher.getId() %></td>
                                <td><%= voucher.getName() %></td>
                                <td><%= voucher.getDiscount() %>%</td>
                                <td><%= voucher.getQuantity() %></td>
                                <td>
                                    <%= voucher.getStartDate() != null ? 
        new SimpleDateFormat("dd/MM/yyyy").format(voucher.getStartDate()) : "N/A" %>
                                </td>
                                <td>
                                    <%= voucher.getEndDate() != null ? 
        new SimpleDateFormat("dd/MM/yyyy").format(voucher.getEndDate()) : "N/A" %>
                                </td>
                                <td class="<%= voucher.getStatus() == 1 ? "status-active" : "status-inactive" %>">
                                    <%= voucher.getStatus() == 1 ? "Hoạt động" : "Không hoạt động" %>
                                </td>
                                <td>
                                    <a href="VoucherController?action=edit&id=<%= voucher.getId() %>" 
                                       class="btn btn-sm btn-warning">
                                        <i class="fa fa-edit"></i>
                                    </a>
                                    <a href="VoucherController?action=delete&id=<%= voucher.getId() %>" 
                                       class="btn btn-sm btn-danger"
                                       onclick="return confirm('Bạn có chắc chắn muốn xóa?')">
                                        <i class="fa fa-trash"></i>
                                    </a>
                                </td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>

            <script src="js/jquery-3.2.1.min.js"></script>
            <script src="styles/bootstrap4/popper.js"></script>
            <script src="styles/bootstrap4/bootstrap.min.js"></script>
        </div>
    </body>
</html>