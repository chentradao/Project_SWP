package controller;

import entity.Product;
import entity.ProductDetail;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.ProductManagementDAO;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import entity.Category;

@WebServlet(name = "ProductManagementServlet", urlPatterns = {"/staff/products/*"})
public class ProductManagementServlet extends HttpServlet {

    private ProductManagementDAO productDAO;

    @Override
    public void init() {
        productDAO = new ProductManagementDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getPathInfo();
        if (action == null) {
            action = "/";
        }

        switch (action) {
            case "/create" ->
                showCreateForm(request, response);
            case "/edit" ->
                showEditForm(request, response);
            case "/delete" ->
                deleteProduct(request, response);
            default ->
                listProducts(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getPathInfo();
        if (action == null) {
            action = "/";
        }

        switch (action) {
            case "/create":
                createProduct(request, response);
                break;
            case "/edit": {
                try {
                    updateProduct(request, response);
                } catch (SQLException ex) {
                    Logger.getLogger(ProductManagementServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            break;

            default:
                response.sendRedirect(request.getContextPath() + "/staff/products");
                break;
        }
    }

    private void showCreateForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Category> categories = productDAO.getAllCategories();

        request.setAttribute("categories", categories);

        request.getRequestDispatcher("/staff/createProduct.jsp").forward(request, response);
    }

    private void createProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get product information
        String productName = request.getParameter("productName");
        int categoryId = Integer.parseInt(request.getParameter("categoryId"));
        String description = request.getParameter("description");
        String status = request.getParameter("status");

        // Create product object
        Product product = new Product();
        product.setProductName(productName);
        product.setCategoryId(categoryId);
        product.setDescription(description);
        product.setProductStatus(status);

        // Get product details
        String[] sizes = request.getParameterValues("size");
        String[] colors = request.getParameterValues("color");
        String[] quantities = request.getParameterValues("quantity");
        String[] importPrices = request.getParameterValues("importPrice");
        String[] prices = request.getParameterValues("price");
        String[] images = request.getParameterValues("image");

        List<ProductDetail> details = new ArrayList<>();
        for (int i = 0; i < sizes.length; i++) {
            ProductDetail detail = new ProductDetail();
            detail.setSize(sizes[i]);
            detail.setColor(colors[i]);
            detail.setQuantity(Integer.parseInt(quantities[i]));
            detail.setImportPrice(Integer.parseInt(importPrices[i]));
            detail.setPrice(Integer.parseInt(prices[i]));
            detail.setImage(images[i]);
            details.add(detail);
        }

        if (productDAO.createProduct(product, details)) {
            request.getSession().setAttribute("successMessage", "Thêm sản phẩm thành công");

            response.sendRedirect(request.getContextPath() + "/staff/products");
        } else {
            request.getSession().setAttribute("successMessage", "Thêm sản phẩm thất bại");

            request.setAttribute("error", "Failed to create product");
            showCreateForm(request, response);
        }
    }

    private void listProducts(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Get search parameters
            String searchTerm = request.getParameter("searchTerm");
            String categoryId = request.getParameter("categoryId");

            // Get pagination parameters
            int page = 1;
            int recordsPerPage = 10; // You can adjust this number

            String pageStr = request.getParameter("page");
            if (pageStr != null && !pageStr.isEmpty()) {
                page = Integer.parseInt(pageStr);
                if (page < 1) {
                    page = 1;
                }
            }

            // Calculate pagination offsets
            int start = (page - 1) * recordsPerPage;

            // Get filtered and paginated products
            List<Product> products;
            int totalRecords;

            if ((searchTerm != null && !searchTerm.trim().isEmpty())
                    || (categoryId != null && !categoryId.trim().isEmpty())) {
                products = productDAO.searchProducts(searchTerm, categoryId, start, recordsPerPage);
                totalRecords = productDAO.getTotalFilteredProducts(searchTerm, categoryId);
            } else {
                products = productDAO.getProducts(start, recordsPerPage);
                totalRecords = productDAO.getTotalProducts();
            }

            // Calculate total pages
            int totalPages = (int) Math.ceil((double) totalRecords / recordsPerPage);

            // Calculate pagination range
            int startPage = Math.max(1, page - 2);
            int endPage = Math.min(totalPages, page + 2);
            // Set attributes for JSP
            request.setAttribute("products", products);
            List<Category> categories = productDAO.getAllCategories();

            request.setAttribute("categories", categories);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("startPage", startPage);
            request.setAttribute("endPage", endPage);

            // Forward to JSP
            request.getRequestDispatcher("/staff/listProducts.jsp").forward(request, response);

        } catch (Exception e) {
            // Log the error
            Logger.getLogger(ProductManagementServlet.class.getName())
                    .log(Level.SEVERE, "Error in listProducts", e);
            // Set error message and redirect
            request.setAttribute("error", "An error occurred while retrieving products");
            request.getRequestDispatcher("/staff/listProducts.jsp").forward(request, response);
        }
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("fuck");
        String idStr = request.getParameter("id");
        int productId = Integer.parseInt(idStr);
        Product product = productDAO.getProductById(productId);

        if (product != null) {
            List<ProductDetail> details = productDAO.getProductDetails(productId);
            request.setAttribute("product", product);
            request.setAttribute("productDetails", details);

            List<Category> categories = productDAO.getAllCategories();

            request.setAttribute("categories", categories);

            request.getRequestDispatcher("/staff/editProduct.jsp").forward(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/staff/products");
        }
    }

    private void updateProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        int productId = Integer.parseInt(request.getParameter("productId"));
        String productName = request.getParameter("productName");
        int categoryId = Integer.parseInt(request.getParameter("categoryId"));
        String description = request.getParameter("description");
        String status = request.getParameter("productStatus");

        Product product = new Product();
        product.setProductId(productId);
        product.setProductName(productName);
        product.setCategoryId(categoryId);
        product.setDescription(description);
        product.setProductStatus(status);

        // Handle product details
        String[] detailIds = request.getParameterValues("detailId");
        String[] sizes = request.getParameterValues("size");
        String[] colors = request.getParameterValues("color");
        String[] quantities = request.getParameterValues("quantity");
        String[] importPrices = request.getParameterValues("importPrice");
        String[] prices = request.getParameterValues("price");
        String[] images = request.getParameterValues("image");

        List<ProductDetail> details = new ArrayList<>();
        for (int i = 0; i < sizes.length; i++) {
            ProductDetail detail = new ProductDetail();
            if (detailIds != null && i < detailIds.length) {
                detail.setID(Integer.parseInt(detailIds[i]));
            }
            detail.setProductId(productId);
            detail.setSize(sizes[i]);
            detail.setColor(colors[i]);
            detail.setQuantity(Integer.parseInt(quantities[i]));
            detail.setImportPrice(Integer.parseInt(importPrices[i]));
            detail.setPrice(Integer.parseInt(prices[i]));
            detail.setImage(images[i]);
            details.add(detail);
        }

        if (productDAO.updateProduct(product, details)) {
            request.getSession().setAttribute("successMessage", "Cập nhật sản phẩm thành công");

            response.sendRedirect(request.getContextPath() + "/staff/products");
        } else {
            request.getSession().setAttribute("errorMessage", "Cập nhật sản phẩm thất bại");

            request.setAttribute("error", "Failed to update product");
            request.setAttribute("product", product);
            request.setAttribute("productDetails", details);
            request.getRequestDispatcher("/staff/editProduct.jsp").forward(request, response);
        }
    }

    private void deleteProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int productId = Integer.parseInt(request.getParameter("id"));

        if (productDAO.deleteProduct(productId)) {
            request.getSession().setAttribute("successMessage", "Xóa sản phẩm thành công");
        } else {
            request.getSession().setAttribute("errorMessage", "Xóa sản phẩm thất bại");
        }

        response.sendRedirect(request.getContextPath() + "/staff/products");
    }

    // Add error handling method
    private void handleError(HttpServletRequest request, HttpServletResponse response, String errorMessage)
            throws ServletException, IOException {
        request.setAttribute("error", errorMessage);
        request.getRequestDispatcher("/staff/error.jsp").forward(request, response);
    }

    // Add validation method
    private boolean validateProduct(Product product, List<ProductDetail> details) {
        if (product.getProductName() == null || product.getProductName().trim().isEmpty()) {
            return false;
        }
        if (product.getCategoryId() <= 0) {
            return false;
        }
        if (details == null || details.isEmpty()) {
            return false;
        }
        for (ProductDetail detail : details) {
            if (detail.getPrice() <= 0 || detail.getQuantity() < 0) {
                return false;
            }
        }
        return true;
    }
}
