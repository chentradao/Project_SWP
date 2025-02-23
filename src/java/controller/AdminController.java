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
import java.util.List;
import java.util.Vector;
import model.DAOOrder;

/**
 *
 * @author admin
 */
@WebServlet(name = "AdminController", urlPatterns = {"/admin"})
public class AdminController extends HttpServlet {
    DAOOrder dao = new DAOOrder();
    
    
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
            int EarnedRevenue = dao.getRevunue("SELECT SUM([TotalCost]) AS [TotalSum]\n"
                    + "  FROM [SWP].[dbo].[Orders]\n"
                    + "  WHERE [OrderStatus] = 1 AND [OrderDate] BETWEEN '" + start_date + "' AND '" + end_date + "'");
            int UpcomingRevunue = dao.getRevunue("SELECT SUM([TotalCost]) AS [TotalSum]\n"
                    + "  FROM [SWP].[dbo].[Orders]\n"
                    + "  WHERE [OrderStatus] != 1 AND [OrderDate] BETWEEN '" + start_date + "' AND '" + end_date + "'");
            int OrderCount = dao.getNumberOrder();

            List<SalesData> data = new ArrayList<>();
            data = dao.getData(start_date, end_date);

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
// Lưu chuỗi JSON vào request để sử dụng trong JSP
            request.setAttribute("jsonData", jsonData);
            
            Vector<Order> latestOrders = dao.getOrderBy("SELECT TOP (3) [OrderID][CustomerID],[CustomerName],[OrderDate],[ShippedDate],[TotalCost],[Phone],[ShipAddress],[ShipCity],[OrderStatus]\n" +
"FROM [SWP].[dbo].[Orders] WHERE [OrderStatus] = 1 ORDER BY [OrderDate] DESC");
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
        String action = request.getParameter("action");
        
        if ("export".equals(action)) {
            exportSalesData(request, response);
        }
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

    List<SalesData> data = dao.getData(start_date, end_date);

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
