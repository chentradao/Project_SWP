/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import entity.Product;
import entity.ProductDetail;
import entity.ProductResponse;
import entity.Slider;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Map;
import model.DAOProducts;
import model.DAOProductDetail;
import model.DAOSlider;
import model.ProductRepository;

/**
 *
 * @author Administrator
 */
public class ProductListServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
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
            out.println("<title>Servlet ProductListServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ProductListServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
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

        ProductRepository productRepository = new ProductRepository();

        // Extract filters from request
        Map<String, String> filters = ProductRepository.extractFilters(request);

        int page = 1; // Default page number
        int pageSize = 10; // Default page size
        String sortBy = "original-order"; // Default sort column
        String sortOrder = "ASC"; // Default sort order

        try {
            if (request.getParameter("page") != null && !request.getParameter("page").isEmpty()) {
                page = Integer.parseInt(request.getParameter("page"));
            }
            if (request.getParameter("pageSize") != null && !request.getParameter("pageSize").isEmpty()) {
                pageSize = Integer.parseInt(request.getParameter("pageSize"));
            }
            if (request.getParameter("sortBy") != null && !request.getParameter("sortBy").isEmpty()) {
                sortBy = request.getParameter("sortBy");
            }
            if (request.getParameter("sortOrder") != null && !request.getParameter("sortOrder").isEmpty()) {
                sortOrder = request.getParameter("sortOrder");
            }
        } catch (NumberFormatException e) {
            // Handle invalid number format gracefully
            page = 1;
            pageSize = 10;
        }

        // Get product list from repository
        List<ProductResponse> productList = productRepository.findAllProducts(page, pageSize, filters, sortBy, sortOrder);
        DAOSlider dAOSlider = new DAOSlider();
        List<Slider> slider = dAOSlider.getAllSliders();
        request.setAttribute("slider", slider);
        request.setAttribute("products", productList);
        request.getRequestDispatcher("index.jsp").forward(request, response);
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
