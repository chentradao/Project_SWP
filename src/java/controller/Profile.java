/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import entity.Accounts;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import model.DAOAccounts;

/**
 *
 * @author Admin
 */
@MultipartConfig
@WebServlet(name = "Profile", urlPatterns = {"/profile"})
public class Profile extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet Profile</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Profile at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Accounts acc = (Accounts) session.getAttribute("acc");
        if (acc.getRole().equals("staff")) {
            request.getRequestDispatcher("staff_profile.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("cus_profile.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String AccountID = request.getParameter("AccountID");
        String FullName = request.getParameter("FullName");
        String Gender = request.getParameter("Gender");
        String Phone = request.getParameter("Phone");
        String Email = request.getParameter("Email");
        String Address = request.getParameter("Address");
        String filename = "";

        try {
            // Lấy phần file từ request
            Part part = request.getPart("file");
            if (part != null && part.getSize() > 0) {
                // Lấy đường dẫn thư mục gốc của ứng dụng
                String appPath = request.getServletContext().getRealPath("/");
                // Đường dẫn tới thư mục mong muốn (cùng cấp với thư mục chứa servlet)
                String path = "web/P_images";
                Path uploadDir = Paths.get(appPath).getParent().getParent().resolve(path);

                // Kiểm tra và tạo thư mục nếu chưa tồn tại
                if (!Files.exists(uploadDir)) {
                    Files.createDirectories(uploadDir);
                }

                // Lấy tên file và đường dẫn file đầy đủ
                filename = "id" + AccountID + "_" + Path.of(part.getSubmittedFileName()).getFileName().toString();
                Path filePath = uploadDir.resolve(filename);

                // Kiểm tra nếu file đã tồn tại, thì ghi đè lên file đó
                if (Files.exists(filePath)) {
                    Files.copy(part.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);
                } else {
                    // Nếu file chưa tồn tại, ghi file mới vào
                    part.write(filePath.toString());
                }
            } else {
                request.setAttribute("errorMessage", "Không có file nào được chọn để upload.");
            }

            HttpSession session = request.getSession();
            Accounts acc = (Accounts) session.getAttribute("acc");

            if (acc == null) {
                request.setAttribute("errorMessage", "Phiên làm việc đã hết hạn. Vui lòng đăng nhập lại.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }

            if (filename.isEmpty()) {
                filename = acc.getImage(); // Giữ avatar cũ nếu không có file mới
            }

            // Cập nhật thông tin người dùng trong cơ sở dữ liệu
            DAOAccounts dao = new DAOAccounts();

            dao.updateAccounts(AccountID, FullName, Gender, Phone, Email, Address, filename); // Gọi hàm đã đổi tên

            // Cập nhật lại session với thông tin người dùng mới
            Accounts updatedAccount = dao.getAccountByAccountID(AccountID);
            session.setAttribute("acc", updatedAccount);

            // Hiển thị thông báo thành công và điều hướng lại trang thông tin
            request.setAttribute("successMessage", "Cập nhật thông tin thành công.");
            response.sendRedirect("profile");

        } catch (IOException | ServletException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Đã xảy ra lỗi trong quá trình cập nhật thông tin.");
            response.sendRedirect("profile");
        }

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
