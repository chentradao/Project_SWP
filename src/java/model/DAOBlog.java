/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import entity.Blog;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Vector;
import java.time.LocalDate;

/**
 *
 * @author admin
 */
public class DAOBlog extends DBConnection {

    public DAOBlog() {
        // Thiết lập kết nối với cơ sở dữ liệu tại đây.
        // Ví dụ: 
        // String url = "jdbc:your_database_url";
        // conn = DriverManager.getConnection(url, "username", "password");
    }

//    public int insertBlog(Blog blog) {
//        int n = 0;
//        String sql = "INSERT INTO [dbo].[Blog] " +
//             "([BlogTitle], [BlogDescription], [BlogThumbnail], [BlogCategory], [BlogAuthor], [Date], [Image], [BlogStatus]) " +
//             "VALUES ('" + blog.getBlogTitle() + "', '" + blog.getBlogDescription() + "', '" + blog.getBlogThumbnail() + "', '" +
//             blog.getBlogCategory() + "', '" + blog.getBlogAuthor() + "', '" + blog.getDate() + "', '" + blog.getImage() + "', '" +
//             blog.getBlogStatus() + "')";
//        try {
//            Statement state = conn.createStatement();
//            n = state.executeUpdate(sql);
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//        return n;
//    }

    public int insertBlog(Blog blog) {
        int result = 0;
        try {
            String sql = "INSERT INTO [dbo].[Blog]\n"
                    + "           ([BlogTitle],[BlogDescription],[BlogThumbnail],[BlogCategory],[BlogAuthor],[Date],[Image],[BlogStatus])"
                    + "     VALUES(?,?,?,?,?,?,?,?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, blog.getBlogTitle());
            ps.setString(2, blog.getBlogDescription());
            ps.setString(3, blog.getBlogThumbnail());
            ps.setInt(4, blog.getBlogCategory());
            ps.setInt(5, blog.getBlogAuthor());
            ps.setDate(6, (Date) blog.getDate());
            ps.setString(7, blog.getImage());
            ps.setInt(8, blog.getBlogStatus());
            result = ps.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return result;
    }

    public int updateBlog(Blog blog) {
    int result = 0;
    try {
        String sql = "UPDATE [dbo].[Blog]\n"
                    + "   SET [BlogTitle] = ?,[BlogDescription] = ?,[BlogThumbnail] = ?,[BlogCategory] = ?,[BlogAuthor] = ?,[Date] = ?,[Image] = ?,[BlogStatus] = ?\n"
                + "   WHERE BlogID = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, blog.getBlogTitle());
        ps.setString(2, blog.getBlogDescription());
        ps.setString(3, blog.getBlogThumbnail());
        ps.setInt(4, blog.getBlogCategory());
        ps.setInt(5, blog.getBlogAuthor());
            ps.setDate(6, (Date) blog.getDate());
        ps.setString(7, blog.getImage());
        ps.setInt(8, blog.getBlogStatus());
        ps.setInt(9, blog.getBlogID());
        result = ps.executeUpdate();
    } catch (SQLException ex) {
        ex.printStackTrace();
        }
    return result;
}

    public int deleteBlog(String BlogID) {
        int result = 0;
        try {
            String sql = "DELETE FROM [dbo].[Blog] WHERE BlogID = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, BlogID);
            result = ps.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return result;
    }
     public Blog getBlogByID(int blogID) {
        Blog blog = null;
        String query = "SELECT * FROM Blog WHERE BlogID = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, blogID);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    blog = new Blog(
                        rs.getInt("BlogID"),
                        rs.getString("BlogTitle"),
                        rs.getString("BlogDescription"),
                        rs.getString("BlogThumbnail"),
                        rs.getInt("BlogCategory"),
                        rs.getInt("BlogAuthor"),
                        rs.getDate("Date"),
                        rs.getString("Image"),
                        rs.getInt("BlogStatus")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return blog;
    }
     
     
    public Vector<Blog> getAllBlogs(String sql) {
        Vector<Blog> vector = new Vector<>();
        try {
            Statement statement = conn.createStatement();
            ResultSet rs = statement.executeQuery(sql);

            while (rs.next()) {
                int BlogID = rs.getInt("BlogID");
                String BlogTitle = rs.getString("BlogTitle");
                String BlogDescription = rs.getString("BlogDescription");
                String BlogThumbnail = rs.getString("BlogThumbnail");
                int BlogCategory = rs.getInt("BlogCategory");
                int BlogAuthor = rs.getInt("BlogAuthor");
                Date Date = rs.getDate("Date");
                String Image = rs.getString("Image");
                int BlogStatus = rs.getInt("BlogStatus");
                Blog blog = new Blog(BlogID, BlogTitle, BlogDescription, BlogThumbnail, BlogCategory, BlogAuthor, Date, Image, BlogStatus);
                vector.add(blog);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return vector;
    }
    
    
    public static void main(String[] args) { 
        DAOBlog dao = new DAOBlog();
        Blog blog = new Blog(34, 
            "Updated Title", 
            "Updated Description", 
            null, 
            2, 
            2, 
            null, 
            null, 
            2);
        int n = dao.updateBlog(blog);
        System.out.println(n);
        Vector<Blog> blogList = dao.getAllBlogs("select * from Blog");
        System.out.println(blogList.size());

    } 
    
    
    
    
}
