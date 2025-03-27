package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import entity.ProductDetail;
import model.DAOProductDetail;
import entity.ProductResponse;

public class ProductDetailController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int productId = Integer.parseInt(request.getParameter("productId"));
            DAOProductDetail daoProductDetail = new DAOProductDetail();
            ProductDetail proDetail = daoProductDetail.getProductDetailById(productId);

            if (proDetail != null) {
                // Set the product detail in the request scope
                request.setAttribute("productDetail", proDetail);
                var relatedProducts = daoProductDetail.getProductsWithFilter(1, 5, null, null, null, null, null, null, null);

                request.setAttribute("relatedProducts", relatedProducts);
                // Forward to the JSP page that displays the product details
                request.getRequestDispatcher("product.jsp").forward(request, response);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Product not found");
            }
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid product ID");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}

