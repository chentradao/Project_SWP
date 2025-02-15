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
                            rs.getString("Description"),
                            rs.getString("ProductStatus")
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
        String sql = "SELECT TOP " + limit + " p.ProductID, p.ProductName, p.CategoryID, "
                + "p.Description, p.ProductStatus, pd.ID, pd.Size, pd.Color, "
                + "pd.Quantity, pd.SoldQuantity, pd.DateCreate, pd.Price, pd.Image, pd.ProductStatus "
                + "FROM Products p "
                + "JOIN ProductDetail pd ON p.ProductID = pd.ProductID";

        try ( PreparedStatement ps = conn.prepareStatement(sql)) {
            try ( ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Product product = new Product(
                            rs.getInt("ProductID"),
                            rs.getString("ProductName"),
                            rs.getInt("CategoryID"),
                            rs.getInt("Quantity"),
                            rs.getInt("SoldQuantity"),
                            rs.getDate("DateCreate"),
                            rs.getString("Description"),
                            rs.getString("ProductStatus"),
                            rs.getString("Image")
                    );
                    ProductDetail productDetail = new ProductDetail(
                            rs.getInt("ID"),
                            product,
                            rs.getString("Size"),
                            rs.getString("Color"),
                            rs.getInt("Price"),
                            rs.getString("Image")
                    );
                    productDetailList.add(productDetail);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error while fetching product details", e);
        }
        return productDetailList;
    }

}
