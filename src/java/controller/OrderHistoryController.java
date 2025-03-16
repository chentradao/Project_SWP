/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import entity.Accounts;
import entity.Order;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.time.LocalDate;
import java.util.Vector;
import model.DAOOrder;

/**
 *
 * @author nguye
 */
@WebServlet(name = "OrderHistoryController", urlPatterns = {"/OrderHistoryURL"})
public class OrderHistoryController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession(true);
        Accounts acc = (Accounts) session.getAttribute("acc");
        DAOOrder dao = new DAOOrder();
        try (PrintWriter out = response.getWriter()) {
            String service = request.getParameter("service");

            if (service.equals("deleteOrder")) {
                String cancel = request.getParameter("cancel");
                Order order;
                int oid = Integer.parseInt(request.getParameter("oid"));
                Vector<Order> vector = dao.getOrders("select * from Orders where OrderID =" + oid);
                for (Order or : vector) {
                    or.setCancelNotification(cancel);
                    dao.updateOrder(or);
                }
                dao.deleteOrder(oid);
                response.sendRedirect(request.getHeader("Referer"));
            }

            if (service.equals("orderHistory")) {
                if (acc != null) {
                    String sortColumn = request.getParameter("sortColumn");
                    String sortOrder = request.getParameter("sortOrder");
                    int page = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;
                    int pageSize = 10; // Số bản ghi mỗi trang (có thể thay đổi)
                    // Tổng số bản ghi
                    int totalRecords = dao.getTotalOrders("SELECT COUNT(*) FROM Orders WHERE CustomerID = " + acc.getAccountID());
                    int totalPages = (int) Math.ceil((double) totalRecords / pageSize);
                    // Đảm bảo page hợp lệ
                    if (page < 1) {
                        page = 1;
                    }
                    if (page > totalPages) {
                        page = totalPages;
                    }
                    // Tính vị trí bắt đầu
                    int start = (page - 1) * pageSize;

                    String orderByClause = " ORDER BY OrderDate DESC"; // Mặc định
                    if (sortColumn != null && sortOrder != null) {
                        String direction = sortOrder.equals("asc") ? "ASC" : "DESC";
                        switch (sortColumn) {
                            case "orderDate":
                                orderByClause = " ORDER BY OrderDate " + direction;
                                break;
                            case "customerName":
                                orderByClause = " ORDER BY CustomerName " + direction;
                                break;
                            case "phone":
                                orderByClause = " ORDER BY Phone " + direction;
                                break;
                            case "totalCost":
                                orderByClause = " ORDER BY TotalCost " + direction;
                                break;
                            case "paymentMethod":
                                orderByClause = " ORDER BY PaymentMethod " + direction;
                                break;
                            case "orderStatus":
                                orderByClause = " ORDER BY OrderStatus " + direction;
                                break;
                        }
                    }

                    // Lấy dữ liệu theo trang
                    Vector<Order> vector = dao.getOrders("SELECT * FROM Orders WHERE CustomerID = " + acc.getAccountID()
                            + orderByClause + " OFFSET " + start + " ROWS FETCH NEXT " + pageSize + " ROWS ONLY");

                    // Truyền dữ liệu cho JSP
                    request.setAttribute("vector", vector);
                    request.setAttribute("currentPage", page);
                    request.setAttribute("totalPages", totalPages);
                    request.setAttribute("sortColumn", sortColumn);
                    request.setAttribute("sortOrder", sortOrder);
                    request.setAttribute("service", "orderHistory");
                    request.getRequestDispatcher("/jsp/OrderHistory.jsp").forward(request, response);
                } else {
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                }
            }

            if (service.equals("orderFilter")) {
                if (acc == null) {
                    response.sendRedirect("OrderURL?service=orderHistory");
                } else {
                    String status = request.getParameter("status");
                    String startDate = request.getParameter("start");
                    String endDate = request.getParameter("end");
                    String payment = request.getParameter("payment");
                    String sortColumn = request.getParameter("sortColumn");
                    String sortOrder = request.getParameter("sortOrder");

                    if (endDate == null || endDate.trim().isEmpty()) {
                        endDate = LocalDate.now().toString();
                    }
                    if (startDate == null) {
                        startDate = "2000-01-01";
                    }

                    // Tham số phân trang
                    int page = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;
                    int pageSize = 10;

                    // Tổng số bản ghi với bộ lọc
                    String countQuery = "SELECT COUNT(*) FROM Orders WHERE OrderStatus LIKE '%" + status + "%' "
                            + "AND OrderDate BETWEEN '" + startDate + "' AND '" + endDate + "' "
                            + "AND PaymentMethod LIKE '%" + payment + "%' AND CustomerID = " + acc.getAccountID();
                    int totalRecords = dao.getTotalOrders(countQuery);
                    int totalPages = (int) Math.ceil((double) totalRecords / pageSize);

                    // Đảm bảo page hợp lệ
                    if (page < 1) {
                        page = 1;
                    }
                    if (page > totalPages) {
                        page = totalPages;
                    }

                    int start = (page - 1) * pageSize;

                    // Xử lý sắp xếp
                    String orderByClause = " ORDER BY OrderDate DESC"; // Mặc định
                    if (sortColumn != null && sortOrder != null) {
                        String direction = sortOrder.equals("asc") ? "ASC" : "DESC";
                        switch (sortColumn) {
                            case "orderDate":
                                orderByClause = " ORDER BY OrderDate " + direction;
                                break;
                            case "customerName":
                                orderByClause = " ORDER BY CustomerName " + direction;
                                break;
                            case "phone":
                                orderByClause = " ORDER BY Phone " + direction;
                                break;
                            case "totalCost":
                                orderByClause = " ORDER BY TotalCost " + direction;
                                break;
                            case "paymentMethod":
                                orderByClause = " ORDER BY PaymentMethod " + direction;
                                break;
                            case "orderStatus":
                                orderByClause = " ORDER BY OrderStatus " + direction;
                                break;
                        }
                    }

                    // Truy vấn dữ liệu theo trang
                    String sql = "SELECT * FROM Orders "
                            + "WHERE OrderStatus LIKE '%" + status + "%' "
                            + "AND OrderDate BETWEEN '" + startDate + "' AND '" + endDate + "' "
                            + "AND PaymentMethod LIKE '%" + payment + "%' "
                            + "AND CustomerID = " + acc.getAccountID() + orderByClause
                            + " OFFSET " + start + " ROWS FETCH NEXT " + pageSize + " ROWS ONLY";
                    Vector<Order> vector = dao.getOrders(sql);

                    // Truyền dữ liệu cho JSP
                    request.setAttribute("vector", vector);
                    request.setAttribute("currentPage", page);
                    request.setAttribute("totalPages", totalPages);
                    request.setAttribute("status", status);
                    request.setAttribute("startDate", startDate);
                    request.setAttribute("endDate", endDate);
                    request.setAttribute("payment", payment);
                    request.setAttribute("sortColumn", sortColumn);
                    request.setAttribute("sortOrder", sortOrder);
                    request.setAttribute("service", "orderFilter");
                    request.getRequestDispatcher("/jsp/OrderHistory.jsp").forward(request, response);
                }
            }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
