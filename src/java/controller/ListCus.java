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

/**
 *
 * @author Admin
 */
@WebServlet(name = "ListCus", urlPatterns = {"/ListCus"})
public class ListCus extends HttpServlet {

    // Số bản ghi mỗi trang
    private static final int PAGE_SIZE = 4;

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
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

            // Lấy tổng số bản ghi khách hàng
            int totalRecords = dao.getCount(search);

            // Tính tổng số trang
            int totalPages = (int) Math.ceil((double) totalRecords / PAGE_SIZE);

            // Lấy trang hiện tại từ tham số request, mặc định là 1 nếu không có
            String pageStr = request.getParameter("page");
            int currentPage = (pageStr == null || pageStr.isEmpty()) ? 1 : Integer.parseInt(pageStr);

            // Đảm bảo currentPage nằm trong khoảng hợp lệ
            if (currentPage < 1) {
                currentPage = 1;
            }
            if (currentPage > totalPages && totalPages > 0) {
                currentPage = totalPages;
            }

            // Tính offset cho truy vấn SQL
            int offset = (currentPage - 1) * PAGE_SIZE;

            // Lấy danh sách khách hàng cho trang hiện tại
            Vector<Accounts> list = dao.getCustomers(offset, PAGE_SIZE, search, sortBy, sortOrder);

            // Đặt các thuộc tính vào session
            request.getSession().setAttribute("data", list);
            request.getSession().setAttribute("totalPages", totalPages);
            request.getSession().setAttribute("currentPage", currentPage);
            request.getSession().setAttribute("search", search); // Lưu giá trị search để giữ trên JSP
            request.getSession().setAttribute("sortBy", sortBy); // Lưu giá trị sortBy
            request.getSession().setAttribute("sortOrder", sortOrder); // Lưu giá trị sortOrder

            // Chuyển hướng đến JSP
            request.getRequestDispatcher("list_cus.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred while processing the request: " + e.getMessage());
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
