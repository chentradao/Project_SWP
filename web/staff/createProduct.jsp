<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Create New Product</title>
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
        padding-bottom: 16px;
        border-bottom: 1px solid #eee;
      }
      .form-group {
        margin-bottom: 20px;
      }
      .form-group label {
        display: block;
        margin-bottom: 8px;
        color: #666;
        font-size: 14px;
        font-weight: 500;
      }
      .form-custom-control {
        width: -webkit-fill-available;
        padding: 12px;
        border: 1px solid #ddd;
        border-radius: 4px;
        font-size: 14px;
        transition: all 0.3s;
      }
      .form-custom-control:focus {
        border-color: #1976d2;
        box-shadow: 0 0 0 2px rgba(25, 118, 210, 0.2);
        outline: none;
      }
      .product-details {
        background: #f8f9fa;
        border-radius: 8px;
        padding: 24px;
        margin: 20px 0;
      }
      .detail-row {
        display: grid;
        grid-template-columns: repeat(3, 1fr);
        gap: 20px;
        padding: 20px;
        background: white;
        border-radius: 8px;
        margin-bottom: 20px;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        position: relative;
      }
      .variant-card {
        display: flex;
        flex-direction: column;
        background: #ffffff;
        border-radius: 12px;
        width: 100%;
      }

      .detail-row {
        display: flex;
        flex-direction: column;
        border-radius: 12px;
        margin-bottom: 24px;
        position: relative;
        overflow: hidden;
        transition: all 0.3s ease;
      }
      .detail-row:hover {
        box-shadow: 0 4px 16px rgba(0, 0, 0, 0.12);
      }
      .remove-variant {
        position: absolute;
        top: 16px;
        right: 16px;
        width: 36px;
        height: 36px;
        color: #d32f2f;
        background: white;
        border: none;
        cursor: pointer;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        transition: all 0.2s;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
      }
      .remove-variant:hover {
        background-color: #ffebee;
        transform: scale(1.05);
      }
      .form-group {
        margin-bottom: 16px;
      }
      .form-group input,
      .form-group select {
        background: #f8f9fa;
        border: 1px solid #e0e0e0;
      }
      .form-group input:focus,
      .form-group select:focus {
        background: #ffffff;
      }

      .remove-variant {
        position: absolute;
        top: 10px;
        right: 10px;
        color: #d32f2f;
        background: white;
        border: 1px solid #d32f2f;
        cursor: pointer;
        padding: 4px;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        transition: all 0.2s;
      }
      .remove-variant:hover {
        background-color: rgba(211, 47, 47, 0.1);
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
      .header .btn {
        display: flex;
        align-items: center;
        gap: 8px;
        padding: 8px 16px;
      }

      .header .material-icons {
        font-size: 20px;
      }
    </style>
  </head>
  <body>
    <div class="container">
      <div class="header">
        <div style="display: flex; align-items: center; gap: 16px">
          <a
            href="${pageContext.request.contextPath}/staff/products"
            class="btn btn-secondary"
            style="text-decoration: none"
          >
            <span class="material-icons">arrow_back</span>
            Quay Lại
          </a>
          <h2 style="margin: 0; color: #1976d2">Tạo Sản Phẩm Mới</h2>
        </div>
      </div>

      <form
        action="${pageContext.request.contextPath}/staff/products/create"
        method="post"
      >
        <div class="form-group">
          <label>Tên Sản Phẩm</label>
          <input
            type="text"
            name="productName"
            required
            class="form-custom-control"
            placeholder="Nhập tên sản phẩm"
          />
        </div>

        <div class="form-group">
          <label>Danh Mục</label>
          <select name="categoryId" required class="form-custom-control">
            <option value="">Chọn danh mục</option>
            <c:forEach var="category" items="${categories}">
              <option value="${category.getCategoryId()}">
                ${category.getCategoryName()}
              </option>
            </c:forEach>
          </select>
        </div>

        <div class="form-group">
          <label>Mô Tả</label>
          <textarea
            name="description"
            class="form-custom-control"
            placeholder="Nhập mô tả sản phẩm"
            rows="4"
          ></textarea>
        </div>

        <div id="productDetails" class="product-details">
          <div class="variant-header">
            <h3 style="margin-bottom: 10px">Biến Thể Sản Phẩm</h3>
          </div>
          <div class="detail-row">
            <div class="variant-card">
              <div class="form-group">
                <label>Kích Thước</label>
                <input
                  type="text"
                  name="size"
                  required
                  class="form-custom-control"
                  placeholder="VD: S, M, L"
                />
              </div>
              <div class="form-group">
                <label>Màu Sắc</label>
                <input
                  type="text"
                  name="color"
                  required
                  class="form-custom-control"
                  placeholder="VD: Đỏ, Xanh"
                />
              </div>
              <div class="form-group">
                <label>Số Lượng</label>
                <input
                  type="number"
                  name="quantity"
                  required
                  class="form-custom-control"
                  placeholder="Nhập số lượng"
                  min="0"
                />
              </div>
              <div class="form-group">
                <label>Giá Nhập (VNĐ)</label>
                <input
                  type="number"
                  name="importPrice"
                  required
                  class="form-custom-control"
                  placeholder="Nhập giá nhập"
                  min="0"
                />
              </div>
              <div class="form-group">
                <label>Giá Bán (VNĐ)</label>
                <input
                  type="number"
                  name="price"
                  required
                  class="form-custom-control"
                  placeholder="Nhập giá bán"
                  min="0"
                />
              </div>
              <div class="form-group">
                <label>Hình Ảnh URL</label>
                <input
                  type="text"
                  name="image"
                  class="form-custom-control"
                  placeholder="Nhập đường dẫn hình ảnh"
                />
              </div>
            </div>
          </div>
        </div>

        <div class="buttons-container">
          <button
            type="button"
            onclick="addDetailRow()"
            class="btn btn-secondary"
          >
            <span class="material-icons">add</span>
            Thêm Biến Thể
          </button>
          <button type="submit" class="btn btn-primary">
            <span class="material-icons">save</span>
            Tạo Sản Phẩm
          </button>
        </div>
      </form>
    </div>

    <script>
      function addDetailRow() {
        const detailsDiv = document.getElementById("productDetails");
        const template = document.querySelector(".detail-row").cloneNode(true);

        // Clear all input values
        template.querySelectorAll("input").forEach((input) => {
          input.value = "";
        });

        // Add remove button
        const removeButton = document.createElement("button");
        removeButton.type = "button";
        removeButton.className = "remove-variant";
        removeButton.innerHTML = '<span class="material-icons">close</span>';
        removeButton.onclick = function () {
          template.remove();
        };
        template.appendChild(removeButton);

        detailsDiv.appendChild(template);
      }
    </script>
  </body>
</html>

<style></style>
