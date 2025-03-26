<%--
    Document   : CreateFlashSale
    Created on : Mar 26, 2025, 10:22:55 AM
    Author     : nguye
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Vector"%>
<%@page import="entity.ProductDetail"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create Flash Sale Page</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <style>
            .suggestion-list {
                position: absolute;
                background: white;
                border: 1px solid #ccc;
                max-height: 150px;
                overflow-y: auto;
                width: calc(100% - 2rem);
                z-index: 20;
                display: none;
                box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            }
            .suggestion-item {
                display: flex;
                align-items: center;
                padding: 8px;
                cursor: pointer;
                border-bottom: 1px solid #eee;
            }
            .suggestion-item:hover {
                background-color: #f0f0f0;
            }
            .suggestion-item img {
                width: 40px;
                height: 40px;
                object-fit: cover;
                margin-right: 10px;
                border-radius: 4px;
            }
            .suggestion-item .details {
                flex-grow: 1;
            }
            .suggestion-item .details p {
                margin: 0;
                font-size: 14px;
            }
            .suggestion-item .details .name {
                font-weight: bold;
            }
            .suggestion-item .details .info {
                color: #666;
                font-size: 12px;
            }
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
            Vector<ProductDetail> pro = (Vector<ProductDetail>) request.getAttribute("pro");
        %>
        <div class="bg-white p-6 rounded-lg shadow-lg w-full max-w-4xl text-gray-900 border">
            <h2 class="text-xl font-bold mb-4">THÊM SẢN PHẨM FLASHSALE</h2>
            <form action="FlashSaleURL" method="post" onsubmit="return validateForm()">
                <input type="hidden" name="service" value="createFlash">
                <input type="hidden" name="submit" value="true">
                <div class="flex flex-col">
                    <!-- Form nhập thông tin -->
                    <div class="flex mb-4">
                        <div class="w-1/2 pr-4 relative">
                            <label class="block mb-2">Tên sản phẩm</label>
                            <input type="text" id="productInput" name="productName" class="w-full p-2 border rounded" autocomplete="off" oninput="showSuggestions()">
                            <div id="suggestionList" class="suggestion-list"></div>
                            <input type="hidden" id="productID" name="productID">
                            <div id="productNameError" class="error-message">Vui lòng chọn một sản phẩm.</div>

                            <label class="block mb-2 mt-4">Ngày</label>
                            <input type="date" id="date" name="date" class="w-full p-2 border rounded">
                            <div id="dateError" class="error-message">Vui lòng chọn ngày.</div>

                            <label class="block mb-2 mt-4">Khung giờ</label>
                            <select name="timeFrame" id="timeFrame" class="w-full p-2 border rounded">
                                <option value="">Chọn khung giờ</option>
                                <option value="1">10h đến 13h</option>
                                <option value="2">13h đến 16h</option>
                                <option value="3">16h đến 19h</option>
                                <option value="4">19h đến 22h</option>
                            </select>
                            <div id="timeFrameError" class="error-message">Vui lòng chọn khung giờ.</div>

                            <label class="block mb-2 mt-4">% Giảm giá</label>
                            <div class="flex items-center p-2 border rounded">
                                <input type="number" id="discount" name="discount" class="w-full p-2 border-none" placeholder="Nhập %">
                                <span class="ml-2">%</span>
                            </div>
                            <div id="discountError" class="error-message">% Giảm giá phải từ 1 đến 99.</div>
                        </div>
                        <div class="w-1/2 pl-4 flex flex-col items-center">
                            <img id="productImage" src="P_images/default.png" alt="Hình ảnh sản phẩm" class="rounded-lg shadow-md mb-4 w-40 h-50 object-cover">
                            <label class="block mb-2">Số lượng trong kho</label>
                            <input type="number" id="stockQuantity" class="w-full p-2 border rounded text-center" readonly>
                        </div>
                    </div>

                    <div class="flex mb-4">
                        <div class="w-1/2 pr-4">
                            <label class="block mb-2">Số lượng muốn FlashSale</label>
                            <input type="number" id="flashQuantity" name="flashQuantity" class="w-full p-2 border rounded" placeholder="Nhập số lượng">
                            <div id="flashQuantityError" class="error-message">Số lượng phải lớn hơn 0 và nhỏ hơn số lượng trong kho.</div>
                        </div>
                        <div class="w-1/2 pr-4 flex">
                            <div class="w-1/2 pr-2">
                                <label class="block mb-2">Màu sắc</label>
                                <input type="text" id="color" class="w-full p-2 border rounded text-center" readonly>
                            </div>
                            <div class="w-1/2 pr-2">
                                <label class="block mb-2">Size</label>
                                <input type="text" id="size" class="w-full p-2 border rounded text-center" readonly>
                            </div>
                        </div>
                    </div>

                    <div class="flex">
                        <button type="button" class="bg-yellow-500 text-white px-4 py-2 rounded w-1/2 mr-2" onclick="window.location.href = 'FlashSaleURL?service=flashSaleList'">HỦY BỎ</button>
                        <button type="submit" class="bg-yellow-500 text-white px-4 py-2 rounded w-1/2 ml-2">THÊM NGAY</button>
                    </div>
                </div>
            </form>
        </div>

        <script>
            // Danh sách sản phẩm từ server
            const products = [
            <% 
                if (pro != null && !pro.isEmpty()) {
                    for (ProductDetail product : pro) {
                        String productName = product.getProductName() != null ? product.getProductName().replace("'", "\\'") : "Unknown";
                        String image = product.getImage() != null ? product.getImage().replace("'", "\\'") : "P_images/default.png";
                        String color = product.getColor() != null ? product.getColor().replace("'", "\\'") : "N/A";
                        String size = product.getSize() != null ? product.getSize().replace("'", "\\'") : "N/A";
                        String id = String.valueOf(product.getID());
            %>
                {
                    id: "<%= id %>",
                    name: "<%= productName %>",
                    image: "<%= image %>",
                    quantity: <%= product.getQuantity() %>,
                    color: "<%= color %>",
                    size: "<%= size %>"
                },
            <% 
                    }
                } else {
                    out.println("// Không có sản phẩm nào được tải từ server");
                }
            %>
            ];

            const productInput = document.getElementById('productInput');
            const suggestionList = document.getElementById('suggestionList');

            // Hiển thị gợi ý khi nhập
            function showSuggestions() {
                const query = productInput.value.toLowerCase();
                suggestionList.innerHTML = '';
                if (query) {
                    const filteredProducts = products.filter(function(p) { return p.name.toLowerCase().includes(query); });
                    filteredProducts.forEach(function(product) {
                        const div = document.createElement('div');
                        div.className = 'suggestion-item';
                        div.innerHTML = '<img src="' + (product.image || 'P_images/default.png') + '" alt="' + product.name + '">' +
                                        '<div class="details">' +
                                            '<p class="name">' + product.name + '</p>' +
                                            '<p class="info">Size: ' + (product.size || 'N/A') + ' | Color: ' + (product.color || 'N/A') + '</p>' +
                                        '</div>';
                        div.onclick = function() { selectProduct(product); };
                        suggestionList.appendChild(div);
                    });
                    suggestionList.style.display = filteredProducts.length ? 'block' : 'none';
                } else {
                    suggestionList.style.display = 'none';
                }
            }

            // Chọn sản phẩm và cập nhật thông tin
            function selectProduct(product) {
                productInput.value = product.name;
                document.getElementById('productID').value = product.id || '';
                document.getElementById('productImage').src = product.image || 'P_images/default.png';
                document.getElementById('stockQuantity').value = product.quantity || 0;
                document.getElementById('color').value = product.color || 'N/A';
                document.getElementById('size').value = product.size || 'N/A';
                suggestionList.style.display = 'none';
            }

            // Đóng danh sách gợi ý khi click ra ngoài
            document.addEventListener('click', function(e) {
                if (!productInput.contains(e.target) && !suggestionList.contains(e.target)) {
                    suggestionList.style.display = 'none';
                }
            });

            // Thiết lập ngày tối thiểu là ngày mai
            var today = new Date();
            var tomorrow = new Date(today);
            tomorrow.setDate(tomorrow.getDate() + 1);
            var tomorrowStr = tomorrow.toISOString().split('T')[0];
            document.getElementById('date').setAttribute('min', tomorrowStr);

            // Validation form
            function validateForm() {
                let isValid = true;
                const productName = document.getElementById('productInput').value.trim();
                const productID = document.getElementById('productID').value.trim();
                const date = document.getElementById('date').value;
                const timeFrame = document.getElementById('timeFrame').value;
                const discount = document.getElementById('discount').value;
                const flashQuantity = document.getElementById('flashQuantity').value;
                const stockQuantity = parseInt(document.getElementById('stockQuantity').value) || 0;

                // Reset error messages
                document.getElementById('productNameError').style.display = 'none';
                document.getElementById('dateError').style.display = 'none';
                document.getElementById('timeFrameError').style.display = 'none';
                document.getElementById('discountError').style.display = 'none';
                document.getElementById('flashQuantityError').style.display = 'none';

                // Kiểm tra trường tên sản phẩm
                if (!productName || !productID) {
                    document.getElementById('productNameError').style.display = 'block';
                    isValid = false;
                }

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
                } else if (discount <= 0 || discount >= 100) {
                    document.getElementById('discountError').textContent = '% Giảm giá phải từ 1 đến 99.';
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