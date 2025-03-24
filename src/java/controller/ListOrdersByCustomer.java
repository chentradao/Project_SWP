package controller;

import entity.Order;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.Vector;
import model.DAOAccounts;
import java.util.logging.Logger;
import java.util.logging.Level;

@WebServlet(name = "ListOrdersByCustomer", urlPatterns = {"/ListOrdersByCustomer"})
public class ListOrdersByCustomer extends HttpServlet {

    private static final int PAGE_SIZE = 5; // Số lượng bản ghi trên mỗi trang
    private static final Logger LOGGER = Logger.getLogger(ListOrdersByCustomer.class.getName());

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        DAOAccounts dao = new DAOAccounts();

        // Lấy tham số từ request
        String customerIDStr = request.getParameter("customerID");
        int customerID = (customerIDStr != null && !customerIDStr.isEmpty()) ? Integer.parseInt(customerIDStr) : 0;

        // Thêm tham số sắp xếp và tìm kiếm
        String sortBy = request.getParameter("sortBy"); // "orderDate" hoặc "totalCost"
        String sortOrder = request.getParameter("sortOrder"); // "asc" hoặc "desc"
        String searchTerm = request.getParameter("searchTerm"); // Giá trị tìm kiếm chung

        // Mặc định nếu không có giá trị
        if (sortBy == null || sortBy.isEmpty()) sortBy = "orderDate"; // Mặc định sắp xếp theo ngày đặt hàng
        if (sortOrder == null || sortOrder.isEmpty()) sortOrder = "desc"; // Mặc định giảm dần

        // Lấy tổng số bản ghi đơn hàng của khách hàng
        int totalRecords = 0;
        try {
            totalRecords = dao.getOrderCountByCustomer(customerID, searchTerm);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi lấy số lượng đơn hàng cho customerID: " + customerID, e);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi khi lấy số lượng đơn hàng: " + e.getMessage());
            return;
        }

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

        // Lấy danh sách đơn hàng của khách hàng
        Vector<Order> list = null;
        try {
            list = dao.getOrdersByCustomer(customerID, offset, PAGE_SIZE, sortBy, sortOrder, searchTerm);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi lấy danh sách đơn hàng cho customerID: " + customerID, e);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi khi lấy danh sách đơn hàng: " + e.getMessage());
            return;
        }

        // Đặt các thuộc tính vào session
        request.getSession().setAttribute("orderData", list);
        request.getSession().setAttribute("orderTotalPages", totalPages);
        request.getSession().setAttribute("orderCurrentPage", currentPage);
        request.getSession().setAttribute("customerID", customerID);
        request.getSession().setAttribute("sortBy", sortBy);
        request.getSession().setAttribute("sortOrder", sortOrder);
        request.getSession().setAttribute("searchTerm", searchTerm);

        // Chuyển hướng đến JSP hiển thị danh sách đơn hàng
        request.getRequestDispatcher("list_orders_by_customer.jsp").forward(request, response);
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
        return "";
    }
}