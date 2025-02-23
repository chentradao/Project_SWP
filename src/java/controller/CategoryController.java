package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import entity.Category;
import service.CategoryService;


@WebServlet("/category")
public class CategoryController extends HttpServlet {
    private final CategoryService categoryService = new CategoryService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        try {
            List<Category> categories = categoryService.listCategories();
            String jsonResponse = convertToJson(categories);

            response.setStatus(HttpServletResponse.SC_OK);
            out.print(jsonResponse);
            out.flush();
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print("{\"error\":\"" + e.getMessage() + "\"}");
            out.flush();
        }
    }

    private String convertToJson(List<Category> categories) {
        StringBuilder json = new StringBuilder("{\"categories\":[");
        for (Category category : categories) {
            json.append(category.toString()).append(",");
        }
        if (!categories.isEmpty()) {
            json.deleteCharAt(json.length() - 1);
        }
        json.append("]}");
        return json.toString();
    }
}
