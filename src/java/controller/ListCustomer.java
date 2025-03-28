package controller;

import entity.Accounts;
import entity.Order; // Thêm import này
import java.io.IOException;
import java.text.SimpleDateFormat; // Thêm để định dạng ngày
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Vector;
import model.DAOAccounts;
import model.DAOOrder;

@WebServlet(name = "ListCustomer", urlPatterns = {"/ListCustomer"})
public class ListCustomer extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        DAOAccounts dao = new DAOAccounts();
        
        int pageSize = 5;
        String pageStr = request.getParameter("page");
        int currentPage = (pageStr == null || pageStr.isEmpty()) ? 1 : Integer.parseInt(pageStr);

        String search = request.getParameter("search");
        if (search == null) {
            search = "";
        }
        String status = request.getParameter("status");

        String sortBy = request.getParameter("sortBy");
        String sortOrder = request.getParameter("sortOrder");
        if (sortBy == null || sortBy.isEmpty()) {
            sortBy = "AccountID";
        }
        if (sortOrder == null || sortOrder.isEmpty()) {
            sortOrder = "asc";
        }

        int start = (currentPage - 1) * pageSize;

        String baseQuery = "SELECT * FROM Accounts WHERE Role = 'Customer'";
        if (!search.isEmpty()) {
            baseQuery += " AND (FullName LIKE '%" + search + "%' OR Phone LIKE '%" + search + "%' OR Email LIKE '%" + search + "%')";
        }
        if (status != null && !status.isEmpty()) {
            baseQuery += " AND AccountStatus = " + status;
        }
        baseQuery += " ORDER BY " + sortBy + " " + sortOrder;

        List<Accounts> allCustomers = dao.getAllAccounts1(baseQuery);
        int totalRecords = allCustomers.size();
        int totalPages = (int) Math.ceil((double) totalRecords / pageSize);

        Vector<Accounts> customersForPage = dao.getCustomers(start, pageSize, search, status, sortBy, sortOrder);

        // Truyền dữ liệu sang JSP
        request.setAttribute("CusData", customersForPage);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("sortBy", sortBy);
        request.setAttribute("sortOrder", sortOrder);
        request.setAttribute("search", search);
        request.setAttribute("status", status);

        request.getRequestDispatcher("customer_list.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Customer List Servlet with Pagination";
    }
}