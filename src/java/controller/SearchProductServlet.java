package controller;

import entity.ProductDetail;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import model.DAOProducts;

public class SearchProductServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy từ khóa tìm kiếm từ tham số
        String keyword = request.getParameter("keyword");

        // Nếu từ khóa rỗng hoặc null, chuyển hướng về trang chủ hoặc hiển thị thông báo
        if (keyword == null || keyword.trim().isEmpty()) {
            request.setAttribute("message", "Vui lòng nhập từ khóa tìm kiếm.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("searchResults.jsp");
            dispatcher.forward(request, response);
            return;
        }

        // Truy vấn cơ sở dữ liệu để tìm sản phẩm
        DAOProducts daoProduct = new DAOProducts();
        List<ProductDetail> searchResults = daoProduct.searchProductsByKeyword(keyword);

        // Truyền danh sách sản phẩm tìm được và từ khóa về JSP
        request.setAttribute("searchResults", searchResults);
        request.setAttribute("keyword", keyword);

        // Chuyển hướng đến trang kết quả tìm kiếm
        RequestDispatcher dispatcher = request.getRequestDispatcher("searchResults.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet to handle product search";
    }
}
