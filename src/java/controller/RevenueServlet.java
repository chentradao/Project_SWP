package controller;

import entity.Order;
import entity.SalesData;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Vector;
import model.DAOOrder;
import model.DAOOrderDetail;

@WebServlet(name = "RevenueServlet", urlPatterns = {"/revenue"})
public class RevenueServlet extends HttpServlet {

    DAOOrder daoOrder = new DAOOrder();
    DAOOrderDetail daoOrderDetail = new DAOOrderDetail();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String start_date = request.getParameter("start-date");
            String end_date = request.getParameter("end-date");
            if (end_date == null) {
                end_date = java.sql.Date.valueOf(LocalDate.now()).toString();
            }
            if (start_date == null) {
                start_date = "2025-01-01";
            }

            // Lấy dữ liệu cho biểu đồ tròn danh sách đơn hàng
            Vector<Order> completed = daoOrder.getOrders("SELECT * FROM [SWP].[dbo].[Orders] WHERE [OrderStatus] = 1 AND [OrderDate] BETWEEN '" + start_date + "' AND '" + end_date + "'");
            Vector<Order> waiting = daoOrder.getOrders("SELECT * FROM [SWP].[dbo].[Orders] WHERE [OrderStatus] = 2 AND [OrderDate] BETWEEN '" + start_date + "' AND '" + end_date + "'");
            Vector<Order> shipping = daoOrder.getOrders("SELECT * FROM [SWP].[dbo].[Orders] WHERE [OrderStatus] = 3 AND [OrderDate] BETWEEN '" + start_date + "' AND '" + end_date + "'");
            Vector<Order> cancelled = daoOrder.getOrders("SELECT * FROM [SWP].[dbo].[Orders] WHERE [OrderStatus] = 4 AND [OrderDate] BETWEEN '" + start_date + "' AND '" + end_date + "'");
            Vector<Order> returned = daoOrder.getOrders("SELECT * FROM [SWP].[dbo].[Orders] WHERE [OrderStatus] = 5 AND [OrderDate] BETWEEN '" + start_date + "' AND '" + end_date + "'");

            // Lấy dữ liệu cho doanh thu
            Vector<Order> latestOrders = daoOrder.getOrders("SELECT TOP (5) * FROM [SWP].[dbo].[Orders] WHERE [OrderStatus] = 2 ORDER BY [OrderDate] DESC");
            int EarnedRevenue = daoOrder.getRevunue("SELECT SUM([TotalCost]) AS [TotalSum] FROM [SWP].[dbo].[Orders] WHERE [OrderStatus] = 1 AND [OrderDate] BETWEEN '" + start_date + "' AND '" + end_date + "'");
            int UpcomingRevenue = daoOrder.getRevunue("SELECT SUM([TotalCost]) AS [TotalSum] FROM [SWP].[dbo].[Orders] WHERE [OrderStatus] != 1 AND [OrderDate] BETWEEN '" + start_date + "' AND '" + end_date + "'");
            int OrderCount = daoOrder.getNumberOrder("SELECT COUNT(*) AS OrderCount FROM [SWP].[dbo].[Orders] WHERE OrderStatus = 1 AND [OrderDate] BETWEEN '" + start_date + "' AND '" + end_date + "'");

            // Tính doanh thu thực tế (Real Revenue) - Bỏ TotalReturnValue
            // 1. Tổng giá nhập từ OrderDetail và Products
            String importCostSql = "SELECT SUM(od.Quantity * p.ImportPrice) AS TotalImportCost " +
                                  "FROM [SWP].[dbo].[OrderDetail] od " +
                                  "JOIN [SWP].[dbo].[ProductDetail] p ON od.ProductID = p.ProductID " +
                                  "JOIN [SWP].[dbo].[Orders] o ON od.OrderID = o.OrderID " +
                                  "WHERE o.OrderStatus = 1 AND o.OrderDate BETWEEN '" + start_date + "' AND '" + end_date + "'";
            int totalImportCost = daoOrderDetail.getTotalCost(importCostSql);

            // 2. Tổng tiền ship từ Orders
            String shippingFeeSql = "SELECT SUM(ISNULL(ShippingFee, 0)) AS TotalShippingFee " +
                                   "FROM [SWP].[dbo].[Orders] " +
                                   "WHERE OrderStatus = 1 AND OrderDate BETWEEN '" + start_date + "' AND '" + end_date + "'";
            int totalShippingFee = daoOrder.getRevunue(shippingFeeSql);

            // 3. Doanh thu thực tế = EarnedRevenue - TotalImportCost - TotalShippingFee
            int realRevenue = EarnedRevenue - totalImportCost - totalShippingFee;

            // Lấy dữ liệu cho biểu đồ doanh thu
            List<SalesData> data = daoOrder.getData(start_date, end_date);
            StringBuilder jsonBuilder = new StringBuilder();
            jsonBuilder.append("[");
            for (SalesData sale : data) {
                jsonBuilder.append("{");
                jsonBuilder.append("\"yearMonth\":\"").append(sale.getYear_Month()).append("\",");
                jsonBuilder.append("\"totalCost\":").append(sale.getTotal());
                jsonBuilder.append("},");
            }
            if (jsonBuilder.length() > 1) {
                jsonBuilder.setLength(jsonBuilder.length() - 1);
            }
            jsonBuilder.append("]");
            String jsonData = jsonBuilder.toString();

            // Lấy dữ liệu cho phần top bán chạy
            Map<String, Integer> productSales = daoOrderDetail.getTop5BestSold("SELECT TOP (5) od.ProductID, p.ProductName, SUM(od.Quantity) AS TotalSold " +
                    "FROM OrderDetail od " +
                    "JOIN Products p ON od.ProductID = p.ProductID " +
                    "JOIN Orders o ON od.OrderID = o.OrderID " +
                    "WHERE o.OrderDate BETWEEN '" + start_date + "' AND '" + end_date + "' " +
                    "GROUP BY od.ProductID, p.ProductName " +
                    "ORDER BY TotalSold DESC");
            request.setAttribute("productSales", productSales);

            // Truyền dữ liệu sang trang JSP
            request.setAttribute("jsonData", jsonData);
            request.setAttribute("completed", completed);
            request.setAttribute("waiting", waiting);
            request.setAttribute("shipping", shipping);
            request.setAttribute("cancelled", cancelled);
            request.setAttribute("returned", returned);
            request.setAttribute("start_date", start_date);
            request.setAttribute("end_date", end_date);
            request.setAttribute("latestOrders", latestOrders);
            request.setAttribute("EarnedRevenue", EarnedRevenue);
            request.setAttribute("UpcomingRevenue", UpcomingRevenue);
            request.setAttribute("OrderCount", OrderCount);
            request.setAttribute("RealRevenue", realRevenue);
            request.setAttribute("TotalImportCost", totalImportCost);
            request.setAttribute("TotalShippingFee", totalShippingFee);

            request.getRequestDispatcher("revenueDashboard.jsp").forward(request, response);
        }
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

    @Override
    public String getServletInfo() {
        return "Servlet for revenue dashboard with real revenue calculation (excluding returns)";
    }
}