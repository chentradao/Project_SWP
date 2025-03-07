<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
    <head>
        <title>Edit Slider</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
    </head>
    <body class="bg-gray-50 min-h-screen">
        
        
        <div class="container mx-auto px-4 py-8">
            
            <div class="flex justify-between items-center mb-6">
                <h1 class="text-3xl font-bold text-gray-800">
                    <i class="fas fa-edit mr-2"></i> Edit Slider
                </h1>
                <a href="slider" 
                   class="bg-gray-600 hover:bg-gray-700 text-white px-6 py-2 rounded-lg shadow-md transition duration-300 flex items-center">
                    <i class="fas fa-arrow-left mr-2"></i> Quay lại danh sách
                </a>
            </div>

            <div class="bg-white rounded-xl shadow-lg overflow-hidden max-w-3xl mx-auto">
                <div class="p-5 border-b border-gray-200">
                    
                </div>

                <form action="slider" method="post" enctype="multipart/form-data" class="p-6 space-y-6">
                    <input type="hidden" name="action" value="update">
                    <input type="hidden" name="id" value="${slider.sliderID}">
                    <!-- Hidden field to track if image should be removed -->
                    <input type="hidden" id="removeImageFlag" name="removeImage" value="false">

                    <div class="space-y-2">
                        <label for="title" class="block text-sm font-medium text-gray-700">
                            <i class="fas fa-heading mr-2 text-blue-500"></i>Tiêu đề
                        </label>
                        <input type="text" id="title" name="title" value="${slider.sliderTitle}" required
                               class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition duration-200"
                               placeholder="Enter slider title">
                    </div>

                    <div class="space-y-2">
                        <label for="photo" class="block text-sm font-medium text-gray-700">
                            <i class="fas fa-image mr-2 text-blue-500"></i>Ảnh
                        </label>
                        <div class="border-2 border-dashed border-gray-300 rounded-lg p-6 text-center hover:border-blue-500 transition duration-200">
                            <input type="file" id="photo" name="photo" accept="image/*" class="hidden">
                            <label for="photo" class="cursor-pointer">
                                <div class="text-center">
                                    <i class="fas fa-cloud-upload-alt text-4xl text-gray-400 mb-2"></i>
                                    <p class="text-sm text-gray-500">Click to upload or drag and drop</p>
                                    <p class="text-xs text-gray-400 mt-1">PNG, JPG, GIF up to 10MB</p>
                                </div>
                            </label>
                            <div id="preview" class="mt-4 ${empty slider.imageURL ? 'hidden' : ''}">
                                <img id="imagePreview" src="${empty slider.imageURL ? '' : 'img/'}${slider.imageURL}" 
                                     class="mx-auto max-h-48 rounded-lg shadow" alt="Image preview">
                                <button type="button" id="removeImage" 
                                        class="mt-2 text-red-500 hover:text-red-700 text-sm">
                                    <i class="fas fa-times mr-1"></i>Xóa
                                </button>
                            </div>
                        </div>
                    </div>

                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                        <div class="space-y-2">
                            <label for="startDate" class="block text-sm font-medium text-gray-700">
                                <i class="fas fa-calendar-alt mr-2 text-blue-500"></i>Ngày bắt đầu
                            </label>
                            <input type="date" id="startDate" name="startDate" value="${slider.startDate}" required
                                   class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition duration-200">
                        </div>
                        <div class="space-y-2">
                            <label for="endDate" class="block text-sm font-medium text-gray-700">
                                <i class="fas fa-calendar-check mr-2 text-blue-500"></i>Ngày kết thúc
                            </label>
                            <input type="date" id="endDate" name="endDate" value="${slider.endDate}" required
                                   class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition duration-200">
                        </div>
                    </div>

                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                        <div class="space-y-2">
                            <label for="author" class="block text-sm font-medium text-gray-700">
                                <i class="fas fa-user mr-2 text-blue-500"></i>Author ID
                            </label>
                            <input type="number" id="author" name="author" value="${slider.sliderAuthor}" required
                                   class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition duration-200"
                                   placeholder="Enter author ID">
                        </div>
                        <div class="space-y-2">
                            <label for="status" class="block text-sm font-medium text-gray-700">
                                <i class="fas fa-toggle-on mr-2 text-blue-500"></i>Trạng thái
                            </label>
                            <select id="status" name="status"
                                    class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition duration-200">
                                <option value="1" <c:if test="${slider.sliderStatus == 1}">selected</c:if>>Active</option>
                                <option value="0" <c:if test="${slider.sliderStatus == 0}">selected</c:if>>Inactive</option>
                            </select>
                        </div>
                    </div>

                    <div class="pt-4">
                        <button type="submit" 
                                class="w-full bg-blue-600 hover:bg-blue-700 text-white py-3 rounded-lg shadow-md transition duration-300 flex items-center justify-center">
                            <i class="fas fa-save mr-2"></i> Update Slider
                        </button>
                    </div>
                </form>
            </div>
        </div>

        <!-- JavaScript for Image Preview and Removal -->
        <script>
            document.addEventListener('DOMContentLoaded', function() {
                const photoInput = document.getElementById('photo');
                const imagePreview = document.getElementById('imagePreview');
                const previewContainer = document.getElementById('preview');
                const removeButton = document.getElementById('removeImage');
                const removeImageFlag = document.getElementById('removeImageFlag');
                
                // Handle file selection
                photoInput.addEventListener('change', function() {
                    const file = this.files[0];
                    if (file) {
                        const reader = new FileReader();
                        
                        reader.onload = function(e) {
                            imagePreview.src = e.target.result;
                            previewContainer.classList.remove('hidden');
                            // Reset the remove flag as we're adding a new image
                            removeImageFlag.value = "false";
                        };
                        
                        reader.readAsDataURL(file);
                    }
                });
                
                // Handle image removal
                removeButton.addEventListener('click', function() {
                    // Clear the file input
                    photoInput.value = '';
                    // Hide the preview
                    previewContainer.classList.add('hidden');
                    // Clear the image source
                    imagePreview.src = '';
                    // Set the flag to true so backend knows to remove the image
                    removeImageFlag.value = "true";
                });
                
                // Date validation
                const startDateInput = document.getElementById('startDate');
                const endDateInput = document.getElementById('endDate');
                
                endDateInput.addEventListener('change', function() {
                    if (startDateInput.value && this.value) {
                        const startDate = new Date(startDateInput.value);
                        const endDate = new Date(this.value);
                        
                        if (endDate < startDate) {
                            alert('End date cannot be before start date');
                            this.value = '';
                        }
                    }
                });
                
                startDateInput.addEventListener('change', function() {
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
    </body>
</html>