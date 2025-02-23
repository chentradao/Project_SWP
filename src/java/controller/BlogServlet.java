/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import entity.Blog;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.util.Date;
import java.util.List;
import java.util.UUID;
import java.util.Vector;
import model.DAOBlog;

/**
 *
 * @author admin
 */
@WebServlet(name = "BlogServlet", urlPatterns = {"/Blog"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024, // 1MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 100 // 100MB
)
public class BlogServlet extends HttpServlet {

    private static final String UPLOAD_DIR = "web/P_images";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        DAOBlog dao = new DAOBlog();
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String service = request.getParameter("service");
            if (service == null) {
                service = "listAllBlogs";
            }
            if (service.equals("add")) {
                try {
                    // Xử lý upload ảnh
                    String uploadPath = getServletContext().getRealPath("/") + File.separator + UPLOAD_DIR;
                    File uploadDir = new File(uploadPath);
                    if (!uploadDir.exists()) {
                        uploadDir.mkdir();
                    }

                    // Xử lý thumbnail
                    Part thumbnailPart = request.getPart("blogThumbnail");
                    String thumbnailFileName = getFileName(thumbnailPart);
                    String blogThumbnail = "";
                    if (thumbnailFileName != null && !thumbnailFileName.isEmpty()) {
                        String thumbnailPath = uploadPath + File.separator + UUID.randomUUID() + "_" + thumbnailFileName;
                        thumbnailPart.write(thumbnailPath);
                        blogThumbnail = UPLOAD_DIR + "/" + Paths.get(thumbnailPath).getFileName().toString();
                    }

                    // Xử lý ảnh chính
                    Part imagePart = request.getPart("image");
                    String imageFileName = getFileName(imagePart);
                    String image = "";
                    if (imageFileName != null && !imageFileName.isEmpty()) {
                        String imagePath = uploadPath + File.separator + UUID.randomUUID() + "_" + imageFileName;
                        imagePart.write(imagePath);
                        image = UPLOAD_DIR + "/" + Paths.get(imagePath).getFileName().toString();
                    }
                    //Xử lý các dữ liệu còn lại
                    String blogTitle = request.getParameter("blogTitle");
                    String blogDescription = request.getParameter("blogDescription");
                    int blogCategoryID = Integer.parseInt(request.getParameter("blogCategoryID"));
                    int blogAuthor = Integer.parseInt(request.getParameter("blogAuthor"));
                    Date date = java.sql.Date.valueOf(LocalDate.now());
                    int blogStatus = Integer.parseInt(request.getParameter("blogStatus"));

                    Blog newBlog = new Blog(blogTitle, blogDescription, blogThumbnail, blogCategoryID, blogAuthor, date, image, blogStatus);
                    int n = dao.insertBlog(newBlog);
                    response.sendRedirect("Blog?service=listAllBlogs");
                } catch (Exception e) {
                    e.printStackTrace();
                    request.setAttribute("error", "Lỗi upload ảnh: " + e.getMessage());
                }

            }  //update a blog
            else if (service.equals("updateBlog")) {
                String submit = request.getParameter("submit");
                Blog oldBlog = dao.getBlogByID(Integer.parseInt(request.getParameter("blogID"))); // Lấy thông tin cũ
                if (submit == null) {
                    String id = (request.getParameter("blogID"));
                    Vector<Blog> vector
                            = dao.getAllBlogs("select * from Blog where BlogID = " + id);
                    request.setAttribute("selectedBlog", vector);
                    request.getRequestDispatcher("/jsp/updateBlog.jsp").forward(request, response);

                } else {
                    try {
                        // Xử lý upload thumbnail 
                        //out.print(oldBlog.getBlogThumbnail());
                        String blogThumbnail = oldBlog.getBlogThumbnail(); // Giữ nguyên giá trị cũ
                        Part thumbnailPart = request.getPart("blogThumbnail");
                        if (thumbnailPart.getSize() > 0) { // Chỉ xử lý khi có file mới
                            String thumbnailFileName = getFileName(thumbnailPart);
                            String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
                            String thumbnailPath = uploadPath + File.separator + UUID.randomUUID() + "_" + thumbnailFileName;
                            thumbnailPart.write(thumbnailPath);
                            blogThumbnail = UPLOAD_DIR + "/" + Paths.get(thumbnailPath).getFileName().toString();
                        }

                        // Xử lý ảnh chính
                        String image = oldBlog.getImage(); // Giữ nguyên giá trị cũ
                        Part imagePart = request.getPart("image");
                        if (imagePart.getSize() > 0) {
                            String imageFileName = getFileName(imagePart);
                            String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
                            String imagePath = uploadPath + File.separator + UUID.randomUUID() + "_" + imageFileName;
                            imagePart.write(imagePath);
                            image = UPLOAD_DIR + "/" + Paths.get(imagePath).getFileName().toString();
                        }
                        //Xử lý các dữ liệu còn lại
                        int id = Integer.parseInt(request.getParameter("blogID"));
                        String blogTitle = request.getParameter("blogTitle");
                        String blogDescription = request.getParameter("blogDescription");
                        int blogCategoryID = Integer.parseInt(request.getParameter("blogCategoryID"));
                        int blogAuthor = Integer.parseInt(request.getParameter("blogAuthor"));
                        Date date = java.sql.Date.valueOf(LocalDate.now());
                        int blogStatus = Integer.parseInt(request.getParameter("blogStatus"));

                        Blog newBlog = new Blog(id, blogTitle, blogDescription, blogThumbnail, blogCategoryID, blogAuthor, date, image, blogStatus);
                        int n = dao.updateBlog(newBlog);
                        response.sendRedirect("Blog?service=listAllBlogs");
                    } catch (Exception e) {
                        e.printStackTrace();
                        out.print(e);
                    }

                }

            } //display blog
            else if (service.equals("listAllBlogs")) {
                String filterDate = request.getParameter("filterDate");
                String filterCategory = request.getParameter("filterCategory");

                String query = "SELECT * FROM Blog";

                if (filterCategory != null && !filterCategory.equals("all")) {
                    query += " WHERE [BlogCategoryID] = " + filterCategory;
                }

                if (filterDate != null) {
                    if (filterDate.equals("newest")) {
                        query += " ORDER BY [Date] DESC";
                    } else if (filterDate.equals("oldest")) {
                        query += " ORDER BY [Date] ASC";
                    }
                }
                Vector<Blog> vectorBlog = dao.getAllBlogs(query);
                request.setAttribute("vectorBlog", vectorBlog);
                request.getRequestDispatcher("blogpage.jsp").forward(request, response);
            } else if (service.equals("displayBlog")) {
                int id = Integer.parseInt(request.getParameter("id"));
                Vector<Blog> blog = dao.getAllBlogs("select * from Blog where BlogID=" + id);
                request.setAttribute("blog", blog);
                request.getRequestDispatcher("/jsp/displayBlog.jsp").forward(request, response);
            } //delete a blog
            else if (service.equals("deleteBlog")) {
                String id = (request.getParameter("blogID"));
                dao.deleteBlog(id);
                response.sendRedirect("Blog?service=listAllBlogs");
            }
        }
    }

    private String getFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] items = contentDisp.split(";");
        for (String s : items) {
            if (s.trim().startsWith("filename")) {
                return s.substring(s.indexOf("=") + 2, s.length() - 1);
            }
        }
        return "";
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
        try {
            Part filePart = request.getPart("file"); // "file" là name của input file
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            InputStream fileContent = filePart.getInputStream();

            // Lưu file vào server
            Files.copy(fileContent, Paths.get("/upload-path/" + fileName));
            response.getWriter().print("Upload thành công!");
        } catch (Exception e) {
            response.getWriter().print("Lỗi: " + e.getMessage());
        }
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
