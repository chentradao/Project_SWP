/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import entity.Accounts;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.DAOAccounts;

/**
 *
 * @author Admin
 */
@WebServlet(name = "UserDetail", urlPatterns = {"/userDetail"})
public class UserDetail extends HttpServlet {

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
        // Lấy tham số username từ URL
        String username = request.getParameter("username");
        
        // Kiểm tra nếu username không tồn tại
        if (username == null || username.isEmpty()) {
            response.sendRedirect("ListUser");
            return;
        }

        // Truy vấn cơ sở dữ liệu để lấy thông tin chi tiết của tài khoản
        DAOAccounts dao = new DAOAccounts();
        Accounts account = dao.getAccountByUserName(username); // Sử dụng phương thức có sẵn

        // Kiểm tra nếu không tìm thấy tài khoản
        if (account == null) {
            response.sendRedirect("ListUser");
            return;
        }

        // Truyền dữ liệu sang JSP
        request.setAttribute("account", account);
        request.getRequestDispatcher("user_detail.jsp").forward(request, response);
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
        doGet(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Servlet to display user details";
    }
}