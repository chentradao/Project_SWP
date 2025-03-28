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
    private int ID;
    private String IdentityCode;
    private int Quantity;
    private String Size;
    private String Color;
    private int Price;
    private String Image;
    private FlashSale flash;

    public Cart() {
    }

    public Cart(int ProductID, String ProductName, int ID, String IdentityCode, int Quantity, String Size, String Color, int Price, String Image) {
        this.ProductID = ProductID;
        this.ProductName = ProductName;
        this.ID = ID;
        this.IdentityCode = IdentityCode;
        this.Quantity = Quantity;
        this.Size = Size;
        this.Color = Color;
        this.Price = Price;
        this.Image = Image;
    }

    public FlashSale getFlash() {
        return flash;
    }

    public void setFlash(FlashSale flash) {
        this.flash = flash;
    }
    public String getIdentityCode() {
        return IdentityCode;
    }

    public void setIdentityCode(String IdentityCode) {
        this.IdentityCode = IdentityCode;
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
