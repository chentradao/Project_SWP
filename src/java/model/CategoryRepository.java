package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import entity.Category;

public class CategoryRepository {
    private static final String GET_ALL_CATEGORIES_SQL = "SELECT categoryId, categoryName, categoryStatus FROM Categories";

    public List<Category> getAllCategories() {
        List<Category> categories = new ArrayList<>();
        try (Connection conn = DBContext.getConnection();
             PreparedStatement stmt = conn.prepareStatement(GET_ALL_CATEGORIES_SQL);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                int categoryId = rs.getInt("categoryId");
                String categoryName = rs.getString("categoryName");
                String categoryStatus = rs.getString("categoryStatus");
                categories.add(new Category(categoryId, categoryName, categoryStatus));
            }

        } catch (SQLException e) {
            throw new RuntimeException("Database error: " + e.getMessage(), e);
        }
        return categories;
    }
}
