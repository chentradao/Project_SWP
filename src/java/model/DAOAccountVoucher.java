/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import entity.AccountVoucher;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author nguye
 */
public class DAOAccountVoucher extends DBConnection{

    public int insertAccountVoucher(AccountVoucher av) {
        int n = 0;
        String sql = "INSERT INTO [dbo].[AccountVoucher]\n"
                + "           ([AccountID]\n"
                + "           ,[VoucherID])\n"
                + "     VALUES (?,?)";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setInt(1, av.getAccountID());
            pre.setInt(2, av.getVoucherID());
            n = pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DAOAccountVoucher.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;
    }
    public boolean hasUsedVoucher(int vid, int aid){
        String sql = "Select * From AccountVoucher Where VoucherID ="+vid+" and AccountID ="+aid;
        ResultSet rs = getData(sql);
        try {
            if(rs.next()){
                return true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOAccountVoucher.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
}
