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
        <link rel="stylesheet" type="text/css" href="styles/bootstrap4/bootstrap.min.css">
        <link href="plugins/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
        <link rel="stylesheet" type="text/css" href="plugins/OwlCarousel2-2.2.1/owl.carousel.css">
        <link rel="stylesheet" type="text/css" href="plugins/OwlCarousel2-2.2.1/owl.theme.default.css">
        <link rel="stylesheet" type="text/css" href="plugins/OwlCarousel2-2.2.1/animate.css">
        <link href="plugins/colorbox/colorbox.css" rel="stylesheet" type="text/css">
        <link rel="stylesheet" type="text/css" href="styles/main_styles.css">
        <link rel="stylesheet" type="text/css" href="styles/responsive.css">
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
            <%@ include file="AminHeader.jsp" %>

            <div class="main-content mt-5">
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
                                <th>Giảm giá tối đa</th>
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
                                <td><%= voucher.getVoucherID() %></td>
                                <td><%= voucher.getVoucherName() %></td>
                                <td><%= voucher.getDiscount() %>%</td>
                                 <td><%= voucher.getMaxDiscount() %></td>
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
                                    <%= voucher.getStatus() == 1 ? "Hoạt động" : (voucher.getStatus() == 2 ? "Riêng tư" : "Không hoạt động") %>
                                </td>
                                <td>
                                    <a href="VoucherController?action=edit&id=<%= voucher.getVoucherID() %>" 
                                       class="btn btn-sm btn-warning">
                                        <i class="fa fa-edit"></i>
                                    </a>
                                    <a href="VoucherController?action=delete&id=<%= voucher.getVoucherID() %>" 
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