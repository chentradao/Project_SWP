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
            String start_date = request.getParameter("start-date");
            String end_date = request.getParameter("end-date");
            String timeFilter = request.getParameter("time-filter"); // Lấy giá trị bộ lọc nhanh
            String[] statusFilters = request.getParameterValues("status"); // Lấy danh sách status từ checkbox

            // Định dạng ngày
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

            // Xử lý bộ lọc nhanh
            LocalDate now = LocalDate.now();
            if (timeFilter != null) {
                switch (timeFilter) {
                    case "all":
                        start_date = "2025-01-01";
                        end_date = now.format(formatter);
                        break;
                    case "today":
                        start_date = now.format(formatter);
                        end_date = now.format(formatter);
                        break;
                    case "week":
                        start_date = now.minusDays(now.getDayOfWeek().getValue() - 1).format(formatter); // Đầu tuần
                        end_date = now.format(formatter);
                        break;
                    case "month":
                        start_date = now.withDayOfMonth(1).format(formatter); // Đầu tháng
                        end_date = now.format(formatter);
                        break;
                }
            }

            if (end_date == null) {
                end_date = java.sql.Date.valueOf(LocalDate.now()).toString();
            }
            if (start_date == null) {
                start_date = "2025-01-01";
            }
            
            Vector<Order> waiting = dao.getOrders("SELECT TOP (1000) [OrderID], [OrderCode], [CustomerID], [CustomerName], [OrderDate], " +
        "[ShippedDate], [ShippingFee], [TotalCost], [Email], [Phone], [ShipAddress], " +
        "[Discount], [Note], [CancelNotification], [PaymentMethod], [OrderStatus] " +
        "FROM [SWP].[dbo].[Orders] "
                    + " WHERE [OrderStatus] = 2 AND [OrderDate] BETWEEN '" + start_date + "' AND '" + end_date + "'");
            
            Vector<Order> cancelled = dao.getOrders("SELECT TOP (1000) [OrderID], [OrderCode], [CustomerID], [CustomerName], [OrderDate], " +
        "[ShippedDate], [ShippingFee], [TotalCost], [Email], [Phone], [ShipAddress], " +
        "[Discount], [Note], [CancelNotification], [PaymentMethod], [OrderStatus] " +
        "FROM [SWP].[dbo].[Orders] "
                    + " WHERE [OrderStatus] = 4 AND [OrderDate] BETWEEN '" + start_date + "' AND '" + end_date + "'");
            
            int OrderCount = dao.getNumberOrder("SELECT COUNT(*) AS OrderCount FROM [SWP].[dbo].[Orders] WHERE OrderStatus = 1  AND [OrderDate] BETWEEN '" + start_date + "' AND '" + end_date + "'");
            List<Map<String, Object>> orderList = dao.getOrderDetails(statusFilters, start_date, end_date);


        request.setAttribute("orderList", orderList);
            request.setAttribute("start_date", start_date);
            request.setAttribute("end_date", end_date);
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
