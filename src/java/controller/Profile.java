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

@MultipartConfig
@WebServlet(name = "Profile", urlPatterns = {"/profile"})
public class Profile extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
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
        if (acc == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        if (acc.getRole().equals("staff")) {
            request.getRequestDispatcher("staff_profile.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("cus_profile.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        String AccountID = request.getParameter("AccountID");
        String FullName = request.getParameter("FullName");
        String Gender = request.getParameter("Gender");
        String Phone = request.getParameter("Phone");
        String Email = request.getParameter("Email");
        String city = request.getParameter("city");
        String district = request.getParameter("district");
        String ward = request.getParameter("ward");
        String specificAddress = request.getParameter("specificAddress");
        String Address = specificAddress + ", " + ward + ", " + district + ", " + city;
        String filename = "";

        try {
            HttpSession session = request.getSession();
            Accounts currentAcc = (Accounts) session.getAttribute("acc");

            if (currentAcc == null) {
                request.setAttribute("errorMessage", "Phiên làm việc đã hết hạn. Vui lòng đăng nhập lại.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }

            boolean isValidForm = true;
            DAOAccounts dao = new DAOAccounts();

            // Check FullName
            if (!checkFullName(FullName)) {
                request.setAttribute("messFuName", "Họ tên phải có ít nhất 10 kí tự và không bao gồm số");
                isValidForm = false;
            }

            // Check Phone (only if changed and not current user's phone)
            if (!Phone.equals(currentAcc.getPhone())) {
                Accounts accByPhone = dao.getAccountByPhone(Phone);
                if (accByPhone != null) {
                    request.setAttribute("messPhone", "Số điện thoại đã được sử dụng");
                    isValidForm = false;
                }
            }

            // Check Email (only if changed and not current user's email)
            if (!Email.equals(currentAcc.getEmail())) {
                Accounts accByEmail = dao.getAccountByEmail(Email);
                if (accByEmail != null) {
                    request.setAttribute("messEmail", "Email đã được sử dụng");
                    isValidForm = false;
                }
            }

            // Check Address
            if (city == null || district == null || ward == null || specificAddress == null ||
                city.isEmpty() || district.isEmpty() || ward.isEmpty() || specificAddress.isEmpty()) {
                request.setAttribute("messAddress", "Vui lòng nhập đầy đủ địa chỉ");
                isValidForm = false;
            }

            // File upload handling
            Part part = request.getPart("file");
            if (part != null && part.getSize() > 0) {
                String contentType = part.getContentType();
                if (contentType == null || !contentType.toLowerCase().startsWith("image/")) {
                    request.setAttribute("errorMessage", "Tệp không phải là ảnh. Chỉ chấp nhận định dạng ảnh.");
                    isValidForm = false;
                } else {
                    String submittedFileName = part.getSubmittedFileName();
                    String fileExtension = submittedFileName.substring(submittedFileName.lastIndexOf(".")).toLowerCase();
                    String[] validExtensions = {".jpg", ".png"};
                    boolean isValidExtension = false;
                    for (String ext : validExtensions) {
                        if (fileExtension.equals(ext)) {
                            isValidExtension = true;
                            break;
                        }
                    }

                    if (!isValidExtension) {
                        request.setAttribute("errorMessage", "Định dạng tệp không hợp lệ. Chỉ chấp nhận .jpg, .png");
                        isValidForm = false;
                    } else {
                        String appPath = request.getServletContext().getRealPath("/");
                        String path = "web/P_images";
                        Path uploadDir = Paths.get(appPath).getParent().getParent().resolve(path);

                        if (!Files.exists(uploadDir)) {
                            Files.createDirectories(uploadDir);
                        }

                        filename = "id" + AccountID + "_" + Path.of(submittedFileName).getFileName().toString();
                        Path filePath = uploadDir.resolve(filename);

                        if (Files.exists(filePath)) {
                            Files.copy(part.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);
                        } else {
                            part.write(filePath.toString());
                        }
                    }
                }
            }

            if (!isValidForm) {
                request.setAttribute("FullName", FullName);
                request.setAttribute("Gender", Gender);
                request.setAttribute("Phone", Phone);
                request.setAttribute("Email", Email);
                request.setAttribute("specificAddress", specificAddress);

                if (currentAcc.getRole().equals("staff")) {
                    request.getRequestDispatcher("staff_profile.jsp").forward(request, response);
                } else {
                    request.getRequestDispatcher("cus_profile.jsp").forward(request, response);
                }
                return;
            }

            if (filename.isEmpty()) {
                filename = currentAcc.getImage(); // Keep old avatar if no new file
            }

            // Update account information
            dao.updateAccounts(AccountID, FullName, Gender, Phone, Email, Address, filename);

            // Update session with new account info
            Accounts updatedAccount = dao.getAccountByAccountID(AccountID);
            session.setAttribute("acc", updatedAccount);

            // Lưu các giá trị địa chỉ vào session với key riêng biệt dựa trên vai trò
            if (updatedAccount.getRole().equals("staff")) {
                session.setAttribute("staffCity", city);
                session.setAttribute("staffDistrict", district);
                session.setAttribute("staffWard", ward);
                session.setAttribute("staffSpecificAddress", specificAddress);
            } else {
                session.setAttribute("customerCity", city);
                session.setAttribute("customerDistrict", district);
                session.setAttribute("customerWard", ward);
                session.setAttribute("customerSpecificAddress", specificAddress);
            }

            // Thiết lập thông báo thành công
            request.setAttribute("successMessage", "Cập nhật thông tin thành công.");

            // Chuyển hướng về trang profile tương ứng
            if (updatedAccount.getRole().equals("staff")) {
                request.getRequestDispatcher("staff_profile.jsp").forward(request, response);
            } else {
                request.getRequestDispatcher("cus_profile.jsp").forward(request, response);
            }

        } catch (IOException | ServletException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Đã xảy ra lỗi trong quá trình cập nhật thông tin.");
            HttpSession session = request.getSession();
            Accounts acc = (Accounts) session.getAttribute("acc");
            if (acc != null && acc.getRole().equals("staff")) {
                request.getRequestDispatcher("staff_profile.jsp").forward(request, response);
            } else {
                request.getRequestDispatcher("cus_profile.jsp").forward(request, response);
            }
        }
    }

    private boolean checkFullName(String FullName) {
        if (FullName == null || FullName.length() < 10) {
            return false;
        }
        for (char c : FullName.toCharArray()) {
            if (Character.isDigit(c)) {
                return false;
            }
        }
        return true;
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}