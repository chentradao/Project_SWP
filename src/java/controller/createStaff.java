package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.DAOAccounts;
import entity.Accounts;

@WebServlet(name = "createStaff", urlPatterns = {"/createStaff"})
public class createStaff extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("createStaff.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        String FullName = request.getParameter("FullName");
        String UserName = request.getParameter("UserName");
        String Password = request.getParameter("Password");
        String ConfirmPassword = request.getParameter("ConfirmPassword"); // Lấy giá trị ConfirmPassword
        String Email = request.getParameter("Email");
        String Phone = request.getParameter("Phone");
        String Role = request.getParameter("Role");
        int AccountStatus = Integer.parseInt(request.getParameter("AccountStatus"));
        String Gender = request.getParameter("Gender");

        try {
            boolean isValidForm = true;
            DAOAccounts dao = new DAOAccounts();

            // Kiểm tra tên đăng nhập
            boolean isNotValidUsername = !checkUserName(UserName);
            Accounts acc = dao.getAccountByUserName(UserName);

            if (isNotValidUsername) {
                request.setAttribute("messU", "Tên đăng nhập phải có ít nhất 5 ký tự");
                isValidForm = false;
            }
            if (acc != null) {
                request.setAttribute("messU", "Tên đăng nhập đã tồn tại");
                isValidForm = false;
            }

            // Kiểm tra mật khẩu
            boolean isNotValidPassword = !checkPassword(Password);
            if (isNotValidPassword) {
                request.setAttribute("messP", "Mật khẩu phải có ít nhất 6 ký tự, bao gồm ký tự in hoa, in thường và số.");
                isValidForm = false;
            }

            // Kiểm tra mật khẩu nhập lại
            if (!Password.equals(ConfirmPassword)) {
                request.setAttribute("messConfirmP", "Mật khẩu nhập lại không khớp");
                isValidForm = false;
            }

            // Kiểm tra họ tên
            if (!checkFullName(FullName)) {
                request.setAttribute("messFuName", "Họ tên phải có ít nhất 10 ký tự và không bao gồm số");
                isValidForm = false;
            }

            // Kiểm tra email
            Accounts accByEmail = dao.getAccountByEmail(Email);
            if (accByEmail != null) {
                request.setAttribute("messEmail", "Email đã tồn tại");
                isValidForm = false;
            }

            // Kiểm tra số điện thoại
            Accounts accByPhone = dao.getAccountByPhone(Phone);
            if (accByPhone != null) {
                request.setAttribute("messPhone", "Số điện thoại đã tồn tại");
                isValidForm = false;
            }

            // Kiểm tra giới tính
            if (Gender == null || (!Gender.equals("M") && !Gender.equals("F"))) {
                request.setAttribute("messGender", "Vui lòng chọn giới tính (Nam hoặc Nữ)");
                isValidForm = false;
            }

            // Nếu có lỗi, quay lại trang createStaff.jsp
            if (!isValidForm) {
                request.setAttribute("FullName", FullName);
                request.setAttribute("UserName", UserName);
                request.setAttribute("Password", Password);
                request.setAttribute("ConfirmPassword", ConfirmPassword); // Lưu giá trị ConfirmPassword
                request.setAttribute("Email", Email);
                request.setAttribute("Phone", Phone);
                request.setAttribute("Role", Role);
                request.setAttribute("AccountStatus", AccountStatus);
                request.setAttribute("Gender", Gender);
                request.getRequestDispatcher("createStaff.jsp").forward(request, response);
            } else {
                // Tạo tài khoản Staff mới
                dao.createStaff(UserName, Password, FullName, Email, Phone, Role, AccountStatus, Gender);
                request.setAttribute("message", "Tạo tài khoản thành công!");
                response.sendRedirect("ListUser"); // Chuyển hướng khi thành công
            }

        } catch (Exception e) {
            request.setAttribute("message", "Có lỗi xảy ra khi tạo tài khoản: " + e.getMessage());
            request.getRequestDispatcher("createStaff.jsp").forward(request, response);
        }
    }

    // Kiểm tra họ tên
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

    // Kiểm tra mật khẩu
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

    // Kiểm tra tên đăng nhập
    private boolean checkUserName(String UserName) {
        return UserName.length() >= 5;
    }


    @Override
    public String getServletInfo() {
        return "Servlet to create staff accounts";
    }
}