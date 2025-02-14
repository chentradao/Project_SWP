package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Map;
import entity.PaginatedResponse;
import entity.Product;
import model.ProductRepository;
import service.ProductService;

public class ProductController extends HttpServlet {

    private final ProductService productService = new ProductService();
    private final ProductRepository productRepository = new ProductRepository();

    private String convertToJson(Object object) {
        StringBuilder json = new StringBuilder("{");
        if (object instanceof PaginatedResponse) {
            PaginatedResponse<?> response = (PaginatedResponse<?>) object;
            json.append("\"total\":").append(response.getTotal()).append(",");
            json.append("\"data\":[");
            for (Object item : response.getData()) {
                json.append(item.toString()).append(",");
            }
            if (!response.getData().isEmpty()) {
                json.deleteCharAt(json.length() - 1);
            }
            json.append("]");
        }
        json.append("}");
        return json.toString();
    }
}
