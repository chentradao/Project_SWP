/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import entity.Accounts;
import entity.Cart;
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
import java.sql.Date;
import java.util.Enumeration;
import model.DAOOrder;

/**
 *
 * @author nguye
 */
@WebServlet(name = "OrderController", urlPatterns = {"/OrderURL"})
public class OrderController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession(true);
        Accounts acc = (Accounts) session.getAttribute("acc");
        DAOOrder dao = new DAOOrder();
        try (PrintWriter out = response.getWriter()) {
            String service = request.getParameter("service");
            if (service.equals("checkout")) {
                String submit = request.getParameter("submit");
                if (submit == null) {
                    request.setAttribute("acc", acc);
                    request.getRequestDispatcher("/jsp/Checkout.jsp").forward(request, response);
                } else {
                    int CustomerID = Integer.parseInt(request.getParameter("CustomerID"));
                    String CustomerName = request.getParameter("CustomerName");
                    Date OrderDate = Date.valueOf(LocalDate.now());
                    Date ShippedDate = null;
                    int TotalCost = Integer.parseInt(request.getParameter("TotalCost"));
                    String Phone = request.getParameter("Phone");
                    String ShipAddress = request.getParameter("ShipAddress");
                    String ShipCity = request.getParameter("ShipCity");
                    int OrderStatus = 1;
                    Order o = new Order(OrderStatus, CustomerID, CustomerName, OrderDate, ShippedDate, TotalCost, Phone, ShipAddress, ShipCity, OrderStatus);
                    int n=dao.insertOrder(o);
                if (n > 0) {
            // Insert các mục giỏ hàng vào OrderDetails
            Enumeration<String> enu = session.getAttributeNames();
            while (enu.hasMoreElements()) {
                String key = enu.nextElement();
                Object obj = session.getAttribute(key);
                
                if (obj instanceof Cart) {
                    Cart cart = (Cart) obj;
                    dao.addToOrder(cart);  
                    session.removeAttribute(key);
                }
            }
            response.sendRedirect("index.jsp");
        }
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
