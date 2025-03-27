package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import entity.Category;

public class CategoryRepository {
    private static final String GET_ALL_CATEGORIES_SQL = "SELECT categoryId, categoryName, categoryStatus FROM Categories Where RootCategoryID IS NULL";

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
    public List<Category> getAllCategoriesByParentCategory(String categoryIdParent) {
        // Câu lệnh SQL để lấy danh mục con dưới 1 cấp của danh mục cha
        String sqlQuery = "SELECT categoryId, categoryName, categoryStatus "
                + "FROM Categories "
                + "WHERE RootCategoryID = ?"; // Điều kiện lọc danh mục con theo RootCategoryID

        List<Category> categories = new ArrayList<>();

        try (Connection conn = DBContext.getConnection(); PreparedStatement stmt = conn.prepareStatement(sqlQuery)) {

            // Thiết lập giá trị của categoryIdParent vào câu lệnh SQL
            stmt.setInt(1, Integer.parseInt(categoryIdParent)); // Chuyển đổi categoryIdParent thành int và thiết lập vào câu lệnh SQL

            try (ResultSet rs = stmt.executeQuery()) {
                // Lấy kết quả và tạo danh sách các Category
                while (rs.next()) {
                    int categoryId = rs.getInt("categoryId");
                    String categoryName = rs.getString("categoryName");
                    String categoryStatus = rs.getString("categoryStatus");
                    categories.add(new Category(categoryId, categoryName, categoryStatus));
                }
            }

        } catch (SQLException e) {
            throw new RuntimeException("Database error: " + e.getMessage(), e);
        }
        return categories;
    }
}
