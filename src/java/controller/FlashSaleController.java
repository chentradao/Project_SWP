/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import entity.FlashSale;
import entity.Order;
import entity.Product;
import entity.ProductDetail;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.time.LocalDate;
import java.util.List;
import java.util.Vector;
import model.DAOFlashSale;
import model.DAOProductDetail;
import model.DAOProducts;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author nguye
 */
@WebServlet(name = "FlashSaleController", urlPatterns = {"/FlashSaleURL"})
public class FlashSaleController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        DAOFlashSale dao = new DAOFlashSale();
        DAOProductDetail da = new DAOProductDetail();
        try (PrintWriter out = response.getWriter()) {
            String service = request.getParameter("service");

            if (service.equals("updateFlash")) {
                String submit = request.getParameter("submit");
                if (submit == null) {
                    int fid = Integer.parseInt(request.getParameter("fid"));
                    FlashSale fls = dao.findFSByID(fid);
                    ProductDetail pro = da.getProDetailbyID(fls.getProductID());
                    fls.setProductDetail(pro);
                    request.setAttribute("flash", fls);
                    request.getRequestDispatcher("/jsp/UpdateFlashSale.jsp").forward(request, response);
                } else {
                    int SaleID = Integer.parseInt(request.getParameter("SaleID"));
                    int ProductID = Integer.parseInt(request.getParameter("productID"));
                    String date = request.getParameter("date");
                    String startTime = null, endTime = null;
                    int timeFrame = 0;
                    if (request.getParameter("timeFrame") != null) {
                        timeFrame = Integer.parseInt(request.getParameter("timeFrame"));
                    }
                    if (timeFrame == 1) {
                        startTime = date + " 10:00:00";
                        endTime = date + " 13:00:00";
                    }
                    if (timeFrame == 2) {
                        startTime = date + " 13:00:00";
                        endTime = date + " 16:00:00";
                    }
                    if (timeFrame == 3) {
                        startTime = date + " 16:00:00";
                        endTime = date + " 19:00:00";
                    }
                    if (timeFrame == 4) {
                        startTime = date + " 19:00:00";
                        endTime = date + " 22:00:00";
                    }
                    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                    Date startDate = null, endDate = null;
                    try {
                        startDate = dateFormat.parse(startTime);
                        endDate = dateFormat.parse(endTime);
                    } catch (ParseException ex) {
                        Logger.getLogger(FlashSaleController.class.getName()).log(Level.SEVERE, null, ex);
                    }
                    int TimeFrame = Integer.parseInt(request.getParameter("timeFrame"));
                    int Discount = Integer.parseInt(request.getParameter("discount"));
                    int Quality = Integer.parseInt(request.getParameter("flashQuantity"));
                    FlashSale flash = new FlashSale(SaleID, ProductID, startDate, endDate, Discount, Quality, TimeFrame, 2);
                    int n = dao.updateFlashSale(flash);
                    response.sendRedirect("FlashSaleURL?service=flashSaleList");
                }
            }

            if (service.equals("deleteFlash")) {
                int saleID = Integer.parseInt(request.getParameter("saleID"));
                int n = dao.DeleteFlashSale(saleID);
                response.sendRedirect("FlashSaleURL?service=flashSaleList");
            }

            if (service.equals("createFlash")) {
                String submit = request.getParameter("submit");
                if (submit == null) {
                    Vector<ProductDetail> pro = da.getProductDetail("Select * from Products p join ProductDetail pd on p.ProductID = pd.ProductID Where pd.ProductStatus = 1");
                    request.setAttribute("pro", pro);
                    request.getRequestDispatcher("/jsp/CreateFlashSale.jsp").forward(request, response);
                } else {
                    int ProductID = Integer.parseInt(request.getParameter("productID"));
                    String date = request.getParameter("date");
                    String startTime = null, endTime = null;
                    int timeFrame = 0;
                    if (request.getParameter("timeFrame") != null) {
                        timeFrame = Integer.parseInt(request.getParameter("timeFrame"));
                    }
                    if (timeFrame == 1) {
                        startTime = date + " 10:00:00";
                        endTime = date + " 13:00:00";
                    }
                    if (timeFrame == 2) {
                        startTime = date + " 13:00:00";
                        endTime = date + " 16:00:00";
                    }
                    if (timeFrame == 3) {
                        startTime = date + " 16:00:00";
                        endTime = date + " 19:00:00";
                    }
                    if (timeFrame == 4) {
                        startTime = date + " 19:00:00";
                        endTime = date + " 22:00:00";
                    }
                    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                    Date startDate = null, endDate = null;
                    try {
                        startDate = dateFormat.parse(startTime);
                        endDate = dateFormat.parse(endTime);
                    } catch (ParseException ex) {
                        Logger.getLogger(FlashSaleController.class.getName()).log(Level.SEVERE, null, ex);
                    }
                    int TimeFrame = Integer.parseInt(request.getParameter("timeFrame"));
                    int Discount = Integer.parseInt(request.getParameter("discount"));
                    int Quality = Integer.parseInt(request.getParameter("flashQuantity"));
                    FlashSale flash = new FlashSale(ProductID, startDate, endDate, Discount, Quality, TimeFrame, 2);
                    int n = dao.insertFlashSale(flash);
                    response.sendRedirect("FlashSaleURL?service=flashSaleList");
                }
            }

            if (service.equals("flashSaleList")) {
                String sortColumn = request.getParameter("sortColumn");
                String sortOrder = request.getParameter("sortOrder");
                int page = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;
                int pageSize = 5; // Số bản ghi mỗi trang (có thể thay đổi)
                // Tổng số bản ghi
                int totalRecords = dao.getTotalFlashSale("SELECT COUNT(*) FROM FlashSale");
                int totalPages = (int) Math.ceil((double) totalRecords / pageSize);
                // Đảm bảo page hợp lệ
                if (page < 1) {
                    page = 1;
                }
                if (page > totalPages) {
                    page = totalPages;
                }
                // Tính vị trí bắt đầu
                int start = (page - 1) * pageSize;

                String orderByClause = " ORDER BY SaleID DESC"; // Mặc định
                if (sortColumn != null && sortOrder != null) {
                    String direction = sortOrder.equals("asc") ? "ASC" : "DESC";
                    switch (sortColumn) {
                        case "saleID":
                            orderByClause = " ORDER BY SaleID " + direction;
                            break;
                        case "timeFrame":
                            orderByClause = " ORDER BY TimeFrame " + direction;
                            break;
                        case "date":
                            orderByClause = " ORDER BY StartTime " + direction;
                            break;
                        case "discount":
                            orderByClause = " ORDER BY Discount " + direction;
                            break;
                        case "quantity":
                            orderByClause = " ORDER BY Quantity " + direction;
                            break;
                        case "Status":
                            orderByClause = " ORDER BY Status " + direction;
                            break;
                    }
                }
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                String today = sdf.format(new Date());

                // Lấy dữ liệu theo trang
                Vector<FlashSale> vector = dao.getFlashSale("SELECT * FROM FlashSale "
                        + orderByClause + " OFFSET " + start + " ROWS FETCH NEXT " + pageSize + " ROWS ONLY");
                for (FlashSale flash : vector) {
                    ProductDetail pro = da.getProDetailbyID(flash.getProductID());
                    flash.setProductDetail(pro);
                    if (sdf.format(flash.getStartTime()).equals(today)) {
                        dao.updateStatusByTime(flash);
                    }
                }
                // Truyền dữ liệu cho JSP
                request.setAttribute("vector", vector);
                request.setAttribute("currentPage", page);
                request.setAttribute("totalPages", totalPages);
                request.setAttribute("sortColumn", sortColumn);
                request.setAttribute("sortOrder", sortOrder);
                request.setAttribute("service", "orderHistory");
                request.getRequestDispatcher("/jsp/FlashSaleList.jsp").forward(request, response);
            }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
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
