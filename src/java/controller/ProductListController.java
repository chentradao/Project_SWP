/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import entity.ProductDetail;
import entity.ProductResponse;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.DAOProductDetail;


@WebServlet(name="ProductListController", urlPatterns={"/product-list"})
public class ProductListController extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ProductListController</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ProductListController at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        // Lấy tham số từ request
        String pageIndexStr = request.getParameter("pageIndex");
        String pageSizeStr = request.getParameter("pageSize");
        String minPriceStr = request.getParameter("minPrice");
        String maxPriceStr = request.getParameter("maxPrice");
        String size = request.getParameter("size");
        String color = request.getParameter("color");
        String categoryIdStr = request.getParameter("categoryId");
        String orderByPrice = request.getParameter("orderByPrice");
        String orderBySize = request.getParameter("orderBySize");

        // Chuyển đổi các tham số từ String sang kiểu dữ liệu phù hợp
        int pageIndex = (pageIndexStr != null) ? Integer.parseInt(pageIndexStr) : 1;
        int pageSize = (pageSizeStr != null) ? Integer.parseInt(pageSizeStr) : 9;
        Integer minPrice = (minPriceStr != null && !minPriceStr.isEmpty()) ? Integer.parseInt(minPriceStr) : null;
        Integer maxPrice = (maxPriceStr != null && !maxPriceStr.isEmpty()) ? Integer.parseInt(maxPriceStr) : null;
        Integer categoryId = (categoryIdStr != null && !categoryIdStr.isEmpty()) ? Integer.parseInt(categoryIdStr) : null;
        DAOProductDetail dao = new DAOProductDetail();
        // Gọi phương thức getProductsWithFilter từ DAOProductDetail
        List<ProductResponse> products = dao.getProductsWithFilter(pageIndex, pageSize, minPrice, maxPrice, size, color, categoryId, orderByPrice, orderBySize);
        int totalPage = dao.getProductsWithFilter(1, Integer.MAX_VALUE, minPrice, maxPrice, size, color, categoryId, orderByPrice, orderBySize).size();
        if(totalPage/pageSize != 0)
        {
            request.setAttribute("totalPage", (totalPage/pageSize)+1);
        }else
        {
            request.setAttribute("totalPage", totalPage/pageSize);
        }
        // Đưa kết quả vào request để hiển thị trong JSP
        request.setAttribute("products", products);
        request.setAttribute("pageSize", pageSize);
        request.setAttribute("pageIndex", pageIndex);
        

        // Forward đến trang JSP để hiển thị kết quả
        request.getRequestDispatcher("productdetaillist.jsp").forward(request, response);
        
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
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
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
