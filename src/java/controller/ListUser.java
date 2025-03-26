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
import java.util.List;
import model.DAOAccounts;

/**
 *
 * @author Admin
 */
@WebServlet(name = "ListUser", urlPatterns = {"/ListUser"})
public class ListUser extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        DAOAccounts dao = new DAOAccounts();

        // Số bản ghi trên mỗi trang
        int pageSize = 5;

        // Lấy số trang hiện tại từ tham số (mặc định là 1 nếu không có tham số)
        String pageStr = request.getParameter("page");
        int currentPage = (pageStr == null || pageStr.isEmpty()) ? 1 : Integer.parseInt(pageStr);

        // Lấy tham số tìm kiếm
        String search = request.getParameter("search");
        String status = request.getParameter("status");

        // Tính toán vị trí bắt đầu của bản ghi
        int start = (currentPage - 1) * pageSize;

        // Xây dựng câu query cơ bản
        String baseQuery = "SELECT * FROM Accounts WHERE 1=1";
        if (search != null && !search.isEmpty()) {
            baseQuery += " AND (fullName LIKE '%" + search + "%' OR phone LIKE '%" + search + "%' OR email LIKE '%" + search + "%')";
        }
        if (status != null && !status.isEmpty()) {
            baseQuery += " AND accountStatus = " + status;
        }

        // Lấy tổng số bản ghi
        List<Accounts> allAccounts = dao.getAllAccounts1(baseQuery); // Dùng getAllAccounts1 thay vì getAllAccounts
        int totalRecords = allAccounts.size();

        // Tính tổng số trang
        int totalPages = (int) Math.ceil((double) totalRecords / pageSize);

        // Lấy danh sách bản ghi cho trang hiện tại
        List<Accounts> accountsForPage = dao.getAccountsByPage(start, pageSize, baseQuery);

        // Debug để kiểm tra
        System.out.println("Total records: " + totalRecords);
        System.out.println("Accounts for page: " + accountsForPage.size());
        System.out.println("Query: " + baseQuery);

        // Truyền dữ liệu sang JSP
        request.setAttribute("data", accountsForPage);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);

        request.getRequestDispatcher("user_list.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response); // Chuyển hướng POST về GET để xử lý tìm kiếm
    }

    @Override
    public String getServletInfo() {
        return "Servlet to list and search user accounts";
    }
}