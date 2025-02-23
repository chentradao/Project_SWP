package entity;

public class Category {

    private int categoryId;
    private String categoryName;
    private String categoryStatus;

    public Category(int categoryId, String categoryName, String categoryStatus) {
        this.categoryId = categoryId;
        this.categoryName = categoryName;
        this.categoryStatus = categoryStatus;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public String getCategoryStatus() {
        return categoryStatus;
    }

    @Override
    public String toString() {
        return "{\"categoryId\":" + categoryId
                + ", \"categoryName\":\"" + categoryName + "\""
                + ", \"categoryStatus\":\"" + categoryStatus + "\"}";
    }
}
