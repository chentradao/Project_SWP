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
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
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

    private static final String UPLOAD_DIR = "Blog_Image";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        DAOBlog dao = new DAOBlog();
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String service = request.getParameter("service");
            if (service == null) {
                service = "listAllBlogs";
            } //update a blog
            else if (service.equals("updateBlog")) {
                String submit = request.getParameter("submit");
                Blog oldBlog = dao.getBlogByID(Integer.parseInt(request.getParameter("blogID"))); // Lấy thông tin cũ
                if (submit == null) {
                    String id = (request.getParameter("blogID"));
                    Vector<Blog> vector
                            = dao.getAllBlogs("select * from Blog where BlogID = " + id);
                    request.setAttribute("selectedBlog", vector);
                    request.getRequestDispatcher("/jsp/updateBlog.jsp").forward(request, response);
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
            } 

            //delete a blog
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
            String fileName = s.substring(s.indexOf("=") + 2, s.length() - 1); // Lấy tên file
            if (isValidImageFile(fileName)) {
                return fileName;
            } else {
                return ""; // Nếu không hợp lệ, trả về chuỗi rỗng
            }
        }
    }
    return "";
}

// Hàm kiểm tra định dạng file
private boolean isValidImageFile(String fileName) {
    String lowerCaseFileName = fileName.toLowerCase();
    return lowerCaseFileName.endsWith(".jpg") || 
           lowerCaseFileName.endsWith(".jpeg") || 
           lowerCaseFileName.endsWith(".png");
}


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        DAOBlog dao = new DAOBlog();
        String service = request.getParameter("service");

        if (service.equals("add")) {
            try {
                // Xử lý upload ảnh
                String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs(); // Tạo tất cả các thư mục cần thiết
                }

                // Xử lý thumbnail
                Part thumbnailPart = request.getPart("blogThumbnail");
                String thumbnailFileName = Paths.get(thumbnailPart.getSubmittedFileName()).getFileName().toString();
                String blogThumbnail = "";
                if (thumbnailFileName != null && !thumbnailFileName.isEmpty()) {
                    String thumbnailPath = uploadPath + File.separator + UUID.randomUUID() + "_" + thumbnailFileName;
                    try (InputStream thumbnailContent = thumbnailPart.getInputStream()) {
                        Files.copy(thumbnailContent, Paths.get(thumbnailPath), StandardCopyOption.REPLACE_EXISTING);
                    }
                    blogThumbnail = "Blog_Image/" + Paths.get(thumbnailPath).getFileName().toString();
                }

                // Xử lý các dữ liệu còn lại
                String blogTitle = request.getParameter("blogTitle");
                String blogDescription = request.getParameter("blogDescription");
                int blogCategoryID = Integer.parseInt(request.getParameter("blogCategoryID"));
                int blogAuthor = Integer.parseInt(request.getParameter("blogAuthor"));
                Date date = java.sql.Date.valueOf(LocalDate.now());
                int blogStatus = Integer.parseInt(request.getParameter("blogStatus"));

                Blog newBlog = new Blog(blogTitle, blogDescription, blogThumbnail, blogCategoryID, blogAuthor, date, null, blogStatus);
                int n = dao.insertBlog(newBlog);
                response.sendRedirect("Blog?service=listAllBlogs");
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", "Lỗi upload ảnh: " + e.getMessage());
            }
        }else if (service.equals("updateBlog")) {
    try {
        // Lấy ID blog cần cập nhật
        int blogID = Integer.parseInt(request.getParameter("blogID"));

        // Lấy thông tin blog hiện tại từ DB
        Blog existingBlog = dao.getBlogByID(blogID);
        if (existingBlog == null) {
            throw new Exception("Không tìm thấy blog với ID: " + blogID);
        }

        // Xử lý upload ảnh
        String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();  
        }

        // Xử lý thumbnail (nếu có thay đổi)
        String blogThumbnail = existingBlog.getBlogThumbnail(); // Giữ nguyên ảnh cũ nếu không đổi
        Part thumbnailPart = request.getPart("blogThumbnail");

        if (thumbnailPart != null && thumbnailPart.getSize() > 0) {
            String thumbnailFileName = getFileName(thumbnailPart);
            if (thumbnailFileName != null && !thumbnailFileName.isEmpty()) {
                // Xóa ảnh cũ nếu có
                String oldThumbnailPath = getServletContext().getRealPath("/") + existingBlog.getBlogThumbnail();
                File oldFile = new File(oldThumbnailPath);
                if (oldFile.exists()) {
                    oldFile.delete();
                }

                // Lưu ảnh mới
                String newFileName = UUID.randomUUID() + "_" + thumbnailFileName;
                String thumbnailPath = uploadPath + File.separator + newFileName;
                thumbnailPart.write(thumbnailPath);

                blogThumbnail = "Blog_Image/" + newFileName;
            }
        }

        // Cập nhật các thông tin khác từ form
        String blogTitle = request.getParameter("blogTitle");
        String blogDescription = request.getParameter("blogDescription");
        int blogCategoryID = Integer.parseInt(request.getParameter("blogCategoryID"));
        int blogAuthor = Integer.parseInt(request.getParameter("blogAuthor"));
        int blogStatus = Integer.parseInt(request.getParameter("blogStatus"));

        // Log để debug
        System.out.println("Cập nhật Blog: " + blogID);
        System.out.println("Tiêu đề: " + blogTitle);
        System.out.println("Mô tả: " + blogDescription);
        System.out.println("Danh mục: " + blogCategoryID);
        System.out.println("Tác giả: " + blogAuthor);
        System.out.println("Trạng thái: " + blogStatus);
        System.out.println("Thumbnail: " + blogThumbnail);

        // Tạo đối tượng Blog mới với thông tin cập nhật
        Blog updatedBlog = new Blog(
                blogID,
                blogTitle,
                blogDescription,
                blogThumbnail,
                blogCategoryID,
                blogAuthor,
                existingBlog.getDate(),
                null,
                blogStatus
        );

        // Gọi phương thức update
        int n = dao.updateBlog(updatedBlog);

        if (n > 0) {
            System.out.println("Cập nhật thành công!");
        } else {
            System.out.println("Cập nhật thất bại!");
        }

    } catch (Exception e) {
        e.printStackTrace();
    }
    response.sendRedirect("Blog?service=listAllBlogs");
}

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
