
package entity;

public class ProductResponse {
    private int productId;
    private String productName;
    private Integer productPrice;
    private int id;
    private int quantity;
    private String productSize;
    private String productColor;
    private String productImage;

    public ProductResponse(int productId, String productName, Integer productPrice, int id, int quantity, String productSize, String productColor, String productImage) {
        this.productId = productId;
        this.productName = productName;
        this.productPrice = productPrice;
        this.id = id;
        this.quantity = quantity;
        this.productSize = productSize;
        this.productColor = productColor;
        this.productImage = productImage;
    }

    

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
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

    public Integer getProductPrice() {
        return productPrice;
    }

    public void setProductPrice(Integer productPrice) {
        this.productPrice = productPrice;
    }

    public String getProductSize() {
        return productSize;
    }

    public void setProductSize(String productSize) {
        this.productSize = productSize;
    }

    public String getProductColor() {
        return productColor;
    }

    public void setProductColor(String productColor) {
        this.productColor = productColor;
    }

    public String getProductImage() {
        return productImage;
    }

    public void setProductImage(String productImage) {
        this.productImage = productImage;
    }
}