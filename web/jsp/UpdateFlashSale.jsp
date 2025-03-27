<%-- 
    Document   : UpdateFlashSale
    Created on : Mar 26, 2025, 6:40:00 PM
    Author     : nguye
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="entity.FlashSale"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update Flash Sale Page</title>
         <script src="https://cdn.tailwindcss.com"></script>
         <style>
             .error-message {
                color: red;
                font-size: 12px;
                margin-top: 4px;
                display: none;
            }
         </style>
    </head>
    <body class="bg-white flex items-center justify-center min-h-screen">
        <%
            FlashSale flash = (FlashSale) request.getAttribute("flash");
        %>
        <div class="bg-white p-6 rounded-lg shadow-lg w-full max-w-4xl text-gray-900 border">
            <h2 class="text-xl font-bold mb-4">THÊM SẢN PHẨM FLASHSALE</h2>
            <form action="FlashSaleURL" method="post" onsubmit="return validateForm()">
                <input type="hidden" name="service" value="updateFlash">
                <input type="hidden" name="submit" value="true">
                <div class="flex flex-col">
                    <!-- Form nhập thông tin -->
                    <div class="flex mb-4">
                        <div class="w-1/2 pr-4 relative">
                            <label class="block mb-2">Tên sản phẩm</label>
                            <input type="text" id="productInput" name="productName" class="w-full p-2 border rounded" value="<%=flash.getProductDetail().getProductName()%>" readonly>
                            <div id="suggestionList" class="suggestion-list"></div>
                            <input type="hidden" id="productID" value="<%=flash.getProductID()%>" name="productID">
                            <input type="hidden" id="SaleID" value="<%=flash.getSaleID()%>" name="SaleID">
                            <label class="block mb-2 mt-4">Ngày</label>
                            <input type="date" id="date" name="date" value="<%=flash.getStartTime()%>" class="w-full p-2 border rounded">
                            <div id="dateError" class="error-message">Vui lòng chọn ngày.</div>

                            <label class="block mb-2 mt-4">Khung giờ</label>
                            <select name="timeFrame" id="timeFrame" class="w-full p-2 border rounded">
                                <option value="1" <%=flash.getTimeFrame()==1?"selected":""%>>10h đến 13h</option>
                                <option value="2" <%=flash.getTimeFrame()==2?"selected":""%>>13h đến 16h</option>
                                <option value="3" <%=flash.getTimeFrame()==3?"selected":""%>>16h đến 19h</option>
                                <option value="4" <%=flash.getTimeFrame()==4?"selected":""%>>19h đến 22h</option>
                            </select>
                            <div id="timeFrameError" class="error-message">Vui lòng chọn khung giờ.</div>

                            <label class="block mb-2 mt-4">% Giảm giá</label>
                            <div class="flex items-center p-2 border rounded">
                                <input type="number" id="discount" name="discount" value="<%=flash.getDiscount()%>" class="w-full p-2 border-none" placeholder="Nhập %">
                                <span class="ml-2">%</span>
                            </div>
                            <div id="discountError" class="error-message">% Giảm giá phải từ 1 đến 99.</div>
                        </div>
                        <div class="w-1/2 pl-4 flex flex-col items-center">
                            <img id="productImage" src="<%= flash.getProductDetail().getImage() %>" alt="Hình ảnh sản phẩm" class="rounded-lg shadow-md mb-4 w-40 h-50 object-cover">
                            <label class="block mb-2">Số lượng trong kho</label>
                            <input type="number" id="stockQuantity" value="<%=flash.getProductDetail().getQuantity()%>" class="w-full p-2 border rounded text-center" readonly>
                        </div>
                    </div>

                    <div class="flex mb-4">
                        <div class="w-1/2 pr-4">
                            <label class="block mb-2">Số lượng muốn FlashSale</label>
                            <input type="number" id="flashQuantity" name="flashQuantity" class="w-full p-2 border rounded" value="<%=flash.getQuantity()%>" placeholder="Nhập số lượng">
                            <div id="flashQuantityError" class="error-message">Số lượng phải lớn hơn 0 và nhỏ hơn số lượng trong kho.</div>
                        </div>
                        <div class="w-1/2 pr-4 flex">
                            <div class="w-1/2 pr-2">
                                <label class="block mb-2">Màu sắc</label>
                                <input type="text" id="color" value="<%= flash.getProductDetail().getColor() != null ? flash.getProductDetail().getColor() : "" %>" class="w-full p-2 border rounded text-center" readonly>
                            </div>
                            <div class="w-1/2 pr-2">
                                <label class="block mb-2">Size</label>
                                <input type="text" id="size" value="<%= flash.getProductDetail().getSize() != null ? flash.getProductDetail().getSize() : "" %>" class="w-full p-2 border rounded text-center" readonly>
                            </div>
                        </div>
                    </div>

                    <div class="flex">
                        <button type="button" class="bg-yellow-500 text-white px-4 py-2 rounded w-1/2 mr-2" onclick="window.location.href = 'FlashSaleURL?service=flashSaleList'">HỦY BỎ</button>
                        <button type="submit" class="bg-yellow-500 text-white px-4 py-2 rounded w-1/2 ml-2">CẬP NHẬT</button>
                    </div>
                </div>
            </form>
        </div>

        <script>
           // Thiết lập ngày tối thiểu là ngày mai
            var today = new Date();
            var tomorrow = new Date(today);
            tomorrow.setDate(tomorrow.getDate() + 1);
            var tomorrowStr = tomorrow.toISOString().split('T')[0];
            document.getElementById('date').setAttribute('min', tomorrowStr);
            
            // Validation form
            function validateForm() {
                let isValid = true;
                const date = document.getElementById('date').value;
                const timeFrame = document.getElementById('timeFrame').value;
                const discount = document.getElementById('discount').value;
                const flashQuantity = document.getElementById('flashQuantity').value;
                const stockQuantity = parseInt(document.getElementById('stockQuantity').value) || 0;

                // Reset error messages
                document.getElementById('dateError').style.display = 'none';
                document.getElementById('timeFrameError').style.display = 'none';
                document.getElementById('discountError').style.display = 'none';
                document.getElementById('flashQuantityError').style.display = 'none';

                // Kiểm tra trường ngày
                if (!date) {
                    document.getElementById('dateError').style.display = 'block';
                    isValid = false;
                }

                // Kiểm tra trường khung giờ
                if (!timeFrame) {
                    document.getElementById('timeFrameError').style.display = 'block';
                    isValid = false;
                }

                // Kiểm tra trường % giảm giá
                if (!discount) {
                    document.getElementById('discountError').textContent = 'Vui lòng nhập % giảm giá.';
                    document.getElementById('discountError').style.display = 'block';
                    isValid = false;
                } else if (discount <= 0 || discount >90) {
                    document.getElementById('discountError').textContent = '% Giảm giá phải từ 1 đến 90.';
                    document.getElementById('discountError').style.display = 'block';
                    isValid = false;
                }

                // Kiểm tra trường số lượng muốn Flash Sale
                if (!flashQuantity) {
                    document.getElementById('flashQuantityError').textContent = 'Vui lòng nhập số lượng.';
                    document.getElementById('flashQuantityError').style.display = 'block';
                    isValid = false;
                } else if (flashQuantity <= 0) {
                    document.getElementById('flashQuantityError').textContent = 'Số lượng phải lớn hơn 0.';
                    document.getElementById('flashQuantityError').style.display = 'block';
                    isValid = false;
                } else if (flashQuantity > stockQuantity) {
                    document.getElementById('flashQuantityError').textContent = 'Số lượng phải nhỏ hơn số lượng trong kho (' + stockQuantity + ').';
                    document.getElementById('flashQuantityError').style.display = 'block';
                    isValid = false;
                }

                return isValid;
            }
        </script>
    </body>
</html>
