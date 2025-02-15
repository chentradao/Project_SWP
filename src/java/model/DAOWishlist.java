/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import entity.Product;
import entity.ProductDetail;
import entity.Wishlist;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author ADMIN-PC
 */
public class DAOWishlist extends DBConnection {

    public boolean addToWishlist(Wishlist wishlist) {
        String sql = "INSERT INTO [SWP].[dbo].[Wishlist] ([AccountID], [ProductID]) VALUES (?, ?)";

        try ( PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, wishlist.getAccount().getAccountID());
            ps.setInt(2, wishlist.getProduct().getProductId());

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.out.println("Error while adding to wishlist: " + e.getMessage());
            return false;
        }
    }

    public List<Wishlist> getWishlistByAccount(int accountId) {
        List<Wishlist> wishlistItems = new ArrayList<>();
        String sql = "SELECT p.ProductID, p.CategoryID, p.ProductName, p.Description "
                + "FROM Wishlist w "
                + "JOIN Products p ON w.ProductID = p.ProductID "
                + "WHERE w.AccountID = ?";

        try ( PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, accountId);

            try ( ResultSet rs = ps.executeQuery()) {
                DAOProductDetail productDetailDAO = new DAOProductDetail();

                while (rs.next()) {
                    int productId = rs.getInt("ProductID");
                    String productName = rs.getString("ProductName");
                    String description = rs.getString("Description");

                    Product product = new Product(productId, productName, description);

                    ProductDetail productDetail = productDetailDAO.getProductDetailByProductId(productId);
                    System.out.println("concacacac" + productDetail.getPrice());
                    product.setProductDetail(productDetail);

                    Wishlist wishlistItem = new Wishlist(product);
                    wishlistItems.add(wishlistItem);
                }
            }
        } catch (SQLException e) {
            System.out.println("Error while retrieving wishlist items: " + e.getMessage());
        }

        return wishlistItems;
    }

    public boolean deleteFromWishlist(int productId) {
        String sql = "DELETE FROM [SWP].[dbo].[Wishlist] WHERE ProductID = ?";

        try ( PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, productId);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.out.println("Error while deleting from wishlist: " + e.getMessage());
            return false;
        }
    }
}
