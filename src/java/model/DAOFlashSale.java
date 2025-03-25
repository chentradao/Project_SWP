/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import entity.FlashSale;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Date;
import java.util.Vector;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.sql.Types;

/**
 *
 * @author nguye
 */
public class DAOFlashSale extends DBConnection {

    public int insertFlashSale(FlashSale fs) {
        int n = 0;
        String sql = "INSERT INTO [dbo].[FlashSale]\n"
                + "           ([ProductID],[StartTime],[EndTime]\n"
                + "           ,[Discount],[Quantity],[TimeFrame],[Status])\n"
                + "     VALUES (?,?,?,?,?,?,?)";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setObject(1, fs.getProductID());
            pre.setObject(2, fs.getStartTime());
            pre.setObject(3, fs.getEndTime());
            pre.setObject(4, fs.getDiscount());
            pre.setObject(5, fs.getQuantity());
            pre.setObject(6, fs.getTimeFrame());
            pre.setObject(7, fs.getStatus());
            n = pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DAOFlashSale.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;
    }

    public int updateFlashSale(FlashSale fs) {
        int n = 0;
        String sql = "UPDATE [dbo].[FlashSale]\n"
                + "   SET [ProductID] = ?,[StartTime] = ?,[EndTime] = ?,[Discount] = ?\n"
                + "      ,[Quantity] = ?,[TimeFrame] = ?,[Status] = ?\n"
                + " WHERE [SaleID] = ?";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setObject(1, fs.getProductID());
            pre.setObject(2, fs.getStartTime());
            pre.setObject(3, fs.getEndTime());
            pre.setObject(4, fs.getDiscount());
            pre.setObject(5, fs.getQuantity());
            pre.setObject(6, fs.getTimeFrame());
            pre.setObject(7, fs.getStatus());
            pre.setObject(8, fs.getSaleID());
            n = pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DAOFlashSale.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;
    }
    public FlashSale findFSByID(int fid){
        FlashSale fs = null;
         String sql = "SELECT * FROM FlashSale WHERE SaleID = ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, fid);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) { // Chỉ lấy một dòng dữ liệu
                fs = new FlashSale(
                        rs.getInt("VoucherID"),
                        rs.getInt("VoucherID"),
                        rs.getDate("StartTime"),
                        rs.getDate("EndTime"),
                        rs.getInt("Discount"),
                        rs.getInt("Quantity"),
                        rs.getInt("TimeFrame"),
                        rs.getInt("Status")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return fs;
    }
    public static void main(String[] args) {
        DAOFlashSale dao = new DAOFlashSale();
        FlashSale n = dao.findFSByID(1);
        System.out.println(n);
    }
}
