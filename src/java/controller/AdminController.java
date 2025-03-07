/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
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
import java.io.OutputStream;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Vector;
import model.DAOOrder;
import model.DAOOrderDetail;

/**
 *
 * @author admin
 */
@WebServlet(name = "AdminController", urlPatterns = {"/admin"})
public class AdminController extends HttpServlet {

    DAOOrder daoOrder = new DAOOrder();
    DAOOrderDetail daoOrderDetail = new DAOOrderDetail();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            String start_date = request.getParameter("start-date");
            String end_date = request.getParameter("end-date");
            if (end_date == null) {
                end_date = java.sql.Date.valueOf(LocalDate.now()).toString();
            }
            if (start_date == null) {
                start_date = "2025-01-01";
            }
            //lấy dữ liệu cho biểu đồ tròn danh sách đơn hàng
            Vector<Order> completed = daoOrder.getOrderBy("SELECT TOP (1000) [OrderID]\n"
                    + "      ,[CustomerID]\n"
                    + "      ,[CustomerName]\n"
                    + "      ,[OrderDate]\n"
                    + "      ,[ShippedDate]\n"
                    + "      ,[TotalCost]\n"
                    + "      ,[Phone]\n"
                    + "      ,[ShipAddress]\n"
                    + "      ,[ShipCity]\n"
                    + "      ,[OrderStatus]\n"
                    + "  FROM [SWP].[dbo].[Orders]\n"
                    + " WHERE [OrderStatus] = 1 AND [OrderDate] BETWEEN '" + start_date + "' AND '" + end_date + "'");
            Vector<Order> waiting = daoOrder.getOrderBy("SELECT TOP (1000) [OrderID]\n"
                    + "      ,[CustomerID]\n"
                    + "      ,[CustomerName]\n"
                    + "      ,[OrderDate]\n"
                    + "      ,[ShippedDate]\n"
                    + "      ,[TotalCost]\n"
                    + "      ,[Phone]\n"
                    + "      ,[ShipAddress]\n"
                    + "      ,[ShipCity]\n"
                    + "      ,[OrderStatus]\n"
                    + "  FROM [SWP].[dbo].[Orders]\n"
                    + " WHERE [OrderStatus] = 2 AND [OrderDate] BETWEEN '" + start_date + "' AND '" + end_date + "'");
            Vector<Order> shipping = daoOrder.getOrderBy("SELECT TOP (1000) [OrderID]\n"
                    + "      ,[CustomerID]\n"
                    + "      ,[CustomerName]\n"
                    + "      ,[OrderDate]\n"
                    + "      ,[ShippedDate]\n"
                    + "      ,[TotalCost]\n"
                    + "      ,[Phone]\n"
                    + "      ,[ShipAddress]\n"
                    + "      ,[ShipCity]\n"
                    + "      ,[OrderStatus]\n"
                    + "  FROM [SWP].[dbo].[Orders]\n"
                    + " WHERE [OrderStatus] = 3 AND [OrderDate] BETWEEN '" + start_date + "' AND '" + end_date + "'");
            Vector<Order> cancelled = daoOrder.getOrderBy("SELECT TOP (1000) [OrderID]\n"
                    + "      ,[CustomerID]\n"
                    + "      ,[CustomerName]\n"
                    + "      ,[OrderDate]\n"
                    + "      ,[ShippedDate]\n"
                    + "      ,[TotalCost]\n"
                    + "      ,[Phone]\n"
                    + "      ,[ShipAddress]\n"
                    + "      ,[ShipCity]\n"
                    + "      ,[OrderStatus]\n"
                    + "  FROM [SWP].[dbo].[Orders]\n"
                    + " WHERE [OrderStatus] = 4 AND [OrderDate] BETWEEN '" + start_date + "' AND '" + end_date + "'");
            Vector<Order> returned = daoOrder.getOrderBy("SELECT TOP (1000) [OrderID]\n"
                    + "      ,[CustomerID]\n"
                    + "      ,[CustomerName]\n"
                    + "      ,[OrderDate]\n"
                    + "      ,[ShippedDate]\n"
                    + "      ,[TotalCost]\n"
                    + "      ,[Phone]\n"
                    + "      ,[ShipAddress]\n"
                    + "      ,[ShipCity]\n"
                    + "      ,[OrderStatus]\n"
                    + "  FROM [SWP].[dbo].[Orders]\n"
                    + " WHERE [OrderStatus] = 5 AND [OrderDate] BETWEEN '" + start_date + "' AND '" + end_date + "'");

            //lấy dữ liệu cho biểu đồ tròn doanh thu
            Vector<Order> latestOrders = daoOrder.getOrderBy("SELECT TOP (5) [OrderID][CustomerID],[CustomerName],[OrderDate],[ShippedDate],[TotalCost],[Phone],[ShipAddress],[ShipCity],[OrderStatus]\n"
                    + "FROM [SWP].[dbo].[Orders] WHERE [OrderStatus] = 2 ORDER BY [OrderDate] DESC");
            int EarnedRevenue = daoOrder.getRevunue("SELECT SUM([TotalCost]) AS [TotalSum]\n"
                    + "  FROM [SWP].[dbo].[Orders]\n"
                    + "  WHERE [OrderStatus] = 1 AND [OrderDate] BETWEEN '" + start_date + "' AND '" + end_date + "'");
            int UpcomingRevunue = daoOrder.getRevunue("SELECT SUM([TotalCost]) AS [TotalSum]\n"
                    + "  FROM [SWP].[dbo].[Orders]\n"
                    + "  WHERE [OrderStatus] != 1 AND [OrderDate] BETWEEN '" + start_date + "' AND '" + end_date + "'");
            int OrderCount = daoOrder.getNumberOrder("SELECT COUNT(*) AS OrderCount FROM [SWP].[dbo].[Orders] WHERE OrderStatus = 1  AND [OrderDate] BETWEEN '" + start_date + "' AND '" + end_date + "'");

            //láy dữ liệu cho biểu đồ doanh thu
            List<SalesData> data = new ArrayList<>();
            data = daoOrder.getData(start_date, end_date);

            StringBuilder jsonBuilder = new StringBuilder();
            jsonBuilder.append("[");
            for (SalesData sale : data) {
                jsonBuilder.append("{");
                jsonBuilder.append("\"yearMonth\":\"").append(sale.getYear_Month()).append("\",");
                jsonBuilder.append("\"totalCost\":").append(sale.getTotal());
                jsonBuilder.append("},");
            }

            // Xóa dấu phẩy cuối cùng và đóng mảng JSON
            if (jsonBuilder.length() > 1) {
                jsonBuilder.setLength(jsonBuilder.length() - 1);
            }
            jsonBuilder.append("]");
            String jsonData = jsonBuilder.toString();

            //lấy dữ liệu cho phần top bán chạy
            Map<String, Integer> productSales = new LinkedHashMap<>();
            productSales = daoOrderDetail.getTop5BestSold("SELECT TOP (5) od.ProductID, p.ProductName, SUM(od.Quantity) AS TotalSold "
                    + "FROM OrderDetail od "
                    + "JOIN Products p ON od.ProductID = p.ProductID "
                    + "JOIN Orders o ON od.OrderID = o.OrderID "
                    + "WHERE o.OrderDate BETWEEN '" + start_date + "' AND '" + end_date + "' "
                    + // Thêm dấu cách trước GROUP BY
                    "GROUP BY od.ProductID, p.ProductName "
                    + "ORDER BY TotalSold DESC");
            request.setAttribute("productSales", productSales);

            // Truyền dữ liệu sang trang jsp
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
            request.setAttribute("UpcomingRevunue", UpcomingRevunue);
            request.setAttribute("OrderCount", OrderCount);
            request.getRequestDispatcher("adminDashboard.jsp").forward(request, response);

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

//        String action = request.getParameter("action");
//
//        if (action.isEmpty()) {
//            processRequest(request, response);
//        }
//        else{
//           exportSalesData(request, response); 
//        }
    }

    private void exportSalesData(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String start_date = request.getParameter("start-date");
        String end_date = request.getParameter("end-date");

        if (end_date == null) {
            end_date = java.sql.Date.valueOf(LocalDate.now()).toString();
        }
        if (start_date == null) {
            start_date = "2025-01-01";
        }

        List<SalesData> data = daoOrder.getData(start_date, end_date);

        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=sales_data.xlsx");

//    Workbook workbook = new XSSFWorkbook();
//    Sheet sheet = workbook.createSheet("Sales Data");
//
//    // Ghi tiêu đề cột
//    Row headerRow = sheet.createRow(0);
//    headerRow.createCell(0).setCellValue("YearMonth");
//    headerRow.createCell(1).setCellValue("TotalCost");
//
//    // Ghi dữ liệu
//    int rowNum = 1;
//    for (SalesData sale : data) {
//        Row row = sheet.createRow(rowNum++);
//        row.createCell(0).setCellValue(sale.getYear_Month());
//        row.createCell(1).setCellValue(sale.getTotal());
//    }
//
//    try (OutputStream out = response.getOutputStream()) {
//        workbook.write(out);
//    }
//    workbook.close();
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
