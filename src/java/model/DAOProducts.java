package model;

import entity.Product;
import entity.ProductDetail;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DAOProducts extends DBConnection {

    private static final Logger LOGGER = Logger.getLogger(DAOProducts.class.getName());

    public Product getProductById(int productId) {
        String sql = "SELECT * FROM Products WHERE ProductID = ?";
        try ( PreparedStatement st = conn.prepareStatement(sql)) {
            st.setInt(1, productId);
            try ( ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    return new Product(
                            rs.getInt("ProductID"),
                            rs.getString("ProductName"),
                            rs.getInt("CategoryID"),
                            rs.getInt("Quantity"),
                            rs.getInt("SoldQuantity"),
                            rs.getDate("Date"),
                            rs.getString("Description"),
                            rs.getString("ProductStatus"),
                            rs.getString("ProductImage")
                    );
                }
            }
        } catch (SQLException e) {
            Logger.getLogger(DAOProducts.class.getName()).log(Level.SEVERE, "Error fetching product with ID: " + productId, e);
        }
        return null;
    }

    public List<ProductDetail> getAllProductDetails(int limit) {
        List<ProductDetail> productDetailList = new ArrayList<>();
        String sql = "SELECT TOP (?) p.ProductID, p.ProductName, p.CategoryID, p.Quantity, p.SoldQuantity, p.Date, "
                + "p.Description, p.ProductStatus, p.ProductImage, "
                + "pd.ID, pd.Size, pd.Color, pd.Price, pd.Image "
                + "FROM Products p "
                + "JOIN ProductDetail pd ON p.ProductID = pd.ProductID";

        try ( PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, limit);  // Set the limit parameter

            try ( ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    int productId = rs.getInt("ProductID");
                    String productName = rs.getString("ProductName");
                    int categoryId = rs.getInt("CategoryID");
                    int quantity = rs.getInt("Quantity");
                    int soldQuantity = rs.getInt("SoldQuantity");
                    java.sql.Date date = rs.getDate("Date");
                    String description = rs.getString("Description");
                    String productStatus = rs.getString("ProductStatus");
                    String productImage = rs.getString("ProductImage");

                    int productDetailId = rs.getInt("ID");
                    String size = rs.getString("Size");
                    String color = rs.getString("Color");
                    int price = rs.getInt("Price");
                    String detailImage = rs.getString("Image");

                    Product product = new Product(productId, productName, categoryId, quantity, soldQuantity, date, description, productStatus, productImage);
                    ProductDetail productDetail = new ProductDetail(productDetailId, product, size, color, price, detailImage);
                    productDetailList.add(productDetail);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error while fetching product details", e);
        }
        return productDetailList;
    }

}
