/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

/**
 *
 * @author nguye
 */
public class AccountVoucher {
    private int AccountID;
    private int VoucherID;

    public AccountVoucher(int AccountID, int VoucherID) {
        this.AccountID = AccountID;
        this.VoucherID = VoucherID;
    }

    public int getAccountID() {
        return AccountID;
    }

    public void setAccountID(int AccountID) {
        this.AccountID = AccountID;
    }

    public int getVoucherID() {
        return VoucherID;
    }

    public void setVoucherID(int VoucherID) {
        this.VoucherID = VoucherID;
    }

    @Override
    public String toString() {
        return "AccountVoucher{" + "AccountID=" + AccountID + ", VoucherID=" + VoucherID + '}';
    }
    
}
