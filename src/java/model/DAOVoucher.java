package model;

import entity.Voucher;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Vector;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DAOVoucher extends DBConnection {

    public Voucher getVoucherByID(int id) {
        Voucher voucher = null;
        String sql = "SELECT * FROM Voucher WHERE VoucherID = " + id;
        try {
            ResultSet rs = conn.createStatement().executeQuery(sql);
            if (rs.next()) {
                voucher = new Voucher(
                        rs.getInt("VoucherID"),
                        rs.getString("VoucherName"),
                        rs.getInt("Discount"),
                        rs.getInt("MaxDiscount"),
                        rs.getInt("Quantity"),
                        rs.getDate("StartDate"),
                        rs.getDate("EndDate"),
                        rs.getString("Description"),
                        rs.getInt("VoucherStatus")
                );
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOVoucher.class.getName()).log(Level.SEVERE, null, ex);
        }
        return voucher;
    }

    public Voucher getVoucherByName(String name) {
        Voucher voucher = null;
        String sql = "SELECT * FROM Voucher WHERE VoucherName = '" + name +"'";
        try {
            ResultSet rs = conn.createStatement().executeQuery(sql);
            if (rs.next()) {
                voucher = new Voucher(
                        rs.getInt("VoucherID"),
                        rs.getString("VoucherName"),
                        rs.getInt("Discount"),
                        rs.getInt("MaxDiscount"),
                        rs.getInt("Quantity"),
                        rs.getDate("StartDate"),
                        rs.getDate("EndDate"),
                        rs.getString("Description"),
                        rs.getInt("VoucherStatus")
                );
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOVoucher.class.getName()).log(Level.SEVERE, null, ex);
        }
        return voucher;
    }

    public int createVoucher(Voucher voucher) {
        String sql = "INSERT INTO Voucher (VoucherName, Discount, Quantity, StartDate, EndDate, Description, VoucherStatus) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, voucher.getName());
            ps.setInt(2, voucher.getDiscount());
            ps.setInt(3, voucher.getMaxDiscount());
            ps.setInt(4, voucher.getQuantity());
            ps.setDate(5, new java.sql.Date(voucher.getStartDate().getTime()));
            ps.setDate(6, new java.sql.Date(voucher.getEndDate().getTime()));
            ps.setString(7, voucher.getDescription());
            ps.setInt(8, voucher.getStatus());
            ps.setInt(9, voucher.getId());
            ps.executeUpdate();
            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOVoucher.class.getName()).log(Level.SEVERE, null, ex);
        }
        return -1;
    }

    public int updateVoucherByHank(Voucher voucher) {
        int n = 0;
        String sql = "UPDATE Voucher SET VoucherName=?, Discount=?, Quantity=?, StartDate=?, EndDate=?, Description=?, VoucherStatus=? WHERE VoucherID=?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, voucher.getName());
            ps.setInt(2, voucher.getDiscount());
            ps.setInt(3, voucher.getMaxDiscount());
            ps.setInt(4, voucher.getQuantity());
            ps.setObject(5, voucher.getStartDate());
            ps.setObject(6, voucher.getEndDate());
            ps.setString(7, voucher.getDescription());
            ps.setInt(8, voucher.getStatus());
            ps.setInt(9, voucher.getId());
            n= ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DAOVoucher.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;
    }
    
    public boolean updateVoucher(Voucher voucher) {
        String sql = "UPDATE Voucher SET VoucherName=?, Discount=?, Quantity=?, StartDate=?, EndDate=?, Description=?, VoucherStatus=? WHERE VoucherID=?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, voucher.getName());
            ps.setInt(2, voucher.getDiscount());
            ps.setInt(3, voucher.getMaxDiscount());
            ps.setInt(4, voucher.getQuantity());
            ps.setDate(5, new java.sql.Date(voucher.getStartDate().getTime()));
            ps.setDate(6, new java.sql.Date(voucher.getEndDate().getTime()));
            ps.setString(7, voucher.getDescription());
            ps.setInt(8, voucher.getStatus());
            ps.setInt(9, voucher.getId());
            return ps.executeUpdate() > 0;
        } catch (SQLException ex) {
            Logger.getLogger(DAOVoucher.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public boolean deleteVoucher(int id) {
        String sql = "DELETE FROM Voucher WHERE VoucherID=?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException ex) {
            Logger.getLogger(DAOVoucher.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
    
    public Vector<Voucher> getVouchers(String sql) {
        Vector<Voucher> vector = new Vector<>();
        try {
            Statement state = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ResultSet rs = state.executeQuery(sql);
            while (rs.next()) {
                int VoucherID = rs.getInt("VoucherID");
                String VoucherName = rs.getString("VoucherName");
                int Discount = rs.getInt("Discount");
                int MaxDiscount = rs.getInt("MaxDiscount");
                int Quantity = rs.getInt("Quantity");
                java.util.Date StartDate = rs.getDate("StartDate");
                java.util.Date EndDate = rs.getDate("EndDate");
                String Description = rs.getString("Description");
                int VoucherStatus = rs.getInt("VoucherStatus");
                Voucher v = new Voucher(VoucherID, VoucherName, Discount, MaxDiscount,Quantity, StartDate, EndDate, Description, VoucherStatus);
                vector.add(v);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOVoucher.class.getName()).log(Level.SEVERE, null, ex);
        }
        return vector;
    }

    public List<Voucher> listVouchers() {
        List<Voucher> vouchers = new ArrayList<>();
        String sql = "SELECT * FROM Voucher";
        try {
            ResultSet rs = conn.createStatement().executeQuery(sql);
            while (rs.next()) {
                vouchers.add(new Voucher(
                        rs.getInt("VoucherID"),
                        rs.getString("VoucherName"),
                        rs.getInt("Discount"),
                        rs.getInt("MaxDiscount"),
                        rs.getInt("Quantity"),
                        rs.getDate("StartDate"),
                        rs.getDate("EndDate"),
                        rs.getString("Description"),
                        rs.getInt("VoucherStatus")
                ));
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOVoucher.class.getName()).log(Level.SEVERE, null, ex);
        }
        return vouchers;
    }
}
