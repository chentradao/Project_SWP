<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="description" content="">
    <meta name="author" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" href="styles/bootstrap4/bootstrap.min.css">
    <link href="plugins/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" type="text/css" href="styles/cart.css">
    <link rel="stylesheet" type="text/css" href="styles/cart_responsive.css">
    <title>Dashboard Quản lý đơn hàng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            padding: 20px;
        }
        .dashboard-container {
            max-width: 1200px;
            margin: 0 auto;
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        h1 {
            color: #2c3e50;
            text-align: center;
            margin-bottom: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #007bff;
            color: white;
        }
        tr:hover {
            background-color: #f1f1f1;
        }
        .sort-link {
            color: white;
            text-decoration: none;
        }
        .sort-link:hover {
            color: #f1f1f1;
        }
    </style>
</head>
<body id="page-top">
    <%@ include file="AminHeader.jsp" %>
    <div class="dashboard-container">
        <h1>Dashboard Quản lý đơn hàng</h1>
        <table>
            <thead>
                <tr>
                    <th>
                        Mã đơn hàng 
                        <a href="OrderManagementServlet?action=order&sortBy=orderID&sortOrder=asc" class="sort-link">▲</a>
                        <a href="OrderManagementServlet?action=order&sortBy=orderID&sortOrder=desc" class="sort-link">▼</a>
                    </th>
                    <th>Tên khách hàng</th>
                    <th>Địa chỉ</th>
                    <th>Mã GHTK</th>
                    <th>
                        Ngày giao 
                        <a href="OrderManagementServlet?action=order&sortBy=shippedDate&sortOrder=asc" class="sort-link">▲</a>
                        <a href="OrderManagementServlet?action=order&sortBy=shippedDate&sortOrder=desc" class="sort-link">▼</a>
                    </th>
                    <th>Trạng thái</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="order" items="${vectorOrder}">
                    <tr>
                        <td>${order.orderID}</td>
                        <td>${order.customerName}</td>
                        <td>${order.shipAddress}</td>                        
                        <td>${order.orderCode}</td>
                        <td>
    <c:choose>
        <c:when test="${order.shippedDate != null}">${order.shippedDate}</c:when>
        <c:otherwise>Chưa giao</c:otherwise>
    </c:choose>
</td>
                        <td>
                            <c:choose>
                                <c:when test="${order.orderStatus == 1}">Đang lấy hàng</c:when>
                                <c:when test="${order.orderStatus == 2}">Đang giao hàng</c:when>
                                <c:when test="${order.orderStatus == 3}">Đã giao thành công</c:when>
                                <c:when test="${order.orderStatus == 4}">Giao hàng thất bại</c:when>
                                <c:when test="${order.orderStatus == 5}">Đang hoàn hàng</c:when>
                                <c:when test="${order.orderStatus == 6}">Đã hoàn hàng</c:when>
                                <c:when test="${order.orderStatus == 7}">Hủy đơn hàng</c:when>
                                <c:when test="${order.orderStatus == 8}">Chờ xác nhận</c:when>
                                <c:otherwise>Không xác định</c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
            
            <!-- Phần phân trang -->
                        <div class="pagination mt-4 d-flex justify-content-center align-items-center">
                            <c:set var="pageSize" value="10" />
                            <c:set var="currentPage" value="${param.page != null ? param.page : 1}" />
                            <c:set var="totalPages" value="${(orderList.size() + pageSize - 1) / pageSize}" />

                            <c:if test="${currentPage > 1}">
                                <a href="manager?page=${currentPage - 1}" class="btn btn-outline-primary mx-1">Trước</a>
                            </c:if>

                            <c:forEach begin="1" end="${totalPages}" var="i">
                                <c:choose>
                                    <c:when test="${i == currentPage}">
                                        <span class="btn btn-primary mx-1">${i}</span>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="manager?page=${i}" class="btn btn-outline-primary mx-1">${i}</a>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>

                            <c:if test="${currentPage < totalPages}">
                                <a href="manager?page=${currentPage + 1}" class="btn btn-outline-primary mx-1">Sau</a>
                            </c:if>

                            <span class="ml-3">
                                Trang ${currentPage} / ${totalPages} 
                                (Tổng ${vectorOrder.size()} đơn hàng)
                            </span>
                        </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>