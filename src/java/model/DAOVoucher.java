/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import entity.Voucher;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Date;
import java.util.Vector;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.sql.PreparedStatement;


/**
 *
 * @author nguye
 */
public class DAOVoucher extends DBConnection {
    public Voucher getVoucherByID(int voucherID) {
    Voucher voucher = null;
    String sql = "SELECT * FROM Voucher WHERE VoucherID = ?";
    
    try (PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setInt(1, voucherID);
        ResultSet rs = ps.executeQuery();
        
        if (rs.next()) { // Chỉ lấy một dòng dữ liệu
            voucher = new Voucher(
                rs.getInt("VoucherID"),
                rs.getString("VoucherName"),
                rs.getInt("Discount"),
                rs.getInt("Quantity"),
                rs.getDate("StartDate"),
                rs.getDate("EndDate"),
                rs.getString("Description"),
                rs.getInt("VoucherStatus")
            );
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return voucher;
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
                int Quantity = rs.getInt("Quantity");
                Date StartDate = rs.getDate("StartDate");
                Date EndDate = rs.getDate("EndDate");
                String Description = rs.getString("Description");
                int VoucherStatus = rs.getInt("VoucherStatus");
                Voucher v = new  Voucher(VoucherID, VoucherName, Discount, Quantity, StartDate, EndDate, Description, VoucherStatus);
                vector.add(v);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOVoucher.class.getName()).log(Level.SEVERE, null, ex);
        }
        return vector;
    }
    public static void main(String[] args) {
        DAOVoucher dao = new DAOVoucher();
        Voucher voucher = dao.getVoucherByID(2);
        if(voucher == null){
            System.out.println("null");
        }else{
            System.out.println(voucher.getDiscount());
        }
    }
}
