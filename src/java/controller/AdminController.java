package controller;

import entity.InventoryItem;
import entity.RevenueChartData;
import entity.RevenueSummary;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.time.LocalDate;
import model.DAOInventory;
import java.util.List;
import java.util.Map;
import com.google.gson.Gson;

@WebServlet(name = "RevenueServlet", urlPatterns = {"/admin"})
public class AdminController extends HttpServlet {

    private DAOInventory inventoryDAO;

    @Override
    public void init() throws ServletException {
        inventoryDAO = new DAOInventory();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        // Lấy thông tin lọc từ form
        String filterType = request.getParameter("filter-type");
        if (filterType == null || filterType.isEmpty()) {
            filterType = "month"; // Mặc định lọc theo tháng
        }
        String startDate = request.getParameter("start-date");
        if (startDate == null || startDate.isEmpty()) {
            startDate = "2025-01-01"; // Mặc định từ đầu năm
        }
        String endDate = request.getParameter("end-date");
        if (endDate == null || endDate.isEmpty()) {
            endDate = LocalDate.now().toString(); // Mặc định đến hiện tại
        }

        // Lấy dữ liệu từ DAOInventory
        RevenueSummary summary = inventoryDAO.getRevenueSummary(startDate, endDate);
        Map<String, Object> chartData = inventoryDAO.getRevenueChartData(filterType, startDate, endDate);
        List<InventoryItem> topSellingProducts = inventoryDAO.getTopSellingProducts(5, startDate, endDate);
        
        // Dữ liệu mới
        Map<String, Object> categoryRevenueData = inventoryDAO.getCategoryRevenueData(startDate, endDate);
        List<InventoryItem> lowStockProducts = inventoryDAO.getLowStockProducts(5); // Ngưỡng < 5
        Map<String, Object> newCustomerData = inventoryDAO.getNewCustomerData(filterType, startDate, endDate);
        Map<String, Object> inventoryData = inventoryDAO.getInventoryData();

        // Đặt dữ liệu vào request
        request.setAttribute("totalRevenue", summary.getTotalRevenue());
        request.setAttribute("totalSold", summary.getTotalSold());
        request.setAttribute("totalStock", summary.getTotalStock());
        request.setAttribute("topSellingProducts", topSellingProducts);
        request.setAttribute("revenueLabels", new Gson().toJson(chartData.get("labels")));
        request.setAttribute("revenueData", new Gson().toJson(chartData.get("data")));
        request.setAttribute("filterType", filterType);
        
        // Dữ liệu mới
        request.setAttribute("categoryRevenueData", new Gson().toJson(categoryRevenueData));
        request.setAttribute("lowStockProducts", lowStockProducts);
        request.setAttribute("newCustomerData", new Gson().toJson(newCustomerData));
        request.setAttribute("inventoryData", new Gson().toJson(inventoryData));

        request.setAttribute("start_date", startDate);
        request.setAttribute("end_date", endDate);

        request.getRequestDispatcher("/adminDashboard.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    
}