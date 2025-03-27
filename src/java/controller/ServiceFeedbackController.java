package controller;

import entity.ServiceFeedback;
import entity.Accounts;
import model.DAOServiceFeedback;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ServiceFeedbackController", urlPatterns = {"/ServiceFeedbackURL"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50 // 50MB
)
public class ServiceFeedbackController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }
        switch (action) {
            case "add":
                showAddFeedbackForm(request, response);
                break;
            case "view":
                viewUserFeedback(request, response);
                break;
            case "list":
                listAllFeedbacks(request, response);
                break;
            default:
                listAllFeedbacks(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String action = request.getParameter("action");
            if ("addFeedback".equals(action)) {
                addServiceFeedback(request, response);
            } else {
                request.setAttribute("errorMessage", "Hành động không hợp lệ!");
                request.getRequestDispatcher("addServiceFeedback.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Có lỗi xảy ra trong quá trình xử lý: " + e.getMessage());
            request.getRequestDispatcher("addServiceFeedback.jsp").forward(request, response);
        }
    }

    private void showAddFeedbackForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("addServiceFeedback.jsp").forward(request, response);
    }

    private void addServiceFeedback(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Object accObj = session.getAttribute("acc");
        if (accObj == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        Accounts acc = (Accounts) accObj;

        int rateStar;
        try {
            String rateStarStr = request.getParameter("rateStar");
            rateStar = Integer.parseInt(rateStarStr);
            if (rateStar < 1 || rateStar > 5) {
                request.setAttribute("errorMessage", "Đánh giá sao phải từ 1 đến 5!");
                request.getRequestDispatcher("addServiceFeedback.jsp").forward(request, response);
                return;
            }
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Đánh giá sao không hợp lệ!");
            request.getRequestDispatcher("addServiceFeedback.jsp").forward(request, response);
            return;
        }

        String feedbackText = request.getParameter("feedbackText");
        if (feedbackText == null || feedbackText.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Nội dung phản hồi không được để trống!");
            request.getRequestDispatcher("addServiceFeedback.jsp").forward(request, response);
            return;
        }
        // Giới hạn độ dài feedbackText (ví dụ: 500 ký tự)
        if (feedbackText.length() > 500) {
            request.setAttribute("errorMessage", "Nội dung phản hồi vượt quá 500 ký tự!");
            request.getRequestDispatcher("addServiceFeedback.jsp").forward(request, response);
            return;
        }

        String imageUrl = "";
        Part filePart = request.getPart("imageURL");
        if (filePart != null && filePart.getSize() > 0) {
            if (filePart.getSize() > 1024 * 1024 * 10) { // Kiểm tra kích thước 10MB
                request.setAttribute("errorMessage", "Kích thước file vượt quá 10MB!");
                request.getRequestDispatcher("addServiceFeedback.jsp").forward(request, response);
                return;
            }
            String contentType = filePart.getContentType();
            if (!contentType.startsWith("image/")) {
                request.setAttribute("errorMessage", "File không phải là ảnh hợp lệ!");
                request.getRequestDispatcher("addServiceFeedback.jsp").forward(request, response);
                return;
            }
            String fileName = extractFileName(filePart);
            String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }
            String filePath = uploadPath + File.separator + fileName;
            filePart.write(filePath);
            imageUrl = "uploads/" + fileName;
        }

        int accountID = acc.getAccountID();
        ServiceFeedback feedback = new ServiceFeedback(accountID, rateStar, feedbackText, imageUrl);
        DAOServiceFeedback daoServiceFeedback = new DAOServiceFeedback();

        if (daoServiceFeedback.addServiceFeedback(feedback)) {
            response.sendRedirect("ServiceFeedbackURL?action=view");
        } else {
            request.setAttribute("errorMessage", "Không thể lưu phản hồi, vui lòng thử lại!");
            request.getRequestDispatcher("addServiceFeedback.jsp").forward(request, response);
        }
    }

    private void viewUserFeedback(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Object accObj = session.getAttribute("acc");
        if (accObj == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        Accounts acc = (Accounts) accObj;
        int accountID = acc.getAccountID();

        DAOServiceFeedback daoServiceFeedback = new DAOServiceFeedback();
        List<ServiceFeedback> feedbacks = daoServiceFeedback.getServiceFeedbackByAccountID(accountID);

        request.setAttribute("feedbacks", feedbacks);
        request.getRequestDispatcher("viewUserFeedback.jsp").forward(request, response);
    }

    private void listAllFeedbacks(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Object accObj = session.getAttribute("acc");

        if (accObj == null || !(accObj instanceof Accounts)) {
            response.sendRedirect("login.jsp");
            return;
        }

        Accounts acc = (Accounts) accObj;
        if (!"admin".equalsIgnoreCase(acc.getRole())) {
            response.sendRedirect("accessDenied.jsp");
            return;
        }

        DAOServiceFeedback daoServiceFeedback = new DAOServiceFeedback();

        int page = 1;
        int pageSize = 10;
        String pageParam = request.getParameter("page");
        if (pageParam != null) {
            try {
                page = Integer.parseInt(pageParam);
            } catch (NumberFormatException e) {
                page = 1;
            }
        }
        int offset = (page - 1) * pageSize;

        List<ServiceFeedback> feedbacks = daoServiceFeedback.getAllServiceFeedback(offset, pageSize);
        int totalFeedbacks = daoServiceFeedback.getFeedbackCount();
        int totalPages = (int) Math.ceil((double) totalFeedbacks / pageSize);

        // Debugging: In ra console để kiểm tra
        System.out.println("Total feedbacks: " + totalFeedbacks);
        System.out.println("Feedbacks size: " + feedbacks.size());

        request.setAttribute("feedbacks", feedbacks);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.getRequestDispatcher("listAllServiceFeedback.jsp").forward(request, response);
    }

    private String extractFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] items = contentDisp.split(";");
        for (String s : items) {
            if (s.trim().startsWith("filename")) {
                return s.substring(s.indexOf("=") + 2, s.length() - 1);
            }
        }
        return "";
    }

    @Override
    public String getServletInfo() {
        return "Servlet quản lý feedback dịch vụ";
    }
}
