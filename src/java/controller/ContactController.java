package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.mail.MessagingException;
import model.EmailHandler;

@WebServlet(name = "ContactController", urlPatterns = {"/ContactURL"})
public class ContactController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession(true);
        try (PrintWriter out = response.getWriter()) {
            String service = request.getParameter("service");

            if (service == null || service.equals("showContact")) {
                // Hiển thị trang liên hệ
                request.getRequestDispatcher("/jsp/contact.jsp").forward(request, response);
            } else if (service.equals("submitFeedback")) {
                // Xử lý khi người dùng gửi biểu mẫu liên hệ
                String name = request.getParameter("Name");
                String email = request.getParameter("Email");
                String subject = request.getParameter("Subject");
                String message = request.getParameter("Message");

                // Gửi email xác nhận bằng phương thức mới
                try {
                    EmailHandler.sendContactConfirmationEmail(email, name, subject, message);
                } catch (MessagingException ex) {
                    Logger.getLogger(ContactController.class.getName()).log(Level.SEVERE, "Failed to send contact confirmation email", ex);
                }

                // Chuyển hướng về trang chính hoặc trang cảm ơn
                response.sendRedirect("ProductListServlet"); // Hoặc một trang cảm ơn khác
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Handles contact form submission and email confirmation";
    }
}