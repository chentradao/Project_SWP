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
import model.DAOAccounts;

/**
 *
 * @author Admin
 */
@WebServlet(name = "SignUp", urlPatterns = {"/signup"})
public class SignUp extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        String FullName = request.getParameter("FullName");
        String UserName = request.getParameter("UserName");
        String Password = request.getParameter("Password");
        String ConfirmPassword = request.getParameter("ConfirmPassword");
        String Email = request.getParameter("Email");
        String Phone = request.getParameter("Phone");

        try {
            boolean isValidForm = true;

            // Kiểm tra tên người dùng
            boolean isNotValidUsername = !checkUserName(UserName);
            Accounts acc = new DAOAccounts().getAccountByUserName(UserName);

            if (isNotValidUsername) {
                request.setAttribute("messU", "Username must have at least 5 characters");
                isValidForm = false;
            }
            if (acc != null) {
                request.setAttribute("messU", "User already exists");
                isValidForm = false;
            }

            // Kiểm tra mật khẩu
            boolean isNotValidPassword = !checkPassword(Password);
            if (isNotValidPassword) {
                request.setAttribute("messP", "Password must have at least 6 characters, "
                        + "including uppercase letters, lowercase letters and numbers.");
                isValidForm = false;
            }

            if (!checkFullName(FullName)) {
                request.setAttribute("messFuName", "Full Name must have at least 10 characters and cannot contain numbers");
                isValidForm = false;
            }

            // Kiểm tra email
            Accounts accByEmail = new DAOAccounts().getAccountByEmail(Email);
            if (accByEmail != null) {
                request.setAttribute("messEmail", "Email already exists");
                isValidForm = false;
            }

            // Kiểm tra số điện thoại
            Accounts accByPhone = new DAOAccounts().getAccountByPhone(Phone);
            if (accByPhone != null) {
                request.setAttribute("messPhone", "Phone number already exists");
                isValidForm = false;
            }

            // Kiểm tra xác nhận mật khẩu
            if (!Password.equals(ConfirmPassword)) {
                request.setAttribute("messCp", "Passwords do not match");
                isValidForm = false;
            }

            // Nếu có lỗi, quay lại trang signup.jsp
            if (!isValidForm) {
                request.setAttribute("FullName", FullName);
                request.setAttribute("UserName", UserName);
                request.setAttribute("Password", Password);
                request.setAttribute("ConfirmPassword", ConfirmPassword);
                request.setAttribute("Email", Email);
                request.setAttribute("Phone", Phone);
                request.getRequestDispatcher("signup.jsp").forward(request, response);
            } else {
                // Tạo tài khoản mới
                new DAOAccounts().createAccount(UserName, Password, FullName, Phone, Email, "Customer", 1);
                response.sendRedirect("login.jsp");
            }

        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
        }

    }

    private boolean checkFullName(String FullName) {
        if (FullName.length() < 10) {
            return false;
        }
        for (char c : FullName.toCharArray()) {
            if (Character.isDigit(c)) {
                return false;
            }
        }
        return true;
    }

    private boolean checkPassword(String Password) {
        if (Password.length() < 6) {
            return false;
        }

        boolean hasUpperCase = false, hasLowerCase = false, hasDigit = false;

        for (char c : Password.toCharArray()) {
            if (Character.isUpperCase(c)) {
                hasUpperCase = true;
            } else if (Character.isLowerCase(c)) {
                hasLowerCase = true;
            } else if (Character.isDigit(c)) {
                hasDigit = true;

            }
        }

        return hasUpperCase && hasLowerCase && hasDigit;
    }

    private boolean checkUserName(String UserName) {
        return UserName.length() >= 5;
    }
}
