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

        int itemsPerPage = 5;
        String pageStr = request.getParameter("page");
        int currentPage = 1;

        try {
            currentPage = (pageStr != null && !pageStr.isEmpty()) ? Integer.parseInt(pageStr) : 1;
        } catch (NumberFormatException e) {
            currentPage = 1;
        }

        int totalItems = wishlistItems.size();
        int totalPages = (int) Math.ceil((double) totalItems / itemsPerPage);

        // Xử lý khi danh sách rỗng
        if (totalItems == 0) {
            totalPages = 1;
            currentPage = 1;
            request.setAttribute("wishlistItems", wishlistItems); // empty list
        } else {
            // Kiểm tra currentPage hợp lệ
            if (currentPage < 1) {
                currentPage = 1;
            }
            if (currentPage > totalPages) {
                currentPage = totalPages;
            }

            int startIndex = (currentPage - 1) * itemsPerPage;
            int endIndex = Math.min(startIndex + itemsPerPage, totalItems);

            // Kiểm tra lại startIndex không âm
            startIndex = Math.max(0, startIndex);

            List<Wishlist> paginatedItems = wishlistItems.subList(startIndex, endIndex);

            String sortOption = request.getParameter("sort");
            if (sortOption != null && !sortOption.equals("default")) {
                paginatedItems.sort((Wishlist w1, Wishlist w2) -> {
                    double price1 = w1.getProduct().getProductDetail().getPrice();
                    double price2 = w2.getProduct().getProductDetail().getPrice();
                    return sortOption.equals("asc") ? Double.compare(price1, price2) : Double.compare(price2, price1);
                });
            }

            request.setAttribute("wishlistItems", paginatedItems);
        }

        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("sortOption", request.getParameter("sort") != null ? request.getParameter("sort") : "default");

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