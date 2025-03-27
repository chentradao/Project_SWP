/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import java.sql.SQLException;
import entity.Accounts;
import entity.Blog;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.Vector;
import model.DAOAccounts;
import model.DAOBlog;

/**
 *
 * @author admin
 */
@WebServlet(name = "AuthorServlet", urlPatterns = {"/AuthorServlet"})
public class AuthorServlet extends HttpServlet {
    DAOAccounts accountDAO = new DAOAccounts();
    DAOBlog blogDAO = new DAOBlog();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException{
        response.setContentType("text/html;charset=UTF-8");
        
        String service = request.getParameter("service");
        if ("authorDetails".equals(service)) {
            try {
                int authorID = Integer.parseInt(request.getParameter("id"));
                
                // Lấy thông tin tác giả từ AccountDAO
                Accounts author = accountDAO.getAccountByAccountID(authorID);
                if (author == null) {
                    request.setAttribute("error", "Không tìm thấy tác giả với ID: " + authorID);
                    request.getRequestDispatcher("error.jsp").forward(request, response);
                    return;
                }
                
               // Đếm số bài viết của tác giả
                int blogCount = 0;
                String sql = "SELECT * FROM Blog WHERE BlogAuthor = "+authorID;
                Vector<Blog> blogList;
                blogList = blogDAO.getAllBlogs(sql);
               blogCount=blogList.size();
               
               Vector<Blog> topPosts = blogDAO.getAllBlogs(
                        "SELECT TOP 3 b.BlogID, b.BlogTitle, CAST(b.BlogDescription AS NVARCHAR(MAX)) AS BlogDescription, "
                        + "b.BlogThumbnail, b.BlogAuthor, b.BlogCategoryID, b.Date, b.BlogStatus "
                        + "FROM Blog b "
                        + "LEFT JOIN Comment c ON b.BlogID = c.BlogID "
                        + "GROUP BY b.BlogID, b.BlogTitle, CAST(b.BlogDescription AS NVARCHAR(MAX)), "
                        + "b.BlogThumbnail, b.BlogAuthor, b.BlogCategoryID, b.Date, b.BlogStatus "
                        + "ORDER BY COUNT(c.CommentID) DESC"
                );
               
               
                // Truyền thông tin sang JSP
                request.setAttribute("author", author);
                request.setAttribute("authorBlogCount", blogCount);
                request.setAttribute("authorID", authorID);
                request.setAttribute("topPosts", topPosts);
                request.getRequestDispatcher("authorDetails.jsp").forward(request, response);
            } catch (NumberFormatException ex) {
                ex.printStackTrace();
                request.setAttribute("error", "ID tác giả không hợp lệ");
                request.getRequestDispatcher("error.jsp").forward(request, response);
            } catch (Exception ex) {
                ex.printStackTrace();
                System.err.println("Error in AuthorServlet: " + ex.getMessage());
                request.setAttribute("error", "Có lỗi xảy ra khi xử lý yêu cầu");
                request.getRequestDispatcher("error.jsp").forward(request, response);
            }
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Service không hợp lệ");
        }
    }


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);    } 

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
