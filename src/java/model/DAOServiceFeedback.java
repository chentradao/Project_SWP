package model;

import entity.ServiceFeedback;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DAOServiceFeedback extends DBConnection {

    // Thêm feedback mới
    public boolean addServiceFeedback(ServiceFeedback feedback) {
        String sql = "INSERT INTO ServiceFeedback (AccountID, RateStar, FeedbackText, ImageURL, Date) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, feedback.getAccountID());
            ps.setInt(2, feedback.getRateStar());
            ps.setString(3, feedback.getFeedbackText());
            ps.setString(4, feedback.getImageURL());
            ps.setDate(5, new java.sql.Date(feedback.getDate().getTime()));
            int rowsAffected = ps.executeUpdate();
            System.out.println("Rows affected: " + rowsAffected);
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Lấy tất cả feedback
    public List<ServiceFeedback> getAllServiceFeedback(int offset, int limit) {
        List<ServiceFeedback> feedbacks = new ArrayList<>();
        String sql = "SELECT sf.*, a.UserName AS accountName FROM ServiceFeedback sf "
                + "LEFT JOIN Accounts a ON sf.AccountID = a.AccountID "
                + "ORDER BY sf.Date DESC LIMIT ? OFFSET ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, limit);
            stmt.setInt(2, offset);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                ServiceFeedback feedback = new ServiceFeedback(
                        rs.getInt("feedbackID"),
                        rs.getInt("accountID"),
                        rs.getString("accountName") != null ? rs.getString("accountName") : "Unknown",
                        rs.getInt("rateStar"),
                        rs.getString("feedbackText"),
                        rs.getString("imageURL"),
                        rs.getDate("date")
                );
                feedbacks.add(feedback);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("SQL Error in getAllServiceFeedback: " + e.getMessage());
        }
        return feedbacks;
    }

    // Lấy feedback theo AccountID (tài khoản người dùng)
    public List<ServiceFeedback> getServiceFeedbackByAccountID(int accountID) {
        List<ServiceFeedback> feedbacks = new ArrayList<>();
        String sql = "SELECT * FROM ServiceFeedback WHERE AccountID = ? ORDER BY Date DESC";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, accountID);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    feedbacks.add(new ServiceFeedback(
                            rs.getInt("AccountID"),
                            rs.getInt("RateStar"),
                            rs.getString("FeedbackText"),
                            rs.getString("ImageURL")
                    ));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return feedbacks;
    }

    // Lấy số lượng feedback của một tài khoản (AccountID)
    public int getFeedbackCountByAccountID(int accountID) {
        String sql = "SELECT COUNT(*) FROM ServiceFeedback WHERE AccountID = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, accountID);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;  // Nếu không có feedback nào thì trả về 0
    }

    // Cập nhật feedback (nếu cần)
    public boolean updateServiceFeedback(ServiceFeedback feedback) {
        String sql = "UPDATE ServiceFeedback SET RateStar = ?, FeedbackText = ?, ImageURL = ? WHERE FeedbackID = ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, feedback.getRateStar());
            ps.setString(2, feedback.getFeedbackText());
            ps.setString(3, feedback.getImageURL());
            ps.setInt(4, feedback.getFeedbackID());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public int getFeedbackCount() {
        String sql = "SELECT COUNT(*) FROM ServiceFeedback";
        try (PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    // Xóa feedback
    public boolean deleteServiceFeedback(int feedbackID) {
        String sql = "DELETE FROM ServiceFeedback WHERE FeedbackID = ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, feedbackID);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
