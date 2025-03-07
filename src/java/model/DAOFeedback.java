package model;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import entity.Feedback;
import entity.FeedbackReply;
import entity.FeedbackStats;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public class DAOFeedback extends DBConnection {

    public List<Feedback> getAllFeedback() {
        List<Feedback> list = new ArrayList<>();
        String sql = "SELECT f.*, p.ProductName, a.UserName "
                + "FROM Feedback f "
                + "JOIN Products p ON f.ProductID = p.ProductID "
                + "JOIN Accounts a ON f.AccountID = a.AccountID "
                + "ORDER BY f.Date DESC";

        try (PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Feedback feedback = new Feedback(
                        rs.getInt("FeedbackID"),
                        rs.getInt("ProductID"),
                        rs.getInt("AccountID"),
                        rs.getInt("RateStar"),
                        rs.getString("ImageURL"),
                        rs.getString("Feedback"),
                        rs.getTimestamp("Date"),
                        rs.getString("UserName")
                );
                feedback.setProductName(rs.getString("ProductName"));
                list.add(feedback);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Feedback> getFeedbackByProductID(int productID) {
        List<Feedback> list = new ArrayList<>();
        String sql = "SELECT f.FeedbackID, f.ProductID, f.AccountID, f.RateStar, "
                + "f.ImageURL, f.Feedback, f.Date, a.UserName, "
                + "r.ReplyID, r.ReplyText, r.ReplyDate, r.AccountID AS ReplyAccountID "
                + "FROM Feedback f "
                + "JOIN Accounts a ON f.AccountID = a.AccountID "
                + "LEFT JOIN FeedbackReply r ON f.FeedbackID = r.FeedbackID "
                + "WHERE f.ProductID = ? ORDER BY f.Date DESC";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, productID);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    // Tạo đối tượng Feedback
                    Feedback feedback = new Feedback(
                            rs.getInt("FeedbackID"),
                            rs.getInt("ProductID"),
                            rs.getInt("AccountID"),
                            rs.getInt("RateStar"),
                            rs.getString("ImageURL"),
                            rs.getString("Feedback"),
                            rs.getTimestamp("Date"),
                            rs.getString("UserName")
                    );

                    // Kiểm tra nếu có phản hồi
                    int replyID = rs.getInt("ReplyID");
                    if (replyID > 0) {
                        FeedbackReply reply = new FeedbackReply(
                                replyID,
                                rs.getInt("FeedbackID"),
                                rs.getInt("ReplyAccountID"),
                                rs.getString("ReplyText"),
                                rs.getDate("ReplyDate")
                        );
                        feedback.setFeedbackReply(reply);
                    }

                    list.add(feedback);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public FeedbackStats getFeedbackStatsByProductID(int productID) {
        String sql = "SELECT "
                + "COUNT(CASE WHEN RateStar = 1 THEN 1 END) AS oneStar, "
                + "COUNT(CASE WHEN RateStar = 2 THEN 1 END) AS twoStar, "
                + "COUNT(CASE WHEN RateStar = 3 THEN 1 END) AS threeStar, "
                + "COUNT(CASE WHEN RateStar = 4 THEN 1 END) AS fourStar, "
                + "COUNT(CASE WHEN RateStar = 5 THEN 1 END) AS fiveStar, "
                + "AVG(RateStar) AS avgStars "
                + "FROM Feedback WHERE ProductID = ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, productID);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new FeedbackStats(
                            rs.getInt("oneStar"),
                            rs.getInt("twoStar"),
                            rs.getInt("threeStar"),
                            rs.getInt("fourStar"),
                            rs.getInt("fiveStar"),
                            rs.getDouble("avgStars")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return new FeedbackStats(0, 0, 0, 0, 0, 0.0);
    }

    public boolean addFeedback(Feedback feedback) {
        String sql = "INSERT INTO Feedback (ProductID, AccountID, RateStar, ImageURL, Feedback, Date) VALUES (?, ?, ?, ?, ?, ?)";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, feedback.getProductID());
            ps.setInt(2, feedback.getAccountID());
            ps.setInt(3, feedback.getRateStar());
            ps.setString(4, feedback.getImageURL());
            ps.setString(5, feedback.getFeedback());
            ps.setDate(6, Date.valueOf(LocalDate.now()));

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteFeedback(int feedbackID) {
        String deleteRepliesSQL = "DELETE FROM FeedbackReply WHERE FeedbackID = ?";
        String deleteFeedbackSQL = "DELETE FROM Feedback WHERE FeedbackID = ?";

        try (PreparedStatement psReplies = conn.prepareStatement(deleteRepliesSQL); PreparedStatement psFeedback = conn.prepareStatement(deleteFeedbackSQL)) {

            psReplies.setInt(1, feedbackID);
            psReplies.executeUpdate();

            psFeedback.setInt(1, feedbackID);
            return psFeedback.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateFeedback(Feedback feedback) {
        String sql = "UPDATE Feedback SET ProductID = ?, AccountID = ?, RateStar = ?, ImageURL = ?, Feedback = ?, Date = ? WHERE FeedbackID = ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, feedback.getProductID());
            ps.setInt(2, feedback.getAccountID());
            ps.setInt(3, feedback.getRateStar());
            ps.setString(4, feedback.getImageURL());
            ps.setString(5, feedback.getFeedback());
            ps.setDate(6, new Date(feedback.getDate().getTime()));
            ps.setInt(7, feedback.getFeedbackID());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    private Feedback mapResultSetToFeedback(ResultSet rs) throws SQLException {
        return new Feedback(
                rs.getInt("FeedbackID"),
                rs.getInt("ProductID"),
                rs.getInt("AccountID"),
                rs.getInt("RateStar"),
                rs.getString("ImageURL"),
                rs.getString("Feedback"),
                rs.getDate("Date")
        );
    }

    // Lấy tổng số đánh giá
    public int getTotalFeedbacksCount() {
        String sql = "SELECT COUNT(*) FROM Feedback";
        try (PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

// Lấy danh sách đánh giá theo trang
    public List<Feedback> getFeedbacksByPage(int offset, int pageSize) {
        List<Feedback> list = new ArrayList<>();
        String sql = "SELECT f.*, p.ProductName, a.UserName "
                + "FROM Feedback f "
                + "JOIN Products p ON f.ProductID = p.ProductID "
                + "JOIN Accounts a ON f.AccountID = a.AccountID "
                + "ORDER BY f.Date DESC "
                + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY"; // Sử dụng cú pháp phân trang của SQL Server

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, offset);
            ps.setInt(2, pageSize);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Feedback feedback = new Feedback(
                            rs.getInt("FeedbackID"),
                            rs.getInt("ProductID"),
                            rs.getInt("AccountID"),
                            rs.getInt("RateStar"),
                            rs.getString("ImageURL"),
                            rs.getString("Feedback"),
                            rs.getTimestamp("Date"),
                            rs.getString("UserName")
                    );
                    feedback.setProductName(rs.getString("ProductName"));
                    list.add(feedback);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

}
