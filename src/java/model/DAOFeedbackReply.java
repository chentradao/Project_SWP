/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import entity.FeedbackReply;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.SQLException;

/**
 *
 * @author ADMIN-PC
 */
public class DAOFeedbackReply extends DBConnection {

    public boolean insertFeedbackReply(FeedbackReply reply) {
        String sql = "INSERT INTO FeedbackReply (FeedbackID, AccountID, ReplyText, ReplyDate) VALUES (?, ?, ?, ?)";
        try ( PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, reply.getFeedbackID());
            stmt.setInt(2, reply.getAccountID());
            stmt.setString(3, reply.getReplyText());
            stmt.setDate(4, new Date(System.currentTimeMillis()));

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteFeedbackReply(int replyID) {
        String sql = "DELETE FROM FeedbackReply WHERE ReplyID = ?";
        try ( PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, replyID);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

}
