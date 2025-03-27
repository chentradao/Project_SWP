/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import entity.Comment;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;
import java.util.Vector;

/**
 *
 * @author admin
 */
public class DAOComment extends DBConnection{
    public Vector<Comment> getAllCommentByBlogID(int blogID) throws SQLException{
        Vector<Comment> comments = new Vector<>();
        String sql = "SELECT c.AccountID,a.FullName,c.BlogID,c.Comment,c.Date from Comment c join Accounts a on a.AccountID=c.AccountID join Blog b on b.BlogID=c.BlogID where b.BlogID = ?";
        try{
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, blogID);
        ResultSet rs = ps.executeQuery();
        while(rs.next()){
            Comment comment = new Comment(rs.getInt("AccountID"), rs.getInt("BlogID"), rs.getString("Comment"), rs.getString("FullName"), rs.getDate("Date"));
            comments.add(comment);
        }
        }
        catch(SQLException e){
            e.printStackTrace();
        }
        return comments;
    }
    public void insertComment(Comment comment){
        try {
            String sql = "INSERT INTO [dbo].[Comment] ([BlogID],[AccountID],[Comment],[Date]) VALUES(?,?,?,?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, comment.getBlogID());
            ps.setInt(2,comment.getAccountID());
            ps.setString(3, comment.getComment());
            ps.setDate(4,(java.sql.Date)comment.getDate());
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }
}
