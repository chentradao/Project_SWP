/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

/**
 *
 * @author nguye
 */
public class OrderDetail {
    private int OrderID;
    private int ProductID;
    private int Quantity;
    private int UnitPrice;
    private int Voucher;

    public OrderDetail(int OrderID, int ProductID, int Quantity, int UnitPrice, int Voucher) {
        this.OrderID = OrderID;
        this.ProductID = ProductID;
        this.Quantity = Quantity;
        this.UnitPrice = UnitPrice;
        this.Voucher = Voucher;
    }

    public int getOrderID() {
        return OrderID;
    }

    public void setOrderID(int OrderID) {
        this.OrderID = OrderID;
    }

    public int getProductID() {
        return ProductID;
    }

    public void setProductID(int ProductID) {
        this.ProductID = ProductID;
    }

    public int getQuantity() {
        return Quantity;
    }

    public void setQuantity(int Quantity) {
        this.Quantity = Quantity;
    }

    public int getUnitPrice() {
        return UnitPrice;
    }

    public void setUnitPrice(int UnitPrice) {
        this.UnitPrice = UnitPrice;
    }

    public int getVoucher() {
        return Voucher;
    }

    public void setVoucher(int Voucher) {
        this.Voucher = Voucher;
    }

    @Override
    public String toString() {
        return "OrderDetail{" + "OrderID=" + OrderID + ", ProductID=" + ProductID + ", Quantity=" + Quantity + ", UnitPrice=" + UnitPrice + ", Voucher=" + Voucher + '}';
    }
    
    
}
