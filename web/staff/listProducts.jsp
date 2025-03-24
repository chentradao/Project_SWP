<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%> <%@ taglib prefix="c"
         uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <title>Product Management</title>
        <link
            href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap"
            rel="stylesheet"
            />
        <link
            href="https://fonts.googleapis.com/icon?family=Material+Icons"
            rel="stylesheet"
            />
        <style>
            body {
                font-family: "Roboto", sans-serif;
                background-color: #f5f5f5;
                margin: 0;
                padding: 24px;
            }
            .container {
                max-width: 1200px;
                margin: 0 auto;
                background: white;
                border-radius: 8px;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
                padding: 24px;
            }
            .header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 24px;
            }
            .search-bar {
                display: flex;
                gap: 16px;
                background: white;
                padding: 16px;
                border-radius: 4px;
                box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
                margin-bottom: 24px;
            }
            .search-input {
                flex: 1;
                padding: 8px 16px;
                border: 1px solid #ddd;
                border-radius: 4px;
                font-size: 14px;
            }
            .btn {
                padding: 8px 16px;
                border-radius: 4px;
                border: none;
                cursor: pointer;
                font-weight: 500;
                transition: all 0.2s;
            }
            .btn-primary {
                background-color: #1976d2;
                color: white;
            }
            .btn-secondary {
                background-color: #f5f5f5;
                color: #333;
            }
            .btn-warning {
                background-color: #ed6c02;
                color: white;
            }
            .btn-danger {
                background-color: #d32f2f;
                color: white;
            }
            .btn:hover {
                opacity: 0.9;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
            }
            .table-container {
                overflow-x: auto;
            }
            .table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 16px;
            }
            .table th {
                background-color: #f5f5f5;
                padding: 12px 16px;
                text-align: left;
                font-weight: 500;
                color: #333;
            }
            .table td {
                padding: 12px 16px;
                border-bottom: 1px solid #eee;
            }
            .variant-table {
                margin: 8px 0;
                background-color: #f8f9fa;
                border-radius: 4px;
            }
            .variant-table th {
                background-color: #eee;
                font-size: 13px;
            }
            .variant-table td {
                font-size: 13px;
            }
            .chip {
                padding: 4px 8px;
                border-radius: 16px;
                font-size: 12px;
                font-weight: 500;
            }
            .chip-active {
                background-color: #e8f5e9;
                color: #2e7d32;
            }
            .chip-inactive {
                background-color: #ffebee;
                color: #c62828;
            }
            .action-buttons {
                display: flex;
                gap: 8px;
            }
            .material-icons {
                font-size: 20px;
                vertical-align: middle;
            }
            .pagination {
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 8px;
                margin-top: 24px;
                padding-top: 24px;
                border-top: 1px solid #eee;
            }

            .pagination-numbers {
                display: flex;
                gap: 8px;
                align-items: center;
            }

            .pagination .btn {
                min-width: 36px;
                height: 36px;
                padding: 0 8px;
                display: flex;
                align-items: center;
                justify-content: center;
            }

            .pagination .btn-primary {
                background-color: #1976d2;
                color: white;
            }

            .pagination .material-icons {
                font-size: 18px;
            }

            a {
                text-decoration: none;
            }
        </style>
    </head>
    <body>
        <div class="container">

            <div style="margin-bottom: 20px;">
                  <c:if test="${not empty sessionScope.successMessage}">
                <div class="alert alert-success" style="margin-top: 20px; padding: 15px; background-color: #d4edda; color: #155724; border: 1px solid #c3e6cb; border-radius: 4px;">
                    ${sessionScope.successMessage}
                </div>
                <% session.removeAttribute("successMessage"); %>
            </c:if>

            <c:if test="${not empty sessionScope.errorMessage}">
                <div class="alert alert-danger" style="margin-top: 20px; padding: 15px; background-color: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; border-radius: 4px;">
                    ${sessionScope.errorMessage}
                </div>
                <% session.removeAttribute("errorMessage"); %>
            </c:if>
            </div>

            <div class="header">
                <h2 style="margin: 0; color: #1976d2">Quản lý sản phẩm</h2>
                <a
                    href="${pageContext.request.contextPath}/staff/products/create"
                    class="btn btn-primary"
                    style="text-decoration: none"
                    >
                    <span class="material-icons">add</span> Thêm sản phẩm mới
                </a>
            </div>

            <div class="search-bar">
                <form action="${pageContext.request.contextPath}/staff/products" method="get" style="display: flex; gap: 16px; width: 100%">
                    <input type="text" name="searchTerm" value="${param.searchTerm}" placeholder="Tìm kiếm sản phẩm..." class="search-input" />
                    <select name="categoryId" class="search-input" style="max-width: 200px;">
                        <option value="">Tất cả danh mục</option>
                        <c:forEach var="category" items="${categories}">
                            <option value="${category.getCategoryId()}" ${param.categoryId == category.getCategoryId() ? 'selected' : ''}>
                                ${category.getCategoryName()}
                            </option>
                        </c:forEach>
                    </select>
                    <button type="submit" class="btn btn-secondary">
                        <span class="material-icons">search</span>
                    </button>
                </form>
            </div>




            <div class="table-container">
                <c:choose>
                    <c:when test="${empty products}">
                        <div style="text-align: center; padding: 40px; background-color: #f8f9fa; border-radius: 8px; margin: 20px 0;">
                            <span class="material-icons" style="font-size: 48px; color: #6c757d; margin-bottom: 16px;">inventory_2</span>
                            <p style="color: #6c757d; font-size: 18px; margin: 0;">Không tìm thấy sản phẩm</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>Mã SP</th>
                                    <th style="max-width: 400px">Tên Sản Phẩm</th>
                                    <th>Danh Mục</th>
                                    <th>Biến Thể</th>
                                    <th style="text-align: center">Thao Tác</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="product" items="${products}">
                                    <tr>
                                        <td>#${product.getProductId()}</td>
                                        <td style="font-weight: 500">${product.getProductName()}</td>
                                        <td>${product.getCategory().getCategoryName()}</td>
                                        <td>
                                            <button
                                                type="button"
                                                class="btn btn-secondary"
                                                onclick="showVariants(${product.getProductId()})"
                                                >
                                                <span class="material-icons">inventory_2</span>
                                            </button>
                                        </td>
                                        <td style="text-align: center">
                                            <div class="action-buttons">
                                                <a
                                                    href="${pageContext.request.contextPath}/staff/products/edit?id=${product.getProductId()}"
                                                    class="btn btn-warning"
                                                    >
                                                    <span class="material-icons">edit</span>
                                                </a>
                                                <button
                                                    type="button"
                                                    class="btn btn-danger"
                                                    onclick="confirmDelete(${product.getProductId()})"
                                                    >
                                                    <span class="material-icons">delete</span>
                                                </button>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:otherwise>
                </c:choose>
            </div>

            <c:if test="${not empty products && totalPages > 1}">
                <div class="pagination">
                    <a href="?page=1&searchTerm=${param.searchTerm}&categoryId=${param.categoryId}" class="btn btn-secondary">
                        <span class="material-icons">first_page</span>
                    </a>
                    <a href="?page=${currentPage - 1}&searchTerm=${param.searchTerm}&categoryId=${param.categoryId}" class="btn btn-secondary">
                        <span class="material-icons">chevron_left</span>
                    </a>

                    <div class="pagination-numbers">
                        <c:forEach var="i" begin="${startPage}" end="${endPage}">
                            <a href="?page=${i}&searchTerm=${param.searchTerm}&categoryId=${param.categoryId}" 
                               class="btn ${currentPage == i ? 'btn-primary' : 'btn-secondary'}">${i}</a>
                        </c:forEach>
                    </div>

                    <a href="?page=${currentPage + 1}&searchTerm=${param.searchTerm}&categoryId=${param.categoryId}" class="btn btn-secondary">
                        <span class="material-icons">chevron_right</span>
                    </a>
                    <a href="?page=${totalPages}&searchTerm=${param.searchTerm}&categoryId=${param.categoryId}" class="btn btn-secondary">
                        <span class="material-icons">last_page</span>
                    </a>
                </div>
            </c:if>
          
        </div>

        <style>
            .variant-table {
                margin: 8px 0;
                background-color: #f8f9fa;
                border-radius: 4px;
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
                transition: all 0.3s ease;
            }

            .variant-table tr:hover {
                background-color: #f5f5f5;
            }

            .modal-header {
                display: flex;
                flex-direction: row;
                justify-content: space-between;
                align-items: center;
            }
        </style>

        <div id="variantModal" class="modal">
            <div class="modal-content">
                <div class="modal-header">
                    <h3 style="margin: 0; color: #1976d2">Biến Thể Sản Phẩm</h3>
                    <button class="btn btn-primary close-button" onclick="closeModal()">
                        &times;
                    </button>
                </div>
                <div class="table-container">
                    <table class="table variant-table">
                        <thead>
                            <tr>
                                <th>Kích Thước</th>
                                <th>Màu Sắc</th>
                                <th>Số Lượng</th>
                                <th>Giá Nhập</th>
                                <th>Giá Bán</th>
                            </tr>
                        </thead>
                        <tbody id="variantTableBody"></tbody>
                    </table>
                </div>
            </div>
        </div>

        <style>
            .modal {
                display: none;
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100vh;
                background: rgba(0, 0, 0, 0.5);
                backdrop-filter: blur(4px);
                z-index: 1000;
                align-items: center;
                justify-content: center;
            }

            .modal-content {
                background: white;
                padding: 24px;
                border-radius: 12px;
                width: 90%;
                max-width: 800px;
                max-height: 80vh;
                overflow-y: auto;
                position: relative;
                animation: modalFade 0.3s ease;
            }

            @keyframes modalFade {
                from {
                    opacity: 0;
                    transform: translateY(-20px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }
        </style>

        <script>

            let modal;
            let variantTableBody;
            // Initialize after DOM is loaded
            document.addEventListener('DOMContentLoaded', function() {
            modal = document.getElementById("variantModal");
            variantTableBody = document.getElementById("variantTableBody");
            });
            function showVariants(productId) {
            const product = products.find(p => p.productId === productId);
            if (!product) return;
            // Clear existing content
            variantTableBody.innerHTML = '';
            product.productDetails.forEach(detail => {
            const row = document.createElement('tr');
            // Create and append cells
            const sizeCell = document.createElement('td');
            sizeCell.textContent = detail.size;
            row.appendChild(sizeCell);
            const colorCell = document.createElement('td');
            colorCell.textContent = detail.color;
            row.appendChild(colorCell);
            const quantityCell = document.createElement('td');
            quantityCell.textContent = detail.quantity;
            row.appendChild(quantityCell);
            const importPriceCell = document.createElement('td');
                    const iPrice = String(detail.importPrice);
            importPriceCell.textContent = parseVietnameseCurrency(iPrice);
            row.appendChild(importPriceCell);
            const priceCell = document.createElement('td');
            
            const price = String(detail.price);
            
            priceCell.textContent = parseVietnameseCurrency(price);
            row.appendChild(priceCell);
            // Append the row to table body
            variantTableBody.appendChild(row);
            });
            modal.style.display = "flex";
            document.body.style.overflow = "hidden";
            }

            function closeModal() {
            modal.style.display = "none";
            document.body.style.overflow = "auto"; // Restore scrolling
            }

            window.onclick = function(event) {
            if (event.target === modal) {
            closeModal();
            }
            }
            
        function parseVietnameseCurrency(input) {
    // Remove any non-numeric characters except for commas and dots
    let cleanedInput = input.replace(/[^\d.,]/g, '');

    // Replace commas with dots if they are used as decimal separators
    cleanedInput = cleanedInput.replace(/,/g, '.');

    // Parse the cleaned input as a float
    let amount = parseFloat(cleanedInput);

    // Format the amount using Vietnamese locale
    let formattedAmount = new Intl.NumberFormat('vi-VN', {
        style: 'currency',
        currency: 'VND'
    }).format(amount);

    return formattedAmount;
}

            const products = [
            <c:forEach var="product" items="${products}" varStatus="status">
            {
            productId: ${product.productId},
                    productDetails: [
                <c:forEach var="detail" items="${product.productDetails}" varStatus="detailStatus">
                    {
                    size: "${detail.size}",
                            color: "${detail.color}",
                            quantity: ${detail.quantity},
                            importPrice: ${detail.importPrice},
                            price: ${detail.price}
                    }${!detailStatus.last ? ',' : ''}
                </c:forEach>
                    ]
            }${!status.last ? ',' : ''}
            </c:forEach>
            ];
            function confirmDelete(productId) {
            console.log("productId", productId);
            if (confirm("Bạn có chắc chắn muốn xóa sản phẩm này?")) {
            window.location.href = `${pageContext.request.contextPath}/staff/products/delete?id=` + productId;
            }
            }
        </script>
    </body>
</html>
