package controller;

import entity.Accounts;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Vector;
import model.DAOAccounts;

@WebServlet(name = "ListCustomer", urlPatterns = {"/ListCustomer"})
public class ListCustomer extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        DAOAccounts dao = new DAOAccounts();
        
        // Số bản ghi trên mỗi trang
        int pageSize = 5;

        // Lấy số trang hiện tại từ tham số (mặc định là 1 nếu không có tham số)
        String pageStr = request.getParameter("page");
        int currentPage = (pageStr == null || pageStr.isEmpty()) ? 1 : Integer.parseInt(pageStr);

        // Lấy tham số tìm kiếm và trạng thái
        String search = request.getParameter("search");
        if (search == null) {
            search = "";
        }
        String status = request.getParameter("status");

        // Lấy tham số sắp xếp
        String sortBy = request.getParameter("sortBy");
        String sortOrder = request.getParameter("sortOrder");
        if (sortBy == null || sortBy.isEmpty()) {
            sortBy = "AccountID"; // Mặc định sắp xếp theo AccountID
        }
        if (sortOrder == null || sortOrder.isEmpty()) {
            sortOrder = "asc"; // Mặc định sắp xếp tăng dần
        }

        // Tính toán vị trí bắt đầu của bản ghi
        int start = (currentPage - 1) * pageSize;

        // Xây dựng câu query cơ bản
        String baseQuery = "SELECT * FROM Accounts WHERE Role = 'Customer'";
        if (!search.isEmpty()) {
            baseQuery += " AND (FullName LIKE '%" + search + "%' OR Phone LIKE '%" + search + "%' OR Email LIKE '%" + search + "%')";
        }
        if (status != null && !status.isEmpty()) {
            baseQuery += " AND AccountStatus = " + status;
        }
        // Thêm sắp xếp
        baseQuery += " ORDER BY " + sortBy + " " + sortOrder;

        // Lấy tổng số bản ghi
        List<Accounts> allCustomers = dao.getAllAccounts1(baseQuery); // Giả sử DAO có method này tương tự ListStaff
        int totalRecords = allCustomers.size();

        // Tính tổng số trang
        int totalPages = (int) Math.ceil((double) totalRecords / pageSize);

        // Lấy danh sách bản ghi cho trang hiện tại
        Vector<Accounts> customersForPage = dao.getCustomers(start, pageSize, search, status, sortBy, sortOrder);

        // Truyền dữ liệu sang JSP
        request.setAttribute("CusData", customersForPage);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("sortBy", sortBy);
        request.setAttribute("sortOrder", sortOrder);
        request.setAttribute("search", search); // Giữ giá trị search trên giao diện
        request.setAttribute("status", status); // Giữ giá trị status trên giao diện

        request.getRequestDispatcher("customer_list.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response); // Chuyển hướng POST về GET để xử lý tìm kiếm
    }

    @Override
    public String getServletInfo() {
        return "Customer List Servlet with Pagination";
    }
}