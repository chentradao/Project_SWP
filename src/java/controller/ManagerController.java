package controller;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
import entity.Order;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Vector;
import model.DAOOrder;

@WebServlet(urlPatterns = {"/manager"})
public class ManagerController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            DAOOrder dao = new DAOOrder();
            String startDate = request.getParameter("startDate");
            String endDate = request.getParameter("endDate");
            String statusFilters = request.getParameter("statusFilters");
            String paymentMethod = request.getParameter("paymentMethod");
            String sortBy = request.getParameter("sortBy");
            String sortOrder = request.getParameter("sortOrder");

            // Định dạng ngày
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

            // Xử lý bộ lọc nhanh
            LocalDate now = LocalDate.now();

            if (endDate == null) {
                endDate = java.sql.Date.valueOf(LocalDate.now()).toString();
            }
            if (startDate == null) {
                startDate = "2025-01-01";
            }
            
            if(sortBy == null){
                sortBy = "orderCode";
            }
            
            if(sortOrder == null){
                sortOrder = "desc";
            }
            Vector<Order> waiting = dao.getOrders("SELECT TOP (1000) [OrderID], [OrderCode], [CustomerID], [CustomerName], [OrderDate], "
                    + "[ShippedDate], [ShippingFee], [TotalCost], [Email], [Phone], [ShipAddress], "
                    + "[Discount], [Note], [CancelNotification], [PaymentMethod], [OrderStatus] "
                    + "FROM [SWP].[dbo].[Orders] "
                    + " WHERE [OrderStatus] = 1 AND [OrderDate] BETWEEN '" + startDate + "' AND '" + endDate + "'");

            Vector<Order> cancelled = dao.getOrders("SELECT TOP (1000) [OrderID], [OrderCode], [CustomerID], [CustomerName], [OrderDate], "
                    + "[ShippedDate], [ShippingFee], [TotalCost], [Email], [Phone], [ShipAddress], "
                    + "[Discount], [Note], [CancelNotification], [PaymentMethod], [OrderStatus] "
                    + "FROM [SWP].[dbo].[Orders] "
                    + " WHERE [OrderStatus] = -1 AND [OrderDate] BETWEEN '" + startDate + "' AND '" + endDate + "'");


            int OrderCount = dao.getNumberOrder("SELECT COUNT(*) AS OrderCount FROM [SWP].[dbo].[Orders] WHERE [OrderDate] BETWEEN '" + startDate + "' AND '" + endDate + "'");
            List<Map<String, Object>> orderList = dao.getOrderDetails(statusFilters, startDate, endDate, sortBy, sortOrder, paymentMethod);

            request.setAttribute("status", statusFilters);
            request.setAttribute("paymentMethod", paymentMethod);
            request.setAttribute("orderList", orderList);
            request.setAttribute("startDate", startDate);
            request.setAttribute("endDate", endDate);
            request.setAttribute("waiting", waiting);
            request.setAttribute("cancelled", cancelled);
            request.setAttribute("OrderCount", OrderCount);
            request.getRequestDispatcher("managerDashboard.jsp").forward(request, response);
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
