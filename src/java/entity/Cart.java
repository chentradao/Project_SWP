/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

/**
 *
 * @author nguye
 */
public class Cart {
    private int ProductID;
    private String ProductName;
    private int Quantity;
    private int ID;
    private String Size;
    private String Color;
    private int Price;
    private String Image;

    public Cart() {
    }

    public Cart(int ProductID, String ProductName, int Quantity, int ID, String Size, String Color, int Price, String Image) {
        this.ProductID = ProductID;
        this.ProductName = ProductName;
        this.Quantity = Quantity;
        this.ID = ID;
        this.Size = Size;
        this.Color = Color;
        this.Price = Price;
        this.Image = Image;
    }

    

    public int getProductID() {
        return ProductID;
    }

    public void setProductID(int ProductID) {
        this.ProductID = ProductID;
    }

    public String getProductName() {
        return ProductName;
    }

    public void setProductName(String ProductName) {
        this.ProductName = ProductName;
    }

    public int getQuantity() {
        return Quantity;
    }

    public void setQuantity(int Quantity) {
        this.Quantity = Quantity;
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

    public int getPrice() {
        return Price;
    }

    public void setPrice(int Price) {
        this.Price = Price;
    }

    public String getImage() {
        return Image;
    }

    public int getID() {
        return ID;
    }

    public void setID(int ID) {
        this.ID = ID;
    }

    public void setImage(String Image) {
        this.Image = Image;
    }

    
    
}
