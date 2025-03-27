package controller;

import entity.Accounts;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.Vector;
import model.DAOAccounts;

@WebServlet(name = "ListCus", urlPatterns = {"/ListCus"})
public class ListCus extends HttpServlet {

    private static final int PAGE_SIZE = 4;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            DAOAccounts dao = new DAOAccounts();

            // Lấy tham số search
            String search = request.getParameter("search") != null ? request.getParameter("search").trim() : "";

            // Lấy tham số sort
            String sortBy = request.getParameter("sortBy") != null ? request.getParameter("sortBy") : "OrderQuality";
            String sortOrder = request.getParameter("sortOrder") != null ? request.getParameter("sortOrder") : "asc";

            // Xây dựng câu query đếm tổng số bản ghi
            String countQuery = "SELECT COUNT(*) FROM Accounts WHERE Role = 'Customer'";
            if (!search.isEmpty()) {
                countQuery += " AND (FullName LIKE '%" + search + "%' OR Phone LIKE '%" + search + "%' OR Email LIKE '%" + search + "%')";
            }
            int totalRecords = dao.getCount(countQuery);

            // Tính tổng số trang, đảm bảo ít nhất là 1 ngay cả khi không có bản ghi
            int totalPages = (int) Math.ceil((double) Math.max(totalRecords, 1) / PAGE_SIZE);

            // Lấy trang hiện tại từ tham số request, mặc định là 1 nếu không có
            String pageStr = request.getParameter("page");
            int currentPage = (pageStr == null || pageStr.isEmpty()) ? 1 : Integer.parseInt(pageStr);

            // Đảm bảo currentPage nằm trong khoảng hợp lệ
            if (currentPage < 1) {
                currentPage = 1;
            }
            if (currentPage > totalPages) {
                currentPage = totalPages;
            }

            // Tính offset cho truy vấn SQL
            int offset = (currentPage - 1) * PAGE_SIZE;

            // Lấy danh sách khách hàng cho trang hiện tại
            Vector<Accounts> list = dao.getCustomers(offset, PAGE_SIZE, search, null, sortBy, sortOrder);

            // Đặt các thuộc tính vào session
            request.getSession().setAttribute("data", list);
            request.getSession().setAttribute("totalPages", totalPages);
            request.getSession().setAttribute("currentPage", currentPage);
            request.getSession().setAttribute("search", search);
            request.getSession().setAttribute("sortBy", sortBy);
            request.getSession().setAttribute("sortOrder", sortOrder);

            // Chuyển hướng đến JSP
            request.getRequestDispatcher("list_cus.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred: " + e.getMessage());
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
        return "Servlet to list customers with pagination, search, and sort";
    }
}