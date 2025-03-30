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
        <link rel="stylesheet" type="text/css" href="plugins/OwlCarousel2-2.2.1/owl.carousel.css">
        <link rel="stylesheet" type="text/css" href="plugins/OwlCarousel2-2.2.1/owl.theme.default.css">
        <link rel="stylesheet" type="text/css" href="plugins/OwlCarousel2-2.2.1/animate.css">
        <link href="plugins/colorbox/colorbox.css" rel="stylesheet" type="text/css">
        <link rel="stylesheet" type="text/css" href="styles/categories.css">
        <link rel="stylesheet" type="text/css" href="styles/OrderDetail.css">
        <link rel="stylesheet" type="text/css" href="styles/responsive.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <script src="https://cdn.tailwindcss.com"></script>
        <style>
            .time-frame-btn {
                transition: background-color 0.3s ease;
            }
            .time-frame-btn.active {
                background-color: #ef4444; /* Màu đỏ khi được chọn */
            }
            .time-frame-btn:hover {
                background-color: #6b7280; /* Màu xám nhạt khi hover */
            }
        </style>
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
                                <div class="home_title">Woman</div>
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
        <div class="flex justify-center gap-4 my-4" id="timeFrameContainer">
            <%
                for (int i = 0; i < timeFrames.length; i++) {
                    String timeFrame = timeFrames[i];
                    String timeFrameValue = timeFrameValues[i];
                    boolean isActive = Integer.parseInt(timeFrameValue) == selectedTimeFrame; // So sánh chính xác
            %>
            <div class="time-frame-btn <%= isActive ? "bg-red-500" : "bg-gray-700" %> text-white px-6 py-2 rounded cursor-pointer"
                 data-value="<%= timeFrameValue %>">
                <%= timeFrame %><br>
                <span class="status" data-start="<%= timeFrames[i].split("-")[0] %>" data-end="<%= timeFrames[i].split("-")[1] %>">
                    <!-- Trạng thái sẽ được cập nhật bằng JS -->
                </span>
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
                            int discountedPrice = originalPrice - (originalPrice * discount) / 100;
            %>
            <div class="bg-white p-4 rounded-lg shadow flex flex-col h-full">
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
                    <h5 class="text-sm text-red-500">🔥Chỉ còn: <%=flash.getQuantity()%></h5>
                </div>

                <!-- Giá và Nút Mua -->
                <div class="mt-auto">
                    <p class="text-red-500 flex items-center gap-2">
                        <span class="line-through text-gray-500 text-sm"><%= formatter.format(originalPrice) %>₫</span>
                        <span class="text-lg font-bold"><%= formatter.format(discountedPrice) %>₫</span>
                    </p>
                    <%if(flash.getStatus() == 1){%>
                    <button type="button" onclick="window.location.href = 'ShoppingFlashSaleURL?service=BuyNow&fid=<%=flash.getSaleID()%>'" class="mt-2 w-full bg-red-500 text-white py-1 rounded">Mua Ngay</button>
                <%}else{%>
                <button class="mt-2 w-full bg-red-500 text-white py-1 rounded cursor-not-allowed" disabled
                        <%if(flash.getStatus() == 0){%>
                        title="Đã Diễn Ra"
                        <%}else if(flash.getStatus() == 2){%>
                        title="Chưa Diễn Ra"
                        <%}%>>
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
                <p class="text-gray-500 w-full max-w-lg">Hiện tại khung giờ này chưa có Flash Sale nào. Hãy quay lại sau để săn deal hot nhé!!</p>
                <a href="categories.jsp" class="mt-4 text-blue-600 hover:text-blue-800 font-medium flex items-center">
                    <i class="fas fa-plus mr-1"></i> Xem Thêm Sản Phẩm Khác
                </a>
            </div>
            <% } %>
        </div>
        <footer class="footer">
                <div class="container">
                    <div class="row">
                        <div class="col text-center">
                            <div class="footer_logo"><a href="ProductListServlet">Estée Lauder</a></div>
                            <nav class="footer_nav">
                                <ul>
                                    <li><a href="ProductListServlet">Trang chủ</a></li>
                                    <li><a href="categories.jsp">Chăm sóc da</a></li>
                                    <li><a href="categories.jsp">Trang điểm</a></li>
                                    <li><a href="categories.jsp">Nước hoa</a></li>
                                    <li><a href="contact.html">Chăm sóc mắt</a></li>
                                </ul>
                            </nav>
                            <div class="footer_social">
                                <ul>
                                    <li><a href="#"><i class="fa fa-pinterest" aria-hidden="true"></i></a></li>
                                    <li><a href="#"><i class="fa fa-linkedin" aria-hidden="true"></i></a></li>
                                    <li><a href="#"><i class="fa fa-instagram" aria-hidden="true"></i></a></li>
                                    <li><a href="#"><i class="fa fa-reddit-alien" aria-hidden="true"></i></a></li>
                                    <li><a href="#"><i class="fa fa-twitter" aria-hidden="true"></i></a></li>
                                </ul>
                            </div>
                            <div class="copyright">
                                Copyright &copy;
                                <script>document.write(new Date().getFullYear());</script> 
                                All rights reserved | This template is made with 
                                <i class="fa fa-heart-o" aria-hidden="true"></i> by 
                                <a href="https://colorlib.com" target="_blank">Colorlib</a>
                            </div>
                        </div>
                    </div>
                </div>
            </footer>
        <script>
            // Danh sách khung giờ (theo giờ 24h)
            const timeFrames = [
                { start: "10:00", end: "13:00", value: "1" },
                { start: "13:00", end: "16:00", value: "2" },
                { start: "16:00", end: "19:00", value: "3" },
                { start: "19:00", end: "22:00", value: "4" }
            ];

            // Ngày hiện tại (dùng ngày thực tế hoặc ngày từ server)
            const currentDate = new Date("March 28, 2025"); // Có thể thay bằng new Date() để lấy thời gian thực

            // Hàm chọn khung giờ
            function selectTimeFrame(timeFrameValue) {
                window.location.href = "ShoppingFlashSaleURL?service=flashSale&timeFrame=" + timeFrameValue;

                // Đổi màu nút (tạm thời trước khi reload)
                const buttons = document.querySelectorAll(".time-frame-btn");
                buttons.forEach(btn => {
                    btn.classList.remove("active");
                    if (btn.getAttribute("data-value") === timeFrameValue) {
                        btn.classList.add("active");
                    }
                });
            }

            // Hàm cập nhật trạng thái khung giờ
            function updateTimeFrameStatus() {
                const now = new Date(); // Thời gian hiện tại
                const today = new Date(now.getFullYear(), now.getMonth(), now.getDate()); // Ngày hiện tại không giờ

                document.querySelectorAll(".time-frame-btn").forEach(btn => {
                    const startTimeStr = btn.querySelector(".status").getAttribute("data-start");
                    const endTimeStr = btn.querySelector(".status").getAttribute("data-end");

                    // Chuyển đổi thời gian bắt đầu và kết thúc thành đối tượng Date
                    const startTime = new Date(today);
                    const [startHour, startMinute] = startTimeStr.split(":");
                    startTime.setHours(parseInt(startHour), parseInt(startMinute), 0, 0);

                    const endTime = new Date(today);
                    const [endHour, endMinute] = endTimeStr.split(":");
                    endTime.setHours(parseInt(endHour), parseInt(endMinute), 0, 0);

                    // Xác định trạng thái
                    let statusText = "";
                    if (now < startTime) {
                        statusText = "Chưa Diễn Ra";
                    } else if (now >= startTime && now <= endTime) {
                        statusText = "Đang Diễn Ra";
                    } else {
                        statusText = "Đã Diễn Ra";
                    }

                    // Cập nhật nội dung trạng thái
                    btn.querySelector(".status").textContent = statusText;
                });
            }

            // Hàm tính thời gian đếm ngược đến khung giờ tiếp theo
            function startCountdown() {
                const now = new Date(); // Thời gian hiện tại
                const today = new Date(now.getFullYear(), now.getMonth(), now.getDate()); // Ngày hiện tại không giờ

                // Tìm khung giờ hiện tại hoặc tiếp theo
                let nextStartTime = null;
                for (let i = 0; i < timeFrames.length; i++) {
                    const startTime = new Date(today);
                    const [startHour, startMinute] = timeFrames[i].start.split(":");
                    startTime.setHours(parseInt(startHour), parseInt(startMinute), 0, 0);

                    const endTime = new Date(today);
                    const [endHour, endMinute] = timeFrames[i].end.split(":");
                    endTime.setHours(parseInt(endHour), parseInt(endMinute), 0, 0);

                    if (now < startTime) {
                        nextStartTime = startTime; // Đếm đến giờ bắt đầu khung tiếp theo
                        break;
                    } else if (now >= startTime && now <= endTime) {
                        nextStartTime = endTime; // Đếm đến giờ kết thúc khung hiện tại
                        break;
                    }
                }

                // Nếu không còn khung giờ nào trong ngày, đếm đến khung đầu tiên của ngày mai
                if (!nextStartTime) {
                    nextStartTime = new Date(today);
                    nextStartTime.setDate(today.getDate() + 1);
                    const [startHour, startMinute] = timeFrames[0].start.split(":");
                    nextStartTime.setHours(parseInt(startHour), parseInt(startMinute), 0, 0);
                }

                // Cập nhật đếm ngược
                const countdownElement = document.getElementById("countdown");
                function updateCountdown() {
                    const currentTime = new Date();
                    const timeDiff = nextStartTime - currentTime; // Khoảng cách thời gian (ms)

                    if (timeDiff <= 0) {
                        countdownElement.textContent = "00:00:00";
                        location.reload(); // Tải lại trang khi hết giờ
                        return;
                    }

                    const hours = Math.floor(timeDiff / (1000 * 60 * 60));
                    const minutes = Math.floor((timeDiff % (1000 * 60 * 60)) / (1000 * 60));
                    const seconds = Math.floor((timeDiff % (1000 * 60)) / 1000);

                    countdownElement.textContent =
                        (hours < 10 ? "0" + hours : hours) + ":" +
                        (minutes < 10 ? "0" + minutes : minutes) + ":" +
                        (seconds < 10 ? "0" + seconds : seconds);
                }

                // Cập nhật mỗi giây
                updateCountdown();
                setInterval(updateCountdown, 1000);
            }

            // Gán sự kiện cho các nút khung giờ
            document.querySelectorAll(".time-frame-btn").forEach(btn => {
                btn.addEventListener("click", () => {
                    const timeFrameValue = btn.getAttribute("data-value");
                    selectTimeFrame(timeFrameValue);
                });
            });

            // Khởi động đếm ngược và cập nhật trạng thái
            startCountdown();
            updateTimeFrameStatus();
            setInterval(updateTimeFrameStatus, 1000); // Cập nhật trạng thái mỗi giây
        </script>
        <script src="js/jquery-3.2.1.min.js"></script>
        <script src="styles/bootstrap4/popper.js"></script>
        <script src="styles/bootstrap4/bootstrap.min.js"></script>
        <script src="plugins/easing/easing.js"></script>
        <script src="plugins/parallax-js-master/parallax.min.js"></script>
        <script src="js/cart_custom.js"></script>
    </body>
</html>