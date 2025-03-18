/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import entity.Accounts;
import entity.Order;
import entity.OrderDetail;
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
import model.DAOOrderDetail;

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
        DAOOrderDetail da = new DAOOrderDetail();
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
                if (acc == null) {
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                    return;
                }

                String status = request.getParameter("status");
                int page = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;
                int pageSize = 4;

                // Tổng số bản ghi
                String countQuery = "SELECT COUNT(*) FROM Orders WHERE CustomerID = " + acc.getAccountID();
                if (status != null && !status.isEmpty()) {
                    countQuery += " AND OrderStatus = " + status;
                }
                int totalRecords = dao.getTotalOrders(countQuery);
                int totalPages = (int) Math.ceil((double) totalRecords / pageSize);

                if (page < 1) {
                    page = 1;
                }
                if (page > totalPages) {
                    page = totalPages;
                }
                int start = (page - 1) * pageSize;

                // Truy vấn dữ liệu (sắp xếp mặc định theo OrderDate DESC)
                String sql = "SELECT * FROM Orders WHERE CustomerID = " + acc.getAccountID();
                if (status != null && !status.isEmpty()) {
                    sql += " AND OrderStatus = " + status;
                }
                sql += " ORDER BY OrderID DESC OFFSET " + start + " ROWS FETCH NEXT " + pageSize + " ROWS ONLY";
                Vector<Order> vector = dao.getOrders(sql);
                for(Order order : vector){
                    Vector<OrderDetail> orderDetail = da.getOrderDetailByOrderID(order.getOrderID());
                    order.setOrderDetail(orderDetail);
                }

                // Truyền dữ liệu cho JSP
                request.setAttribute("vector", vector);
                request.setAttribute("currentPage", page);
                request.setAttribute("totalPages", totalPages);
                request.setAttribute("status", status);
                request.getRequestDispatcher("/jsp/OrderHistory.jsp").forward(request, response);
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
