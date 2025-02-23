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
import java.util.Date;
import java.util.Vector;
import model.DAOOrder;

@WebServlet(urlPatterns={"/manager"})
public class ManagerController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            DAOOrder dao = new DAOOrder();
            String start_date = request.getParameter("start-date");
            String end_date = request.getParameter("end-date");
            if(end_date == null){
                end_date = java.sql.Date.valueOf(LocalDate.now()).toString();
            }
            if(start_date == null){
                start_date = "2025-01-01";
            }
            Vector<Order> completed = dao.getOrderBy("SELECT TOP (1000) [OrderID]\n"
                + "      ,[CustomerID]\n"
                + "      ,[CustomerName]\n"
                + "      ,[OrderDate]\n"
                + "      ,[ShippedDate]\n"
                + "      ,[TotalCost]\n"
                + "      ,[Phone]\n"
                + "      ,[ShipAddress]\n"
                + "      ,[ShipCity]\n"
                + "      ,[OrderStatus]\n"
                + "  FROM [SWP].[dbo].[Orders]\n"
                + " WHERE [OrderStatus] = 1 AND [OrderDate] BETWEEN '" + start_date + "' AND '" + end_date + "'");
                  Vector<Order> waiting = dao.getOrderBy("SELECT TOP (1000) [OrderID]\n"
                + "      ,[CustomerID]\n"
                + "      ,[CustomerName]\n"
                + "      ,[OrderDate]\n"
                + "      ,[ShippedDate]\n"
                + "      ,[TotalCost]\n"
                + "      ,[Phone]\n"
                + "      ,[ShipAddress]\n"
                + "      ,[ShipCity]\n"
                + "      ,[OrderStatus]\n"
                + "  FROM [SWP].[dbo].[Orders]\n"
                + " WHERE [OrderStatus] = 2 AND [OrderDate] BETWEEN '" + start_date + "' AND '" + end_date + "'");  
         Vector<Order> shipping = dao.getOrderBy("SELECT TOP (1000) [OrderID]\n"
                + "      ,[CustomerID]\n"
                + "      ,[CustomerName]\n"
                + "      ,[OrderDate]\n"
                + "      ,[ShippedDate]\n"
                + "      ,[TotalCost]\n"
                + "      ,[Phone]\n"
                + "      ,[ShipAddress]\n"
                + "      ,[ShipCity]\n"
                + "      ,[OrderStatus]\n"
                + "  FROM [SWP].[dbo].[Orders]\n"
                + " WHERE [OrderStatus] = 3 AND [OrderDate] BETWEEN '" + start_date + "' AND '" + end_date + "'"); 
         Vector<Order> cancelled = dao.getOrderBy("SELECT TOP (1000) [OrderID]\n"
                + "      ,[CustomerID]\n"
                + "      ,[CustomerName]\n"
                + "      ,[OrderDate]\n"
                + "      ,[ShippedDate]\n"
                + "      ,[TotalCost]\n"
                + "      ,[Phone]\n"
                + "      ,[ShipAddress]\n"
                + "      ,[ShipCity]\n"
                + "      ,[OrderStatus]\n"
                + "  FROM [SWP].[dbo].[Orders]\n"
                + " WHERE [OrderStatus] = 4 AND [OrderDate] BETWEEN '" + start_date + "' AND '" + end_date + "'"); 
         Vector<Order> returned = dao.getOrderBy("SELECT TOP (1000) [OrderID]\n"
                + "      ,[CustomerID]\n"
                + "      ,[CustomerName]\n"
                + "      ,[OrderDate]\n"
                + "      ,[ShippedDate]\n"
                + "      ,[TotalCost]\n"
                + "      ,[Phone]\n"
                + "      ,[ShipAddress]\n"
                + "      ,[ShipCity]\n"
                + "      ,[OrderStatus]\n"
                + "  FROM [SWP].[dbo].[Orders]\n"
                + " WHERE [OrderStatus] = 5 AND [OrderDate] BETWEEN '" + start_date + "' AND '" + end_date + "'");
          Vector<Order> latestOrders = dao.getOrderBy("SELECT TOP (3) [OrderID][CustomerID],[CustomerName],[OrderDate],[ShippedDate],[TotalCost],[Phone],[ShipAddress],[ShipCity],[OrderStatus]\n" +
"FROM [SWP].[dbo].[Orders] WHERE [OrderStatus] = 2 ORDER BY [OrderDate] DESC");
        request.setAttribute("latestOrders", latestOrders);
         request.setAttribute("completed", completed);
         request.setAttribute("waiting", waiting);
         request.setAttribute("shipping", shipping);
         request.setAttribute("cancelled", cancelled);
         request.setAttribute("returned", returned);
         request.getRequestDispatcher("managerDashboard.jsp").forward(request, response);
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
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
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
