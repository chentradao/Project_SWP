/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import java.util.Date;

/**
 *
 * @author ASUS
 */
public class Voucher {
    private int voucherID;

    private String voucherName;

    private int discount;

    private int quantity;
    
    private int maxDiscount;

    private Date startDate;

    private Date endDate;

    private String description;

    private int voucherStatus;

    public Voucher() {
    }

    public Voucher(int voucherID, String voucherName, int discount, int maxDiscount, int quantity, Date startDate, Date endDate, String description, int voucherStatus) {
        this.voucherID = voucherID;
        this.voucherName = voucherName;
        this.discount = discount;
        this.maxDiscount = maxDiscount;
        this.quantity = quantity;
        this.startDate = startDate;
        this.endDate = endDate;
        this.description = description;
        this.voucherStatus = voucherStatus;
    }


    public int getId() {
        return voucherID;
    }

    public int getVoucherID() {
        return voucherID;
    }

    public String getVoucherName() {
        return voucherName;
    }

    public int getVoucherStatus() {
        return voucherStatus;
    }

    public void setVoucherStatus(int voucherStatus) {
        this.voucherStatus = voucherStatus;
    }

    public void setVoucherID(int voucherID) {
        this.voucherID = voucherID;
    }

    public String getName() {
        return voucherName;
    }

    public void setVoucherName(String voucherName) {
        this.voucherName = voucherName;
    }

    public int getDiscount() {
        return discount;
    }

    public void setDiscount(int discount) {
        this.discount = discount;
    }

    public int getMaxDiscount() {
        return maxDiscount;
    }

    public void setMaxDiscount(int maxDiscount) {
        this.maxDiscount = maxDiscount;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getStatus() {
        return voucherStatus;
    }

    public void setStatus(int voucherStatus) {
        this.voucherStatus = voucherStatus;
    }
}
