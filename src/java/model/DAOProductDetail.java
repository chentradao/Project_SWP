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
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Vector;
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
        String sql = "SELECT p.ProductID, p.ProductName, p.CategoryID, pd.Quantity, pd.SoldQuantity, "
                + "p.Date, p.Description, p.ProductStatus, "
                + "pd.ID, pd.Size, pd.Color, pd.Price, pd.Image "
                + "FROM Products p "
                + "JOIN ProductDetail pd ON p.ProductID = pd.ProductID "
                + "WHERE p.ProductID = ?";
        try (PreparedStatement st = conn.prepareStatement(sql)) {
            st.setInt(1, productId);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    return new ProductDetail(
                            rs.getInt("ProductID"),
                            rs.getString("ProductName"),
                            rs.getInt("CategoryID"),
                            rs.getInt("Quantity"),
                            rs.getInt("SoldQuantity"),
                            rs.getDate("Date"),
                            rs.getString("Description"),
                            rs.getInt("ProductStatus"),
                            rs.getInt("ID"),
                            rs.getString("Size"),
                            rs.getString("Color"),
                            rs.getInt("Price"),
                            rs.getString("Image")
                    );
                }
            }
        } catch (SQLException e) {
            Logger.getLogger(DAOProducts.class.getName())
                    .log(Level.SEVERE, "Error fetching product with ID: " + productId, e);
        }
        return null;
    }
    
    public ProductDetail getProDetailbyID(int ID){
        ProductDetail pro = null;
        String sql = "Select * from ProductDetail pd join Products p ON p.ProductID = pd.ProductID Where ID=" +ID;
        try {
            ResultSet rs = conn.createStatement().executeQuery(sql);
            if(rs.next()){
                pro = new ProductDetail(
                        rs.getInt("ID"), 
                        rs.getString("ProductName"),
                        rs.getInt("ProductID"),
                        rs.getString("IdentityCode"),
                        rs.getString("Size"), 
                        rs.getString("Color"), 
                        rs.getInt("Quantity"),
                        rs.getInt("SoldQuantity"), 
                        rs.getDate("DateCreate"),
                        rs.getInt("ImportPrice"), 
                        rs.getInt("Price"),
                        rs.getString("Image"), 
                        rs.getInt("ProductStatus"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOProductDetail.class.getName()).log(Level.SEVERE, null, ex);
        }
        return pro;
    }

    public int updateProductDetail(ProductDetail pro) {
        int n = 0;
        String sql = "UPDATE [dbo].[ProductDetail]\n"
                + "   SET [ProductID] = ?,[IdentityCode] = ?,[Size] = ?,[Color] = ?\n"
                + "      ,[Quantity] = ?,[SoldQuantity] = ?,[DateCreate] = ?\n"
                + "      ,[ImportPrice] = ?,[Price] = ?,[Image] = ?,[ProductStatus] = ?\n"
                + " WHERE [ID] = ?";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setObject(1, pro.getProductId());
            pre.setObject(2, pro.getIdentityCode());
            pre.setObject(3, pro.getSize());
            pre.setObject(4, pro.getColor());
            pre.setObject(5, pro.getQuantity());
            pre.setObject(6, pro.getSoldQuantity());
            pre.setObject(7, pro.getDateCreate());
            pre.setObject(8, pro.getImportPrice());
            pre.setObject(9, pro.getPrice());
            pre.setObject(10, pro.getImage());
            pre.setObject(11, pro.getProductStatus());
            pre.setObject(12, pro.getID());
            n = pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DAOProductDetail.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;
    }
    
    public Vector<ProductDetail> getProductDetail(String sql){
        Vector<ProductDetail> vector = new Vector<>();
        try {
            Statement state = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ResultSet rs = state.executeQuery(sql);
            while (rs.next()) {
                int ID = rs.getInt("ID");
                    String productName = rs.getString("ProductName");
                    int productId = rs.getInt("ProductID");
                    String IdentityCode = rs.getString("IdentityCode");
                    String Size = rs.getString("Size");
                    String Color = rs.getString("Color");
                    int quantity = rs.getInt("Quantity");
                    int soldQuantity = rs.getInt("SoldQuantity");
                    java.sql.Date date = rs.getDate("DateCreate");
                    int ImportPrice = rs.getInt("ImportPrice");
                    int Price = rs.getInt("Price");
                    String Image = rs.getString("Image");
                    int productStatus = rs.getInt("ProductStatus");
                    ProductDetail pd = new ProductDetail(ID, productName, productId, IdentityCode, Size, Color, quantity, soldQuantity, date, ImportPrice, Price, Image, productStatus);
                    vector.add(pd);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOProductDetail.class.getName()).log(Level.SEVERE, null, ex);
        }
        return vector;
    }

    public List<ProductDetail> getAllProducts(int limit) {
        List<ProductDetail> productList = new ArrayList<>();
        String sql = "select p.ProductID, p.ProductName, p.CategoryID, p.Quantity, p.SoldQuantity,\n"
                + "p.Date, p.Description, p.ProductStatus, pd.ID, \n"
                + "pd.Size, pd.Color, pd.Price,pd.Image\n"
                + "from Products p join ProductDetail pd on p.ProductID = pd.ProductID";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, limit);  // Set the limit parameter

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    int ID = rs.getInt("ID");
                    String productName = rs.getString("ProductName");
                    int productId = rs.getInt("ProductID");
                    String IdentityCode = rs.getString("IdentityCode");
                    String Size = rs.getString("Size");
                    String Color = rs.getString("Color");
                    int quantity = rs.getInt("Quantity");
                    int soldQuantity = rs.getInt("SoldQuantity");
                    java.sql.Date date = rs.getDate("DateCreate");
                    int ImportPrice = rs.getInt("ImportPrice");
                    int Price = rs.getInt("Price");
                    String Image = rs.getString("Image");
                    int productStatus = rs.getInt("ProductStatus");
                    ProductDetail pd = new ProductDetail(ID, productName, productId, IdentityCode, Size, Color, quantity, soldQuantity, date, ImportPrice, Price, Image, productStatus);
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

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, productId);

            try (ResultSet rs = ps.executeQuery()) {
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
    public static void main(String[] args) {
        DAOProductDetail dao = new DAOProductDetail();
        ProductDetail pro =dao.getProDetailbyID(10);
        System.out.println(pro);
    }

}
