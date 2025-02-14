/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.Date;

/**
 *
 * @author ASUS
 */
public class Product {
    private int productID;
    private String productName;
    private Integer categoryID;
    private Integer quantity;
    private Integer soldQuantity;
    private Date date;
    private String description;
    private int productStatus;

    public Product(int productID, String productName, Integer categoryID, Integer quantity, Integer soldQuantity, Date date, String description, int productStatus) {
        this.productID = productID;
        this.productName = productName;
        this.categoryID = categoryID;
        this.quantity = quantity;
        this.soldQuantity = soldQuantity;
        this.date = date;
        this.description = description;
        this.productStatus = productStatus;
    }

    public Product() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public Integer getCategoryID() {
        return categoryID;
    }

    public void setCategoryID(Integer categoryID) {
        this.categoryID = categoryID;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }

    public Integer getSoldQuantity() {
        return soldQuantity;
    }

    public void setSoldQuantity(Integer soldQuantity) {
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

    @Override
    public String toString() {
        return "Product{" + "productID=" + productID + ", productName=" + productName + ", categoryID=" + categoryID + ", quantity=" + quantity + ", soldQuantity=" + soldQuantity + ", date=" + date + ", description=" + description + ", productStatus=" + productStatus + '}';
    }
    
}
