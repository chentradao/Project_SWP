
package model;

import java.sql.Statement;
import java.sql.ResultSet;
import entity.Order;
import entity.SalesData;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Vector;

public class DAOOrder extends DBConnection {

    public Vector<Order> getOrderBy(String sql) {
        Vector<Order> vector = new Vector<>();
        try {
            Statement statement = conn.createStatement();
            ResultSet rs = statement.executeQuery(sql);

            while (rs.next()) {
                int CustomerID = rs.getInt("CustomerID"),
                        TotalCost = rs.getInt("TotalCost"),
                        OrderStatus = rs.getInt("OrderStatus");
                String CustomerName = rs.getString("CustomerName"),
                        ShipAddress = rs.getString("ShipAddress"),
                        ShipCity = rs.getString("ShipCity"),
                        Phone = rs.getString("Phone");
                Date OrderDate = rs.getDate("OrderDate"),
                        ShippedDate = rs.getDate("ShippedDate");
                Order order = new Order(CustomerID, TotalCost, OrderStatus, CustomerName, ShipAddress, ShipCity, Phone, OrderDate, ShippedDate);
                vector.add(order);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        return vector;
    }
    public int getRevunue(String sql){
        int revenue = 0;
        try {
            Statement statement = conn.createStatement();
            ResultSet rs = statement.executeQuery(sql);
            if(rs.next()) {
                revenue = rs.getInt("TotalSum");
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return revenue;
    }
    public int getNumberOrder(){
        int OrderCount = 0;
        try {
            Statement statement = conn.createStatement();
            ResultSet rs = statement.executeQuery("SELECT COUNT(*) AS OrderCount FROM [SWP].[dbo].[Orders] WHERE OrderStatus = 1");
            if(rs.next()) {
                OrderCount = rs.getInt("OrderCount");
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return OrderCount;
    }
    public List<SalesData> getData(String startDate,String endDate){
        List<SalesData> data = new ArrayList<>();
        try {
            String sql = "SELECT FORMAT(OrderDate, 'yyyy-MM-dd') AS YearMonth, TotalCost FROM Orders " +
             "WHERE OrderDate BETWEEN ? AND ? ORDER BY OrderDate;";
            
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1,startDate );
            pstmt.setString(2,endDate );            
            ResultSet rs = pstmt.executeQuery();            
            while (rs.next()) {
                data.add(new SalesData(
                    rs.getString("YearMonth"),
                    rs.getInt("TotalCost")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return data;
    }
 
    public static void main(String[] args) {
        DAOOrder dao = new DAOOrder();
        Vector<Order> latestOrders = dao.getOrderBy("SELECT TOP (3) [OrderID][CustomerID],[CustomerName],[OrderDate],[ShippedDate],[TotalCost],[Phone],[ShipAddress],[ShipCity],[OrderStatus]\n" +
"FROM [SWP].[dbo].[Orders] ORDER BY [OrderDate] DESC");
        System.out.println(latestOrders.size()
        );
    }
}
