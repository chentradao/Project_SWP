/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import entity.Cart;
import entity.FlashSale;
import entity.ProductDetail;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Vector;
import model.DAOCart;
import model.DAOFlashSale;
import model.DAOProductDetail;

/**
 *
 * @author nguye
 */
@WebServlet(name = "ShoppingFlashSaleController", urlPatterns = {"/ShoppingFlashSaleURL"})
public class ShoppingFlashSaleController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession(true);
        int cartQuantiry = session.getAttribute("cartQuantiry") != null ? (int) session.getAttribute("cartQuantiry") : 0;
        DAOFlashSale dao = new DAOFlashSale();
        DAOProductDetail da = new DAOProductDetail();
        DAOCart d = new DAOCart();
        try (PrintWriter out = response.getWriter()) {
            String service = request.getParameter("service");

            if (service.equals("BuyNow")) {
                int fid = Integer.parseInt(request.getParameter("fid"));
                FlashSale flash = dao.findFSByID(fid);
                session.setAttribute("flash", "true");
                session.setAttribute("flash_" + flash.getProductID(), flash);
                Cart newCart = d.getCart(flash.getProductID());
                if (session.getAttribute(flash.getProductID() + "") == null) {
                    newCart.setQuantity(1);
                    session.setAttribute(flash.getProductID() + "", newCart);
                    cartQuantiry += 1;
                } else {
                    Cart oldCart = (Cart) session.getAttribute(flash.getProductID() + "");
                    oldCart.setQuantity(oldCart.getQuantity() + 1);
                    session.setAttribute(flash.getProductID() + "", oldCart);
                }
                session.setAttribute("cartQuantiry", cartQuantiry);
                response.sendRedirect(request.getHeader("Referer"));
            }

            if (service.equals("flashSale")) {
                // Lấy ngày và khung giờ từ request (nếu có)
                String timeFrame = request.getParameter("timeFrame");
                int selectedTimeFrame = 1;
                if (timeFrame != null) {
                    selectedTimeFrame = Integer.parseInt(timeFrame);
                }
                // Truy vấn danh sách Flash Sale theo ngày và khung giờ
                String sql = "SELECT * \n"
                        + "FROM FlashSale\n"
                        + "WHERE StartTime >= CAST(GETDATE() AS DATE)\n"
                        + " AND EndTime < DATEADD(DAY, 1, CAST(GETDATE() AS DATE))\n"
                        + " AND TimeFrame = " + selectedTimeFrame + "\n"
                        + " AND Status <> 4";
                Vector<FlashSale> vector = dao.getFlashSale(sql);

                // Lấy thông tin sản phẩm cho từng Flash Sale
                for (FlashSale flash : vector) {
                    ProductDetail pro = da.getProDetailbyID(flash.getProductID());
                    flash.setProductDetail(pro);
                    dao.updateStatusByTime(flash);
                }

                // Truyền dữ liệu vào request
                request.setAttribute("vector", vector);
                request.setAttribute("selectedTimeFrame", selectedTimeFrame);

                // Chuyển hướng đến JSP
                request.getRequestDispatcher("/jsp/ShoppingFlashSale.jsp").forward(request, response);
            }
        }
        // Hàm lấy khung giờ hiện tại dựa trên thời gian hiện tại

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
