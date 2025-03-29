/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import entity.Order;
import entity.Cart;
import entity.SalesData;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Date;
import java.util.Vector;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.sql.Types;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * @author nguye
 */
public class DAOOrder extends DBConnection {

    public void changeStaffID(int oid, int StafID) {
        String sql = "update Orders set StaffID=" + StafID + " where OrderID=" + oid;
        try {
            Statement state = conn.createStatement();
            state.executeUpdate(sql);
        } catch (SQLException ex) {
            Logger.getLogger(DAOOrder.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public Vector<Order> getOrderByStaffID(int StaffID) {
        Vector<Order> orders = new Vector<>();

        try {
            String sql = "SELECT * FROM Orders WHERE StaffID = ?";

            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, StaffID);

            
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Order order = new Order(
                        rs.getInt("OrderID"),
                        rs.getString("OrderCode"),
                        rs.getInt("CustomerID"),
                        rs.getString("CustomerName"),
                        rs.getDate("OrderDate"),
                        rs.getDate("ShippedDate"),
                        rs.getInt("ShippingFee"),
                        rs.getInt("TotalCost"),
                        rs.getString("Email"),
                        rs.getString("Phone"),
                        rs.getString("ShipAddress"),
                        rs.getInt("Discount"),
                        rs.getString("CancelNotification"),
                        rs.getString("Note"),
                        rs.getString("PaymentMethod"),
                        rs.getInt("OrderStatus")
                );
                orders.add(order);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return orders;
    }

    public Order getLatestOrder() {
        Order order = null;
        String sql = "SELECT TOP 1 * FROM Orders ORDER BY OrderDate DESC, OrderID DESC";

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                order = new Order(
                        rs.getInt("OrderID"),
                        rs.getInt("CustomerID"),
                        rs.getString("CustomerName"),
                        rs.getDate("OrderDate"),
                        rs.getDate("ShippedDate"),
                        rs.getInt("ShippingFee"),
                        rs.getInt("TotalCost"),
                        rs.getString("Email"),
                        rs.getString("Phone"),
                        rs.getString("ShipAddress"),
                        rs.getInt("Discount"),
                        rs.getString("CancelNotification"),
                        rs.getString("Note"),
                        rs.getString("PaymentMethod"),
                        rs.getInt("OrderStatus")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return order;
    }

    public int getRevunue(String sql) {
        int revenue = 0;
        try {
            Statement statement = conn.createStatement();
            ResultSet rs = statement.executeQuery(sql);
            if (rs.next()) {
                revenue = rs.getInt("TotalSum");
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return revenue;
    }

    public int getNumberOrder(String sql) {
        int OrderCount = 0;
        try {
            Statement statement = conn.createStatement();
            ResultSet rs = statement.executeQuery(sql);
            if (rs.next()) {
                OrderCount = rs.getInt("OrderCount");
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return OrderCount;
    }

    public List<Map<String, Object>> getOrderDetails(String statusFilter, String startDate, String endDate, String sortBy, String sortOrder, String paymentMethod) {
    List<Map<String, Object>> list = new ArrayList<>();
    Map<Integer, Double> orderTotalMap = new HashMap<>();

    // Xây dựng SQL query với điều kiện lọc
    StringBuilder sql = new StringBuilder(
        "SELECT *," +        
        "SUM(od.Quantity) OVER (PARTITION BY o.OrderID) AS TotalQuantity " +
        "FROM OrderDetail od " +
        "JOIN Orders o ON od.OrderID = o.OrderID " +
        "JOIN ProductDetail pd ON od.ProductID = pd.ID " +
        "JOIN Products p ON pd.ProductID = p.ProductID " +
        "JOIN ( " +
        "    SELECT ProductID, SUM(Quantity) AS TotalStock " +
        "    FROM ProductDetail " +
        "    GROUP BY ProductID " +
        ") s ON s.ProductID = p.ProductID " +
        "WHERE o.OrderDate BETWEEN ? AND ?"
    );

    // Thêm điều kiện lọc theo trạng thái nếu có
    if (statusFilter != null && !statusFilter.trim().isEmpty()) {
        sql.append(" AND o.OrderStatus IN (").append(statusFilter).append(")");
    }

    // Thêm điều kiện lọc theo phương thức thanh toán nếu có
    if (paymentMethod != null && !paymentMethod.trim().isEmpty()) {
        sql.append(" AND o.PaymentMethod = ?");
    }

    // Thêm phần ORDER BY
    if (sortBy != null && !sortBy.trim().isEmpty()) {
        if (sortBy.equalsIgnoreCase("Quantity")) {
            sql.append(" ORDER BY TotalQuantity ");
        } else {
            sql.append(" ORDER BY ").append(sortBy);
        }

        if (sortOrder != null && (sortOrder.equalsIgnoreCase("ASC") || sortOrder.equalsIgnoreCase("DESC"))) {
            sql.append(" ").append(sortOrder);
        } else {
            sql.append(" ASC");
        }
    }

    try (PreparedStatement ps = conn.prepareStatement(sql.toString())) {
        int paramIndex = 1;
        
        // Đặt giá trị cho startDate và endDate
        ps.setString(paramIndex++, startDate);
        ps.setString(paramIndex++, endDate);

        // Đặt giá trị cho PaymentMethod nếu có
        if (paymentMethod != null && !paymentMethod.trim().isEmpty()) {
            ps.setString(paramIndex++, paymentMethod);
        }

        // Chạy query
        try (ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                int orderId = rs.getInt("OrderID");
                double price = rs.getDouble("UnitPrice");
                int quantity = rs.getInt("Quantity");
                
                // Lưu thông tin đơn hàng vào danh sách
                Map<String, Object> row = new HashMap<>();
                row.put("OrderID", orderId);
                row.put("orderCode", rs.getString("orderCode"));
                row.put("ProductName", rs.getString("ProductName"));
                row.put("Quantity", quantity);
                row.put("Stock", rs.getInt("TotalStock"));
                row.put("UnitPrice", price);
                row.put("OrderStatus", rs.getInt("OrderStatus"));
                row.put("ShipAddress", rs.getString("ShipAddress"));
                row.put("PaymentMethod", rs.getString("PaymentMethod"));
                row.put("TotalQuantity", rs.getInt("TotalQuantity"));
                row.put("TotalCost",rs.getInt("TotalCost"));
                
                list.add(row);

                // Tính tổng tiền cho từng OrderID
                orderTotalMap.put(orderId, orderTotalMap.getOrDefault(orderId, 0.0) + (price * quantity));
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }

    // Gán tổng tiền vào danh sách
    for (Map<String, Object> order : list) {
        int orderId = (int) order.get("OrderID");
        order.put("TotalAmount", orderTotalMap.get(orderId));
    }

    return list;
}

    public void updateStatus(int orderId, int status) throws SQLException {
        try {
            String sql = "UPDATE Orders SET OrderStatus = ? WHERE OrderID = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, status);
            pstmt.setInt(2, orderId);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<SalesData> getData(String startDate, String endDate) {
        List<SalesData> data = new ArrayList<>();
        try {
            String sql = "SELECT FORMAT(OrderDate, 'yyyy-MM-dd') AS YearMonth, TotalCost FROM Orders "
                    + "WHERE OrderDate BETWEEN ? AND ? ORDER BY OrderDate;";

            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, startDate);
            pstmt.setString(2, endDate);
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

    public int insertOrder(Order o) {
        int n = 0;
        String sql = "INSERT INTO [dbo].[Orders] "
                + "([CustomerID], [CustomerName], [OrderDate], [ShippedDate], [ShippingFee], "
                + "[TotalCost], [Email], [Phone], [ShipAddress], [Discount], "
                + "[CancelNotification], [Note], [PaymentMethod], [OrderStatus]) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);

            // ✅ Kiểm tra nếu CustomerID là null thì đặt NULL vào SQL
            if (o.getCustomerID() != null) {
                ps.setInt(1, o.getCustomerID());
            } else {
                ps.setNull(1, Types.INTEGER);
            }

            ps.setString(2, o.getCustomerName());
            if (o.getOrderDate() != null) {
                ps.setDate(3, new java.sql.Date(o.getOrderDate().getTime()));
            } else {
                ps.setNull(3, Types.DATE);
            }

            if (o.getShippedDate() != null) {
                ps.setDate(4, new java.sql.Date(o.getShippedDate().getTime()));
            } else {
                ps.setNull(4, Types.DATE);
            }
            ps.setInt(5, o.getShippingFee());
            ps.setInt(6, o.getTotalCost());
            ps.setString(7, o.getEmail());
            ps.setString(8, o.getPhone());
            ps.setString(9, o.getShipAddress());
            ps.setInt(10, o.getDiscount());
            ps.setString(11, o.getCancelNotification());
            ps.setString(12, o.getNote());
            ps.setString(13, o.getPaymentMethod());
            ps.setInt(14, o.getOrderStatus());

            // ✅ Thực thi truy vấn
            n = ps.executeUpdate();

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

    public int getTotalOrders(String countQuery) {
        int total = 0;
        try {
            ResultSet rs = getData(countQuery); // Giả sử getData trả về ResultSet từ SQL
            if (rs.next()) {
                total = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return total;
    }

    public int deleteOrder(int oid) {
        int n = 0;
        String sqlCheck = "Select * from [OrderDetail] where OrderID=" + oid;
        ResultSet rs = getData(sqlCheck);
        try {
            if (rs.next()) {
                changeStatus(oid, -1);
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
                + "      ,[ShippedDate] = ?,[ShippingFee] = ?,[TotalCost] = ?,[Email] = ?,[Phone] = ?\n"
                + "      ,[ShipAddress] = ?,[Discount] = ?,[CancelNotification] = ?,[Note] = ?,[PaymentMethod] = ?,[OrderStatus] = ?\n"
                + " WHERE [OrderID] = ?";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setObject(1, o.getCustomerID());
            pre.setObject(2, o.getCustomerName());
            pre.setObject(3, o.getOrderDate());
            pre.setObject(4, o.getShippedDate());
            pre.setObject(5, o.getShippingFee());
            pre.setObject(6, o.getTotalCost());
            pre.setObject(7, o.getEmail());
            pre.setObject(8, o.getPhone());
            pre.setObject(9, o.getShipAddress());
            pre.setObject(10, o.getDiscount());
            pre.setObject(11, o.getCancelNotification());
            pre.setObject(12, o.getNote());
            pre.setObject(13, o.getPaymentMethod());
            pre.setObject(14, o.getOrderStatus());
            pre.setObject(15, o.getOrderID());
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
                String OrderCode = rs.getString("OrderCode");
                String CustomerName = rs.getString("CustomerName");
                Date OrderDate = rs.getDate("OrderDate");
                Date ShippedDate = rs.getDate("ShippedDate");
                int ShippingFee = rs.getInt("ShippingFee");
                int TotalCost = rs.getInt("TotalCost");
                String Email = rs.getString("Email");
                String Phone = rs.getString("Phone");
                String ShipAddress = rs.getString("ShipAddress");
                int Discount = rs.getInt("Discount");
                String CancelNotification = rs.getString("CancelNotification");
                String Note = rs.getString("Note");
                String PaymentMethod = rs.getString("PaymentMethod");
                int OrderStatus = rs.getInt("OrderStatus");
                Order or = new Order(OrderID, OrderCode, CustomerID, CustomerName, OrderDate, ShippedDate, ShippingFee, TotalCost, Email, Phone, ShipAddress, Discount, CancelNotification, Note, PaymentMethod, OrderStatus);
                vector.add(or);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOOrder.class.getName()).log(Level.SEVERE, null, ex);
        }
        return vector;
    }

    public Order getOrderByOrderID(int orderID) {
        Order order = null;
        String query = "SELECT * FROM Orders WHERE OrderID = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, orderID);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    order = new Order(rs.getInt("OrderID"),
                            rs.getString("orderCode"),
                            rs.getInt("CustomerID"),
                            rs.getInt("TotalCost"),
                            rs.getInt("OrderStatus"),
                            rs.getString("CustomerName"),
                            rs.getString("ShipAddress"),
                            rs.getString("Phone"),
                            rs.getDate("OrderDate"),
                            rs.getDate("ShippedDate"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return order;
    }

    public void addToOrder(Cart cart) {
        String sql = "select top 1 OrderID from Orders order by OrderID desc";
        PreparedStatement pre;
        try {
            pre = conn.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            if (rs.next()) {
                int oid = rs.getInt(1);
                String sql2 = "INSERT INTO [dbo].[OrderDetail]\n"
                        + "           ([OrderID]\n"
                        + "           ,[ProductID]\n"
                        + "           ,[Quantity]\n"
                        + "           ,[UnitPrice])\n"
                        + "     VALUES(?,?,?,?)";
                PreparedStatement state = conn.prepareStatement(sql2);
                state.setObject(1, oid);
                state.setObject(2, cart.getID());
                state.setObject(3, cart.getQuantity());
                state.setObject(4, cart.getPrice());
                state.executeQuery();
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOOrder.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public static void main(String[] args) {
        DAOOrder dao = new DAOOrder();
        Vector<Order> vectorOrder = dao.getOrderByStaffID(5);
       
            System.out.println(vectorOrder.size());   
    }
}
