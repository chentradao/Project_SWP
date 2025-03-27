package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.DAOAccounts;

@WebServlet(name = "DeleteStaff", urlPatterns = {"/DeleteStaff"})
public class DeleteStaff extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy username từ tham số
        String username = request.getParameter("username");

        // Kiểm tra nếu username không null hoặc rỗng
        if (username != null && !username.isEmpty()) {
            DAOAccounts dao = new DAOAccounts();
            
            // Xóa tài khoản từ cơ sở dữ liệu
            boolean isDeleted = dao.deleteAccount(username);

            if (isDeleted) {
                System.out.println("Deleted staff account: " + username);
            } else {
                System.out.println("Failed to delete staff account: " + username);
            }
        }

        // Chuyển hướng về trang danh sách nhân viên
        response.sendRedirect("ListStaff");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response); // Chuyển hướng POST về GET
    }

    @Override
    public String getServletInfo() {
        return "Servlet to delete a staff account";
    }
}