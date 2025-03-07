<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="service.ProductService"%>
<%@page import="entity.ProductResponse"%>
<%@page import="model.ProductRepository"%>
<%@page import="entity.PaginatedResponse"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.DecimalFormatSymbols"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="css/style.css">


<%
   // Retrieve categoryId from request, default to 1 if not provided
    String categoryIdParam = request.getParameter("category");
    int categoryId = 1; // Default category ID

    if (categoryIdParam != null && !categoryIdParam.isEmpty()) {
        try {
            categoryId = Integer.parseInt(categoryIdParam);
        } catch (NumberFormatException e) {
            categoryId = 1; // Fallback to default if parsing fails
        }
    }

    // Retrieve optional filters
    String size = request.getParameter("size");
    String minPriceParam = request.getParameter("minPrice");
    String maxPriceParam = request.getParameter("maxPrice");

    Map<String, String> filters = ProductRepository.extractFilters(request); // Extract filters from request

    // Add additional filters manually
    if (size != null && !size.isEmpty()) {
        filters.put("Size", size);
    }
    if (minPriceParam != null && !minPriceParam.isEmpty()) {
        filters.put("minPrice", minPriceParam);
    }
    if (maxPriceParam != null && !maxPriceParam.isEmpty()) {
        filters.put("maxPrice", maxPriceParam);
    }
    
    // Handle pagination parameters
    String pageParam = request.getParameter("page");
    int currentPage = 1; // Default to first page
    int pageSize = 12; // Default page size

    if (pageParam != null && !pageParam.isEmpty()) {
        try {
            currentPage = Integer.parseInt(pageParam);
        } catch (NumberFormatException e) {
            currentPage = 1; // Fallback to default if parsing fails
        }
    }

    // Retrieve pageSize from request parameters
    String pageSizeParam = request.getParameter("pageSize");
    if (pageSizeParam != null && !pageSizeParam.isEmpty()) {
        try {
            pageSize = Integer.parseInt(pageSizeParam);
        } catch (NumberFormatException e) {
            pageSize = 12; // Fallback to default
        }
    }
    // Sorting parameters
    String sortBy = request.getParameter("sortBy");
    if (sortBy == null || sortBy.isEmpty()) {
        sortBy = "Price"; // Default sort by Price
    }
    
    String sortOrder = request.getParameter("sortOrder");
    if (sortOrder == null || sortOrder.isEmpty()) {
        sortOrder = "ASC"; // Default to ascending order
    }

    // Call service to get product list
    PaginatedResponse<ProductResponse> productResponse = productService.listProductsByCategory(
        categoryId, currentPage, pageSize, filters, sortBy, sortOrder
    );

    List<ProductResponse> products = productResponse.getData();

    // Create a DecimalFormat to display price with dot as grouping separator.
    DecimalFormatSymbols symbols = new DecimalFormatSymbols();
    symbols.setGroupingSeparator('.');
    DecimalFormat formatter = new DecimalFormat("#,###", symbols);
%>

<!-- Product Grid -->
<div class="product-container">
    <% if (products.isEmpty()) { %>
    <p>No products found.</p>
    <% } else { %>
    <% for (ProductResponse product : products) { %>
    <div class="product">
        <div class="product_image">
            <img src="<%= product.getProductImage() != null ? product.getProductImage() : "images/default-product.jpg" %>" alt="">
        </div>
        <div class="product_content">
            <div class="product_name">
                <a href="<%= request.getContextPath() %>/ProductDetail?productId=<%= product.getProductId() %>">
                    <%= product.getProductName() %>
                </a>
            </div>
            <div class="product_price"><%= formatter.format(product.getProductPrice()) %> VND</div>
            <div class="product_details">
                <span>Size: <%= product.getProductSize() %></span> |
                <span>Màu Sắc: <%= product.getProductColor() %></span>
            </div>
        </div>
        <div class="product_options">
            <a href="CartURL?service=add2cart&id=<%=product.getId()%>">
                <div class="product_buy product_option">
                    <img src="images/shopping-bag-white.svg" alt="">
                </div>
            </a>
            
            <!--<a href="addToWishlist?productId=<%=product.getId()%>">-->
                <div class="product_fav product_option">+</div>
            <!--</a>-->
        </div>
    </div>
    <% } %>
    <% } %>
</div>

<style>
    .product-container {
        margin-top: 20px;
        display: flex;
        flex-wrap: wrap;
        justify-content: center;
    }

    .product {
        width: calc(33.33% - 20px); /* Ensures 3 items per row */
        max-width: 300px; /* Limits the max size */
        height: 350px; /* Set a fixed height for consistency */
        display: flex;
        flex-direction: column;
        align-items: center;
        margin-bottom: 20px;
    }

    .product_image {
        display: flex;
        justify-content: center;
        align-items: center;
        height: 250px; /* Fixed image container height */
        overflow: hidden;
        width: 100%; /* Ensure full width */
    }

    .product_image img {
        width: 100%;
        height: 100%;
        object-fit: contain; /* Ensures full image is displayed */
    }

    .product_content {
        flex-grow: 1;
        padding: 10px;
        text-align: center;
    }

    .product_name a {
        font-size: 16px;
        font-weight: bold;
        color: #333;
        text-decoration: none;
    }

    .product_price {
        font-size: 18px;
        color: #e60023;
        font-weight: bold;
        margin: 10px 0;
    }

    .product_details {
        font-size: 14px;
        color: #666;
    }

    .product_options {
        display: flex;
        justify-content: center;
        margin-bottom: 10px;
    }


</style>