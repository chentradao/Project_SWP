<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="entity.Accounts,java.sql.ResultSet,java.util.Vector,entity.Order,entity.OrderDetail" %>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.DecimalFormatSymbols"%>

<html>
    <head>
        <title>Order History</title>
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
        <link rel="stylesheet" type="text/css" href="styles/orderHistory.css">
        <link rel="stylesheet" type="text/css" href="styles/responsive.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />

    </head>


    <body class="bg-gray-50 min-h-screen">
        <%
            Vector<Order> vector = (Vector<Order>) request.getAttribute("vector");
            int currentPage = (Integer) request.getAttribute("currentPage");
            int totalPages = (Integer) request.getAttribute("totalPages");
            String status = (String) request.getAttribute("status");
            String sortColumn = (String) request.getAttribute("sortColumn");
            String sortOrder = (String) request.getAttribute("sortOrder");

            String service = request.getParameter("service") != null ? request.getParameter("service") : "orderHistory";
            String baseUrl = "OrderHistoryURL?service=" + service;
            if (sortColumn != null && !sortColumn.isEmpty()) baseUrl += "&sortColumn=" + sortColumn;
            if (sortOrder != null && !sortOrder.isEmpty()) baseUrl += "&sortOrder=" + sortOrder;
            if (status != null && !status.isEmpty()) baseUrl += "&status=" + status;

            DecimalFormatSymbols symbols = new DecimalFormatSymbols();
            symbols.setGroupingSeparator('.');
            DecimalFormat formatter = new DecimalFormat("#,###", symbols);
        %>

        <!-- Header -->
        <%@ include file="/header.jsp" %>

        <!-- Menu -->
        <%@ include file="/menu.jsp" %>

        <!-- Home -->
        <div class="container mx-auto px-4 py-8 flex items-start">
            <!-- Status Filter Buttons -->
            <div class="w-1/5 bg-white rounded-xl shadow-md p-5 h-full mt-20">
                <h3 class="text-lg font-semibold mb-4">Trạng thái đơn hàng</h3>
                <a href="OrderHistoryURL?service=orderHistory&status=" 
                   class="block w-full text-center m-2 px-4 py-2 rounded-lg <%= status == null || status.isEmpty() ? "bg-blue-500 text-white" : "bg-gray-200 text-gray-700 hover:bg-gray-300" %>">
                    Tất cả
                </a>
                <a href="OrderHistoryURL?service=orderHistory&status=1" 
                   class="block w-full text-center m-2 px-4 py-2 rounded-lg <%= "1".equals(status) ? "bg-blue-500 text-white" : "bg-gray-200 text-gray-700 hover:bg-gray-300" %>">
                    Đang Chờ
                </a>
                <a href="OrderHistoryURL?service=orderHistory&status=2" 
                   class="block w-full text-center m-2 px-4 py-2 rounded-lg <%= "2".equals(status) ? "bg-blue-500 text-white" : "bg-gray-200 text-gray-700 hover:bg-gray-300" %>">
                    Vận Chuyển
                </a>
                <a href="OrderHistoryURL?service=orderHistory&status=3" 
                   class="block w-full text-center m-2 px-4 py-2 rounded-lg <%= "3".equals(status) ? "bg-blue-500 text-white" : "bg-gray-200 text-gray-700 hover:bg-gray-300" %>">
                    Hoàn Thành
                </a>
                <a href="OrderHistoryURL?service=orderHistory&status=0" 
                   class="block w-full text-center m-2 px-4 py-2 rounded-lg <%= "0".equals(status) ? "bg-blue-500 text-white" : "bg-gray-200 text-gray-700 hover:bg-gray-300" %>">
                    Đã Hủy
                </a>
            </div>

            <!-- Main Content -->
            <div class="w-4/5 ml-6 bg-white rounded-xl shadow-lg overflow-hidden mt-20">
                <%
                        for (Order order : vector) {
                %>
                <div class="overflow-x-auto border-b mb-5">
                    <a href="#">
                    <div class="order-header p-4 border-b">
                        <span>ID đơn hàng: <%=order.getOrderID()%></span>
                        <span>Ngày tạo đơn: <%=order.getOrderDate()%></span>
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
                </a>
                    <!-- Hiển thị danh sách sản phẩm từ OrderDetail -->
                    <% for (OrderDetail detail : order.getOrderDetail()) {
                    int subtotal =detail.getUnitPrice() * detail.getQuantity();
                    %>
                    <div class="order-item p-3 flex items-center border-b">
                        <img src="<%=detail.getImage()%>" alt="Product" class="w-16 h-16 object-cover mr-4">
                        <div class="order-details flex-1">
                            <a href="<%= request.getContextPath() %>/ProductDetail?productId=<%= detail.getProductID() %>">
                                <p><%=detail.getProductName()%></p></a>
                            <div class="product-info text-sm text-gray-600">
                                <div style="display: flex; gap: 5px; flex-wrap: wrap; align-items: center;">
                                    <% if (detail.getColor() != null) { %>
                                    <span>Màu: <%=detail.getColor()%></span>
                                    <% } %>
                                    <% if (detail.getSize() != null) { %>
                                    <span> | Size: <%=detail.getSize()%></span>
                                    <% } %>
                                </div>
                                <span>Số lượng: <%=detail.getQuantity()%></span>
                                <span>Đơn giá: <%=formatter.format(detail.getUnitPrice())%>đ</span>
                            </div>
                        </div>
                        <p class="price text-gray-800"><%=formatter.format(subtotal)%>đ</p>
                    </div>
                    <% } %>
                    <div class="p-4 flex justify-between items-center flex-row-reverse">
                        <p class="total">Tổng <%=order.getOrderDetail().size()%> mặt hàng: <%=formatter.format(order.getTotalCost())%>đ</p>
                        <div class="flex space-x-2">
                            <%if(order.getOrderStatus() == 1 || order.getOrderStatus() == 2){%>
                            <button
                                class="order_button_2">
                                Cập Nhật 
                            </button>
                            <button type="button"
                                    class="order_button_2"
                                    data-orderid="<%=order.getOrderID()%>"
                                    data-status="<%=order.getOrderStatus()%>"
                                    onclick="checkStatusAndShowPopup('<%=order.getOrderID()%>', <%=order.getOrderStatus()%>)">
                                Hủy Đơn Hàng
                            </button>
                            <%}else if(order.getOrderStatus() == 3){%>
                            <button
                                type="button"
                                class="order_button_2"
                                onclick="window.location.href = 'OrderHistoryURL?service=reOrder&oid=<%=order.getOrderID()%>'">
                                Mua Lại
                            </button>
                            <button
                                class="order_button_2">
                                Đánh Giá
                            </button>
                            <%}else if(order.getOrderStatus() == 0){%>
                            <button
                                type="button"
                                class="order_button_2"
                                onclick="window.location.href = 'OrderHistoryURL?service=reOrder&oid=<%=order.getOrderID()%>'">
                                Mua Lại
                            </button>
                            <%}%>
                        </div>
                    </div>
                </div>
                <% } %>

                <!-- Popup hủy đơn -->
                <div class="popup_clear fixed inset-0 bg-gray-800 bg-opacity-50 flex items-center justify-center" style="display: none;">
                    <form action="OrderHistoryURL" method="post">
                        <input type="hidden" name="service" value="deleteOrder" />
                        <div class="popup_content">
                            <h3 class="text-red-600 text-lg font-semibold">Bạn muốn hủy đơn hàng?</h3>
                            <input type="hidden" name="oid" id="popupOrderID">
                            <input type="text" name="cancel" class="w-full border rounded-lg p-2 mt-2" placeholder="Lý do hủy đơn">
                            <div class="mt-4 flex justify-center space-x-2">
                                <button type="button" class="button_clear order_button" onclick="closePopup()">Trở Về</button>
                                <button type="submit" class="button_clear order_button">Hủy Đơn</button>
                            </div>
                        </div>
                    </form>
                </div>

                <!-- Popup thông báo lỗi -->
                <div class="popup_error fixed inset-0 bg-gray-800 bg-opacity-50 flex items-center justify-center" style="display: none;">
                    <div class="bg-white p-6 rounded-lg">
                        <h3 class="text-red-600 text-lg font-semibold">Thông báo</h3>
                        <p class="mt-2">Chỉ có thể hủy đơn hàng khi trạng thái là "Đang Chờ".</p>
                        <div class="mt-4 flex justify-center">
                            <button type="button" class="button_clear order_button" onclick="closeErrorPopup()">Đóng</button>
                        </div>
                    </div>
                </div>

                <!-- Empty State -->
                <c:if test="${empty vector}">
                    <div class="py-12 flex flex-col items-center justify-center text-center">
                        <div class="w-16 h-16 rounded-full bg-blue-100 flex items-center justify-center mb-4">
                            <i class="fas fa-image text-blue-500 text-xl"></i>
                        </div>
                        <h3 class="text-lg font-medium text-gray-700 mb-2">Không có đơn hàng nào được tìm thấy</h3>
                        <p class="text-gray-500 max-w-md">Bạn chưa mua bất kỳ đơn hàng nào. Hãy đặt đơn đầu tiên ngay hôm nay để nhận ưu đãi đặc biệt!</p>
                        <a href="categories.jsp" class="mt-4 text-blue-600 hover:text-blue-800 font-medium">
                            <i class="fas fa-plus mr-1"></i> Mua đơn hàng đầu tiên của bạn
                        </a>
                    </div>
                </c:if>

                <!-- Pagination -->
                <div class="px-5 py-4 border-t border-gray-200 flex items-center justify-between">
                    <div class="text-sm text-gray-500">Hiển thị đơn hàng</div>
                    <div class="flex space-x-1">
                        <% if (currentPage > 1) { %>
                        <a href="<%= baseUrl %>&page=<%= currentPage - 1 %>" class="px-3 py-1 rounded border border-gray-300 text-gray-600 hover:bg-gray-50">
                            <i class="fas fa-chevron-left mr-1"></i> Trang trước
                        </a>
                        <% } else { %>
                        <button class="px-3 py-1 rounded border border-gray-300 text-gray-400 cursor-not-allowed" disabled>
                            <i class="fas fa-chevron-left mr-1"></i> Trang trước
                        </button>
                        <% } %>
                        <div class="pagination">
                            <span class="px-3 py-1 text-gray-600">Trang <%= currentPage %> / <%= totalPages %></span>
                        </div>
                        <% if (currentPage < totalPages) { %>
                        <a href="<%= baseUrl %>&page=<%= currentPage + 1 %>" class="px-3 py-1 rounded border border-gray-300 text-gray-600 hover:bg-gray-50">
                            Trang sau <i class="fas fa-chevron-right ml-1"></i>
                        </a>
                        <% } else { %>
                        <button class="px-3 py-1 rounded border border-gray-300 text-gray-400 cursor-not-allowed" disabled>
                            Trang sau <i class="fas fa-chevron-right ml-1"></i>
                        </button>
                        <% } %>
                    </div>
                </div>
            </div>
        </div>

        <!-- JavaScript -->
        <script>
            function checkStatusAndShowPopup(orderId, status) {
                if (status === 1) {
                    showPopup(orderId);
                } else {
                    showErrorPopup();
                }
            }
            function showPopup(orderId) {
                document.querySelector(".popup_clear").style.display = "flex";
                document.getElementById("popupOrderID").value = orderId;
            }
            function closePopup() {
                document.querySelector(".popup_clear").style.display = "none";
            }
            function showErrorPopup() {
                document.querySelector(".popup_error").style.display = "flex";
            }
            function closeErrorPopup() {
                document.querySelector(".popup_error").style.display = "none";
            }
            document.querySelector(".popup_clear").addEventListener("click", function (event) {
                if (event.target === this) {
                    this.style.display = "none";
                }
            });
            document.querySelector(".popup_error").addEventListener("click", function (event) {
                if (event.target === this) {
                    this.style.display = "none";
                }
            });
        </script>
        <script src="js/jquery-3.2.1.min.js"></script>
        <script src="styles/bootstrap4/popper.js"></script>
        <script src="styles/bootstrap4/bootstrap.min.js"></script>
        <script src="plugins/easing/easing.js"></script>
        <script src="plugins/parallax-js-master/parallax.min.js"></script>
        <script src="js/cart_custom.js"></script>
    </body>
</html>