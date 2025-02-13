/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import java.sql.Date;

/**
 *
 * @author ADMIN-PC
 */
public class Product {

    private int productId;
    private String productName;
    private int categoryId;
    private int quantity;
    private int soldQuantity;
    private Date date;
    private String description;
    private String productStatus;
    private String productImage;
    private ProductDetail productDetail;

    public Product() {
    }

    public Product(int productId, String productName, int categoryId, int quantity, int soldQuantity, Date date, String description, String productStatus, String productImage) {
        this.productId = productId;
        this.productName = productName;
        this.categoryId = categoryId;
        this.quantity = quantity;
        this.soldQuantity = soldQuantity;
        this.date = date;
        this.description = description;
        this.productStatus = productStatus;
        this.productImage = productImage;
    }

    public Product(int productId, String productName, String productImage, String description) {
        this.productId = productId;
        this.productName = productName;
        this.productImage = productImage;
        this.description = description;

    }

    public int getProductId() {
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

    public ProductDetail getProductDetail() {
        return productDetail;
    }

    public void setProductDetail(ProductDetail productDetail) {
        this.productDetail = productDetail;
    }

}
