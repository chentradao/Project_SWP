package controller;

import entity.Accounts;
import entity.FeedbackReply;
import java.io.IOException;
import java.sql.Date;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.DAOFeedbackReply;

public class ReplyFeedbackController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Accounts acc = (Accounts) session.getAttribute("acc");

        if (acc == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            int productId = Integer.parseInt(request.getParameter("productId"));
            int feedbackID = Integer.parseInt(request.getParameter("feedbackID"));
            String replyText = request.getParameter("replyText");

            // Tạo đối tượng phản hồi
            FeedbackReply reply = new FeedbackReply(0, feedbackID, acc.getAccountID(), replyText, new Date(System.currentTimeMillis()));

            // Gọi DAO để lưu phản hồi
            DAOFeedbackReply dao = new DAOFeedbackReply();
            boolean isInserted = dao.insertFeedbackReply(reply);

            if (isInserted) {
                response.sendRedirect("ProductDetail?productId=" + productId);
            } else {
                response.sendRedirect("ProductDetail?productId=" + productId + "&error=failed");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("error.jsp?message=Invalid+input");
        }
    }

    @Override
    public String getServletInfo() {
        return "Handles feedback replies";
    }
}
