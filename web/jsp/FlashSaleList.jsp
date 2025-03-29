<%--
    Document   : FlashSaleList
    Created on : Mar 26, 2025, 9:15:18 AM
    Author     : nguye
--%>

<%@page import="java.text.DecimalFormatSymbols"%>
<%@page import="java.text.DecimalFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Vector"%>
<%@page import="entity.FlashSale"%> <!-- Đảm bảo import model FlashSale -->
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Flash Sale List Page</title>
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
        <style>
            .popup_clear{
    width: 100%;
    height: 100%;
    position: fixed;
    top: 0;
    display: none;
    justify-content: center;
    padding-left: 5%;
    align-items: center;
    text-align: center;
    z-index: 100;
}
        </style>
    </head>
    <body class="bg-gray-50 min-h-screen">
        <%
            Vector<FlashSale> vector = (Vector<FlashSale>) request.getAttribute("vector");
            int currentPage = (Integer) request.getAttribute("currentPage");
            int totalPages = (Integer) request.getAttribute("totalPages");
            String sortColumn = (String) request.getAttribute("sortColumn");
            String sortOrder = (String) request.getAttribute("sortOrder");

            // Xây dựng baseUrl
            String baseUrl = "FlashSaleURL?service=flashSaleList"; // Điều chỉnh URL theo controller
            if (sortColumn != null && !sortColumn.isEmpty()) baseUrl += "&sortColumn=" + sortColumn;
            if (sortOrder != null && !sortOrder.isEmpty()) baseUrl += "&sortOrder=" + sortOrder;

            DecimalFormatSymbols symbols = new DecimalFormatSymbols();
            symbols.setGroupingSeparator('.');
            DecimalFormat formatter = new DecimalFormat("#,###", symbols);
        %>

        <!-- Header -->
        <%@ include file="/AminHeader.jsp" %>

        <!-- Menu -->

        <!-- Home -->
        <!-- Main Content -->
            <div class="bg-white rounded-xl shadow-lg overflow-hidden mt-20">
                <!-- Table Header -->
                <div class="p-5 border-b border-gray-200">
                    <h2 class="text-xl font-semibold text-gray-800">Danh sách Flash Sale</h2>
                </div>

                <!-- Table -->
                <div class="overflow-x-auto">
                    <table class="w-full">
                        <thead class="border-b border-gray-300 bg-white">
                            <tr>
                                <th class=" px-4 py-3 text-left cursor-pointer" id="sortSaleIDHeader">
                                    ID
                                    <span class="ml-1">
                                        <% if ("saleID".equals(sortColumn) && "asc".equals(sortOrder)) { %>
                                        <i class="fas fa-sort-up"></i>
                                        <% } else if ("saleID".equals(sortColumn) && "desc".equals(sortOrder)) { %>
                                        <i class="fas fa-sort-down"></i>
                                        <% } else { %>
                                        <i class="fas fa-sort"></i>
                                        <% } %>
                                    </span>
                                </th>
                                <th class="px-4 py-3 text-left cursor-pointer" id="sortProductIDHeader">
                                    Ảnh 
                                </th>
                                <th class="px-4 py-3 text-left cursor-pointer" id="sortProductIDHeader">
                                    Tên Sản Phẩm 
                                </th>
                                <th class="px-4 py-3 text-left cursor-pointer" id="sortDateHeader">
                                    Ngày
                                    <span class="ml-1">
                                        <% if ("date".equals(sortColumn) && "asc".equals(sortOrder)) { %>
                                        <i class="fas fa-sort-up"></i>
                                        <% } else if ("date".equals(sortColumn) && "desc".equals(sortOrder)) { %>
                                        <i class="fas fa-sort-down"></i>
                                        <% } else { %>
                                        <i class="fas fa-sort"></i>
                                        <% } %>
                                    </span>
                                </th>
                                <th class="px-4 py-3 text-left cursor-pointer" id="sortTimeFrame">
                                    Khung giờ
                                    <span class="ml-1">
                                        <% if ("timeFrame".equals(sortColumn) && "asc".equals(sortOrder)) { %>
                                        <i class="fas fa-sort-up"></i>
                                        <% } else if ("timeFrame".equals(sortColumn) && "desc".equals(sortOrder)) { %>
                                        <i class="fas fa-sort-down"></i>
                                        <% } else { %>
                                        <i class="fas fa-sort"></i>
                                        <% } %>
                                    </span>
                                </th>
                                <th class="px-4 py-3 text-left cursor-pointer" id="sortDiscountHeader">
                                    Giảm Giá
                                    <span class="ml-1">
                                        <% if ("discount".equals(sortColumn) && "asc".equals(sortOrder)) { %>
                                        <i class="fas fa-sort-up"></i>
                                        <% } else if ("discount".equals(sortColumn) && "desc".equals(sortOrder)) { %>
                                        <i class="fas fa-sort-down"></i>
                                        <% } else { %>
                                        <i class="fas fa-sort"></i>
                                        <% } %>
                                    </span>
                                </th>
                                <th class="px-4 py-3 text-left cursor-pointer" id="sortQuantityHeader">
                                    Số Lượng
                                    <span class="ml-1">
                                        <% if ("quantity".equals(sortColumn) && "asc".equals(sortOrder)) { %>
                                        <i class="fas fa-sort-up"></i>
                                        <% } else if ("quantity".equals(sortColumn) && "desc".equals(sortOrder)) { %>
                                        <i class="fas fa-sort-down"></i>
                                        <% } else { %>
                                        <i class="fas fa-sort"></i>
                                        <% } %>
                                    </span>
                                </th>
                                <th class="px-4 py-3 text-left cursor-pointer" id="sortStatusHeader">
                                    Trạng Thái
                                    <span class="ml-1">
                                        <% if ("Status".equals(sortColumn) && "asc".equals(sortOrder)) { %>
                                        <i class="fas fa-sort-up"></i>
                                        <% } else if ("Status".equals(sortColumn) && "desc".equals(sortOrder)) { %>
                                        <i class="fas fa-sort-down"></i>
                                        <% } else { %>
                                        <i class="fas fa-sort"></i>
                                        <% } %>
                                    </span>
                                </th>
                                <th class="px-4 py-3 text-left">Hành Động</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-gray-100">
                            <%
                                for (FlashSale flashSale : vector) {
                            %>
                            <tr class="hover:bg-gray-50 transition duration-150">
                                <td class="px-4 py-3 text-gray-600"><%=flashSale.getSaleID()%></td>
                                <td class="px-4 py-3 text-gray-600">
                                    <img src="<%= flashSale.getProductDetail().getImage() %>" alt="Sale Image" class="w-auto h-20 rounded-lg">
                                </td>
                                <td class="px-3 py-3 text-gray-600"><%=flashSale.getProductDetail().getProductName()%>
                                    <div class="text-sm text-gray-500">
                                        <%if(flashSale.getProductDetail().getSize() != null){%>
                                        Size: <%= flashSale.getProductDetail().getSize() %> | 
                                        <%}if(flashSale.getProductDetail().getColor() != null){%>
                                        Màu: <%= flashSale.getProductDetail().getColor() %>
                                        <%}%>
                                    </div>
                                </td>
                                <td class="px-4 py-3 text-gray-800"><%=flashSale.getStartTime()%></td>
                                <td class="px-4 py-3 text-gray-800">
                                    <% if (flashSale.getTimeFrame() == 1) { %>
                                    <span >10h đến 13h</span>
                                    <% } else if(flashSale.getTimeFrame() == 2) { %>
                                    <span >13h đến 16h</span>
                                    <% } else if(flashSale.getTimeFrame() == 3) { %>
                                    <span>16h đến 19h</span>
                                    <% } else if(flashSale.getTimeFrame() == 4) { %>
                                    <span>19h đến 22h</span>
                                    <% } %>
                                </td>
                                <td class="px-4 py-3 text-gray-800"><%=flashSale.getDiscount()%>%</td>
                                <td class="px-4 py-3 text-gray-800"><%=formatter.format(flashSale.getQuantity())%></td>
                                <td class="px-4 py-3 text-gray-800">
                                    <% if (flashSale.getStatus() == 1) { %>
                                    <span class="text-green-800">Đang Diễn Ra</span>
                                    <% } else if(flashSale.getStatus() == 2) { %>
                                    <span class="text-red-800">Sắp Diễn Ra</span>
                                    <% } else if(flashSale.getStatus() == 0) { %>
                                    <span class="text-red-800">Đã Diễn Ra</span>
                                    <% } else if(flashSale.getStatus() == 4) { %>
                                    <span class="text-red-800">Đã Hết Hàng</span>
                                    <% } %>
                                </td>
                                <td class="px-4 py-3 w-[60px]">
                                    <div class="flex justify-center space-x-2">
                                        <a href="FlashSaleURL?service=updateFlash&fid=<%=flashSale.getSaleID()%>" 
                                           class="text-blue-500 hover:text-blue-700 bg-blue-50 hover:bg-blue-100 rounded-full p-1 transition duration-300"
                                           title="Cập nhật Flash Sale">
                                            <i class="fas fa-edit"></i>
                                        </a>
                                        <button type="button"
                                                class="text-red-500 hover:text-red-700 bg-red-50 hover:bg-red-100 rounded-full p-1 transition duration-300"
                                                onclick="showDeletePopup('<%=flashSale.getSaleID()%>')"
                                                title="Xóa Flash Sale">
                                            <i class="fas fa-trash-alt"></i>
                                        </button>
                                    </div>
                                </td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>

                <!-- Popup xóa Flash Sale -->
                <div class="popup_clear" style="display: none;">
                    <form action="FlashSaleURL" method="post">
                        <input type="hidden" name="service" value="deleteFlash" />
                        <div class="popup_content">
                            <h3 class="text-red-600">Bạn muốn xóa Flash Sale này?</h3>
                            <input type="hidden" name="saleID" id="popupSaleID">
                            <div class="mt-4 flex justify-center space-x-2">
                                <button type="button" class="button_clear order_button" onclick="closePopup()">Trở Về</button>
                                <button type="submit" class="button_clear order_button">Xóa</button>
                            </div>
                        </div>
                    </form>
                </div>

                <!-- Empty State -->
                <% if (vector.isEmpty()) { %>
                <div class="py-12 flex flex-col items-center justify-center text-center">
                    <div class="w-16 h-16 rounded-full bg-blue-100 flex items-center justify-center mb-4">
                        <i class="fas fa-bolt text-blue-500 text-xl"></i>
                    </div>
                    <h3 class="text-lg font-medium text-gray-700 mb-2">Không có Flash Sale nào được tìm thấy</h3>
                    <p class="text-gray-500 max-w-md">Hiện tại chưa có Flash Sale nào. Hãy tạo Flash Sale đầu tiên ngay hôm nay!</p>
                    <a href="FlashSaleURL?service=createFlash" class="mt-4 text-blue-600 hover:text-blue-800 font-medium">
                        <i class="fas fa-plus mr-1"></i> Tạo Flash Sale mới
                    </a>
                </div>
                <% } %>

                <!-- Pagination -->
                <div class="px-5 py-4 border-t border-gray-200 flex items-center justify-between">
                    <div class="text-sm text-gray-500">
                        Hiển thị Flash Sale
                    </div>
                    <div>
                        <a href="FlashSaleURL?service=createFlash" class="mt-4 text-blue-600 hover:text-blue-800 font-medium">
                            <i class="fas fa-plus mr-1"></i> Tạo Flash Sale mới
                        </a>
                    </div>
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
                            <span class="px-3 py-1 text-gray-600">
                                Trang <%= currentPage %> / <%= totalPages %>
                            </span>
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

        <!-- JavaScript -->
        <script>
            function showDeletePopup(saleID) {
                document.querySelector(".popup_clear").style.display = "flex";
                document.getElementById("popupSaleID").value = saleID;
            }

            function closePopup() {
                document.querySelector(".popup_clear").style.display = "none";
            }

            document.querySelector(".popup_clear").addEventListener("click", function (event) {
                if (event.target === this) {
                    this.style.display = "none";
                }
            });

            function handleSort(column) {
                const currentSortColumn = "<%= sortColumn != null ? sortColumn : "" %>";
                const currentSortOrder = "<%= sortOrder != null ? sortOrder : "" %>";
                let newSortOrder = "";

                if (currentSortColumn === column) {
                    newSortOrder = currentSortOrder === "asc" ? "desc" : "asc";
                } else {
                    newSortOrder = "asc";
                }

                const urlObj = new URL(window.location.href);
                urlObj.searchParams.set("sortColumn", column);
                urlObj.searchParams.set("sortOrder", newSortOrder);
                window.location.href = urlObj.toString();
            }

            document.getElementById("sortSaleIDHeader").addEventListener("click", () => handleSort("saleID"));
            document.getElementById("sortTimeFrame").addEventListener("click", () => handleSort("timeFrame"));
            document.getElementById("sortDateHeader").addEventListener("click", () => handleSort("date"));
            document.getElementById("sortDiscountHeader").addEventListener("click", () => handleSort("discount"));
            document.getElementById("sortQuantityHeader").addEventListener("click", () => handleSort("quantity"));
            document.getElementById("sortStatusHeader").addEventListener("click", () => handleSort("Status"));
        </script>
        <script src="js/jquery-3.2.1.min.js"></script>
        <script src="styles/bootstrap4/popper.js"></script>
        <script src="styles/bootstrap4/bootstrap.min.js"></script>
        <script src="plugins/easing/easing.js"></script>
        <script src="plugins/parallax-js-master/parallax.min.js"></script>
        <script src="js/cart_custom.js"></script>
    </body>
</html>