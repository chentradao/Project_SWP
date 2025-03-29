<%-- 
    Document   : OrderDetail
    Created on : Mar 23, 2025, 11:57:55 PM
    Author     : nguye
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="entity.Accounts,java.sql.ResultSet,java.util.Vector,entity.Order,entity.OrderDetail" %>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.DecimalFormatSymbols"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Chi tiết đơn hàng</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="description" content="Wish shop project">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" type="text/css" href="styles/bootstrap4/bootstrap.min.css">
        <link href="plugins/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
        <link rel="stylesheet" type="text/css" href="plugins/OwlCarousel2-2.2.1/owl.carousel.css">
        <link rel="stylesheet" type="text/css" href="plugins/OwlCarousel2-2.2.1/owl.theme.default.css">
        <link rel="stylesheet" type="text/css" href="plugins/OwlCarousel2-2.2.1/animate.css">
        <link href="plugins/colorbox/colorbox.css" rel="stylesheet" type="text/css">
        <link rel="stylesheet" type="text/css" href="styles/main_styles.css">
        <link rel="stylesheet" type="text/css" href="styles/OrderDetail.css">
        <link rel="stylesheet" type="text/css" href="styles/responsive.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
    </head>
    <body>
        <%
            Vector<Order> vector = (Vector<Order>) request.getAttribute("vector");
            Accounts acc = (Accounts)request.getAttribute("acc");
            DecimalFormatSymbols symbols = new DecimalFormatSymbols();
            symbols.setGroupingSeparator('.');
            DecimalFormat formatter = new DecimalFormat("#,###", symbols);
        %>
        <!-- Header -->

        <%@ include file="/header.jsp" %>

        <!-- Menu -->

        <%@ include file="/menu.jsp" %>

        <!-- Home -->
        <div class="container ">
            <%
                        for (Order order : vector) {
            %>
            <div class="order-container mt-5 pt-20">
                <div class="order-header">
                    <%if(acc != null){%>
                    <a href="OrderHistoryURL?service=orderHistory" class="px-3 py-1 rounded border border-gray-300 text-gray-600 hover:bg-gray-50">
                        <i class="fas fa-chevron-left mr-1"></i> Trở Về
                    </a>
                    <%}%>
                    <div class="fs-3">Chi tiết đơn hàng</div>
                    <% if (order.getOrderStatus() == 1) { %>
                    <span class=" px-4 py-3 text-gray-800">Đang Chờ</span>
                    <% } else if (order.getOrderStatus() == 2) { %>
                    <span class="px-4 py-3 text-green-800">Vận Chuyển</span>
                    <% } else if (order.getOrderStatus() == 3) { %>
                    <span class="px-4 py-3 text-green-800">Hoàn Thành</span>
                    <% } else if (order.getOrderStatus() == 0) { %>
                    <span class="px-4 py-3 text-red-800">Đã Hủy</span>
                    <% } %>
                </div>
                <p class="text-dark"><strong>Mã đơn hàng:</strong> <%=order.getOrderID()%></p>
                <p class="text-dark"><strong>Thời gian:</strong> <%=order.getOrderDate()%></p>
                <p class="text-dark"><strong>Phương thức thanh toán:</strong> <%=order.getPaymentMethod()%></p>
                <hr>
                <%
                    int total = 0;
                    for (OrderDetail detail : order.getOrderDetail()) {
                    int subtotal =detail.getUnitPrice() * detail.getQuantity();
                    total += subtotal;
                %>
                <div class="order-item">
                    <img src="<%=detail.getImage()%>" alt="Double Wear Foundation">
                    <div class="order-item-details">
                        <a href="<%= request.getContextPath() %>/ProductDetail?productId=<%= detail.getProductID() %>">
                        <p class="mb-1"><strong><%=detail.getProductName()%></strong></p>
                        </a>
                        <p><% if (detail.getColor() != null) { %>
                            <span>Màu: <%=detail.getColor()%></span>
                            <% } %>
                            <% if (detail.getSize() != null) { %>
                            <span> | Size: <%=detail.getSize()%></span>
                            <% } %></p>
                        <p>Số lượng: <%=detail.getQuantity()%></p>
                        <p><%=formatter.format(detail.getUnitPrice())%>đ</p>
                    </div>
                    <strong class="text-dark"><%=formatter.format(subtotal)%>đ</strong>
                </div>
                <%}%>
                <hr>
                <div class="customer-info">
                    <h3 class="text-lg font-semibold"><i class="fa-solid fa-money-bill"></i> Thông tin thanh toán</h3>
                </div>
                <table class="order-summary">
                    <tr>
                        <th>Tổng tiền sản phẩm</th>
                        <td><%=formatter.format(total)%>đ</td>
                    </tr>
                    <tr>
                        <th>Giảm giá</th>
                        <td><%=formatter.format(order.getDiscount())%>đ</td>
                    </tr>
                    <tr>
                        <th>Phí vận chuyển</th>
                        <td><%=formatter.format(order.getShippingFee())%>đ</td>
                    </tr>
                    <tr>
                        <th>Thành Tiền</th>
                        <td class=""><%=formatter.format(order.getTotalCost())%>đ</td>
                    </tr>
                    <tr>
                        <th>Đã thanh toán</th>
                            <%if(order.getPaymentMethod().equalsIgnoreCase("VNPAY") || order.getOrderStatus() == 3){%>
                        <td class="bold text-green-800"><strong><%= formatter.format(order.getTotalCost()) %>đ</strong></td>
                        <%}else if(order.getPaymentMethod().equalsIgnoreCase("COD")){%>
                        <td class="text-highlight">0đ</td>
                        <%}%>
                    </tr>
                </table>
                <hr>
                <div class="customer-info">
                    <div class="customer-details">
                        <h5>Thông tin khách hàng</h5>
                        <hr>
                        <p><i class="fa-solid fa-user-tie"></i> <strong><%=order.getCustomerName()%></strong></p>
                        <p><i class="fa-solid fa-phone"> </i> <%=order.getPhone()%></p>
                        <p> <i class="fa-solid fa-location-dot"></i> <%=order.getShipAddress()%></p>
                    </div>
                    <div class="customer-note">
                        <h5>Ghi chú</h5>
                        <hr>
                        <% if (order.getNote() != null && !order.getNote().trim().isEmpty()) { %>
                        <p><%= order.getNote() %></p>
                        <% } %>
                    </div>
                </div>
                <hr>
                <div class="mt-3">
                    <h5>Thông tin hỗ trợ</h5>
                    <p>📞 <span class="text-danger">(024) 7100 0267</span></p>
                    <p>🏠 267 Đường Quang Trung, P. Quang Trung, Q. Hà Đông</p>
                    <hr>
                    <div class="mt-3">
                        <%if(order.getOrderStatus() == 1){%>
                        <button
                            class="order_button_2"
                            onclick="window.open('https://zalo.me/0926310999', '_blank')">
                            Liên hệ với người bán 
                        </button>
                        <button type="button"
                                class="btn btn-outline-secondary"
                                data-orderid="<%=order.getOrderID()%>"
                                data-status="<%=order.getOrderStatus()%>"
                                onclick="checkStatusAndShowPopup('<%=order.getOrderID()%>', <%=order.getOrderStatus()%>)">
                            Hủy Đơn Hàng
                        </button>
                        <%}if(order.getOrderStatus() == 2){%>
                        <button
                            class="order_button_2"
                            onclick="window.open('https://zalo.me/0926310999', '_blank')">
                            Liên hệ với người bán 
                        </button>
                        <%}else if(order.getOrderStatus() == 3){%>
                        <button class="btn btn-custom">Đánh giá</button>
                        <button type="button" class="btn btn-outline-secondary" onclick="window.location.href = 'OrderHistoryURL?service=reOrder&oid=<%=order.getOrderID()%>'">Mua lại</button>
                        <%}else if(order.getOrderStatus() == 0){%>
                        <button
                            class="btn btn-outline-secondary">
                            Mua Lại
                        </button>
                        <%}%>
                    </div>
                </div>
            </div>
            <%}%>
        </div>
        <script src="js/jquery-3.2.1.min.js"></script>
        <script src="styles/bootstrap4/popper.js"></script>
        <script src="styles/bootstrap4/bootstrap.min.js"></script>
        <script src="plugins/easing/easing.js"></script>
        <script src="plugins/parallax-js-master/parallax.min.js"></script>
        <script src="js/cart_custom.js"></script>
    </body>
</html>

