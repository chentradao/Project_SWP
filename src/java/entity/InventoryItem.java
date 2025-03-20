package entity;

public class InventoryItem {
    private int productDetailId;
    private int productId;
    private String productName;
    private String size;
    private String color;
    private int quantity;
    private int soldQuantity;
    private double price;

    // Constructors
    public InventoryItem() {}

    public InventoryItem(int productDetailId, int productId, String productName, String size, String color, int quantity, int soldQuantity, double price) {
        this.productDetailId = productDetailId;
        this.productId = productId;
        this.productName = productName;
        this.size = size;
        this.color = color;
        this.quantity = quantity;
        this.soldQuantity = soldQuantity;
        this.price = price;
    }

    // Getters and Setters
    public int getProductDetailId() { return productDetailId; }
    public void setProductDetailId(int productDetailId) { this.productDetailId = productDetailId; }
    public int getProductId() { return productId; }
    public void setProductId(int productId) { this.productId = productId; }
    public String getProductName() { return productName; }
    public void setProductName(String productName) { this.productName = productName; }
    public String getSize() { return size; }
    public void setSize(String size) { this.size = size; }
    public String getColor() { return color; }
    public void setColor(String color) { this.color = color; }
    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }
    public int getSoldQuantity() { return soldQuantity; }
    public void setSoldQuantity(int soldQuantity) { this.soldQuantity = soldQuantity; }
    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }
}