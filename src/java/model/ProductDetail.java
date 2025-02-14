/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author ASUS
 */
public class ProductDetail {
    private int id;
    private int productID;
    private String size;
    private String color;
    private Integer price;
    private String image;

    public ProductDetail(int id, int productID, String size, String color, Integer price, String image) {
        this.id = id;
        this.productID = productID;
        this.size = size;
        this.color = color;
        this.price = price;
        this.image = image;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    public String getSize() {
        return size;
    }

    public void setSize(String size) {
        this.size = size;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public Integer getPrice() {
        return price;
    }

    public void setPrice(Integer price) {
        this.price = price;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    @Override
    public String toString() {
        return "PorductDetail{" + "id=" + id + ", productID=" + productID + ", size=" + size + ", color=" + color + ", price=" + price + ", image=" + image + '}';
    }
    
}
