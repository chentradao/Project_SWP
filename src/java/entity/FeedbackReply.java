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
public class FeedbackReply {

    private int replyID;
    private int feedbackID;
    private int accountID;
    private String replyText;
    private Date replyDate;

    public FeedbackReply() {
    }

    public FeedbackReply(int replyID, int feedbackID, int accountID, String replyText, Date replyDate) {
        this.replyID = replyID;
        this.feedbackID = feedbackID;
        this.accountID = accountID;
        this.replyText = replyText;
        this.replyDate = replyDate;
    }

    public int getReplyID() {
        return replyID;
    }

    public void setReplyID(int replyID) {
        this.replyID = replyID;
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

    public String getReplyText() {
        return replyText;
    }

    public void setReplyText(String replyText) {
        this.replyText = replyText;
    }

    public Date getReplyDate() {
        return replyDate;
    }

    public void setReplyDate(Date replyDate) {
        this.replyDate = replyDate;
    }

}
