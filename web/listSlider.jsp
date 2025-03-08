<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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
    <%@ include file="adminheader.jsp" %>

    <body class="bg-gray-50 min-h-screen">

        <div class="container mx-auto px-4 py-8">
            <!-- Header Section -->


            <!-- Main Content -->
            <div class="bg-white rounded-xl shadow-lg overflow-hidden">
                <!-- Table Header -->
                <div class="p-5 border-b border-gray-200"></div>

                <!-- Table -->
                <div class="overflow-x-auto">
                    <table class="w-full">
                        <thead class="border-b border-gray-300 bg-white">
                            <tr>
                                <th class="px-4 py-3 text-left">ID</th>
                                <th class="px-4 py-3 text-left">Tiêu đề</th>
                                <th class="px-4 py-3 text-left">Ảnh</th>
                                <th class="px-4 py-3 text-left">Ngày bắt đầu</th>
                                <th class="px-4 py-3 text-left">Ngày kết thúc</th>
                                <th class="px-4 py-3 text-left">Tác giả</th>
                                <th class="px-4 py-3 text-left">Trạng Thái</th>
                                <th class="px-4 py-3 text-center">Hành động</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-gray-100">
                            <c:forEach var="slider" items="${sliders}">
                                <tr class="hover:bg-gray-50 transition duration-150">
                                    <td class="px-4 py-3 text-gray-600">${slider.sliderID}</td>
                                    <td class="px-4 py-3 font-medium text-gray-800">${slider.sliderTitle}</td>
                                    <td class="px-4 py-3">
                                        <div class="relative group">
                                            <img src="img/${slider.imageURL}" 
                                                 class="w-24 h-16 object-cover rounded-lg border border-gray-200 group-hover:shadow-md transition duration-300"
                                                 onclick="showImageDetail('img/${slider.imageURL}')"
                                                 alt="${slider.sliderTitle}">
                                            <div class="absolute inset-0 bg-black bg-opacity-0 group-hover:bg-opacity-10 flex items-center justify-center rounded-lg transition duration-300">
                                                <i class="fas fa-search text-white opacity-0 group-hover:opacity-100"></i>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="px-4 py-3 text-gray-600">${slider.startDate}</td>
                                    <td class="px-4 py-3 text-gray-600">${slider.endDate}</td>
                                    <td class="px-4 py-3">
                                        <div class="flex items-center">
                                            <div class="w-8 h-8 rounded-full bg-blue-100 text-blue-600 flex items-center justify-center mr-2">
                                                <i class="fas fa-user-edit text-xs"></i>
                                            </div>
                                            <span class="text-gray-700">${slider.sliderAuthor}</span>
                                        </div>
                                    </td>
                                    <td class="px-4 py-3">
                                        <span class="px-3 py-1 rounded-full text-sm font-medium
                                              ${slider.sliderStatus == 1 ? 'bg-green-100 text-green-700' : 'bg-red-100 text-red-700'}">
                                            <i class="fas ${slider.sliderStatus == 1 ? 'fa-check-circle mr-1' : 'fa-times-circle mr-1'}"></i>
                                            ${slider.sliderStatus == 1 ? "Active" : "Inactive"}
                                        </span>
                                    </td>
                                    <td class="px-4 py-3">
                                        <div class="flex justify-center space-x-2">
                                            <a href="slider?action=edit&id=${slider.sliderID}" 
                                               class="text-blue-500 hover:text-blue-700 bg-blue-50 hover:bg-blue-100 rounded-full p-2 transition duration-300"
                                               title="Edit Slider">
                                                <i class="fas fa-edit"></i>
                                            </a>
                                            <form action="slider" method="POST" class="inline-block"
                                                  onsubmit="return confirm('Are you sure you want to delete this slider?');">
                                                <input type="hidden" name="action" value="delete">
                                                <input type="hidden" name="id" value="${slider.sliderID}">
                                                <button type="submit"
                                                        class="text-red-500 hover:text-red-700 bg-red-50 hover:bg-red-100 rounded-full p-2 transition duration-300"
                                                        title="Delete Slider">
                                                    <i class="fas fa-trash-alt"></i>
                                                </button>
                                            </form>

                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>

                <!-- Empty State (shown if no sliders) -->
                <c:if test="${empty sliders}">
                    <div class="py-12 flex flex-col items-center justify-center text-center">
                        <div class="w-16 h-16 rounded-full bg-blue-100 flex items-center justify-center mb-4">
                            <i class="fas fa-image text-blue-500 text-xl"></i>
                        </div>
                        <h3 class="text-lg font-medium text-gray-700 mb-2">No Sliders Found</h3>
                        <p class="text-gray-500 max-w-md">You haven't created any sliders yet. Add your first slider to showcase it on your website.</p>
                        <a href="addSlider.jsp" class="mt-4 text-blue-600 hover:text-blue-800 font-medium">
                            <i class="fas fa-plus mr-1"></i> Add Your First Slider
                        </a>
                    </div>
                </c:if>

                <!-- Pagination (optional) -->
                <div class="px-5 py-4 border-t border-gray-200 flex items-center justify-between">
                    <div class="text-sm text-gray-500">
                        Hiển thị <span class="font-medium">${sliders.size()}</span> sliders
                    </div>
                    <div class="flex justify-between items-center mb-6">
                        <a href="addSlider.jsp" 
                           class="bg-[#9B8978] hover:bg-[#8A7968] text-white px-6 py-2 rounded-md shadow-sm border border-[#9B8978] uppercase tracking-wider text-sm flex items-center">
                            <i class="fas fa-plus mr-2"></i> Tạo Slider mới
                        </a>
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

        <!-- Image Modal -->
        <div id="imageModal" class="fixed inset-0 bg-black bg-opacity-75 hidden z-50 flex justify-center items-center">
            <div class="relative bg-white rounded-xl shadow-2xl max-w-4xl w-full mx-4">
                <div class="p-4 border-b border-gray-200 flex justify-between items-center">
                    <h3 class="text-lg font-medium text-gray-800">Image Preview</h3>
                    <button class="text-gray-500 hover:text-gray-700 focus:outline-none"
                            onclick="closeImageDetail()">
                        <i class="fas fa-times text-xl"></i>
                    </button>
                </div>
                <div class="p-6 flex justify-center">
                    <img id="modalImage" class="max-w-full max-h-[70vh] object-contain rounded-lg" alt="Slider preview">
                </div>
                <div class="p-4 border-t border-gray-200 bg-gray-50 rounded-b-xl">
                    <button onclick="closeImageDetail()" 
                            class="w-full bg-blue-600 hover:bg-blue-700 text-white px-4 py-2 rounded-lg transition duration-300">
                        Close Preview
                    </button>
                </div>
            </div>
        </div>

        <!-- JavaScript -->
        <script>
            // Đảm bảo các hàm được khai báo trong phạm vi toàn cục
            window.showImageDetail = function (imageUrl) {
                var modal = document.getElementById("imageModal");
                var modalImg = document.getElementById("modalImage");

                modalImg.src = imageUrl;
                modal.classList.remove("hidden");
                document.body.classList.add("overflow-hidden");
            };

            window.closeImageDetail = function () {
                var modal = document.getElementById("imageModal");
                modal.classList.add("hidden");
                document.body.classList.remove("overflow-hidden");
            };

            // Đóng modal khi nhấp vào bên ngoài nội dung
            document.addEventListener("DOMContentLoaded", function () {
                var modal = document.getElementById("imageModal");
                modal.addEventListener("click", function (e) {
                    if (e.target === modal) {
                        closeImageDetail();
                    }
                });
            });
        </script>


    </body>
</html>