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

@WebServlet(name = "ListUser", urlPatterns = {"/ListUser"})
public class ListUser extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        DAOAccounts dao = new DAOAccounts();

        // Số bản ghi trên mỗi trang
        int pageSize = 5;

        // Lấy số trang hiện tại từ tham số (mặc định là 1 nếu không có tham số hoặc lỗi)
        String pageStr = request.getParameter("page");
        int currentPage = 1;
        try {
            if (pageStr != null && !pageStr.isEmpty()) {
                currentPage = Integer.parseInt(pageStr);
            }
        } catch (NumberFormatException e) {
            currentPage = 1; // Mặc định về trang 1 nếu lỗi
        }

        // Lấy tham số tìm kiếm và trạng thái
        String search = request.getParameter("search");
        if (search == null) search = "";
        String status = request.getParameter("status");

        // Lấy tham số sắp xếp
        String sortBy = request.getParameter("sortBy");
        String sortOrder = request.getParameter("sortOrder");
        if (sortBy == null || sortBy.isEmpty()) {
            sortBy = "userName"; // Mặc định sắp xếp theo userName
        }
        if (sortOrder == null || sortOrder.isEmpty()) {
            sortOrder = "asc"; // Mặc định sắp xếp tăng dần
        }

        // Tính toán vị trí bắt đầu của bản ghi
        int start = (currentPage - 1) * pageSize;

        
        String baseQuery = "SELECT * FROM Accounts WHERE 1=1";
        if (!search.isEmpty()) {
            baseQuery += " AND (fullName LIKE '%" + search + "%' OR phone LIKE '%" + search + "%' OR email LIKE '%" + search + "%')";
        }
        if (status != null && !status.isEmpty()) {
            baseQuery += " AND AccountStatus = " + status;
        }
        baseQuery += " ORDER BY " + sortBy + " " + sortOrder;

        // Lấy tổng số bản ghi
        List<Accounts> allAccounts = dao.getAllAccounts(baseQuery);
        int totalRecords = allAccounts.size();

        // Tính tổng số trang
        int totalPages = (int) Math.ceil((double) totalRecords / pageSize);

        // Lấy danh sách bản ghi cho trang hiện tại
        List<Accounts> accountsForPage = dao.getAccountsByPage(start, pageSize, baseQuery);


        // Truyền dữ liệu sang JSP
        request.setAttribute("data", accountsForPage);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("sortBy", sortBy);
        request.setAttribute("sortOrder", sortOrder);

        request.getRequestDispatcher("user_list.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "";
    }
}