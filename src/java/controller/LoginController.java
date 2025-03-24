/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbproject/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import entity.Accounts;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.DAOAccounts;

/**
 *
 * @author Admin
 */
@WebServlet(name = "LoginController", urlPatterns = {"/login"})
public class LoginController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        DAOAccounts dao = new DAOAccounts();
        String UserName = request.getParameter("UserName");
        String Password = request.getParameter("Password");
        Accounts acc = dao.login(UserName, Password);
        
        try {
            if (UserName != null && Password != null) {
                if (acc == null) {
                    request.setAttribute("mess", "Sai tài khoản hoặc mật khẩu");
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                } else {
                    // Kiểm tra AccountStatus
                    if (acc.getAccountStatus() == 0) {
                        request.setAttribute("mess", "Tài khoản của bạn đã bị khóa. Vui lòng liên hệ với admin để mở khóa.");
                        request.getRequestDispatcher("login.jsp").forward(request, response);
                    } else {
                        HttpSession session = request.getSession(true);
                        session.setAttribute("acc", acc);
                        if(acc.getRole().equals("admin")){
                            response.sendRedirect("admin");
                        } else if(acc.getRole().equals("staff")){
                            response.sendRedirect("manager");
                        } else {
                            response.sendRedirect("ProductListServlet");
                        }
                    }
                }
            } else {
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }

        } catch (IOException e) {
            System.out.println("Error occurred while logging in");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String ac = request.getParameter("ac");

        if (ac != null && ac.equals("logout")) {
            HttpSession session = request.getSession();
            session.removeAttribute("acc");
            session.removeAttribute("mess");
            response.sendRedirect("ProductListServlet");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}