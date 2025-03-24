/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import entity.Accounts;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.sql.Date;
import java.sql.Statement;
import java.util.Vector;
import java.util.logging.Level;
import java.util.logging.Logger;
import entity.Order;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Admin
 */
public class DAOAccounts extends DBConnection {

    public List<Accounts> getAllAccounts1(String query) {
        List<Accounts> list = new ArrayList<>();
        try {
            PreparedStatement ps = conn.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Accounts acc = new Accounts();
                acc.setUserName(rs.getString("userName"));
                acc.setFullName(rs.getString("fullName"));
                acc.setPhone(rs.getString("phone"));
                acc.setEmail(rs.getString("email"));
                acc.setAddress(rs.getString("address"));
                acc.setRole(rs.getString("role"));
                acc.setAccountStatus(rs.getInt("accountStatus"));
                list.add(acc);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Phương thức mới để lấy dữ liệu theo trang
    public List<Accounts> getAccountsByPage(int start, int pageSize) {
        List<Accounts> list = new ArrayList<>();
        String query = "SELECT * FROM Accounts ORDER BY userName OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try {
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setInt(1, start);
            ps.setInt(2, pageSize);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Accounts acc = new Accounts();
                acc.setUserName(rs.getString("userName"));
                acc.setFullName(rs.getString("fullName"));
                acc.setPhone(rs.getString("phone"));
                acc.setEmail(rs.getString("email"));
                acc.setAddress(rs.getString("address"));
                acc.setRole(rs.getString("role"));
                acc.setAccountStatus(rs.getInt("accountStatus"));
                list.add(acc);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public Vector<Order> getOrdersByCustomer(int customerID, int offset, int pageSize, String sortBy, String sortOrder, String searchTerm) {
        Vector<Order> list = new Vector<>();
        String sql = "SELECT OrderID, CustomerID, CustomerName, OrderDate, ShippedDate, ShippingFee, TotalCost, Email, Phone, "
                + "ShipAddress, Discount, CancelNotification, Note, PaymentMethod, OrderStatus "
                + // Thêm Discount vào query
                "FROM Orders WHERE CustomerID = ?";

        // Thêm điều kiện tìm kiếm
        if (searchTerm != null && !searchTerm.trim().isEmpty()) {
            sql += " AND (PaymentMethod LIKE ? OR Email LIKE ? OR Phone LIKE ? OR ShipAddress LIKE ?)";
        }

        // Thêm sắp xếp với kiểm tra giá trị hợp lệ
        String sortColumn = "OrderDate";  // Giá trị mặc định
        if ("totalCost".equalsIgnoreCase(sortBy)) {
            sortColumn = "TotalCost";
        }
        String sortDirection = "ASC";  // Giá trị mặc định
        if ("desc".equalsIgnoreCase(sortOrder)) {
            sortDirection = "DESC";
        }
        sql += " ORDER BY " + sortColumn + " " + sortDirection
                + " OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            ps = conn.prepareStatement(sql);
            int paramIndex = 1;
            ps.setInt(paramIndex++, customerID);

            // Gán giá trị cho các tham số tìm kiếm
            if (searchTerm != null && !searchTerm.trim().isEmpty()) {
                String searchPattern = "%" + searchTerm.trim() + "%";
                ps.setString(paramIndex++, searchPattern); // PaymentMethod
                ps.setString(paramIndex++, searchPattern); // Email
                ps.setString(paramIndex++, searchPattern); // Phone
                ps.setString(paramIndex++, searchPattern); // ShipAddress
            }

            // Gán giá trị cho phân trang
            ps.setInt(paramIndex++, offset);
            ps.setInt(paramIndex, pageSize);

            rs = ps.executeQuery();

            while (rs.next()) {
                Order order = new Order(
                        rs.getInt("OrderID"), // Thêm OrderID
                        rs.getInt("CustomerID"),
                        rs.getString("CustomerName"),
                        rs.getDate("OrderDate"),
                        rs.getDate("ShippedDate"),
                        rs.getInt("ShippingFee"),
                        rs.getInt("TotalCost"),
                        rs.getString("Email"),
                        rs.getString("Phone"),
                        rs.getString("ShipAddress"),
                        rs.getInt("Discount"), // Thêm Discount
                        rs.getString("CancelNotification"),
                        rs.getString("Note"),
                        rs.getString("PaymentMethod"),
                        rs.getInt("OrderStatus")
                );
                list.add(order);
            }
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi khi truy vấn danh sách đơn hàng: " + e.getMessage(), e);
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
            } catch (SQLException e) {
                throw new RuntimeException("Lỗi khi đóng tài nguyên: " + e.getMessage(), e);
            }
        }
        return list;
    }

    // Cập nhật phương thức đếm tổng số đơn hàng với tìm kiếm theo paymentMethod
    public int getOrderCountByCustomer(int customerID, String searchTerm) {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM Orders WHERE CustomerID = ?";

        // Thêm điều kiện tìm kiếm trên cả 4 trường nếu searchTerm không rỗng
        if (searchTerm != null && !searchTerm.isEmpty()) {
            sql += " AND (PaymentMethod LIKE ? OR Email LIKE ? OR Phone LIKE ? OR ShipAddress LIKE ?)";
        }

        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            ps = conn.prepareStatement(sql);
            int paramIndex = 1;
            ps.setInt(paramIndex++, customerID);

            // Gán giá trị cho các tham số tìm kiếm
            if (searchTerm != null && !searchTerm.isEmpty()) {
                String searchPattern = "%" + searchTerm + "%";
                ps.setString(paramIndex++, searchPattern); // PaymentMethod
                ps.setString(paramIndex++, searchPattern); // Email
                ps.setString(paramIndex++, searchPattern); // Phone
                ps.setString(paramIndex++, searchPattern); // ShipAddress
            }

            rs = ps.executeQuery();

            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
            throw new RuntimeException("Lỗi khi đếm số đơn hàng: " + e.getMessage(), e);
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
            } catch (Exception e) {
                throw new RuntimeException("Lỗi khi đóng tài nguyên: " + e.getMessage(), e);
            }
        }
        return count;
    }

    public void createStaff(String UserName, String Password, String FullName,
            String Email, String Address, String Phone,
            String Role, int AccountStatus) throws SQLException {
        String sql = "INSERT INTO Accounts (UserName, Password, FullName, Email, Address, Phone, Role,CreateDate, AccountStatus) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?,?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, UserName);
            ps.setString(2, Password);
            ps.setString(3, FullName);
            ps.setString(4, Email);
            ps.setString(5, Address);
            ps.setString(6, Phone);
            ps.setString(7, Role);
            ps.setDate(8, Date.valueOf(LocalDate.now()));
            ps.setInt(9, AccountStatus);

            int rowsAffected = ps.executeUpdate();
            System.out.println("Rows affected: " + rowsAffected); // Debug
            if (rowsAffected == 0) {
                throw new SQLException("Không thể tạo tài khoản, không có dòng nào được thêm.");
            }
        }
    }

    public boolean isUsernameExists(String UserName) {
        String sql = "SELECT COUNT(*) FROM Accounts WHERE UserName = ?";
        try {
            PreparedStatement st = conn.prepareStatement(sql);
            st.setString(1, UserName);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException ex) {
            System.out.println(ex);
        }
        return false;
    }

    public void changeStatus(String status, String username) {
        int newStatus = (Integer.parseInt(status) == 1) ? 0 : 1;
        String query = "UPDATE Accounts SET AccountStatus = ? WHERE UserName = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setInt(1, newStatus);
            ps.setString(2, username);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void createAccount(String UserName, String Password, String FullName, String Phone, String Email, String Role, int AccountStatus) {
        String sql = "INSERT INTO Accounts (UserName, Password, FullName, Phone, Email, Role, CreateDate, AccountStatus) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement st = conn.prepareStatement(sql)) {
            st.setString(1, UserName);
            st.setString(2, Password);
            st.setString(3, FullName);
            st.setString(4, Phone);
            st.setString(5, Email);
            st.setString(6, Role);
            st.setDate(7, Date.valueOf(LocalDate.now())); // Lấy ngày hiện tại 
            st.setInt(8, AccountStatus);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Error while trying to sign up: " + e.getMessage());
        }
    }

// Kiểm tra đăng nhập
    public Accounts login(String UserName, String Password) {
        String sql = "SELECT * FROM Accounts WHERE UserName = ? AND Password = ?";
        try (PreparedStatement st = conn.prepareStatement(sql)) {
            st.setString(1, UserName);
            st.setString(2, Password);

            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    Accounts acc = new Accounts(rs.getInt("AccountID"),
                            rs.getString("UserName"),
                            rs.getString("Password"),
                            rs.getString("FullName"),
                            rs.getString("Gender"),
                            rs.getString("Phone"),
                            rs.getString("Email"),
                            rs.getString("Address"),
                            rs.getString("Role"),
                            rs.getString("Image"),
                            rs.getString("GoogleID"),
                            rs.getDate("CreateDate"),
                            rs.getInt("OrderQuality"),
                            rs.getInt("TotalSpending"),
                            rs.getInt("AccountStatus")
                    );
                    return acc;
                }
            }
        } catch (SQLException e) {
            System.out.println("Error while trying to login: " + e.getMessage());
        }
        return null;
    }

    public Vector<Accounts> getAllAccounts(String sql) {
        Vector<Accounts> vector = new Vector<>();
        try {
            Statement state = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ResultSet rs = state.executeQuery(sql);
            while (rs.next()) {
                int AccountID = rs.getInt("AccountID");
                String UserName = rs.getString("UserName");
                String Password = rs.getString("Password");
                String FullName = rs.getString("FullName");
                String Gender = rs.getString("Gender");
                String Phone = rs.getString("Phone");
                String Email = rs.getString("Email");
                String Address = rs.getString("Address");
                String Role = rs.getString("Role");
                String Image = rs.getString("Image");
                String GoogleID = rs.getString("GoogleID");
                Date CreateDate = rs.getDate("CreateDate");
                int OrderQuality = rs.getInt("OrderQuality");
                int TotalSpending = rs.getInt("TotalSpending");
                int AccountStatus = rs.getInt("AccountStatus");
                // Tạo đối tượng Accounts với dữ liệu đúng
                Accounts acc = new Accounts(AccountID, UserName, Password, FullName, Gender, Phone, Email, Address, Role, Image, GoogleID, CreateDate, OrderQuality, TotalSpending, AccountStatus);
                vector.add(acc);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOAccounts.class.getName()).log(Level.SEVERE, null, ex);
        }
        return vector;
    }

    public Accounts getAccountByUserName(String UserName) {
        String sql = "Select * from Accounts where UserName =?";
        try {
            PreparedStatement st = conn.prepareStatement(sql);
            st.setString(1, UserName);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                Accounts acc = new Accounts(rs.getInt("AccountID"),
                        rs.getString("UserName"),
                        rs.getString("Password"),
                        rs.getString("FullName"),
                        rs.getString("Gender"),
                        rs.getString("Phone"),
                        rs.getString("Email"),
                        rs.getString("Address"),
                        rs.getString("Role"),
                        rs.getString("Image"),
                        rs.getString("GoogleID"),
                        rs.getDate("CreateDate"),
                        rs.getInt("OrderQuality"),
                        rs.getInt("TotalSpending"),
                        rs.getInt("AccountStatus"));
                return acc;
            }
        } catch (SQLException e) {
            System.out.println("Error cannot get account");
            return null;
        }
        return null;
    }

    public Accounts getAccountByAccountID(String AccountID) {
        String sql = "Select * from Accounts where AccountID =?";
        try {
            PreparedStatement st = conn.prepareStatement(sql);
            st.setString(1, AccountID);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                Accounts acc = new Accounts(rs.getInt("AccountID"),
                        rs.getString("UserName"),
                        rs.getString("Password"),
                        rs.getString("FullName"),
                        rs.getString("Gender"),
                        rs.getString("Phone"),
                        rs.getString("Email"),
                        rs.getString("Address"),
                        rs.getString("Role"),
                        rs.getString("Image"),
                        rs.getString("GoogleID"),
                        rs.getDate("CreateDate"),
                        rs.getInt("OrderQuality"),
                        rs.getInt("TotalSpending"),
                        rs.getInt("AccountStatus"));
                return acc;
            }
        } catch (SQLException e) {
            System.out.println("Error cannot get account");
            return null;
        }
        return null;
    }

    public Accounts getAccountByEmail(String Email) {
        String sql = "Select * from Accounts where Email =?";
        try {
            PreparedStatement st = conn.prepareStatement(sql);
            st.setString(1, Email);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                Accounts acc = new Accounts(rs.getInt("AccountID"),
                        rs.getString("UserName"),
                        rs.getString("Password"),
                        rs.getString("FullName"),
                        rs.getString("Gender"),
                        rs.getString("Phone"),
                        rs.getString("Email"),
                        rs.getString("Address"),
                        rs.getString("Role"),
                        rs.getString("Image"),
                        rs.getString("GoogleID"),
                        rs.getDate("CreateDate"),
                        rs.getInt("OrderQuality"),
                        rs.getInt("TotalSpending"),
                        rs.getInt("AccountStatus"));
                return acc;
            }
        } catch (SQLException e) {
            System.out.println("Error cannot get account");
            return null;
        }
        return null;
    }

    public Accounts getAccountByPhone(String Phone) {
        String sql = "Select * from Accounts where Phone =?";
        try {
            PreparedStatement st = conn.prepareStatement(sql);
            st.setString(1, Phone);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                Accounts acc = new Accounts(rs.getInt("AccountID"),
                        rs.getString("UserName"),
                        rs.getString("Password"),
                        rs.getString("FullName"),
                        rs.getString("Gender"),
                        rs.getString("Phone"),
                        rs.getString("Email"),
                        rs.getString("Address"),
                        rs.getString("Role"),
                        rs.getString("Image"),
                        rs.getString("GoogleID"),
                        rs.getDate("CreateDate"),
                        rs.getInt("OrderQuality"),
                        rs.getInt("TotalSpending"),
                        rs.getInt("AccountStatus"));
                return acc;
            }
        } catch (SQLException e) {
            System.out.println("Error cannot get account");
            return null;
        }
        return null;
    }

    public void updateAccounts(String AccountID, String FullName, String Gender, String Phone, String Email, String Address, String Image) {
        String sql = "UPDATE Accounts SET FullName = ?, Gender = ?, Phone = ?, Email = ?,Address = ?, Image = ? WHERE AccountID = ?";

        try (PreparedStatement st = conn.prepareStatement(sql)) {
            st.setString(1, FullName);
            st.setString(2, Gender);
            st.setString(3, Phone);
            st.setString(4, Email);
            st.setString(5, Address);
            st.setString(6, Image);
            st.setString(7, AccountID);

            int rowsAffected = st.executeUpdate();
            System.out.println("Rows affected: " + rowsAffected); // Thêm dòng này để kiểm tra
            if (rowsAffected > 0) {
                System.out.println("Cập nhật thông tin người dùng thành công.");
            } else {
                System.out.println("Không tìm thấy người dùng với ID đã cho.");
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    public int getCount(String search) {
        int count = 0;
        String query = "SELECT COUNT(*) FROM Accounts WHERE Role = 'Customer'";
        if (!search.isEmpty()) {
            query += " AND (FullName LIKE ? OR Phone LIKE ? OR Email LIKE ?)";
        }
        try (PreparedStatement ps = conn.prepareStatement(query)) {
            if (!search.isEmpty()) {
                ps.setString(1, "%" + search + "%");
                ps.setString(2, "%" + search + "%");
                ps.setString(3, "%" + search + "%");
            }
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    count = rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            Logger.getLogger(DAOAccounts.class.getName()).log(Level.SEVERE, null, e);
        }
        return count;
    }

    public Vector<Accounts> getCustomers(int offset, int pageSize, String search, String sortBy, String sortOrder) {
        Vector<Accounts> vector = new Vector<>();
        String sql = "SELECT a.AccountID, a.UserName, a.Password, a.FullName, a.Gender, a.Phone, a.Email, a.Address, a.Role, "
                + "a.Image, a.GoogleID, a.CreateDate, a.AccountStatus, "
                + "COUNT(o.OrderID) AS OrderQuality, COALESCE(SUM(o.TotalCost), 0) AS TotalSpending "
                + "FROM Accounts a "
                + "LEFT JOIN Orders o ON a.AccountID = o.CustomerID "
                + "WHERE a.Role = 'Customer' ";
        if (!search.isEmpty()) {
            sql += "AND (a.FullName LIKE ? OR a.Phone LIKE ? OR a.Email LIKE ?) ";
        }
        sql += "GROUP BY a.AccountID, a.UserName, a.Password, a.FullName, a.Gender, a.Phone, a.Email, a.Address, "
                + "a.Role, a.Image, a.GoogleID, a.CreateDate, a.AccountStatus "
                + "ORDER BY ";
        if ("OrderQuality".equalsIgnoreCase(sortBy)) {
            sql += "COUNT(o.OrderID) ";
        } else if ("TotalSpending".equalsIgnoreCase(sortBy)) {
            sql += "COALESCE(SUM(o.TotalCost), 0) ";
        } else {
            sql += "a.AccountID "; // Mặc định sort theo AccountID nếu sortBy không hợp lệ
        }
        sql += sortOrder.equalsIgnoreCase("desc") ? "DESC " : "ASC ";
        sql += "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            int paramIndex = 1;
            if (!search.isEmpty()) {
                ps.setString(paramIndex++, "%" + search + "%");
                ps.setString(paramIndex++, "%" + search + "%");
                ps.setString(paramIndex++, "%" + search + "%");
            }
            ps.setInt(paramIndex++, offset);
            ps.setInt(paramIndex++, pageSize);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int AccountID = rs.getInt("AccountID");
                String UserName = rs.getString("UserName");
                String Password = rs.getString("Password");
                String FullName = rs.getString("FullName");
                String Gender = rs.getString("Gender");
                String Phone = rs.getString("Phone");
                String Email = rs.getString("Email");
                String Address = rs.getString("Address");
                String Role = rs.getString("Role");
                String Image = rs.getString("Image");
                String GoogleID = rs.getString("GoogleID");
                Date CreateDate = rs.getDate("CreateDate");
                int AccountStatus = rs.getInt("AccountStatus");
                int OrderQuality = rs.getInt("OrderQuality");
                double TotalSpending = rs.getDouble("TotalSpending");

                Accounts acc = new Accounts(AccountID, UserName, Password, FullName, Gender,
                        Phone, Email, Address, Role, Image, GoogleID, CreateDate, OrderQuality, (int) TotalSpending, AccountStatus);
                vector.add(acc);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOAccounts.class.getName()).log(Level.SEVERE, null, ex);
        }
        return vector;
    }

    public static void main(String[] args) {
        DAOAccounts acc = new DAOAccounts();
        //acc.createAccount("admin", "20042004", "Adminnnnn", "0999999999", "esteelauder046@gmail.com", "admin", 1);
        //acc.updateAccounts("1", "Minh", "M", "0987567567", "minhnq@gmail.com", "HaDong", "HaNoi", "");
        acc.createAccount("admin", "20042004", "ADMINNN", "0999999999", "minhnqhe181174fpt.edu.vn", "admin", 1);
    }
}
