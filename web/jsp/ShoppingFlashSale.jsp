<%-- 
    Document   : ShoppingFlashSale
    Created on : Mar 26, 2025, 10:27:28 PM
    Author     : nguye
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Vector"%>
<%@page import="entity.FlashSale"%>
<%@page import="entity.ProductDetail"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.DecimalFormatSymbols"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Flash Sale</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" type="text/css" href="styles/bootstrap4/bootstrap.min.css">
        <link href="plugins/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
        <link rel="stylesheet" type="text/css" href="styles/categories.css">
        <link rel="stylesheet" type="text/css" href="styles/OrderDetail.css">
        <link rel="stylesheet" type="text/css" href="styles/responsive.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
        <script src="https://cdn.tailwindcss.com"></script>
    </head>
    <body class="bg-gray-100">
        
            <!-- Header -->

            <%@ include file="/header.jsp" %>

            <!-- Menu -->

            <%@ include file="/menu.jsp" %>
            
            <div class="home">
                <div class="home_background parallax-window" data-parallax="scroll" data-image-src="P_images/Cart_header.jpg" data-speed="0.8"></div>
                <div class="container">
                    <div class="row">
                        <div class="col">
                            <div class="home_container">
                                <div class="home_content">
                                    <div class="home_title">Flash Sale</div>
                                    <div class="breadcrumbs">
                                        <ul>
                                            <li><a href="index.html">Trang chủ</a></li>
                                            <li>Flash Sale</li>
                                            <li>Sale</li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Home -->
        <%
            Vector<FlashSale> vector = (Vector<FlashSale>) request.getAttribute("vector");
            String selectedDate = (String) request.getAttribute("selectedDate");
            int selectedTimeFrame = (int) request.getAttribute("selectedTimeFrame");

            // Định dạng giá tiền
            DecimalFormatSymbols symbols = new DecimalFormatSymbols();
            symbols.setGroupingSeparator('.');
            DecimalFormat formatter = new DecimalFormat("#,###", symbols);

            // Định nghĩa các khung giờ
            String[] timeFrames = {"10:00-13:00", "13:00-16:00", "16:00-19:00", "19:00-22:00"};
            String[] timeFrameValues = {"1", "2", "3", "4"};
        %>


        <!-- Header Flash Sale -->
        <div class="bg-white p-4 text-center font-bold text-xl flex justify-center items-center gap-2 border-b">
            <span class="text-red-500">⚡FLASH SALE⚡</span>
            <span class="text-gray-600">KẾT THÚC TRONG <span id="countdown" class="text-black font-semibold">01:37:01</span></span>
        </div>

        <!-- Khung giờ Flash Sale -->
        <div class="flex justify-center gap-4 my-4">
            <%
                for (int i = 0; i < timeFrames.length; i++) {
                    String timeFrame = timeFrames[i];
                    String timeFrameValue = timeFrameValues[i];
                    boolean isActive = timeFrameValue.equals(selectedTimeFrame);
            %>
            <div class="<%= isActive ? "bg-red-500" : "bg-gray-700" %> text-white px-6 py-2 rounded cursor-pointer"
                 onclick="selectTimeFrame('<%= timeFrameValue %>')">
                <%= timeFrame %><br>
                <%= isActive ? "Đang Diễn Ra" : "Chưa Diễn Ra" %>
            </div>
            <% } %>
        </div>

        <!-- Danh sách sản phẩm -->
        <div class="grid grid-cols-4 gap-4 p-4">
            <%
                if (vector != null && !vector.isEmpty()) {
                    for (FlashSale flash : vector) {
                        ProductDetail pro = flash.getProductDetail();
                        if (pro != null) {
                            int originalPrice = pro.getPrice(); // Giả sử ProductDetail có getPrice()
                            int discount = flash.getDiscount();
                            int discountedPrice = originalPrice - (originalPrice * discount)/100;
            %>
            <div class="bg-white p-4 rounded-lg shadow flex flex-col h-full">
                <a href="ProductDetail?productId=<%=flash.getProductID()%>">
                <!-- Hình ảnh -->
                <div class="w-full h-56 bg-gray-100 flex items-center justify-center rounded-lg overflow-hidden">
                    <img src="<%= pro.getImage() != null ? pro.getImage() : "https://via.placeholder.com/150" %>" 
                         alt="<%= pro.getProductName() %>" 
                         class="w-full h-full object-contain">
                </div>

                <!-- Nội dung sản phẩm -->
                <div class="flex flex-col flex-grow">
                    <h3 class="mt-2 font-bold h-12 line-clamp-2 overflow-hidden">
                        <%= pro.getProductName() %>
                    </h3>
                    <div class="text-sm text-gray-500">
                        <% if(pro.getSize() != null) { %>
                        Size: <%= pro.getSize() %> | 
                        <% } if(pro.getColor() != null) { %>
                        Màu: <%= pro.getColor() %>
                        <% } %>
                    </div>
                </div>
                </a>
                <!-- Giá và Nút Mua -->
                <div class="mt-auto">
                    <p class="text-red-500 flex items-center gap-2">
                        <span class="line-through text-gray-500 text-sm"><%= formatter.format(originalPrice) %>₫</span>
                        <span class="text-lg font-bold"><%= formatter.format(discountedPrice) %>₫</span>
                    </p>
                    <%if(flash.getStatus() == 1){%>
                    <button type="button" onclick="window.location.href = 'ShoppingFlashSaleURL?service=BuyNow&fid=<%=flash.getSaleID()%>'" class="mt-2 w-full bg-red-500 text-white py-1 rounded">Mua Ngay</button>
                <%}else{%>
                <button class="mt-2 w-full bg-red-500 text-white py-1 rounded cursor-not-allowed" disabled title="Chưa Diễn Ra">
                            Mua Ngay
                        </button>
                <%}%>
                </div>
            </div>
            <%
                    }
                }
            } else {
            %>
            <div class="col-span-4 flex flex-col items-center text-center py-8">
                <div class="w-12 h-12 rounded-full bg-blue-100 flex items-center justify-center mb-4">
                    <i class="fas fa-bolt text-blue-500 text-lg"></i>
                </div>
                <h3 class="text-lg font-medium text-gray-700 mb-2">Không có Flash Sale nào được tìm thấy</h3>
                <p class="text-gray-500 w-full max-w-lg">Hiện tại khung giờ này chưa có Flash Sale nào. hãy quay lại sau để săn deal hot nhé!!</p>
                <a href="categories.jsp" class="mt-4 text-blue-600 hover:text-blue-800 font-medium flex items-center">
                    <i class="fas fa-plus mr-1"></i> Xem Thêm Sản Phẩm Khác
                </a>
            </div>
            <% } %>
        </div>

        <script>
            // Hàm chọn khung giờ
            function selectTimeFrame(timeFrame) {
                window.location.href = "ShoppingFlashSaleURL?service=flashSale&timeFrame=" + timeFrame;
            }

            // Đếm ngược thời gian (giả lập)
            function startCountdown() {
                let time = 3600 + 37 * 60 + 1; // 01:37:01 in seconds
                setInterval(() => {
                    if (time <= 0)
                        return;
                    time--;
                    let hours = Math.floor(time / 3600);
                    let minutes = Math.floor((time % 3600) / 60);
                    let seconds = time % 60;
                    document.getElementById("countdown").textContent =
                            (hours < 10 ? "0" + hours : hours) + ":" +
                            (minutes < 10 ? "0" + minutes : minutes) + ":" +
                            (seconds < 10 ? "0" + seconds : seconds);
                }, 1000);
            }

            // Khởi động đếm ngược
            startCountdown();
        </script>
        <script src="js/jquery-3.2.1.min.js"></script>
        <script src="styles/bootstrap4/popper.js"></script>
        <script src="styles/bootstrap4/bootstrap.min.js"></script>
        <script src="plugins/easing/easing.js"></script>
        <script src="plugins/parallax-js-master/parallax.min.js"></script>
        <script src="js/cart_custom.js"></script>
    </body>
</html>