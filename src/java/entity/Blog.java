package entity;

import java.util.Date;

public class Blog {
    int BlogID;
    String BlogTitle;
    String BlogDescription;
    String BlogThumbnail;
    int BlogCategoryID;
    int BlogAuthor;
    Date Date;
    String Image;
    int BlogStatus;

    public Blog() {
    }

    public Blog(int BlogID, String BlogTitle, String BlogDescription, String BlogThumbnail, int BlogCategoryID, int BlogAuthor, Date Date, String Image, int BlogStatus) {
        this.BlogID = BlogID;
        this.BlogTitle = BlogTitle;
        this.BlogDescription = BlogDescription;
        this.BlogThumbnail = BlogThumbnail;
        this.BlogCategoryID = BlogCategoryID;
        this.BlogAuthor = BlogAuthor;
        this.Date = Date;
        this.Image = Image;
        this.BlogStatus = BlogStatus;
    }

    public Date getDate() {
        return Date;
    }

    public void setDate(Date Date) {
        this.Date = Date;
    }

    public Blog(String BlogTitle, String BlogDescription, String BlogThumbnail, int BlogCategoryID, int BlogAuthor, Date Date, String Image, int BlogStatus) {
        this.BlogTitle = BlogTitle;
        this.BlogDescription = BlogDescription;
        this.BlogThumbnail = BlogThumbnail;
        this.BlogCategoryID = BlogCategoryID;
        this.BlogAuthor = BlogAuthor;
        this.Date = Date;
        this.Image = Image;
        this.BlogStatus = BlogStatus;
    }
    
    
    
    

    public int getBlogID() {
        return BlogID;
    }

    public String getBlogTitle() {
        return BlogTitle;
    }

    public void setBlogTitle(String BlogTitle) {
        this.BlogTitle = BlogTitle;
    }

    public String getBlogDescription() {
        return BlogDescription;
    }

    public void setBlogDescription(String BlogDescription) {
        this.BlogDescription = BlogDescription;
    }

    public String getBlogThumbnail() {
        return BlogThumbnail;
    }

    @Override
    public String toString() {
        return "Blog{" + "BlogID=" + BlogID + ", BlogTitle=" + BlogTitle + ", BlogDescription=" + BlogDescription + ", BlogThumbnail=" + BlogThumbnail + ", BlogCategoryID=" + BlogCategoryID + ", BlogAuthor=" + BlogAuthor + ", Date=" + Date + ", Image=" + Image + ", BlogStatus=" + BlogStatus + '}';
    }

    public void setBlogThumbnail(String BlogThumbnail) {
        this.BlogThumbnail = BlogThumbnail;
    }

    public int getBlogCategoryID() {
        return BlogCategoryID;
    }

    public void setBlogCategory(int BlogCategory) {
        this.BlogCategoryID = BlogCategory;
    }

    public int getBlogAuthor() {
        return BlogAuthor;
    }

    public void setBlogAuthor(int BlogAuthor) {
        this.BlogAuthor = BlogAuthor;
    }

    

    public String getImage() {
        return Image;
    }

    public void setImage(String Image) {
        this.Image = Image;
    }

    public int getBlogStatus() {
        return BlogStatus;
    }

    public void setBlogStatus(int BlogStatus) {
        this.BlogStatus = BlogStatus;
    }
    
}
