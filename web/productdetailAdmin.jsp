
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- Retrieve product details from the request attribute --%>
<c:set var="productDetail" value="${requestScope.productDetail}" />
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Edit Product</title>
  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <!-- Custom CSS -->
  <style>
    .form-label {
      font-weight: 500;
    }
    
    .preview-image {
      max-height: 200px;
      object-fit: contain;
    }
    
    .ck-editor__editable_inline {
      min-height: 300px;
    }
    
    .required::after {
      content: "*";
      color: red;
      margin-left: 4px;
    }
    
    .invalid-feedback {
      display: none;
    }
    
    .was-validated .form-control:invalid ~ .invalid-feedback {
      display: block;
    }
    
    #loadingOverlay {
      position: fixed;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background-color: rgba(255, 255, 255, 0.8);
      display: flex;
      justify-content: center;
      align-items: center;
      z-index: 9999;
    }
  </style>
</head>
<body>
  <!-- Loading Overlay -->
 

  <div class="container py-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
      <h1 class="mb-0">Edit Product</h1>
      <a href="products.html" class="btn btn-outline-secondary">Back to Products</a>
    </div>
    
    <div class="card">
      <div class="card-body">
        <!-- Form with standard submission - action points to the servlet URL -->
        <form id="productEditForm" class="needs-validation" novalidate method="POST" action="product-detail-admin">
          <div class="row">
            <!-- Left Column -->
            <div class="col-md-6">
              <div class="mb-3">
                <label for="productId" class="form-label required">Product ID</label>
                <input type="number" class="form-control" id="productId" value="${productDetail.ID}" name="productId" readonly>
                <div class="invalid-feedback">Product ID is required</div>
              </div>
              
              <div class="mb-3">
                <label for="identityCode" class="form-label required">Identity Code</label>
                <input type="text" class="form-control" id="identityCode" name="identityCode" value="${productDetail.identityCode}" maxlength="15" required>
                <div class="invalid-feedback">Identity Code is required (max 15 characters)</div>
              </div>
              
              <div class="mb-3">
                <label for="size" class="form-label required">Size</label>
                <select class="form-select" id="size" name="size" required>
                    <option value="7ml" ${productDetail.size == '7ml' ? 'selected' : ''}>7ml</option>
                  <option value="30ml" ${productDetail.size == '30ml' ? 'selected' : ''}>30ml</option>
                <option value="50ml" ${productDetail.size == '50ml' ? 'selected' : ''}>50ml</option>
                <option value="100ml" ${productDetail.size == '100ml' ? 'selected' : ''}>100ml</option>
                <option value="150ml" ${productDetail.size == '150ml' ? 'selected' : ''}>150ml</option>
                <option value="200ml" ${productDetail.size == '200ml' ? 'selected' : ''}>200ml</option>
                </select>
                <div class="invalid-feedback">Size is required</div>
              </div>
              
              <div class="mb-3">
                <label for="color" class="form-label">Color</label>
                <input type="text" class="form-control" id="color"  value="${productDetail.color}" name="color" maxlength="50">
                <div class="invalid-feedback">Color must be 50 characters or less</div>
              </div>
              
              <div class="mb-3">
                <label for="quantity" class="form-label required">Quantity</label>
                <input type="number" class="form-control" id="quantity"  value="${productDetail.quantity}" name="quantity" min="0" required>
                <div class="invalid-feedback">Quantity must be 0 or greater</div>
              </div>
              
              <div class="mb-3">
                <label for="soldQuantity" class="form-label required">Sold Quantity</label>
                <input value="${productDetail.soldQuantity}" type="number" class="form-control" id="soldQuantity" name="soldQuantity" min="0" required>
                <div class="invalid-feedback">Sold Quantity must be 0 or greater</div>
              </div>
            </div>
            
            <!-- Right Column -->
            <div class="col-md-6">
              <div class="mb-3">
                <label for="dateCreate" class="form-label required">Date Created</label>
                <input value="${productDetail.dateCreate}" type="date" class="form-control" id="dateCreate" name="dateCreate" required>
                <div class="invalid-feedback">Date Created is required</div>
              </div>
              
              <div class="mb-3">
                <label for="importPrice" class="form-label">Import Price</label>
                <div class="input-group">
                  <span class="input-group-text">₫</span>
                  <input value="${productDetail.importPrice}" type="number" class="form-control" id="importPrice" name="importPrice" min="0">
                  <div class="invalid-feedback">Import Price must be 0 or greater</div>
                </div>
              </div>
              
              <div class="mb-3">
                <label for="price" class="form-label required">Price</label>
                <div class="input-group">
                  <span class="input-group-text">₫</span>
                  <input value="${productDetail.price}" type="number" class="form-control" id="price" name="price" min="0" required>
                  <div class="invalid-feedback">Price must be 0 or greater</div>
                </div>
              </div>
              
              <div class="mb-3">
                <label for="image" class="form-label">Image</label>
                <input type="file" class="form-control" id="image" name="image" accept="image/*">
                <div class="mt-2" id="imagePreviewContainer" style="display: none;">
                  <img id="imagePreview" class="preview-image img-thumbnail" src="${productDetail.image}" alt="Product image preview">
                </div>
              </div>
              
              <div class="mb-3">
                <label for="productStatus" class="form-label required">Product Status</label>
                <select class="form-select" id="productStatus" name="productStatus" required>
                  <option value="1" ${productDetail.productStatus == '1' ? 'selected' : ''}>Active</option>
                                <option value="0" ${productDetail.productStatus == '0' ? 'selected' : ''}>Inactive</option>
                </select>
                <div class="invalid-feedback">Product Status is required</div>
              </div>
            </div>
          </div>
          
          <!-- Product Description -->
          <div class="mb-3">
            <label for="description" class="form-label required">Description</label>
            <textarea class="form-control" id="description" name="description" rows="3" required>${productDetail.description}</textarea>
            <div class="invalid-feedback">Description is required</div>
          </div>
          
          <!-- Product Details with CKEditor -->
          <div class="mb-4">
            <label for="details" class="form-label required">Product Details</label>
            <textarea id="details" name="details" required>${productDetail.getDetails()}</textarea>
            <div class="invalid-feedback">Product Details are required</div>
          </div>
          
          <!-- Hidden field to store CKEditor content -->
          <input type="hidden" id="detailsContent" name="details">
          
          <div class="d-flex gap-2">
            <button type="submit" class="btn btn-primary" id="saveButton">Save Changes</button>
            <a href="products.html" class="btn btn-outline-secondary">Cancel</a>
          </div>
        </form>
      </div>
    </div>
  </div>

  <!-- Bootstrap JS Bundle with Popper -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
  
  <!-- CKEditor -->
  <script src="https://cdn.ckeditor.com/ckeditor5/40.0.0/classic/ckeditor.js"></script>
  
  <!-- Custom JavaScript -->
  <script>
    // Initialize CKEditor
    let editor;
    
    ClassicEditor
      .create(document.querySelector('#details'), {
        toolbar: [
          'heading', '|',
          'bold', 'italic', 'link', 'bulletedList', 'numberedList', '|',
          'outdent', 'indent', '|',
          'blockQuote', 'insertTable', 'undo', 'redo'
        ]
      })
      .then(newEditor => {
        window.editor = newEditor;
        editor = newEditor;
        
        // Add event listener to form to capture CKEditor content before submission
        document.getElementById('productEditForm').addEventListener('submit', function() {
          // Get CKEditor content and set it to the hidden field
          document.getElementById('detailsContent').value = editor.getData();
        });
      })
      .catch(error => {
        console.error('Error initializing CKEditor:', error);
      });
      
      
      
CKEDITOR.editorConfig = function( config ) {
    config.image2_prefillDimensions = true; // Không tự động điền kích thước
    config.image2_maxWidth = 300; // Giới hạn chiều rộng tối đa
};    
    // Image preview functionality
    const imageInput = document.getElementById('image');
    const imagePreview = document.getElementById('imagePreview');
    const imagePreviewContainer = document.getElementById('imagePreviewContainer');
    
    imageInput.addEventListener('change', function() {
      const file = this.files[0];
      if (file) {
        const reader = new FileReader();
        reader.onload = function(e) {
          imagePreview.src = e.target.result;
          imagePreviewContainer.style.display = 'block';
        }
        reader.readAsDataURL(file);
      }
    });
    
   
      
      if (window.editor) {
        window.editor.setData(editorContent);
      } else {
        // If editor isn't initialized yet, wait and try again
        const checkEditorInterval = setInterval(() => {
          if (window.editor) {
            window.editor.setData(editorContent);
            clearInterval(checkEditorInterval);
          }
        }, 100);
        
        // Clear interval after 5 seconds to prevent infinite checking
        setTimeout(() => clearInterval(checkEditorInterval), 5000);
      }
    

   
  </script>
</body>
</html>