/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import entity.Accounts;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
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
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
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

            // Lấy tổng số bản ghi khách hàng
            String countQuery = "SELECT COUNT(*) FROM Accounts WHERE Role = 'Customer'";
            int totalRecords = dao.getCount(countQuery);

            // Tính tổng số trang
            int totalPages = (int) Math.ceil((double) totalRecords / PAGE_SIZE);

            // Lấy trang hiện tại từ tham số request, mặc định là 1 nếu không có
            String pageStr = request.getParameter("page");
            int currentPage = (pageStr == null || pageStr.isEmpty()) ? 1 : Integer.parseInt(pageStr);

            // Đảm bảo currentPage nằm trong khoảng hợp lệ
            if (currentPage < 1) currentPage = 1;
            if (currentPage > totalPages && totalPages > 0) currentPage = totalPages;

            // Tính offset cho truy vấn SQL
            int offset = (currentPage - 1) * PAGE_SIZE;

            // Lấy danh sách khách hàng cho trang hiện tại
            String query = "SELECT * FROM Accounts WHERE Role = 'Customer' ORDER BY AccountID OFFSET " 
                         + offset + " ROWS FETCH NEXT " + PAGE_SIZE + " ROWS ONLY";
            List<Accounts> list = dao.getAllAccounts(query);

            // Đặt các thuộc tính vào session
            request.getSession().setAttribute("data", list);
            request.getSession().setAttribute("totalPages", totalPages);
            request.getSession().setAttribute("currentPage", currentPage);

            // Chuyển hướng đến JSP
            request.getRequestDispatcher("list_cus.jsp").forward(request, response);
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
        return "Servlet to list customers with pagination";
    }// </editor-fold>
}