/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import java.sql.Date;

/**
 *
 * @author ASUS
 */
public class ProductDetail {
   private int productId;
    private String productName;
    private int categoryId;
    private int quantity;
    private int soldQuantity;
    private Date date;
    private String description;
    private int productStatus;
    private int ID;
    private String IdentityCode;
    private String size;
    private String Color;
    private Date DateCreate;
    private int ImportPrice;
    private int Price;
    private String image;
    private Product product;

    public ProductDetail(int productId, String productName, int categoryId, int quantity, int soldQuantity, Date date, String description, int productStatus, int ID, String size, String Color, int Price, String image) {
        this.productId = productId;
        this.productName = productName;
        this.categoryId = categoryId;
        this.quantity = quantity;
        this.soldQuantity = soldQuantity;
        this.date = date;
        this.description = description;
        this.productStatus = productStatus;
        this.ID = ID;
        this.size = size;
        this.Color = Color;
        this.Price = Price;
        this.image = image;
    }

    public ProductDetail(int ID,Product Product, String size, String color, int price, String image) {
        this.ID = ID;
        this.product = Product;
        this.size = size;
        this.Color = color;
        this.Price = price;
        this.image = image;
    }
    
    public ProductDetail(int ID,int ProductId, String size, String color, int price, String image) {
        this.ID = ID;
        this.productId = ProductId;
        this.size = size;
        this.Color = color;
        this.Price = price;
        this.image = image;
    }

    public ProductDetail(String size, String color, double price, String detailImage) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    public ProductDetail(int id, String productName, int productId,String IdentityCode ,String size, String color, int Quantity, int SoldQuantity, Date DateCreate, int ImportPrice,int price, String image, int ProductStatus) {
        this.ID = id;
        this.productName = productName;
        this.productId = productId;
        this.IdentityCode = IdentityCode;
        this.size = size;
        this.Color = color;
        this.quantity = Quantity;
        this.soldQuantity = SoldQuantity;
        this.DateCreate = DateCreate;
        this.ImportPrice = ImportPrice;
        this.Price = price;
        this.image = image;
        this.productStatus = ProductStatus;
    }

    public Date getDateCreate() {
        return DateCreate;
    }

    public void setDateCreate(Date DateCreate) {
        this.DateCreate = DateCreate;
    }

    public int getImportPrice() {
        return ImportPrice;
    }

    public void setImportPrice(int ImportPrice) {
        this.ImportPrice = ImportPrice;
    }

    public String getIdentityCode() {
        return IdentityCode;
    }

    public void setIdentityCode(String IdentityCode) {
        this.IdentityCode = IdentityCode;
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

    public int getProductStatus() {
        return productStatus;
    }

    public void setProductStatus(int productStatus) {
        this.productStatus = productStatus;
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
        return image;
    }

    public void setImage(String Image) {
        this.image = Image;
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
}
