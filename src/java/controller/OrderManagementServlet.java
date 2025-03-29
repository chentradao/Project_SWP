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
import java.sql.SQLException;
import java.util.Vector;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.DAOOrder;

@WebServlet(name = "OrderManagementServlet", urlPatterns = {"/OrderManagementServlet"})
public class OrderManagementServlet extends HttpServlet {

    private DAOOrder dao = new DAOOrder();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        String action = request.getParameter("action"); // Đổi từ "action" thành "service" để đồng bộ với JSP

        if ("order".equals(action)) {
            // Lấy tham số sắp xếp từ request
            String sortBy = request.getParameter("sortBy");
            String sortOrder = request.getParameter("sortOrder");

            // Xây dựng câu truy vấn SQL dựa trên tham số sắp xếp
            String sql = "SELECT * FROM Orders WHERE OrderCode IS NOT NULL";
            if (sortBy != null && sortOrder != null) {
                if (sortBy.equals("orderID")) {
                    sql += " ORDER BY OrderID " + (sortOrder.equals("asc") ? "ASC" : "DESC");
                } else if (sortBy.equals("shippedDate")) {
                    // Xử lý null trong shippedDate: null sẽ xếp cuối khi ASC, đầu khi DESC
                    sql += " ORDER BY ISNULL(ShippedDate, '9999-12-31') " + (sortOrder.equals("asc") ? "ASC" : "DESC");
                }
            }

            // Lấy danh sách đơn hàng từ DAO
            Vector<Order> vectorOrder = dao.getOrders(sql);
            System.out.println("SQL Query: " + sql); // Debug câu truy vấn
            System.out.println("Number of orders: " + (vectorOrder != null ? vectorOrder.size() : "null")); // Debug số lượng đơn hàng

            // Gửi danh sách đơn hàng tới JSP
            request.setAttribute("vectorOrder", vectorOrder);
            request.getRequestDispatcher("orderManagement.jsp").forward(request, response);
        } else if ("cancel".equals(action)) {
            int orderId = Integer.parseInt(request.getParameter("orderId"));
            Order o = dao.getOrderByOrderID(orderId);            
            HttpSession session = request.getSession();
            Accounts acc = (Accounts) session.getAttribute("acc");
            dao.changeStatus(orderId, -1);
            dao.changeStaffID(orderId, acc.getAccountID());
            response.sendRedirect("manager");
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid service parameter");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(OrderManagementServlet.class.getName()).log(Level.SEVERE, null, ex);
            request.setAttribute("errorMessage", "Database error: " + ex.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(OrderManagementServlet.class.getName()).log(Level.SEVERE, null, ex);
            request.setAttribute("errorMessage", "Database error: " + ex.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet for managing orders with sorting and status updates";
    }
}