/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import java.sql.Date;

/**
 *
 * @author Administrator
 */
public class ProductDetail {

    private int productId;
    private String productName;
    private int categoryId;
    private int quantity;
    private int soldQuantity;
    private Date date;
    private String description;
    private String productStatus;
    private String productImage;
    private int ID;
    private String size;
    private String Color;
    private int Price;
    private String Image;
    private Product product;

    public ProductDetail(int productId, String productName, int categoryId, int quantity, int soldQuantity, Date date, String description, String productStatus, String productImage, int ID, String Size, String Color, int Price, String Image) {
        this.productId = productId;
        this.productName = productName;
        this.categoryId = categoryId;
        this.quantity = quantity;
        this.soldQuantity = soldQuantity;
        this.date = date;
        this.description = description;
        this.productStatus = productStatus;
        this.productImage = productImage;
        this.ID = ID;
        this.size = Size;
        this.Color = Color;
        this.Price = Price;
        this.Image = Image;
    }

    public ProductDetail(int id, Product product, String size, String color, int price, String image) {
        this.productId = id;
        this.product = product;
        this.size = size;
        this.Color = color;
        this.Price = price;
        this.Image = image;
    }

    public ProductDetail(String size, String color, double price, String detailImage) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    public ProductDetail(int id, int productId, String size, String color, int price, String image) {
        this.ID = id;
        this.productId = productId;
        this.size = size;
        this.Color = color;
        this.Price = price;
        this.Image = image;
    }

    public int getproductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public int getSoldQuantity() {
        return soldQuantity;
    }

    public void setSoldQuantity(int soldQuantity) {
        this.soldQuantity = soldQuantity;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getProductStatus() {
        return productStatus;
    }

    public void setProductStatus(String productStatus) {
        this.productStatus = productStatus;
    }

    public String getProductImage() {
        return productImage;
    }

    public void setProductImage(String productImage) {
        this.productImage = productImage;
    }

    public int getID() {
        return ID;
    }

    public void setID(int ID) {
        this.ID = ID;
    }

    public String getSize() {
        return size;
    }

    public void setSize(String Size) {
        this.size = Size;
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

    public void setImage(String Image) {
        this.Image = Image;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public int getProductId() {
        return productId;
    }

    @Override
    public String toString() {
        return "ProductDetail{" + "productId=" + productId + ", productName=" + productName + ", categoryId=" + categoryId + ", quantity=" + quantity + ", soldQuantity=" + soldQuantity + ", date=" + date + ", description=" + description + ", productStatus=" + productStatus + ", productImage=" + productImage + ", ID=" + ID + ", Size=" + size + ", Color=" + Color + ", Price=" + Price + ", Image=" + Image + '}';
    }

}
