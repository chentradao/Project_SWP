/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import service.UploadImage;
import entity.Accounts;
import entity.Feedback;
import entity.Slider;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.DAOSlider;
import java.sql.Date;
import model.DAOFeedback;

/**
 *
 * @author
 */
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 10,
        maxFileSize = 1024 * 1024 * 50,
        maxRequestSize = 1024 * 1024 * 100
)
public class UserFeedbackController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
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

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UploadImage uploadImage = new UploadImage();
        DAOFeedback dAOFeedback = new DAOFeedback();
        HttpSession session = request.getSession();
        Accounts acc = (Accounts) session.getAttribute("acc");

        if (acc == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        String feedback = request.getParameter("feedback");
        int productId = Integer.parseInt(request.getParameter("productId")); 
        int rateStar = Integer.parseInt(request.getParameter("rateStar"));

        String imageUrl = uploadImage.uploadFile(request, "img");

        if (imageUrl == null) {
            imageUrl = "";
        }
        Feedback f = new Feedback();
        f.setAccountID(acc.getAccountID());
        f.setFeedback(feedback);
        f.setImageURL(imageUrl);
        f.setProductID(productId);
        f.setRateStar(rateStar);
        f.setDate(new java.sql.Timestamp(System.currentTimeMillis()));
        dAOFeedback.addFeedback(f);
        response.sendRedirect("ProductDetail?productId=" + productId);
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
