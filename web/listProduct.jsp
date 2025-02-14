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
    int pageSize = 10; // Default page size

    if (pageParam != null && !pageParam.isEmpty()) {
        try {
            currentPage = Integer.parseInt(pageParam);
        } catch (NumberFormatException e) {
            currentPage = 1; // Fallback to default if parsing fails
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
    ProductService productService = new ProductService();
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
<div class="product_grid">
    <% if (products.isEmpty()) { %>
    <p>No products found.</p>
    <% } else { %>
    <% for (ProductResponse product : products) { %>
    <!-- Product -->
    <div class="product">
        <div class="product_image" style="display: flex; justify-content: center; align-items: center; height: 360px; overflow: hidden;">
            <img src="<%= product.getProductImage() != null ? product.getProductImage() : "images/default-product.jpg" %>" alt="" style="max-height: 360px; width: auto;">
        </div>
        <div class="product_content clearfix">
            <div class="product_info">
                <div class="product_name">
                    <a href="productDetail.jsp?productId=<%= product.getProductId() %>"><%= product.getProductName() %></a>
                </div>
                <!-- Format the price using the formatter -->
                <div class="product_price"><%= formatter.format(product.getProductPrice()) %> VND</div>
                <div class="product_details">
                    <span>Size: <%= product.getProductSize() %></span> |
                    <span>Màu Sắc: <%= product.getProductColor() %></span>
                </div>
            </div>
            <div class="product_options">
                <a href="CartURL?service=add2cart&id=<%=product.getId()%>"><div class="product_buy product_option"><img src="images/shopping-bag-white.svg" alt=""></div></a>
                <div class="product_fav product_option">+</div>
            </div>
        </div>
    </div>
    <% } %>
    <% } %>
</div>
