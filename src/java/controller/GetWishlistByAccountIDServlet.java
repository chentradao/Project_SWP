package controller;

import entity.Accounts;
import entity.Wishlist;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import model.DAOWishlist;

public class GetWishlistByAccountIDServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Accounts account = (Accounts) session.getAttribute("acc");

        if (account == null) {
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        DAOWishlist daoWishlist = new DAOWishlist();
        List<Wishlist> wishlistItems = daoWishlist.getWishlistByAccount(account.getAccountID());

        // Số sản phẩm trên mỗi trang
        int itemsPerPage = 5;
        // Lấy trang hiện tại từ tham số (mặc định là trang 1)
        String pageStr = request.getParameter("page");
        int currentPage = (pageStr != null && !pageStr.isEmpty()) ? Integer.parseInt(pageStr) : 1;

        // Tính tổng số sản phẩm và tổng số trang
        int totalItems = wishlistItems.size();
        int totalPages = (int) Math.ceil((double) totalItems / itemsPerPage);

        // Đảm bảo currentPage nằm trong khoảng hợp lệ
        if (currentPage < 1) {
            currentPage = 1;
        }
        if (currentPage > totalPages) {
            currentPage = totalPages;
        }

        // Tính chỉ số bắt đầu và kết thúc của danh sách sản phẩm cho trang hiện tại
        int startIndex = (currentPage - 1) * itemsPerPage;
        int endIndex = Math.min(startIndex + itemsPerPage, totalItems);

        // Lấy danh sách sản phẩm cho trang hiện tại
        List<Wishlist> paginatedItems = wishlistItems.subList(startIndex, endIndex);

        // Sắp xếp theo giá nếu có tham số sort
        String sortOption = request.getParameter("sort");
        if (sortOption != null && !sortOption.equals("default")) {
            paginatedItems.sort((Wishlist w1, Wishlist w2) -> {
                double price1 = w1.getProduct().getProductDetail().getPrice();
                double price2 = w2.getProduct().getProductDetail().getPrice();
                if (sortOption.equals("asc")) {
                    return Double.compare(price1, price2); // Tăng dần
                } else {
                    return Double.compare(price2, price1); // Giảm dần
                }
            });
        }

        // Truyền dữ liệu vào JSP
        request.setAttribute("wishlistItems", paginatedItems);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("sortOption", sortOption != null ? sortOption : "default");

        RequestDispatcher dispatcher = request.getRequestDispatcher("wishlist.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet to get wishlist by account ID with pagination and sorting";
    }
}
