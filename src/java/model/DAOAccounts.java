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

/**
 *
 * @author Admin
 */
public class DAOAccounts extends DBConnection {

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
                            rs.getInt("AccountStatus"));
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
                int AccountStatus = rs.getInt("AccountStatus");
                // Tạo đối tượng Accounts với dữ liệu đúng
                Accounts acc = new Accounts(AccountID, UserName, Password, FullName, Gender, Phone, Email, Address, Role, Image, GoogleID, CreateDate, AccountStatus);
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
                        rs.getInt("AccountStatus"));
                return acc;
            }
        } catch (SQLException e) {
            System.out.println("Error cannot get account");
            return null;
        }
        return null;
    }

    public static void main(String[] args) {
        DAOAccounts acc = new DAOAccounts();
        acc.createAccount("minhchien", "Chien123456@", "DoMinhChien", "0987654333", "hihi1@gmail.com", "Staff", 1);
    }
}
