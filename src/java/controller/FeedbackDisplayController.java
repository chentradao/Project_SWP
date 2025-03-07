package controller;

import entity.Feedback;
import entity.FeedbackStats;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import model.DAOProductDetail;
import entity.ProductDetail;
import java.util.List;
import model.DAOFeedback;

public class FeedbackDisplayController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int productId = Integer.parseInt(request.getParameter("productId"));
            DAOProductDetail daoProductDetail = new DAOProductDetail();
            DAOFeedback feedbackDao = new DAOFeedback();
            ProductDetail proDetail = daoProductDetail.getProductDetailById(productId);
            List<Feedback> feedbackList = feedbackDao.getFeedbackByProductID(productId);
            FeedbackStats stats = feedbackDao.getFeedbackStatsByProductID(productId);

            request.setAttribute("stats", stats);
            request.setAttribute("productDetail", proDetail);
            request.setAttribute("feedbacks", feedbackList);
            request.getRequestDispatcher("displayFeedback.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid product ID");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
