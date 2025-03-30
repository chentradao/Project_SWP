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
import java.text.NumberFormat;
import java.util.Locale;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.mail.internet.AddressException;
import model.EmailHandler;

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
                request.setAttribute("messU", "Tên đăng nhập phải có ít nhất 5 kí tự");
                isValidForm = false;
            }
            if (acc != null) {
                request.setAttribute("messU", "Tên đăng nhập đã tồn tại");
                isValidForm = false;
            }

            // Kiểm tra mật khẩu
            boolean isNotValidPassword = !checkPassword(Password);
            if (isNotValidPassword) {
                request.setAttribute("messP", "Mật khẩu phải có ít nhất 6 kí tự, "
                        + "bao gồm kí tự in hoa, in thường và số.");
                isValidForm = false;
            }

            if (!checkFullName(FullName)) {
                request.setAttribute("messFuName", "Họ tên phải có ít nhất 10 kí tự và không bao gồm số");
                isValidForm = false;
            }

            // Kiểm tra email
            Accounts accByEmail = new DAOAccounts().getAccountByEmail(Email);
            if (accByEmail != null) {
                request.setAttribute("messEmail", "Email đã tồn tại");
                isValidForm = false;
            }

            // Kiểm tra số điện thoại
            Accounts accByPhone = new DAOAccounts().getAccountByPhone(Phone);
            if (accByPhone != null) {
                request.setAttribute("messPhone", "Số điện thoại đã tồn tại");
                isValidForm = false;
            }

            // Kiểm tra xác nhận mật khẩu
            if (!Password.equals(ConfirmPassword)) {
                request.setAttribute("messCp", "Mật khẩu không khớp");
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
                 sendVoucherEmail(Email, "WELCOME02", 20, 200000);
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
    private void sendVoucherEmail(String email, String voucherCode, int discount, int maxDiscount) {
         NumberFormat formatter = NumberFormat.getNumberInstance(new Locale("vi", "VN"));
         formatter.setGroupingUsed(true); 
         String subject = "ESTÉE LAUDER - Mã Voucher Giảm Giá Dành Cho Bạn!";
         String content = "<!DOCTYPE html>"
                 + "<html>"
                 + "<head>"
                 + "    <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">"
                 + "    <title>Mã Voucher Giảm Giá</title>"
                 + "    <style>"
                 + "        .container { margin: 50px 200px; background-color: #F3F3F3; padding: 25px; text-align: center; }"
                 + "        .voucher-code { font-size: 24px; font-weight: bold; color: #ce0707; margin-top: 20px; }"
                 + "        .discount { font-size: 20px; margin-top: 10px; color: #333; }"
                 + "    </style>"
                 + "</head>"
                 + "<body style=\" padding: 30px;\">"
                 + "    <div class=\"container\">"
                 + "        <p>Cảm ơn bạn đã mua sắm tại <a href=\"http://localhost:8080/Project_SWP/ProductListServlet\">ESTÉE LAUDER</a>!</p>"
                 + "        <p>Chúng tôi gửi tặng bạn một mã giảm giá đặc biệt.</p>"
                 + "        <div class=\"voucher-code\">" + voucherCode + "</div>"
                 + "        <div class=\"discount\">Giảm ngay " + discount + "% trên tổng giá trị đơn hàng</div>"
                 + "        <p>Giảm tối đa "+formatter.format(maxDiscount)+"</p>"
                 + "        <p>Hãy sử dụng mã này trong lần mua sắm tiếp theo để nhận ưu đãi!</p>"
                 + "        <p>Trân trọng,</p>"
                 + "        <h2>ESTÉE LAUDER</h2>"
                 + "    </div>"
                 + "</body>"
                 + "</html>";
         try {
             EmailHandler.sendEmail(email, subject, content);
         } catch (AddressException ex) {
             Logger.getLogger(OrderController.class.getName()).log(Level.SEVERE, null, ex);
         }
     }

    private boolean checkUserName(String UserName) {
        return UserName.length() >= 5;
    }
}
