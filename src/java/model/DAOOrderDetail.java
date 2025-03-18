/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import entity.OrderDetail;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author nguye
 */
public class DAOOrderDetail extends DBConnection{
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
        Vector<OrderDetail> vector = dao.getOrderDetailByOrderID(14);
        for(OrderDetail ord : vector){
            System.out.println(ord);
        }
    }
}
