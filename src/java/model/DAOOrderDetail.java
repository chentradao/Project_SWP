/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import entity.OrderDetail;
import java.util.LinkedHashMap;
import java.util.Map;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Vector;
import java.util.logging.Level;
import java.util.logging.Logger;


/**
 *
 * @author admin
 */
public class DAOOrderDetail extends DBConnection{
    public Map<String, Integer> getTop5BestSold(String sql){
        Map<String, Integer> productSales = new LinkedHashMap<>(); // Giữ thứ tự sản phẩm

        try  {
            

            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                String productName = rs.getString("ProductName");
                int totalSold = rs.getInt("TotalSold");
                productSales.put(productName, totalSold);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return productSales;
    }
    public Vector<OrderDetail> getOrderDetailByOrderID(int OrderID){
        Vector<OrderDetail> ord = new Vector<>();
        String sql ="Select * "
                + "From OrderDetail ord join ProductDetail pd on ord.ProductID = pd.ID join Products p on pd.ProductID = p.ProductID "
                + "Where OrderID =? ";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setInt(1, OrderID);
            ResultSet rs = pre.executeQuery();
            while(rs.next()){
                OrderDetail order = new OrderDetail(
                rs.getInt("OrderID"),
                rs.getInt("ProductID"),
                rs.getInt("Quantity"),
                rs.getInt("UnitPrice"),
                rs.getString("ProductName"),
                rs.getString("Size"),
                rs.getString("Color"),
                rs.getString("Image")
                );
                ord.add(order);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOOrderDetail.class.getName()).log(Level.SEVERE, null, ex);
        }
        return ord;
    }
    
    public static void main(String[] args) {
        DAOOrderDetail dao = new DAOOrderDetail();
        List<Map<String, Object>> productSales = new ArrayList<>();
        String sql = "SELECT TOP (5) od.ProductID, p.ProductName, SUM(od.Quantity) AS TotalSold " +
                         "FROM OrderDetail od " +
                         "JOIN Products p ON od.ProductID = p.ProductID " +
                         "JOIN Orders o ON od.OrderID = o.OrderID " +
                         "WHERE o.OrderDate BETWEEN '2025-01-01' AND '2025-02-01' " +
                         "GROUP BY od.ProductID, p.ProductName " +
                         "ORDER BY TotalSold DESC";
        
        
        System.out.println(productSales);
    }
}
