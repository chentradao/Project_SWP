package model;

import entity.Category;
import entity.Product;
import entity.ProductDetail;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class ProductManagementDAO extends DBContext {

    private static final Logger LOGGER = Logger.getLogger(ProductManagementDAO.class.getName());

    public boolean createProduct(Product product, List<ProductDetail> details) {
        String productSql = "INSERT INTO Products (ProductName, CategoryID, Description, ProductStatus) "
                + "VALUES (?, ?, ?, 1) SELECT SCOPE_IDENTITY() as ProductID";

        String detailSql = "INSERT INTO ProductDetail (ProductID, Size, Color, Quantity, ImportPrice, Price, Image, ProductStatus) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, 1)";

        try (Connection conn = getConnection()) {
            conn.setAutoCommit(false);
            try (PreparedStatement productStmt = conn.prepareStatement(productSql, Statement.RETURN_GENERATED_KEYS)) {
                productStmt.setString(1, product.getProductName());
                productStmt.setInt(2, product.getCategoryId());
                productStmt.setString(3, product.getDescription());
                
                int affectedRows = productStmt.executeUpdate();
                if (affectedRows == 0) {
                    throw new SQLException("Creating product failed, no rows affected.");
                }

                int productId;
                try (ResultSet generatedKeys = productStmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        productId = generatedKeys.getInt(1);
                    } else {
                        throw new SQLException("Creating product failed, no ID obtained.");
                    }
                }

                // Insert product details
                try (PreparedStatement detailStmt = conn.prepareStatement(detailSql)) {
                    for (ProductDetail detail : details) {
                        detailStmt.setInt(1, productId);
                        detailStmt.setString(2, detail.getSize());
                        detailStmt.setString(3, detail.getColor());
                        detailStmt.setInt(4, detail.getQuantity());
                        detailStmt.setInt(5, detail.getImportPrice());
                        detailStmt.setInt(6, detail.getPrice());
                        detailStmt.setString(7, detail.getImage());
                        detailStmt.executeUpdate();
                    }
                }

                conn.commit();
                return true;
            } catch (SQLException e) {
                conn.rollback();
                LOGGER.log(Level.SEVERE, "Error creating product", e);
                return false;
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error creating product", e);
            return false;
        }
    }

    public boolean updateProduct(Product product, List<ProductDetail> details) throws SQLException {
        String productSql = "UPDATE Products SET ProductName=?, CategoryID=?, Description=? WHERE ProductID=?";
        String detailSql = "UPDATE ProductDetail SET Size=?, Color=?, Quantity=?, ImportPrice=?, Price=?, Image=? WHERE ID=?";
        String newDetailSql = "INSERT INTO ProductDetail (ProductID, Size, Color, Quantity, ImportPrice, Price, Image, ProductStatus) VALUES (?, ?, ?, ?, ?, ?, ?, 1)";

        try (Connection conn = getConnection()) {
            conn.setAutoCommit(false);
            try {
                // Update product
                try (PreparedStatement productStmt = conn.prepareStatement(productSql)) {
                    productStmt.setString(1, product.getProductName());
                    productStmt.setInt(2, product.getCategoryId());
                    productStmt.setString(3, product.getDescription());
                    productStmt.setInt(4, product.getProductId());
                    productStmt.executeUpdate();
                }

                // Update or insert details
                PreparedStatement updateDetailStmt = conn.prepareStatement(detailSql);
                PreparedStatement newDetailStmt = conn.prepareStatement(newDetailSql);

                for (ProductDetail detail : details) {
                    if (detail.getID() > 0) {
                        // Update existing detail
                        updateDetailStmt.setString(1, detail.getSize());
                        updateDetailStmt.setString(2, detail.getColor());
                        updateDetailStmt.setInt(3, detail.getQuantity());
                        updateDetailStmt.setInt(4, detail.getImportPrice());
                        updateDetailStmt.setInt(5, detail.getPrice());
                        updateDetailStmt.setString(6, detail.getImage());
                        updateDetailStmt.setInt(7, detail.getID());
                        updateDetailStmt.executeUpdate();
                    } else {
                        // Insert new detail
                        newDetailStmt.setInt(1, product.getProductId());
                        newDetailStmt.setString(2, detail.getSize());
                        newDetailStmt.setString(3, detail.getColor());
                        newDetailStmt.setInt(4, detail.getQuantity());
                        newDetailStmt.setInt(5, detail.getImportPrice());
                        newDetailStmt.setInt(6, detail.getPrice());
                        newDetailStmt.setString(7, detail.getImage());
                        newDetailStmt.executeUpdate();
                    }
                }

                conn.commit();
                return true;
            } catch (SQLException e) {
                conn.rollback();
                LOGGER.log(Level.SEVERE, "Error updating product", e);
                return false;
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error updating product", e);
            return false;
        }
    }

    public boolean deleteProduct(int productId) {
        String sql = "UPDATE Products SET ProductStatus = 0 WHERE ProductID = ?";
        try (PreparedStatement stmt = getConnection().prepareStatement(sql)) {
            stmt.setInt(1, productId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error deleting product", e);
            return false;
        }
    }

    public List<Product> searchProducts(String keyword) {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT * FROM Products WHERE ProductStatus = 1 AND ProductName LIKE ? OR Description LIKE ?";
        try (PreparedStatement stmt = getConnection().prepareStatement(sql)) {
            stmt.setString(1, "%" + keyword + "%");
            stmt.setString(2, "%" + keyword + "%");
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Product product = new Product(
                        rs.getInt("ProductID"),
                        rs.getString("ProductName"),
                        rs.getInt("CategoryID"),
                        rs.getString("Description"),
                        rs.getString("ProductStatus")
                );
                products.add(product);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error searching products", e);
        }
        return products;
    }

    public List<Product> getAllProducts() {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT p.*, c.CategoryName, c.CategoryStatus FROM Products p "
                + "LEFT JOIN Categories c ON p.CategoryID = c.CategoryID WHERE p.ProductStatus = 1";

        try (Connection conn = getConnection()) {

            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Product product = new Product();
                // Set product fields
                product.setProductId(rs.getInt("ProductID"));
                product.setProductName(rs.getString("ProductName"));
                product.setCategoryId(rs.getInt("CategoryID"));
                product.setDate(rs.getDate("Date"));
                product.setDescription(rs.getString("Description"));
                product.setProductStatus(rs.getString("ProductStatus"));

                // Create and set category
                Category category = new Category(
                        rs.getInt("CategoryID"),
                        rs.getString("CategoryName"),
                        rs.getString("CategoryStatus")
                );
                product.setCategory(category);

                // Get product details (if you have existing code for this)
                product.setProductDetails(getProductDetails(product.getProductId()));

                products.add(product);
            }
        } catch (SQLException e) {
            // Your existing error handling
        }
        return products;
    }

    // If you need to update the getProductById method as well:
    public Product getProductById(int productId) {
        String sql = "SELECT p.*, c.CategoryName, c.CategoryStatus FROM Products p "
                + "LEFT JOIN Categories c ON p.CategoryID = c.CategoryID "
                + "WHERE p.ProductID = ? and p.ProductStatus = 1";

        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, productId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Product product = new Product();
                    // Set product fields
                    product.setProductId(rs.getInt("ProductID"));
                    product.setProductName(rs.getString("ProductName"));
                    product.setCategoryId(rs.getInt("CategoryID"));
                    product.setDate(rs.getDate("Date"));
                    product.setDescription(rs.getString("Description"));
                    product.setProductStatus(rs.getString("ProductStatus"));

                    // Create and set category
                    Category category = new Category(
                            rs.getInt("CategoryID"),
                            rs.getString("CategoryName"),
                            rs.getString("CategoryStatus")
                    );
                    product.setCategory(category);

                    // Get product details
                    product.setProductDetails(getProductDetails(productId));

                    return product;
                }
            }
        } catch (SQLException e) {
                   System.out.println(e);

        }
        return null;
    }

    public ArrayList<ProductDetail> getProductDetails(int productId) {
        ArrayList<ProductDetail> details = new ArrayList<>();
        String sql = "SELECT * FROM ProductDetail WHERE ProductID = ? AND ProductStatus = 1";

        try (PreparedStatement stmt = getConnection().prepareStatement(sql)) {
            stmt.setInt(1, productId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    ProductDetail detail = new ProductDetail();
                    detail.setID(rs.getInt("ID"));
                    detail.setProductId(rs.getInt("ProductID"));
                    detail.setSize(rs.getString("Size"));
                    detail.setColor(rs.getString("Color"));
                    detail.setQuantity(rs.getInt("Quantity"));
                    detail.setImportPrice(rs.getInt("ImportPrice"));
                    detail.setPrice(rs.getInt("Price"));
                    detail.setImage(rs.getString("Image"));
                    details.add(detail);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching product details for product ID: " + productId, e);
        }
        return details;
    }

    public boolean deleteProductDetail(int detailId) {
        String sql = "UPDATE ProductDetail SET ProductStatus = 0 WHERE ID = ?";
        try (PreparedStatement stmt = getConnection().prepareStatement(sql)) {
            stmt.setInt(1, detailId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error deleting product detail: " + detailId, e);
            return false;
        }
    }

    public List<Product> searchProducts(String searchTerm, String categoryId, int start, int recordsPerPage) {
        List<Product> products = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
                "SELECT p.*, c.CategoryName, c.CategoryStatus FROM Products p "
                + "LEFT JOIN Categories c ON p.CategoryID = c.CategoryID WHERE 1=1 AND p.ProductStatus = 1 "
        );
        List<Object> params = new ArrayList<>();

        if (searchTerm != null && !searchTerm.trim().isEmpty()) {
            sql.append(" AND (p.ProductName LIKE ? OR p.Description LIKE ?)");
            params.add("%" + searchTerm + "%");
            params.add("%" + searchTerm + "%");
        }

        if (categoryId != null && !categoryId.trim().isEmpty()) {
            sql.append(" AND p.CategoryID = ?");
            params.add(Integer.parseInt(categoryId));
        }

        sql.append(" ORDER BY p.ProductID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        params.add(start);
        params.add(recordsPerPage);

        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(sql.toString())) {

            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i));
            }

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Product product = new Product();
                    product.setProductId(rs.getInt("ProductID"));
                    product.setProductName(rs.getString("ProductName"));
                    product.setCategoryId(rs.getInt("CategoryID"));
                    product.setDate(rs.getDate("Date"));
                    product.setDescription(rs.getString("Description"));
                    product.setProductStatus(Integer.toString(rs.getInt("ProductStatus")));

                    Category category = new Category(
                            rs.getInt("CategoryID"),
                            rs.getString("CategoryName"),
                            Integer.toString(rs.getInt("CategoryStatus"))
                    );
                    product.setCategory(category);
                    product.setProductDetails(getProductDetails(product.getProductId()));
                    products.add(product);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error searching products", e);
        }
        return products;
    }

    public int getTotalFilteredProducts(String searchTerm, String categoryId) {
        StringBuilder sql = new StringBuilder(
                "SELECT COUNT(*) FROM Products p WHERE 1=1 and p.ProductStatus = 1 "
        );
        List<Object> params = new ArrayList<>();

        if (searchTerm != null && !searchTerm.trim().isEmpty()) {
            sql.append(" AND (p.ProductName LIKE ? OR p.Description LIKE ?)");
            params.add("%" + searchTerm + "%");
            params.add("%" + searchTerm + "%");
        }

        if (categoryId != null && !categoryId.trim().isEmpty()) {
            sql.append(" AND p.CategoryID = ?");
            params.add(Integer.parseInt(categoryId));
        }

        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(sql.toString())) {

            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i));
            }

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error counting filtered products", e);
        }
        return 0;
    }

    public List<Product> getProducts(int start, int recordsPerPage) {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT p.*, c.CategoryName, c.CategoryStatus FROM Products p  "
                + "LEFT JOIN Categories c ON p.CategoryID = c.CategoryID where p.productStatus = 1"
                + "ORDER BY p.ProductID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, start);
            stmt.setInt(2, recordsPerPage);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Product product = new Product();
                    product.setProductId(rs.getInt("ProductID"));
                    product.setProductName(rs.getString("ProductName"));
                    product.setCategoryId(rs.getInt("CategoryID"));
                    product.setDate(rs.getDate("Date"));
                    product.setDescription(rs.getString("Description"));
                    product.setProductStatus(Integer.toString(rs.getInt("ProductStatus")));

                    Category category = new Category(
                            rs.getInt("CategoryID"),
                            rs.getString("CategoryName"),
                            Integer.toString(rs.getInt("CategoryStatus"))
                    );
                    product.setCategory(category);
                    product.setProductDetails(getProductDetails(product.getProductId()));
                  
                    if(product.getProductStatus().equals("1")) {
                          products.add(product);
                    }
                    
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching paginated products", e);
        }
        return products;
    }

    public int getTotalProducts() {
        String sql = "SELECT COUNT(*) FROM Products where ProductStatus = 1";
        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error counting total products", e);
        }
        return 0;
    }

    public List<Product> getProductsByCategory(int categoryId) {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT * FROM Products WHERE CategoryID = ? AND ProductStatus = 1";

        try (PreparedStatement stmt = getConnection().prepareStatement(sql)) {
            stmt.setInt(1, categoryId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Product product = new Product(
                            rs.getInt("ProductID"),
                            rs.getString("ProductName"),
                            rs.getInt("CategoryID"),
                            rs.getString("Description"),
                            rs.getString("ProductStatus")
                    );
                    products.add(product);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching products by category: " + categoryId, e);
        }
        return products;
    }

    public boolean checkProductNameExists(String productName, Integer excludeProductId) {
        String sql = "SELECT COUNT(*) FROM Products WHERE ProductName = ? AND ProductID != COALESCE(?, -1)";
        try (PreparedStatement stmt = getConnection().prepareStatement(sql)) {
            stmt.setString(1, productName);
            stmt.setObject(2, excludeProductId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error checking product name existence", e);
        }
        return false;
    }

    public int getProductStock(int productId) {
        String sql = "SELECT SUM(Quantity) FROM ProductDetail WHERE ProductID = ? AND ProductStatus = 1";
        try (PreparedStatement stmt = getConnection().prepareStatement(sql)) {
            stmt.setInt(1, productId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting product stock for product ID: " + productId, e);
        }
        return 0;
    }

    public List<Category> getAllCategories() {
        List<Category> categories = new ArrayList<>();
        String sql = "SELECT * FROM Categories WHERE CategoryStatus = 1";

        try (PreparedStatement stmt = getConnection().prepareStatement(sql)) {

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Category category = new Category(
                        rs.getInt("CategoryID"),
                        rs.getString("CategoryName"),
                        Integer.toString(rs.getInt("CategoryStatus"))
                );
                categories.add(category);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching categories", e);
        }
        return categories;
    }
}
