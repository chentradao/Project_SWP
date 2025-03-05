<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="entity.Accounts,java.sql.ResultSet,java.util.Vector,entity.Cart,entity.Voucher,entity.Order" %>

<html>
    <head>
        <title>Slider Management</title>
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
        <link rel="stylesheet" type="text/css" href="styles/responsive.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
    </head>


    <body class="bg-gray-50 min-h-screen">
        <%
            Vector<Order> vector=(Vector<Order>)request.getAttribute("vector");
        %>
        <!-- Header -->

        <%@ include file="/header.jsp" %>


        <!-- Menu -->

        <%@ include file="/menu.jsp" %>

        <!-- Home -->
        <div class="container mx-auto px-4 py-8 flex items-start">
            <!-- Bộ lọc -->
            <div class="w-1/4 bg-white rounded-xl shadow-md p-5 h-full mt-20">
                <form action="OrderURL" method="post">
                    <input type="hidden" name="service" value="orderFilter" />
                    <h3 class="text-lg font-semibold mb-4">Bộ lọc</h3>

                    <!-- Filter by Status -->
                    <div class="mb-4">
                        <label class="block text-sm font-medium text-gray-700">Trạng thái</label>
                        <select id="filterStatus" name="status" class="mt-1 w-full border rounded-lg p-2">
                            <option value="">Tất cả</option>
                            <option value="1">Đang Chờ</option>
                            <option value="2">Đang Giao</option>
                            <option value="3">Hoàn Thành</option>
                            <option value="0">Đã Hủy</option>
                        </select>
                    </div>

                    <!-- Filter by Date -->
                    <div class="mb-4">
                        <label class="block text-sm font-medium text-gray-700">Ngày đặt hàng</label>
                        <input type="date" name="start" id="filterDate" class="mt-1 w-full border rounded-lg p-2">
                        <input type="date" name="end" id="filterDate" class="mt-1 w-full border rounded-lg p-2">
                    </div>

                    <!-- Filter by Payment Method -->
                    <div class="mb-4">
                        <label class="block text-sm font-medium text-gray-700">Phương thức thanh toán</label>
                        <select id="filterPayment" name="payment" class="mt-1 w-full border rounded-lg p-2">
                            <option value="">Tất cả</option>
                            <option value="COD">Thanh toán khi nhận hàng</option>
                            <option value="VNPAY">VNPAY</option>
                        </select>
                    </div>

                    <!-- Filter by Price -->


                    <button type="submit" onclick="applyFilters()" class="w-full bg-blue-600 text-white py-2 rounded-lg hover:bg-blue-700">Lọc</button>
                </form>
            </div>
            <!-- Main Content -->
            <div class="w-3/4">
                <div class="bg-white rounded-xl shadow-lg overflow-hidden">
                    <!-- Table Header -->
                    <div class="p-5 border-b border-gray-200"></div>

                    <!-- Table -->
                    <div class="overflow-x-auto">
                        <table class="w-full">
                            <thead class="border-b border-gray-300 bg-white">
                                <tr>
                                    <th class="px-4 py-3 text-left">ID</th>
                                    <th class="px-4 py-3 text-left">Ngày Đặt Hàng</th>
                                    <th class="px-4 py-3 text-left">Tên Người Nhận</th>
                                    <th class="px-4 py-3 text-left">Số Điện Thoại</th>
                                    <th class="px-4 py-3 text-left">Đơn giá</th>
                                    <th class="px-4 py-3 text-left">Trạng Thái</th>

                                </tr>
                            </thead>
                            <tbody class="divide-y divide-gray-100">
                                <%
                                    for(Order order : vector){
                                %>
                                <tr class="hover:bg-gray-50 transition duration-150">
                                    <td class="px-4 py-3 text-gray-600"><%=order.getOrderID()%></td>
                                    <td class="px-4 py-3 font-medium text-gray-800"><%=order.getOrderDate()%></td>
                                    <td class="px-4 py-3 font-medium text-gray-800"><%=order.getCustomerName()%></td>
                                    <td class="px-4 py-3"><%=order.getPhone()%></td>
                                    <td class="px-4 py-3 text-gray-800"><%=order.getTotalCost()%>₫</td>
                                    <% if(order.getOrderStatus()==1){%>
                                    <td class="px-4 py-3 text-gray-800">Đang Chờ</td>
                                    <%} else if(order.getOrderStatus()==2){%>
                                    <td class="px-4 py-3 text-green-800">Đang Giao</td>
                                    <%} else if(order.getOrderStatus()==3){%>
                                    <td class="px-4 py-3 text-green-800">Hoàn Thành</td>
                                    <%}else if(order.getOrderStatus()==0){%>
                                    <td class="px-4 py-3 text-red-800">Đã Hủy</td>
                                    <%}%>
                                    <td class="px-4 py-3">
                                        <div class="flex justify-center space-x-2">
                                            <a href="slider?action=edit&id=${slider.sliderID}" 
                                               class="text-blue-500 hover:text-blue-700 bg-blue-50 hover:bg-blue-100 rounded-full p-2 transition duration-300"
                                               title="Cập nhật đơn hàng">
                                                <i class="fas fa-edit"></i>
                                            </a>

                                            <button type="button"
                                                    id="clearCartBtn"
                                                    class="text-red-500 hover:text-red-700 bg-red-50 hover:bg-red-100 rounded-full p-2 transition duration-300"
                                                    data-orderid="<%=order.getOrderID()%>"
                                                    title="Hủy đơn hàng">
                                                <i class="fas fa-trash-alt"></i>
                                            </button>

                                        </div>
                                    </td>
                                </tr>
                                <%}%>
                            </tbody>
                        </table>
                    </div>
                    <div class="popup_clear">
                        <form action="OrderURL" method="post">
                            <input type="hidden" name="service" value="deleteOrder" />
                            <div class="popup_content">
                                <h3>Bạn muốn hủy đơn hàng?</h3>
                                <input type="hidden" name="OrderID" id="popupOrderID">
                                <input type="text" name="cancel" class="" id="" placeholder="Lý do hủy đơn" >
                                <button type="button" class="button_clear cart_button" id="closePopup">Trở Về</button>
                                <button type="submit" class="button_clear cart_button"id="closePopup">Hủy Đơn</button>
                            </div>
                        </form>
                    </div>
                    <!-- Empty State (shown if no sliders) -->
                    <c:if test="${empty vector}">
                        <div class="py-12 flex flex-col items-center justify-center text-center">
                            <div class="w-16 h-16 rounded-full bg-blue-100 flex items-center justify-center mb-4">
                                <i class="fas fa-image text-blue-500 text-xl"></i>
                            </div>
                            <h3 class="text-lg font-medium text-gray-700 mb-2">Không có đơn hàng nào được tìm thấy</h3>
                            <p class="text-gray-500 max-w-md">Bạn chưa mua bất kỳ đơn hàng nào. Hãy đặt đơn đầu tiên ngay hôm nay để nhận ưu đãi đặc biệt!</p>
                            <a href="index.jsp" class="mt-4 text-blue-600 hover:text-blue-800 font-medium">
                                <i class="fas fa-plus mr-1"></i> Mua đơn hàng đầu tiên của bạn
                            </a>
                        </div>
                    </c:if>

                    <!-- Pagination (optional) -->
                    <div class="px-5 py-4 border-t border-gray-200 flex items-center justify-between">
                        <div class="text-sm text-gray-500">
                            Hiển thị đơn hàng
                        </div>

                        <div class="flex space-x-1">
                            <button class="px-3 py-1 rounded border border-gray-300 text-gray-600 hover:bg-gray-50">
                                <i class="fas fa-chevron-left mr-1"></i> Previous
                            </button>
                            <button class="px-3 py-1 rounded border border-gray-300 text-gray-600 hover:bg-gray-50">
                                Next <i class="fas fa-chevron-right ml-1"></i>
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- JavaScript -->
        <script>
//            popup
            document.getElementById("clearCartBtn").addEventListener("click", function () {
                document.querySelector(".popup_clear").style.display = "flex";
            });
            // Ẩn popup khi nhấn "Trở Về"
            document.getElementById("closePopup").addEventListener("click", function () {
                document.querySelector(".popup_clear").style.display = "none";
            });

            // Ẩn popup khi click ra ngoài
            document.querySelector(".popup_clear").addEventListener("click", function (event) {
                if (event.target === this) {
                    this.style.display = "none";
                }
            });
        </script> 
    </body>
</html>