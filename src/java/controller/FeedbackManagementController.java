package controller;

import entity.Feedback;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.DAOFeedback;

public class FeedbackManagementController extends HttpServlet {

    private DAOFeedback daoFeedback;

    @Override
    public void init() {
        daoFeedback = new DAOFeedback();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "list":
                listFeedbacks(request, response);
                break;
            case "delete":
                deleteFeedback(request, response);
                break;
            default:
                listFeedbacks(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Xử lý nếu cần
    }

    private void listFeedbacks(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Số lượng đánh giá trên mỗi trang
        final int PAGE_SIZE = 5;

        // Lấy tham số page từ request, mặc định là 1 nếu không có
        String pageStr = request.getParameter("page");
        int page = 1;
        try {
            page = (pageStr != null && !pageStr.isEmpty()) ? Integer.parseInt(pageStr) : 1;
        } catch (NumberFormatException e) {
            page = 1;
        }

        // Tính tổng số đánh giá
        int totalFeedbacks = daoFeedback.getTotalFeedbacksCount();
        // Tính tổng số trang
        int totalPages = (int) Math.ceil((double) totalFeedbacks / PAGE_SIZE);

        // Đảm bảo page nằm trong khoảng hợp lệ
        page = Math.max(1, Math.min(page, totalPages));

        // Tính offset
        int offset = (page - 1) * PAGE_SIZE;

        // Lấy danh sách đánh giá cho trang hiện tại
        List<Feedback> feedbacks = daoFeedback.getFeedbacksByPage(offset, PAGE_SIZE);

        // Đặt các thuộc tính để gửi lên JSP
        request.setAttribute("feedbacks", feedbacks);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);

        // Chuyển hướng đến JSP
        request.getRequestDispatcher("listFeedback.jsp").forward(request, response);
    }

    private void deleteFeedback(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int feedbackID = Integer.parseInt(request.getParameter("feedbackID"));
        String page = request.getParameter("page");

        boolean deleted = daoFeedback.deleteFeedback(feedbackID);

        if (deleted) {
            request.setAttribute("message", "Feedback deleted successfully.");
        } else {
            request.setAttribute("error", "Failed to delete feedback.");
        }

        // Chuyển hướng lại trang hiện tại
        response.sendRedirect("feedbacks?page=" + (page != null ? page : "1"));
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
