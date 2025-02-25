/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import entity.Order;
import entity.Cart;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Date;
import java.util.Vector;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author nguye
 */
public class DAOOrder extends DBConnection {

    public int insertOrder(Order o) {
        int n = 0;
        String sql = "INSERT INTO [dbo].[Orders]\n"
                + "           ([CustomerID]\n"
                + "           ,[CustomerName]\n"
                + "           ,[OrderDate]\n"
                + "           ,[ShippedDate]\n"
                + "           ,[TotalCost]\n"
                + "           ,[Phone]\n"
                + "           ,[ShipAddress]\n"
                + "           ,[ShipCity]\n"
                + "           ,[OrderStatus])\n"
                + "     VALUES('" + o.getCustomerID() + "','" + o.getCustomerName() + "','" + o.getOrderDate() + "',"
                + "'" + o.getShippedDate() + "','" + o.getTotalCost() + "','" + o.getPhone() + "',"
                + "'" + o.getShipAddress() + "','" + o.getShipCity() + "','" + o.getOrderStatus() + "')";
        try {
            Statement state = conn.createStatement();
            n = state.executeUpdate(sql);
        } catch (SQLException ex) {
            Logger.getLogger(DAOOrder.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;
    }

    public void changeStatus(int oid, int newNumber) {
        String sql = "update Orders set OrderStatus=" + newNumber + " where OrderID=" + oid;
        try {
            Statement state = conn.createStatement();
            state.executeUpdate(sql);
        } catch (SQLException ex) {
            Logger.getLogger(DAOOrder.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public int deleteOrder(int oid) {
        int n = 0;
        String sqlCheck = "Select * from [Order Details] where OrderID=" + oid;
        ResultSet rs = getData(sqlCheck);
        try {
            if (rs.next()) {
                changeStatus(oid, 0);
                return 0;
            }
            String sql = "Delete from Orders where OrderID=" + oid;

            Statement state = conn.createStatement();
            n = state.executeUpdate(sql);
        } catch (SQLException ex) {
            Logger.getLogger(DAOOrder.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;
    }

    public int updateOrder(Order o) {
        int n = 0;
        String sql = "UPDATE [dbo].[Orders]\n"
                + "   SET [CustomerID] = ?,[CustomerName] = ?,[OrderDate] = ?\n"
                + "      ,[ShippedDate] = ?,[TotalCost] = ?,[Phone] = <?\n"
                + "      ,[ShipAddress] = ?,[ShipCity] = ?,[OrderStatus] = ?\n"
                + " WHERE [OrderID] = ?";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setObject(1, o.getCustomerID());
            pre.setObject(2, o.getCustomerName());
            pre.setObject(3, o.getOrderDate());
            pre.setObject(4, o.getShippedDate());
            pre.setObject(5, o.getTotalCost());
            pre.setObject(6, o.getPhone());
            pre.setObject(7, o.getShipAddress());
            pre.setObject(8, o.getShipCity());
            pre.setObject(9, o.getOrderStatus());
            pre.setObject(10, o.getOrderID());
            n = pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DAOOrder.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;
    }

    public Vector<Order> getOrders(String sql) {
        Vector<Order> vector = new Vector<>();
        try {
            Statement state = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ResultSet rs = state.executeQuery(sql);
            while (rs.next()) {
                int OrderID = rs.getInt("OrderID");
                int CustomerID = rs.getInt("CustomerID");
                String CustomerName = rs.getString("CustomerName");
                Date OrderDate = rs.getDate("OrderDate");
                Date ShippedDate = rs.getDate("ShippedDate");
                int TotalCost = rs.getInt("TotalCost");
                String Phone = rs.getString("Phone");
                String ShipAddress = rs.getString("ShipAddress");
                String ShipCity = rs.getString("ShipCity");
                int OrderStatus = rs.getInt("OrderStatus");
                Order or = new Order(OrderID, CustomerID, CustomerName, OrderDate, ShippedDate, TotalCost, Phone, ShipAddress, ShipCity, OrderStatus);
                vector.add(or);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOOrder.class.getName()).log(Level.SEVERE, null, ex);
        }
        return vector;
    }
    public void addToOrder(Cart cart){
        String sql ="select top 1 OrderID from Orders order by OrderID desc";
        PreparedStatement pre;
        try {
            pre = conn.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
        if(rs.next()){
            int oid = rs.getInt(1);
            String sql2 = "INSERT INTO [dbo].[Order Details]\n" +
"           ([OrderID]\n" +
"           ,[ProductID]\n" +
"           ,[UnitPrice]\n" +
"           ,[Quantity]\n" +
"           ,[Discount])\n" +
"     VALUES(?,?,?,?,?)";
            PreparedStatement state = conn.prepareStatement(sql2);
            state.setObject(1, oid);
            state.setObject(2, cart.getID());
            state.setObject(3, cart.getQuantity());
            state.setObject(4, cart.getPrice());
            state.setObject(5, "null");
            state.executeQuery();
        }
        } catch (SQLException ex) {
            Logger.getLogger(DAOOrder.class.getName()).log(Level.SEVERE, null, ex);
        }
        
    }
}
