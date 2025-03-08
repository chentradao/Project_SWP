    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <title>Add Slider</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="description" content="Wish shop project">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" type="text/css" href="styles/bootstrap4/bootstrap.min.css">
        <link href="plugins/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
        <link rel="stylesheet" type="text/css" href="styles/cart.css">
        <link rel="stylesheet" type="text/css" href="styles/cart_responsive.css">
    </head>
    <body class="bg-gray-50 min-h-screen">
        <div class="container mx-auto px-4 py-8">

            <!-- Header Section -->
            <h1 class="cart_title mb-6">Tạo mới Slider</h1>
            <div class="flex justify-between items-center mt-4 mb-6">
                <button type="button" onclick="window.location.href = 'slider'" 
                        class="cart_button button_clear px-6 py-2 flex items-center">
                    <i class="fas fa-arrow-left mr-2"></i> Quay lại danh sách
                </button>
            </div>

            <!-- Form Card -->
            <div class="bg-white rounded-xl shadow-lg overflow-hidden max-w-3xl mx-auto">
                <div class="p-5 border-b border-gray-200">

                </div>

                <form action="slider" method="post" enctype="multipart/form-data" class="p-6 space-y-6">
                    <input type="hidden" name="action" value="add">

                    <!-- Title Field -->
                    <div class="space-y-2">
                        <label for="title" class="block text-sm font-medium text-gray-700">
                            <i class="fas fa-heading mr-2 text-blue-500"></i>Tiêu đề
                        </label>
                        <input type="text" id="title" name="title" required
                               class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition duration-200"
                               placeholder="Enter slider title">
                    </div>

                    <!-- Image Upload Field -->
                    <div class="space-y-2">
                        <label for="photo" class="block text-sm font-medium text-gray-700">
                            <i class="fas fa-image mr-2 text-blue-500"></i>HÌnh ảnh
                        </label>
                        <div class="border-2 border-dashed border-gray-300 rounded-lg p-6 text-center hover:border-blue-500 transition duration-200">
                            <input type="file" id="photo" name="photo" required accept="image/*" 
                                   class="hidden">
                            <label for="photo" class="cursor-pointer">
                                <div class="text-center">
                                    <i class="fas fa-cloud-upload-alt text-4xl text-gray-400 mb-2"></i>
                                    <p class="text-sm text-gray-500">Click to upload or drag and drop</p>
                                    <p class="text-xs text-gray-400 mt-1">PNG, JPG, GIF up to 10MB</p>
                                </div>
                            </label>
                            <div id="preview" class="mt-4 hidden">
                                <img id="imagePreview" class="mx-auto max-h-48 rounded-lg shadow" alt="Image preview">
                                <button type="button" id="removeImage" 
                                        class="mt-2 text-red-500 hover:text-red-700 text-sm">
                                    <i class="fas fa-times mr-1"></i>Xóa
                                </button>
                            </div>
                        </div>
                    </div>

                    <!-- Date Fields Row -->
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                        <div class="space-y-2">
                            <label for="startDate" class="block text-sm font-medium text-gray-700">
                                <i class="fas fa-calendar-alt mr-2 text-blue-500"></i>Ngày bắt đầu
                            </label>
                            <input type="date" id="startDate" name="startDate" required
                                   class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition duration-200">
                        </div>

                        <div class="space-y-2">
                            <label for="endDate" class="block text-sm font-medium text-gray-700">
                                <i class="fas fa-calendar-check mr-2 text-blue-500"></i>Ngày kết thúc
                            </label>
                            <input type="date" id="endDate" name="endDate" required
                                   class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition duration-200">
                        </div>
                    </div>

                    <!-- Author and Status Row -->
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                        <div class="space-y-2">
                            <label for="author" class="block text-sm font-medium text-gray-700">
                                <i class="fas fa-user mr-2 text-blue-500"></i>Author ID
                            </label>
                            <input type="number" id="author" name="author" required
                                   class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition duration-200"
                                   placeholder="Enter author ID">
                        </div>

                        <div class="space-y-2">
                            <label for="status" class="block text-sm font-medium text-gray-700">
                                <i class="fas fa-toggle-on mr-2 text-blue-500"></i>Trạng Thái
                            </label>
                            <select id="status" name="status"
                                    class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition duration-200">
                                <option value="1">Active</option>
                                <option value="0">Inactive</option>
                            </select>
                        </div>
                    </div>

                    <!-- Submit Button -->
                    <div class="pt-4 flex justify-center">
                        <button type="submit" 
                                class="cart_button button_update px-6 py-2 flex items-center">
                            <i class="fas fa-save mr-2"></i> Lưu Slider
                        </button>
                    </div>


                </form>
            </div>
        </div>

        <!-- JavaScript for Image Preview -->
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                const photoInput = document.getElementById('photo');
                const imagePreview = document.getElementById('imagePreview');
                const previewContainer = document.getElementById('preview');
                const removeButton = document.getElementById('removeImage');

                photoInput.addEventListener('change', function () {
                    const file = this.files[0];
                    if (file) {
                        const reader = new FileReader();

                        reader.onload = function (e) {
                            imagePreview.src = e.target.result;
                            previewContainer.classList.remove('hidden');
                        };

                        reader.readAsDataURL(file);
                    }
                });

                removeButton.addEventListener('click', function () {
                    photoInput.value = '';
                    previewContainer.classList.add('hidden');
                    imagePreview.src = '';
                });

                // Date validation
                const startDateInput = document.getElementById('startDate');
                const endDateInput = document.getElementById('endDate');

                endDateInput.addEventListener('change', function () {
                    if (startDateInput.value && this.value) {
                        const startDate = new Date(startDateInput.value);
                        const endDate = new Date(this.value);

                        if (endDate < startDate) {
                            alert('End date cannot be before start date');
                            this.value = '';
                        }
                    }
                });

                startDateInput.addEventListener('change', function () {
                    if (endDateInput.value && this.value) {
                        const startDate = new Date(this.value);
                        const endDate = new Date(endDateInput.value);

                        if (endDate < startDate) {
                            alert('End date cannot be before start date');
                            endDateInput.value = '';
                        }
                    }
                });
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