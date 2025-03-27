package controller;

import entity.Accounts;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.DAOAccounts;

@WebServlet(name = "EditStaff", urlPatterns = {"/EditStaff"})
public class EditStaff extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        DAOAccounts dao = new DAOAccounts();
        String username = request.getParameter("username");

        // Lấy thông tin nhân viên dựa trên username
        Accounts staff = dao.getAccountByUserName(username);
        if (staff == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy nhân viên.");
            return;
        }

        request.setAttribute("staff", staff);
        request.getRequestDispatcher("edit_staff.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        DAOAccounts dao = new DAOAccounts();
        String username = request.getParameter("username");
        String fullName = request.getParameter("fullName");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");

        // Lấy thông tin nhân viên hiện tại để so sánh
        Accounts currentStaff = dao.getAccountByUserName(username);
        if (currentStaff == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy nhân viên.");
            return;
        }

        boolean isValidForm = true;

        // Kiểm tra FullName
        if (!checkFullName(fullName)) {
            request.setAttribute("messFuName", "Họ tên phải có ít nhất 10 ký tự và không chứa số.");
            isValidForm = false;
        }

        // Kiểm tra Phone
        if (!isVietnamesePhoneNumber(phone)) {
            request.setAttribute("messPhone", "Số điện thoại phải có 10 số, bắt đầu bằng 03, 05, 07, 08, 09 hoặc 01[2,6,8,9].");
            isValidForm = false;
        } else if (!phone.equals(currentStaff.getPhone())) {
            Accounts accByPhone = dao.getAccountByPhone(phone);
            if (accByPhone != null && !accByPhone.getUserName().equals(username)) {
                request.setAttribute("messPhone", "Số điện thoại đã được sử dụng.");
                isValidForm = false;
            }
        }

        // Kiểm tra Email
        if (!validateEmail(email)) {
            request.setAttribute("messEmail", "Email phải có định dạng hợp lệ (ví dụ: ten@domain.com).");
            isValidForm = false;
        } else if (!email.equals(currentStaff.getEmail())) {
            Accounts accByEmail = dao.getAccountByEmail(email);
            if (accByEmail != null && !accByEmail.getUserName().equals(username)) {
                request.setAttribute("messEmail", "Email đã được sử dụng.");
                isValidForm = false;
            }
        }

        // Nếu có lỗi, quay lại form chỉnh sửa với thông báo
        if (!isValidForm) {
            request.setAttribute("staff", currentStaff);
            request.setAttribute("fullName", fullName);
            request.setAttribute("phone", phone);
            request.setAttribute("email", email);
            request.getRequestDispatcher("edit_staff.jsp").forward(request, response);
        } else {
            // Cập nhật thông tin nếu hợp lệ
            boolean updated = dao.updateStaff(username, fullName, phone, email);
            if (updated) {
                response.sendRedirect("ListStaff");
            } else {
                request.setAttribute("error", "Cập nhật thất bại. Vui lòng thử lại.");
                request.setAttribute("staff", currentStaff);
                request.getRequestDispatcher("edit_staff.jsp").forward(request, response);
            }
        }
    }

    // Kiểm tra FullName: ít nhất 10 ký tự, không chứa số
    private boolean checkFullName(String fullName) {
        if (fullName == null || fullName.length() < 10) {
            return false;
        }
        for (char c : fullName.toCharArray()) {
            if (Character.isDigit(c)) {
                return false;
            }
        }
        return true;
    }

    // Kiểm tra định dạng số điện thoại Việt Nam
    private boolean isVietnamesePhoneNumber(String number) {
        if (number == null) return false;
        String phonePattern = "^(03|05|07|08|09|01[2689])[0-9]{8}$";
        return number.matches(phonePattern);
    }

    // Kiểm tra định dạng email
    private boolean validateEmail(String email) {
        if (email == null) return false;
        String emailPattern = "^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$";
        return email.matches(emailPattern);
    }

    @Override
    public String getServletInfo() {
        return "Servlet to edit staff information";
    }
}