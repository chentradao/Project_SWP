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
public class FlashSale {
    private int SaleID;
    private int ProductID;
    private Date StartTime;
    private Date EndTime;
    private int Discount;
    private int Quantity;
    private int TimeFrame;
    private int Status;
    private ProductDetail productDetail;

    public FlashSale(int ProductID, Date StartTime, Date EndTime, int Discount, int Quantity, int TimeFrame, int Status) {
        this.ProductID = ProductID;
        this.StartTime = StartTime;
        this.EndTime = EndTime;
        this.Discount = Discount;
        this.Quantity = Quantity;
        this.TimeFrame = TimeFrame;
        this.Status = Status;
    }

    public FlashSale(int SaleID, int ProductID, Date StartTime, Date EndTime, int Discount, int Quantity, int TimeFrame, int Status) {
        this.SaleID = SaleID;
        this.ProductID = ProductID;
        this.StartTime = StartTime;
        this.EndTime = EndTime;
        this.Discount = Discount;
        this.Quantity = Quantity;
        this.TimeFrame = TimeFrame;
        this.Status = Status;
    }

    public ProductDetail getProductDetail() {
        return productDetail;
    }

    public void setProductDetail(ProductDetail productDetail) {
        this.productDetail = productDetail;
    }
    

    public int getSaleID() {
        return SaleID;
    }

    public void setSaleID(int SaleID) {
        this.SaleID = SaleID;
    }

    public int getProductID() {
        return ProductID;
    }

    public void setProductID(int ProductID) {
        this.ProductID = ProductID;
    }

    public Date getStartTime() {
        return StartTime;
    }

    public void setStartTime(Date StartTime) {
        this.StartTime = StartTime;
    }

    public Date getEndTime() {
        return EndTime;
    }

    public void setEndTime(Date EndTime) {
        this.EndTime = EndTime;
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

    public int getTimeFrame() {
        return TimeFrame;
    }

    public void setTimeFrame(int TimeFrame) {
        this.TimeFrame = TimeFrame;
    }

    public int getStatus() {
        return Status;
    }

    public void setStatus(int Status) {
        this.Status = Status;
    }

    @Override
    public String toString() {
        return "FlashSale{" + "SaleID=" + SaleID + ", ProductID=" + ProductID + ", StartTime=" + StartTime + ", EndTime=" + EndTime + ", Discount=" + Discount + ", Quantity=" + Quantity + ", TimeFrame=" + TimeFrame + ", Status=" + Status + '}';
    }
    
    
}
