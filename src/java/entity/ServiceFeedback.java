package entity;

import java.sql.Date;

public class ServiceFeedback {

    private int feedbackID;
    private int accountID;
    private String accountName;
    private int rateStar;
    private String feedbackText;
    private String imageURL;
    private Date date;

    public ServiceFeedback() {
    }

    public ServiceFeedback(int accountID, int rateStar, String feedbackText, String imageURL) {
        this.accountID = accountID;
        this.rateStar = rateStar;
        this.feedbackText = feedbackText;
        this.imageURL = imageURL;
        this.date = new Date(System.currentTimeMillis());  // Gán ngày hiện tại
    }

    public ServiceFeedback(int feedbackID, int accountID, String accountName, int rateStar, String feedbackText, String imageURL, Date date) {
        this.feedbackID = feedbackID;
        this.accountID = accountID;
        this.accountName = accountName;
        this.rateStar = rateStar;
        this.feedbackText = feedbackText;
        this.imageURL = imageURL;
        this.date = date;
    }

    public int getFeedbackID() {
        return feedbackID;
    }

    public void setFeedbackID(int feedbackID) {
        this.feedbackID = feedbackID;
    }

    public int getAccountID() {
        return accountID;
    }

    public void setAccountID(int accountID) {
        this.accountID = accountID;
    }

    public String getAccountName() {
        return accountName;
    }

    public void setAccountName(String accountName) {
        this.accountName = accountName;
    }

    public int getRateStar() {
        return rateStar;
    }

    public void setRateStar(int rateStar) {
        this.rateStar = rateStar;
    }

    public String getFeedbackText() {
        return feedbackText;
    }

    public void setFeedbackText(String feedbackText) {
        this.feedbackText = feedbackText;
    }

    public String getImageURL() {
        return imageURL;
    }

    public void setImageURL(String imageURL) {
        this.imageURL = imageURL;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    @Override
    public String toString() {
        return "ServiceFeedback{"
                + "feedbackID=" + feedbackID
                + ", accountID=" + accountID
                + ", accountName='" + accountName + '\''
                + ", rateStar=" + rateStar
                + ", feedbackText='" + feedbackText + '\''
                + ", imageURL='" + imageURL + '\''
                + ", date=" + date
                + '}';
    }
}
