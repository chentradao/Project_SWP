package model;

import jakarta.servlet.http.HttpServletRequest;
import java.sql.*;
import java.util.*;
import entity.ProductResponse;

public class ProductRepository {

    // Include "original-order" as an allowed sort option.
    private static final List<String> ALLOWED_SORT = Arrays.asList("Price", "Size", "Color", "original-order");
    private static final List<String> ALLOWED_FILTERS = Arrays.asList("Color", "Size", "minPrice", "maxPrice");

    private static final String BASE_QUERY = "SELECT p.ProductID,p.ProductName,pd.ID,pd.Quantity,pd.Size,pd.Color,pd.Price,pd.Image "
            + "FROM ProductDetail pd "
            + "INNER JOIN Products p ON pd.ProductID = p.ProductID "
            + "WHERE pd.ProductStatus = 1 AND p.CategoryID = ?";

    private static final String COUNT_QUERY = "SELECT COUNT(*) FROM ProductDetail pd "
            + "INNER JOIN Products p ON pd.ProductID = p.ProductID "
            + "WHERE pd.ProductStatus = 1 AND p.CategoryID = ?";

    /**
     * Finds products by category applying pagination, filters, and sorting.
     *
     * @param categoryId the category ID
     * @param page the page number (1-based)
     * @param pageSize the number of items per page
     * @param filters the map of filters (including "Color", "Size", "minPrice",
     * and "maxPrice")
     * @param sortBy the column to sort by (if any)
     * @param sortOrder the sort order (e.g., ASC or DESC)
     * @return a list of ProductResponse objects
     */
    public List<ProductResponse> findByCategory(int categoryId, int page, int pageSize,
            Map<String, String> filters, String sortBy, String sortOrder) {
        validateFilters(filters);
        validateSort(sortBy);

        String sql = buildCategoryQuery(filters, sortBy, sortOrder);
        System.out.println("sqlll " + sql);
        List<Object> params = buildParams(categoryId, filters, page, pageSize);

        try (Connection conn = DBContext.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            setParameters(stmt, params);
            ResultSet rs = stmt.executeQuery();
            return mapProductResponses(rs);
        } catch (SQLException e) {
            throw new RuntimeException("Database error while fetching products by category", e);
        }
    }

    private List<ProductResponse> mapProductResponses(ResultSet rs) throws SQLException {
        List<ProductResponse> productResponses = new ArrayList<>();
        while (rs.next()) {
            ProductResponse productResponse = new ProductResponse(
                    rs.getInt("ProductID"),
                    rs.getString("ProductName"),
                    rs.getInt("Price"),
                    rs.getInt("ID"),
                    rs.getInt("Quantity"),
                    rs.getString("Size"),
                    rs.getString("Color"),
                    rs.getString("Image")
            );
            productResponses.add(productResponse);
        }
        return productResponses;
    }

    /**
     * Extracts filters from the HTTP request. It looks for parameters named
     * "Color", "Size", "minPrice", and "maxPrice" (if provided).
     *
     * @param request the HTTP request
     * @return a map of filter names and values
     */
    public static Map<String, String> extractFilters(HttpServletRequest request) {
        Map<String, String> filters = new HashMap<>();
        for (String filter : ALLOWED_FILTERS) {
            String value = request.getParameter(filter);
            if (value != null && !value.isEmpty()) {
                filters.put(filter, value);
            }
        }
        return filters;
    }

    private String buildCategoryQuery(Map<String, String> filters, String sortBy, String sortOrder) {
        StringBuilder sql = new StringBuilder(BASE_QUERY);
        appendFilters(sql, filters);

        // Only append ORDER BY clause if sortBy is not null and is not "original-order"
        if (sortBy != null) {
            if ("Size".equals(sortBy)) {
                // Remove the 'ml' suffix and cast to int for numeric sorting
                sql.append(" ORDER BY CAST(REPLACE(pd.Size, 'ml', '') AS INT) ").append(sortOrder);
            } else {
                sql.append(" ORDER BY pd.").append(sortBy).append(" ").append(sortOrder);
            }
        }
        sql.append(" OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        return sql.toString();
    }

    /**
     * Appends the filter conditions to the SQL query. For "minPrice" and
     * "maxPrice", we use range operators.
     */
    private void appendFilters(StringBuilder sql, Map<String, String> filters) {
        boolean firstCondition = true;
        for (String key : ALLOWED_FILTERS) {
            if (filters.containsKey(key)) {
                if (firstCondition) {
                    sql.append(" AND ");
                    firstCondition = false;
                } else {
                    sql.append(" AND ");
                }
                if ("minPrice".equals(key)) {
                    sql.append("pd.Price >= ?");
                } else if ("maxPrice".equals(key)) {
                    sql.append("pd.Price <= ?");
                } else {
                    sql.append("pd.").append(key).append(" = ?");
                }
            }
        }
    }

    public int countByCategory(int categoryId, Map<String, String> filters) {
        StringBuilder sql = new StringBuilder(COUNT_QUERY);
        appendFilters(sql, filters);

        try (Connection conn = DBContext.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql.toString())) {

            List<Object> params = new ArrayList<>();
            params.add(categoryId);
            for (String key : ALLOWED_FILTERS) {
                if (filters.containsKey(key)) {
                    if ("minPrice".equals(key) || "maxPrice".equals(key)) {
                        params.add(Integer.valueOf(filters.get(key)));
                    } else {
                        params.add(filters.get(key));
                    }
                }
            }

            setParameters(stmt, params);

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            throw new RuntimeException("Database error while counting products by category", e);
        }
        return 0;
    }

    public List<ProductResponse> findAllProducts(int page, int pageSize, Map<String, String> filters, String sortBy, String sortOrder) {
        validateFilters(filters);
        validateSort(sortBy);

        String sql = buildAllProductsQuery(filters, sortBy, sortOrder);
        try (Connection conn = DBContext.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            ResultSet rs = stmt.executeQuery();
            return mapProductResponses(rs);
        } catch (SQLException e) {
            throw new RuntimeException("Database error while fetching all products", e);
        }
    }

    private String buildAllProductsQuery(Map<String, String> filters, String sortBy, String sortOrder) {
        StringBuilder sql = new StringBuilder(
                "SELECT p.ProductID, p.ProductName, pd.ID, pd.Quantity, pd.Size, pd.Color, pd.Price, pd.Image "
                + "FROM ProductDetail pd "
                + "INNER JOIN Products p ON pd.ProductID = p.ProductID "
                + "WHERE pd.ProductStatus = 1");

        return sql.toString();
    }

    /**
     * Builds the parameters for the prepared statement in the same order as
     * they are used in the SQL.
     */
    private List<Object> buildParams(int categoryId, Map<String, String> filters, int page, int pageSize) {
        List<Object> params = new ArrayList<>();
        params.add(categoryId);
        for (String key : ALLOWED_FILTERS) {
            if (filters.containsKey(key)) {
                if ("minPrice".equals(key) || "maxPrice".equals(key)) {
                    params.add(Integer.valueOf(filters.get(key)));
                } else {
                    params.add(filters.get(key));
                }
            }
        }
        params.add((page - 1) * pageSize);
        params.add(pageSize);
        return params;
    }

    private void setParameters(PreparedStatement stmt, List<Object> params) throws SQLException {
        for (int i = 0; i < params.size(); i++) {
            stmt.setObject(i + 1, params.get(i));
        }
    }

    private void validateFilters(Map<String, String> filters) {
        for (String key : filters.keySet()) {
            if (!ALLOWED_FILTERS.contains(key)) {
                throw new IllegalArgumentException("Invalid filter attribute: " + key);
            }
        }
    }

    private void validateSort(String sortBy) {
        if (sortBy != null && !ALLOWED_SORT.contains(sortBy)) {
            throw new IllegalArgumentException("Invalid sort attribute: " + sortBy);
        }
    }
    // In ProductRepository.java

    public List<String> findAvailableSizesByCategory() {
        String sql = "SELECT Size FROM ( "
                + "    SELECT DISTINCT pd.Size, "
                + "    TRY_CAST(LEFT(pd.Size, PATINDEX('%[^0-9]%', pd.Size + 'x') - 1) AS INT) AS NumericSize "
                + "    FROM ProductDetail pd "
                + "    INNER JOIN Products p ON pd.ProductID = p.ProductID "
                + "    WHERE pd.ProductStatus = 1 "
                + ") AS SortedSizes "
                + "WHERE NumericSize IS NOT NULL "
                + "ORDER BY NumericSize ASC";

        List<String> sizes = new ArrayList<>();
        try (Connection conn = DBContext.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                sizes.add(rs.getString("Size"));
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error fetching available sizes", e);
        }
        return sizes;
    }
    public List<String> getDistinctColors() {
        List<String> colors = new ArrayList<>();
        String sql = "SELECT DISTINCT [Color] FROM [SWP].[dbo].[ProductDetail]";

        try (Connection conn = DBContext.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            // Lặp qua kết quả và thêm màu vào danh sách
            while (rs.next()) {
                colors.add(rs.getString("Color"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return colors;
    }

}
