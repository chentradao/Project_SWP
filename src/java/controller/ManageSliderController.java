/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import Helper.UploadImage;
import entity.Slider;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.DAOSlider;
import java.sql.Date;

/**
 *
 * @author
 */
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 10,
        maxFileSize = 1024 * 1024 * 50,
        maxRequestSize = 1024 * 1024 * 100
)
public class ManageSliderController extends HttpServlet {

    private DAOSlider daoSlider = new DAOSlider();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AddNewImage</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddNewImage at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "new":
                request.getRequestDispatcher("addSlider.jsp").forward(request, response);
                break;
            case "edit":
                int id = Integer.parseInt(request.getParameter("id"));
                Slider slider = daoSlider.getSliderById(id);
                request.setAttribute("slider", slider);
                request.getRequestDispatcher("editSlider.jsp").forward(request, response);
                break;
            case "delete":

            default:
                List<Slider> sliders = daoSlider.getAllSliders();
                request.setAttribute("sliders", sliders);
                request.getRequestDispatcher("listSlider.jsp").forward(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        UploadImage uploadImage = new UploadImage();

        if ("add".equals(action)) {
            String title = request.getParameter("title");
            response.getWriter().print(request.getParameter("photo"));
            String imageUrl = (String) uploadImage.uploadFile(request, "img");
            Date startDate = Date.valueOf(request.getParameter("startDate"));
            Date endDate = Date.valueOf(request.getParameter("endDate"));
            int author = Integer.parseInt(request.getParameter("author"));
            short status = Short.parseShort(request.getParameter("status"));
            Slider slider = new Slider(0, title, imageUrl, startDate, endDate, author, status);
            daoSlider.insertSlider(slider);
        } else if ("update".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            String title = request.getParameter("title");
            response.getWriter().print(request.getParameter("photo"));
            String imageUrl = (String) uploadImage.uploadFile(request, "img");
            Date startDate = Date.valueOf(request.getParameter("startDate"));
            Date endDate = Date.valueOf(request.getParameter("endDate"));
            int author = Integer.parseInt(request.getParameter("author"));
            short status = Short.parseShort(request.getParameter("status"));

            Slider slider = new Slider(id, title, imageUrl, startDate, endDate, author, status);
            daoSlider.updateSlider(slider);
        } else if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            daoSlider.deleteSlider(id);
        }
        response.sendRedirect("slider");
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

//       int id = Integer.valueOf(request.getParameter("id"));
//        String pid = request.getParameter("id");
//        response.getWriter().print(request.getParameter("photo"));
//        UploadImage uploadImage = new UploadImage();
//        String img = (String) uploadImage.uploadFile(request, "img");
//
//        ProductDAO pdao = new ProductDAO();
//        pdao.AddImage(img, id);
//        
//        Product p = pdao.getProductById(Integer.valueOf(pid));
//      
//        ArrayList<Product_img> o = pdao.getImgById(pid);
//
//       
//        request.setAttribute("p", p);
//
//        request.setAttribute("o", o);
//        request.getRequestDispatcher("productdetails.jsp").forward(request, response);
