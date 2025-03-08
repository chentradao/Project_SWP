/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import java.util.Date;

/**
 *
 * @author Administrator
 */
public class Feedback {

    private int feedbackID;
    private int productID;
    private int accountID;
    private int rateStar;
    private String imageURL;
    private String feedback;
    private Date date;
    private String accountName;
    private FeedbackReply feedbackReply;
    private String productName;

    public Feedback() {
    }

    public Feedback(int feedbackID, int productID, int accountID, int rateStar, String imageURL, String feedback, Date date, String accountName) {
        this.feedbackID = feedbackID;
        this.productID = productID;
        this.accountID = accountID;
        this.rateStar = rateStar;
        this.imageURL = imageURL;
        this.feedback = feedback;
        this.date = date;
        this.accountName = accountName;
    }

    public Feedback(int feedbackID, int productID, int accountID, int rateStar, String imageURL, String feedback, Date date) {
        this.feedbackID = feedbackID;
        this.productID = productID;
        this.accountID = accountID;
        this.rateStar = rateStar;
        this.imageURL = imageURL;
        this.feedback = feedback;
        this.date = date;
    }

    public int getFeedbackID() {
        return feedbackID;
    }

    public void setFeedbackID(int feedbackID) {
        this.feedbackID = feedbackID;
    }

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    public int getAccountID() {
        return accountID;
    }

    public void setAccountID(int accountID) {
        this.accountID = accountID;
    }

    public int getRateStar() {
        return rateStar;
    }

    public void setRateStar(int rateStar) {
        this.rateStar = rateStar;
    }

    public String getImageURL() {
        return imageURL;
    }

    public void setImageURL(String imageURL) {
        this.imageURL = imageURL;
    }

    public String getFeedback() {
        return feedback;
    }

    public void setFeedback(String feedback) {
        this.feedback = feedback;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public String getAccountName() {
        return accountName;
    }

    public void setAccountName(String accountName) {
        this.accountName = accountName;
    }

    public FeedbackReply getFeedbackReply() {
        return feedbackReply;
    }

    public void setFeedbackReply(FeedbackReply feedbackReply) {
        this.feedbackReply = feedbackReply;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

}
