/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import java.util.Date;

/**
 *
 * @author admin
 */
public class Comment {
    int CommentID,AccountID,BlogID;
    String Comment,AccountName;
    Date date;

    public Comment() {
    }

    public Comment(int AccountID, int BlogID, String Comment, String AccountName) {
        this.AccountID = AccountID;
        this.BlogID = BlogID;
        this.Comment = Comment;
        this.AccountName = AccountName;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public Comment(int AccountID, int BlogID, String Comment, String AccountName, Date date) {
        this.AccountID = AccountID;
        this.BlogID = BlogID;
        this.Comment = Comment;
        this.AccountName = AccountName;
        this.date = date;
    }

    

    public int getCommentID() {
        return CommentID;
    }

    public void setCommentID(int CommentID) {
        this.CommentID = CommentID;
    }

    public int getAccountID() {
        return AccountID;
    }

    public void setAccountID(int AccountID) {
        this.AccountID = AccountID;
    }

    public int getBlogID() {
        return BlogID;
    }

    public void setBlogID(int BlogID) {
        this.BlogID = BlogID;
    }

    public String getComment() {
        return Comment;
    }

    public void setComment(String Comment) {
        this.Comment = Comment;
    }

    public String getAccountName() {
        return AccountName;
    }

    public void setAccountName(String AccountName) {
        this.AccountName = AccountName;
    }
    
    
}
