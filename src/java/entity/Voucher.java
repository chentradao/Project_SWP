/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import java.util.Date;

/**
 *
 * @author nguye
 */
public class Voucher {
    private int VoucherID;
    private String VoucherName;
    private int Discount;
    private int Quantity;
    private Date StartDate;
    private Date EndDate;
    private String Description;
    private int VoucherStatus;

    public Voucher(int VoucherID, String VoucherName, int Discount, int Quantity, Date StartDate, Date EndDate, String Description, int VoucherStatus) {
        this.VoucherID = VoucherID;
        this.VoucherName = VoucherName;
        this.Discount = Discount;
        this.Quantity = Quantity;
        this.StartDate = StartDate;
        this.EndDate = EndDate;
        this.Description = Description;
        this.VoucherStatus = VoucherStatus;
    }

    public int getVoucherID() {
        return VoucherID;
    }

    public void setVoucherID(int VoucherID) {
        this.VoucherID = VoucherID;
    }

    public String getVoucherName() {
        return VoucherName;
    }

    public void setVoucherName(String VoucherName) {
        this.VoucherName = VoucherName;
    }

    public int getDiscount() {
        return Discount;
    }

    public void setDiscount(int Discount) {
        this.Discount = Discount;
    }

    public int getQuantity() {
        return Quantity;
    }

    public void setQuantity(int Quantity) {
        this.Quantity = Quantity;
    }

    public Date getStartDate() {
        return StartDate;
    }

    public void setStartDate(Date StartDate) {
        this.StartDate = StartDate;
    }

    public Date getEndDate() {
        return EndDate;
    }

    public void setEndDate(Date EndDate) {
        this.EndDate = EndDate;
    }

    public String getDescription() {
        return Description;
    }

    public void setDescription(String Description) {
        this.Description = Description;
    }

    public int getVoucherStatus() {
        return VoucherStatus;
    }

    public void setVoucherStatus(int VoucherStatus) {
        this.VoucherStatus = VoucherStatus;
    }

    @Override
    public String toString() {
        return "Voucher{" + "VoucherID=" + VoucherID + ", VoucherName=" + VoucherName + ", Discount=" + Discount + ", Quantity=" + Quantity + ", StartDate=" + StartDate + ", EndDate=" + EndDate + ", Description=" + Description + ", VoucherStatus=" + VoucherStatus + '}';
    }
    
}
