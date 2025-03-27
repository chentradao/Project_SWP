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
    
    // Hàm getTotalCost để tính tổng giá nhập hoặc chi phí khác dựa trên truy vấn SQL
    public int getTotalCost(String sql) {
        int totalCost = 0;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();
            if (rs.next()) {
                totalCost = rs.getInt(1); // Lấy giá trị đầu tiên từ kết quả (TotalImportCost)
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOOrderDetail.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
            } catch (SQLException ex) {
                Logger.getLogger(DAOOrderDetail.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return totalCost;
    }
    
    public static void main(String[] args) {
        DAOOrderDetail dao = new DAOOrderDetail();
        String importCostSql = "SELECT SUM(od.Quantity * p.ImportPrice) AS TotalImportCost " +
                      "FROM [SWP].[dbo].[OrderDetail] od " +
                      "JOIN [SWP].[dbo].[ProductDetail] p ON od.ProductID = p.ProductID " +
                      "JOIN [SWP].[dbo].[Orders] o ON od.OrderID = o.OrderID ";
        
        int total = dao.getTotalCost(importCostSql);
        System.out.println(total);
    }
}
