<%@ page import="entity.Voucher" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat" %>

<%
    Voucher voucher = (Voucher) request.getAttribute("voucher");
    boolean isEdit = voucher != null;
%>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" type="text/css" href="styles/bootstrap4/bootstrap.min.css">
        <title><%= isEdit ? "Chỉnh sửa" : "Thêm mới" %> Voucher</title>
        <style>
            .form-container {
                max-width: 800px;
                margin: 20px auto;
                padding: 30px;
                background: white;
                border-radius: 8px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            }
        </style>
    </head>
    <body>
        <div class="super_container">
            <header class="header">
                <!-- Same header as voucher-list.jsp -->
            </header>

            <div class="main-content">
                <div class="form-container">
                    <h2><%= isEdit ? "Chỉnh sửa Voucher" : "Thêm Voucher mới" %></h2>

                    <form action="VoucherController" method="post">
                        <% if (isEdit) { %>
                        <input type="hidden" name="id" value="<%= voucher.getVoucherID() %>">
                        <% } %>

                        <div class="form-group">
                            <label>Tên Voucher</label>
                            <input type="text" name="name" class="form-control" 
                                   value="<%= isEdit ? voucher.getVoucherName() : "" %>" required>
                        </div>

                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>Giảm giá (%)</label>
                                    <input type="number" name="discount" class="form-control" 
                                           value="<%= isEdit ? voucher.getDiscount() : "" %>" min="1" max="100" required>
                                </div>
                            </div>
                                           <div class="col-md-6">
                                               <div class="form-group">
                                                   <label>Giảm giá tối đa</label>
                                                   <input type="number" name="maxDiscount" class="form-control" 
                                                          value="<%= isEdit ? voucher.getMaxDiscount() : "" %>"  required>
                                               </div>
                                           </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>Số lượng</label>
                                    <input type="number" name="quantity" class="form-control" 
                                           value="<%= isEdit ? voucher.getQuantity() : "" %>" min="1" required>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>Ngày bắt đầu</label>
                                    <input type="date" name="startDate" class="form-control" 
                                           value="<%= isEdit ? new SimpleDateFormat("yyyy-MM-dd").format(voucher.getStartDate()) : "" %>" required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>Ngày kết thúc</label>
                                    <input type="date" name="endDate" class="form-control" 
                                           value="<%= isEdit ? new SimpleDateFormat("yyyy-MM-dd").format(voucher.getEndDate()) : "" %>" required>
                                </div>
                            </div>
                        </div>

                        <div class="form-group">
                            <label>Mô tả</label>
                            <textarea name="description" class="form-control" rows="3"><%= isEdit ? voucher.getDescription() : "" %></textarea>
                        </div>

                        <div class="form-group">
                            <label>Trạng thái</label>
                            <select name="status" class="form-control" required>
                                <option value="1" <%= isEdit && voucher.getStatus() == 1 ? "selected" : "" %>>Hoạt động</option>
                                <option value="0" <%= isEdit && voucher.getStatus() == 0 ? "selected" : "" %>>Không hoạt động</option>
                            </select>
                        </div>

                        <button type="submit" class="btn btn-primary">
                            <%= isEdit ? "Cập nhật" : "Thêm mới" %>
                        </button>
                        <a href="VoucherController" class="btn btn-secondary">Hủy</a>
                    </form>
                </div>
            </div>

            <script src="js/jquery-3.2.1.min.js"></script>
            <script src="styles/bootstrap4/bootstrap.min.js"></script>
        </div>
    </body>
</html>