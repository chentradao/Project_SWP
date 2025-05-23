/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import entity.ProductDetail;
import entity.ProductResponse;
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
                + "pd.ID, pd.Size, pd.Color, pd.Price, pd.Image, pd.Details "
                + "FROM Products p "
                + "JOIN ProductDetail pd ON p.ProductID = pd.ProductID "
                + "WHERE pd.ID = ?";
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
                            rs.getString("Image"),
                            rs.getString("Details")
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
                + "      ,[ImportPrice] = ?,[Price] = ?,[Image] = ?,[ProductStatus] = ?,[Details] = ?\n"
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
            pre.setObject(12, pro.getDetails());
            pre.setObject(13, pro.getID());
            n = pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DAOProductDetail.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;
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
                    int productId = rs.getInt("ProductID");
                    String productName = rs.getString("ProductName");
                    int categoryId = rs.getInt("CategoryID");
                    int quantity = rs.getInt("Quantity");
                    int soldQuantity = rs.getInt("SoldQuantity");
                    java.sql.Date date = rs.getDate("Date");
                    String description = rs.getString("Description");
                    int productStatus = rs.getInt("ProductStatus");
                    int ID = rs.getInt("ID");
                    String Size = rs.getString("Size");
                    String Color = rs.getString("Color");
                    int Price = rs.getInt("Price");
                    String Image = rs.getString("Image");
                    ProductDetail pd = new ProductDetail(productId, productName, categoryId,
                            quantity, soldQuantity, date, description,
                            productStatus, ID, Size, Color, Price, Image);
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
    public List<ProductResponse> getProductsWithFilter(int page, int pageSize,
            Integer minPrice, Integer maxPrice, String size, String color,
            Integer categoryId, String orderByPrice, String orderBySize) {

        List<ProductResponse> productList = new ArrayList<>();

        // Tính toán offset dựa trên page và pageSize
        int offset = (page - 1) * pageSize;

        // Base SQL query
        StringBuilder sql = new StringBuilder("SELECT p.ProductID, p.ProductName, p.CategoryID, pd.Quantity, pd.SoldQuantity,\n"
                + "p.Date, p.Description, p.ProductStatus, pd.ID, \n"
                + "pd.Size, pd.Color, pd.Price, pd.Image\n"
                + "FROM Products p\n"
                + "JOIN ProductDetail pd ON p.ProductID = pd.ProductID\n"
                + "WHERE 1=1 "); // Default condition to simplify adding further conditions

        // Adding conditions dynamically based on the filters
        if (minPrice != null) {
            sql.append("AND pd.Price >= ? ");
        }
        if (maxPrice != null) {
            sql.append("AND pd.Price <= ? ");
        }
        if (size != null && !size.isEmpty()) {
            sql.append("AND pd.Size = ? ");
        }
        if (color != null && !color.isEmpty()) {
            sql.append("AND pd.Color = ? ");
        }

        // Lọc sản phẩm dựa vào categoryId và danh mục con
        if (categoryId != null) {
            sql.append("AND (p.CategoryID IN (SELECT CategoryID FROM Categories WHERE RootCategoryID = ?) ");
            sql.append("OR p.CategoryID = ?) ");
        }

        // Sorting conditions
        // Always add ORDER BY to support OFFSET-FETCH
        if (orderByPrice != null && orderByPrice.equals("asc")) {
            sql.append("ORDER BY pd.Price ASC ");
        } else if (orderByPrice != null && orderByPrice.equals("desc")) {
            sql.append("ORDER BY pd.Price DESC ");
        } else if (orderBySize != null && orderBySize.equals("asc")) {
            sql.append("ORDER BY pd.sizeInt ASC ");
        } else if (orderBySize != null && orderBySize.equals("desc")) {
            sql.append("ORDER BY pd.sizeInt DESC ");
        } else {
            // Default ordering by ProductID if no sorting specified
            sql.append("ORDER BY p.ProductID ASC ");
        }

        // Adding offset and fetch for pagination (SQL Server)
        sql.append("OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

        try (PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            int index = 1;

            // Set the parameters dynamically based on the filters
            if (minPrice != null) {
                ps.setInt(index++, minPrice);
            }
            if (maxPrice != null) {
                ps.setInt(index++, maxPrice);
            }
            if (size != null && !size.isEmpty()) {
                ps.setString(index++, size);
            }
            if (color != null && !color.isEmpty()) {
                ps.setString(index++, color);
            }

            // If categoryId is provided, set it for filtering the child categories
            if (categoryId != null) {
                ps.setInt(index++, categoryId); // Set categoryId for filtering subcategories
                ps.setInt(index++, categoryId); // For filtering the category itself
            }

            // Set pagination parameters
            ps.setInt(index++, offset); // OFFSET (skip rows)
            ps.setInt(index++, pageSize);  // FETCH NEXT (fetch rows)

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    int productId = rs.getInt("ProductID");
                    String productName = rs.getString("ProductName");
                    int categoryIdRes = rs.getInt("CategoryID");
                    int quantity = rs.getInt("Quantity");
                    int soldQuantity = rs.getInt("SoldQuantity");
                    java.sql.Date date = rs.getDate("Date");
                    String description = rs.getString("Description");
                    String productStatus = rs.getString("ProductStatus");
                    String productImage = rs.getString("Image");
                    int ID = rs.getInt("ID");
                    String Size = rs.getString("Size");
                    String Color = rs.getString("Color");
                    int Price = rs.getInt("Price");
                    String Image = rs.getString("Image");

                    ProductResponse pd = new ProductResponse(productId, productName, Price, ID, quantity, Size, Color, Image);
                    productList.add(pd);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error while fetching products with filters", e);
        }
        return productList;
    }

}
