/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import entity.ProductDetail;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import model.DBConnection;

/**
 *
 * @author Administrator
 */
public class DAOProductDetail extends DBConnection {

    private static final Logger LOGGER = Logger.getLogger(DAOProducts.class.getName());

    public ProductDetail getProductDetailById(int productId) {
        String sql = "select p.ProductID, p.ProductName, p.CategoryID, p.Quantity, p.SoldQuantity,\n"
                + "p.Date, p.Description, p.ProductStatus, p.ProductImage, pd.ID, \n"
                + "pd.Size, pd.Color, pd.Price,pd.Image\n"
                + "from Products p join ProductDetail pd on p.ProductID = pd.ProductID";
        try ( PreparedStatement st = conn.prepareStatement(sql)) {
            st.setInt(1, productId);
            try ( ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    return new ProductDetail(
                            rs.getInt("ProductID"),
                            rs.getString("ProductName"),
                            rs.getInt("CategoryID"),
                            rs.getInt("Quantity"),
                            rs.getInt("SoldQuantity"),
                            rs.getDate("Date"),
                            rs.getString("Description"),
                            rs.getString("ProductStatus"),
                            rs.getString("ProductImage"),
                            rs.getInt("ID"),
                            rs.getString("Size"),
                            rs.getString("Color"),
                            rs.getInt("Price"),
                            rs.getString("Image")
                    );
                }
            }
        } catch (SQLException e) {
            Logger.getLogger(DAOProducts.class.getName()).log(Level.SEVERE, "Error fetching product with ID: " + productId, e);
        }
        return null;
    }

    public List<ProductDetail> getAllProducts(int limit) {
        List<ProductDetail> productList = new ArrayList<>();
        String sql = "select p.ProductID, p.ProductName, p.CategoryID, p.Quantity, p.SoldQuantity,\n"
                + "p.Date, p.Description, p.ProductStatus, p.ProductImage, pd.ID, \n"
                + "pd.Size, pd.Color, pd.Price,pd.Image\n"
                + "from Products p join ProductDetail pd on p.ProductID = pd.ProductID";

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
                    int ID = rs.getInt("ID");
                    String Size = rs.getString("Size");
                    String Color = rs.getString("Color");
                    int Price = rs.getInt("Price");
                    String Image = rs.getString("Image");
                    ProductDetail pd = new ProductDetail(productId, productName, categoryId,
                            quantity, soldQuantity, date, description,
                            productStatus, productImage, ID, Size, Color, Price, Image);
                    productList.add(pd);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error while fetching products", e);
        }
        return productList;
    }

    public ProductDetail getProductDetailByProductId(int productId) {
        String sql = "SELECT ID, Size, Color, Price, Image FROM ProductDetail WHERE ProductID = ?";

        ProductDetail productDetail = null; // Khởi tạo biến ở đầu phương thức

        try ( PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, productId);

            try ( ResultSet rs = ps.executeQuery()) {
                if (rs.next()) { // Chỉ lấy một bản ghi
                    int id = rs.getInt("ID");
                    String size = rs.getString("Size");
                    String color = rs.getString("Color");
                    int price = rs.getInt("Price");
                    String image = rs.getString("Image");

                    // Tạo đối tượng ProductDetail
                    productDetail = new ProductDetail(id, productId, size, color, price, image);
                }
            }
        } catch (SQLException e) {
            System.out.println("Error while retrieving product details: " + e.getMessage());
        }

        return productDetail; // Trả về đối tượng ProductDetail (hoặc null nếu không tìm thấy)
    }

}
