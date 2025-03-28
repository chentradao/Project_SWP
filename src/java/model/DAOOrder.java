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

    public List<Map<String, Object>> getOrderDetails(String[] statusFilters, String startDate, String endDate) {
        List<Map<String, Object>> list = new ArrayList<>();
        Map<Integer, Double> orderTotalMap = new HashMap<>();

        // Xây dựng SQL query với điều kiện lọc
        StringBuilder sql = new StringBuilder(
                "SELECT o.OrderID,o.orderCode, p.ProductName, od.Quantity, od.UnitPrice, o.OrderStatus,o.ShipAddress "
                + "FROM OrderDetail od "
                + "JOIN Orders o ON od.OrderID = o.OrderID "
                + "JOIN Products p ON od.ProductID = p.ProductID "
                + "WHERE o.OrderDate BETWEEN ? AND ?"
        );

        // Thêm điều kiện lọc theo trạng thái nếu có
        if (statusFilters != null && statusFilters.length > 0) {
            sql.append(" AND o.OrderStatus IN (");
            sql.append(String.join(",", Collections.nCopies(statusFilters.length, "?")));
            sql.append(")");
        }

        try (PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            // Đặt giá trị cho startDate và endDate
            ps.setString(1, startDate);
            ps.setString(2, endDate);

            // Đặt giá trị cho OrderStatus nếu có
            if (statusFilters != null) {
                for (int i = 0; i < statusFilters.length; i++) {
                    ps.setInt(i + 3, Integer.parseInt(statusFilters[i]));  // Vị trí bắt đầu từ 3
                }
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
                    row.put("ShipAddress", rs.getString("ShipAddress"));
                    row.put("Price", price);
                    row.put("OrderStatus", rs.getInt("OrderStatus"));

                    list.add(row);

                    // Tính tổng tiền cho từng OrderID
                    orderTotalMap.put(orderId, orderTotalMap.getOrDefault(orderId, 0.0) + (price * quantity));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        // Gán tổng tiền vào danh sách (tránh mất đơn hàng cuối cùng)
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
        Vector<Order> vectorOrder = dao.getOrders("select * from Orders where OrderCode IS NOT NULL");
        for (Order order : vectorOrder) {
            System.out.println(order.getOrderCode());
        }
    }
}
