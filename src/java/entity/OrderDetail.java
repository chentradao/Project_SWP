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
    private String ProductName;
    private String Size;
    private String Color; 
    private String Image;

    public OrderDetail(int OrderID, int ProductID, int Quantity, int UnitPrice, String ProductName, String Size, String Color, String Image) {
        this.OrderID = OrderID;
        this.ProductID = ProductID;
        this.Quantity = Quantity;
        this.UnitPrice = UnitPrice;
        this.ProductName = ProductName;
        this.Size = Size;
        this.Color = Color;
        this.Image = Image;
    }

    public String getProductName() {
        return ProductName;
    }

    public void setProductName(String ProductName) {
        this.ProductName = ProductName;
    }

    public String getSize() {
        return Size;
    }

    public void setSize(String Size) {
        this.Size = Size;
    }

    public String getColor() {
        return Color;
    }

    public void setColor(String Color) {
        this.Color = Color;
    }

    public String getImage() {
        return Image;
    }

    public void setImage(String Image) {
        this.Image = Image;
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

    @Override
    public String toString() {
        return "OrderDetail{" + "OrderID=" + OrderID + ", ProductID=" + ProductID + ", Quantity=" + Quantity + ", UnitPrice=" + UnitPrice + ", ProductName=" + ProductName + ", Size=" + Size + ", Color=" + Color + ", Image=" + Image + '}';
    } 
    
}
