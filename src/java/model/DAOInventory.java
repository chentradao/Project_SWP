package model;

import entity.InventoryItem;
import entity.RevenueChartData;
import entity.RevenueSummary;
import java.math.BigDecimal;
import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DAOInventory extends DBConnection {

    public List<InventoryItem> getAllInventory() {
        List<InventoryItem> inventoryList = new ArrayList<>();
        String sql = "SELECT pd.ID AS productDetailId, pd.ProductID, p.ProductName, pd.Size, pd.Color, pd.Quantity, pd.SoldQuantity, pd.Price "
                + "FROM ProductDetail pd "
                + "JOIN Products p ON pd.ProductID = p.ProductID";

        try {
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql);

            while (rs.next()) {
                InventoryItem item = new InventoryItem(
                        rs.getInt("productDetailId"),
                        rs.getInt("ProductID"),
                        rs.getString("ProductName"),
                        rs.getString("Size"),
                        rs.getString("Color"),
                        rs.getInt("Quantity"),
                        rs.getInt("SoldQuantity"),
                        rs.getDouble("Price")
                );
                inventoryList.add(item);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return inventoryList;
    }

    public List<InventoryItem> getInventoryByDateRange(String startDate, String endDate) {
        List<InventoryItem> inventoryList = new ArrayList<>();
        String sql = "SELECT pd.ID AS productDetailId, pd.ProductID, p.ProductName, pd.Size, pd.Color, pd.Quantity, pd.SoldQuantity, pd.Price "
                + "FROM ProductDetail pd "
                + "JOIN Products p ON pd.ProductID = p.ProductID "
                + "WHERE pd.DateCreate BETWEEN ? AND ?";

        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);

            pstmt.setString(1, startDate);
            pstmt.setString(2, endDate);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    InventoryItem item = new InventoryItem(
                            rs.getInt("productDetailId"),
                            rs.getInt("ProductID"),
                            rs.getString("ProductName"),
                            rs.getString("Size"),
                            rs.getString("Color"),
                            rs.getInt("Quantity"),
                            rs.getInt("SoldQuantity"),
                            rs.getDouble("Price")
                    );
                    inventoryList.add(item);
                }
            }
        } catch (SQLException e) {
            // Ghi log lỗi (có thể thay bằng logging framework như SLF4J)
            System.err.println("Error fetching inventory by date range: " + e.getMessage());
            e.printStackTrace();
        }
        return inventoryList;
    }


    public int getLowStockCount() {
        int count = 0;
        String sql = "SELECT COUNT(*) AS count FROM ProductDetail WHERE Quantity < 10";

        try {
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql);

            if (rs.next()) {
                count = rs.getInt("count");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }


    // Cập nhật số lượng 
    public void updateQuantity(int productDetailId, int quantity) {
        String sql = "UPDATE ProductDetail SET Quantity = ? WHERE ID = ?";

        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);

            pstmt.setInt(1, quantity);
            pstmt.setInt(2, productDetailId);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Xóa sản phẩm
    public void deleteItem(int productDetailId) {
        String sql = "DELETE FROM ProductDetail WHERE ID = ?";

        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);

            pstmt.setInt(1, productDetailId);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public Map<String, Object> getRevenueChartData(String filterType, String month, String year, String startDate, String endDate) {
    Logger logger = Logger.getLogger(DAOInventory.class.getName());
    Map<String, Object> chartData = new HashMap<>();
    List<String> labels = new ArrayList<>();
    List<Double> data = new ArrayList<>();
    startDate = validateDate(startDate, "2025-01-01");
    endDate = validateDate(endDate, LocalDate.now().toString());
    filterType = (filterType == null || filterType.trim().isEmpty()) ? "month" : filterType.toLowerCase();
    String sql = buildChartQuery(filterType, month, year);
    try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
        
        int paramIndex = 1;
        pstmt.setString(paramIndex++, startDate);
        pstmt.setString(paramIndex++, endDate);

        if ("day".equals(filterType)) {
            if (month != null && !month.isEmpty()) {
                pstmt.setString(paramIndex++, month);
            }
            if (year != null && !year.isEmpty()) {
                pstmt.setString(paramIndex++, year);
            }
        } else if ("month".equals(filterType)) {
            if (month != null && !month.isEmpty()) {
                pstmt.setString(paramIndex++, month);
            }
            if (year != null && !year.isEmpty()) {
                pstmt.setString(paramIndex++, year);
            }
        } else if ("year".equals(filterType)) {
            if (year != null && !year.isEmpty()) {
                pstmt.setString(paramIndex++, year);
            }
        }

        try (ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                labels.add(rs.getString("dateLabel"));
                double revenue = rs.getDouble("revenue");
                data.add(rs.wasNull() ? 0.0 : revenue);
            }
        }
        chartData.put("labels", labels);
        chartData.put("data", data);
    } catch (SQLException e) {
        logger.log(Level.SEVERE, "Error fetching revenue chart data: " + e.getMessage(), e);
    }

    return chartData;
}


    private String buildChartQuery(String filterType, String month, String year) {
    String baseSql = "SELECT ";
    String whereClause = " WHERE o.OrderStatus = 5 AND o.OrderDate BETWEEN ? AND ? ";
    String groupBy = " GROUP BY ";
    String orderBy = " ORDER BY ";
    String fromClause = " FROM [SWP].[dbo].[OrderDetail] od "
            + "JOIN [SWP].[dbo].[Orders] o ON od.OrderID = o.OrderID ";

    switch (filterType) {
        case "year":
            baseSql += "YEAR(o.OrderDate) AS dateLabel, SUM(o.TotalCost) AS revenue ";
            groupBy += "YEAR(o.OrderDate)";
            orderBy += "YEAR(o.OrderDate)";
            break;

        case "day":
            baseSql += "CAST(o.OrderDate AS DATE) AS dateLabel, SUM(o.TotalCost) AS revenue ";
            groupBy += "CAST(o.OrderDate AS DATE)";
            orderBy += "CAST(o.OrderDate AS DATE)";

            if (month != null && !month.isEmpty()) {
                whereClause += " AND MONTH(o.OrderDate) = ? ";
            }
            if (year != null && !year.isEmpty()) {
                whereClause += " AND YEAR(o.OrderDate) = ? ";
            }
            break;

        case "month":
            baseSql += "CAST(YEAR(o.OrderDate) AS VARCHAR) + ' ' + DATENAME(month, o.OrderDate) AS dateLabel, SUM(o.TotalCost) AS revenue ";
            groupBy += "YEAR(o.OrderDate), DATENAME(month, o.OrderDate), MONTH(o.OrderDate)";
            orderBy += "YEAR(o.OrderDate), MONTH(o.OrderDate)";

            if (month != null && !month.isEmpty()) {
                whereClause += " AND MONTH(o.OrderDate) = ? ";
            }
            if (year != null && !year.isEmpty()) {
                whereClause += " AND YEAR(o.OrderDate) = ? ";
            }
            break;

        default:
            baseSql += "CAST(YEAR(o.OrderDate) AS VARCHAR) + ' ' + DATENAME(month, o.OrderDate) AS dateLabel, SUM(o.TotalCost) AS revenue ";
            groupBy += "YEAR(o.OrderDate), DATENAME(month, o.OrderDate), MONTH(o.OrderDate)";
            orderBy += "YEAR(o.OrderDate), MONTH(o.OrderDate)";
            break;
    }

    return baseSql + fromClause + whereClause + groupBy + orderBy;
}


    private String validateDate(String date, String defaultDate) {
        if (date == null || date.trim().isEmpty()) {
            return defaultDate;
        }
        try {
            LocalDate.parse(date);
            return date;
        } catch (Exception e) {
            Logger.getLogger(DAOInventory.class.getName()).warning("Invalid date: " + date + ", using default: " + defaultDate);
            return defaultDate;
        }
    }

    // Lấy dữ liệu tóm tắt (giữ nguyên)
    public RevenueSummary getRevenueSummary(String startDate, String endDate) {
        Logger logger = Logger.getLogger(DAOInventory.class.getName());
        RevenueSummary summary = new RevenueSummary();
        String sql = "SELECT SUM(o.TotalCost) AS totalRevenue, "
                + "SUM(od.Quantity) AS totalSold, "
                + "SUM(pd.Quantity - pd.SoldQuantity) AS totalStock "
                + "FROM [SWP].[dbo].[OrderDetail] od "
                + "JOIN [SWP].[dbo].[Orders] o ON od.OrderID = o.OrderID "
                + "JOIN [SWP].[dbo].[ProductDetail] pd ON od.ProductID = pd.ProductID "
                + "WHERE o.OrderStatus = 5 AND o.OrderDate BETWEEN ? AND ?";

        startDate = validateDate(startDate, "2025-01-01");
        endDate = validateDate(endDate, LocalDate.now().toString());

        logger.info("Fetching revenue summary - Start Date: " + startDate + ", End Date: " + endDate);

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            if (conn == null) {
                logger.severe("Database connection is null!");
                throw new SQLException("Database connection is null");
            }

            pstmt.setString(1, startDate);
            pstmt.setString(2, endDate);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    BigDecimal totalRevenue = rs.getBigDecimal("totalRevenue");
                    int totalSold = rs.getInt("totalSold");
                    int totalStock = rs.getInt("totalStock");

                    logger.info("Raw data from DB - totalRevenue: " + totalRevenue
                            + ", totalSold: " + totalSold
                            + ", totalStock: " + (rs.wasNull() ? "NULL" : totalStock));

                    summary.setTotalRevenue(totalRevenue != null ? totalRevenue : BigDecimal.ZERO);
                    summary.setTotalSold(totalSold);
                    summary.setTotalStock(rs.wasNull() ? 0 : totalStock); // Xử lý NULL cho totalStock
                } else {
                    logger.warning("No data found for the given date range");
                    summary.setTotalRevenue(BigDecimal.ZERO);
                    summary.setTotalSold(0);
                    summary.setTotalStock(0);
                }
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "SQL Error fetching revenue summary: " + e.getMessage(), e);
            summary.setTotalRevenue(BigDecimal.ZERO);
            summary.setTotalSold(0);
            summary.setTotalStock(0);
        }

        logger.info("Returning summary - totalRevenue: " + summary.getTotalRevenue()
                + ", totalSold: " + summary.getTotalSold()
                + ", totalStock: " + summary.getTotalStock());
        return summary;
    }

    // Lấy top sản phẩm bán chạy 
    public List<InventoryItem> getTopSellingProducts(int limit, String startDate, String endDate) {
        List<InventoryItem> topSellingList = new ArrayList<>();
        String sql = "SELECT TOP (?) pd.ID AS productDetailId, pd.ProductID, p.ProductName, pd.Size, pd.Color, pd.SoldQuantity, pd.Price "
                + "FROM [SWP].[dbo].[ProductDetail] pd "
                + "JOIN [SWP].[dbo].[Products] p ON pd.ProductID = p.ProductID "
                + "WHERE pd.DateCreate BETWEEN ? AND ? "
                + "ORDER BY pd.SoldQuantity DESC";

        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, limit);
            pstmt.setString(2, startDate);
            pstmt.setString(3, endDate);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                InventoryItem item = new InventoryItem(
                        rs.getInt("productDetailId"),
                        rs.getInt("ProductID"),
                        rs.getString("ProductName"),
                        rs.getString("Size"),
                        rs.getString("Color"),
                        0, // Quantity không cần cho top selling
                        rs.getInt("SoldQuantity"),
                        rs.getDouble("Price")
                );
                topSellingList.add(item);
            }
        } catch (SQLException e) {
            System.err.println("Error fetching top selling products: " + e.getMessage());
            e.printStackTrace();
        }
        return topSellingList;
    }

    public Map<String, Object> getCategoryRevenueData(String startDate, String endDate) {
        Logger logger = Logger.getLogger(DAOInventory.class.getName());
        Map<String, Object> categoryData = new HashMap<>();
        List<String> categories = new ArrayList<>();
        List<Double> categoryRevenue = new ArrayList<>();

        startDate = validateDate(startDate, "2025-01-01");
        endDate = validateDate(endDate, LocalDate.now().toString());

        logger.info("Fetching category revenue data - Start: " + startDate + ", End: " + endDate);

        String sql = "SELECT c.CategoryName, SUM(o.TotalCost) AS CategoryRevenue "
                + "FROM [SWP].[dbo].[OrderDetail] od "
                + "JOIN [SWP].[dbo].[Orders] o ON od.OrderID = o.OrderID "
                + "JOIN [SWP].[dbo].[ProductDetail] pd ON od.ProductID = pd.ProductID "
                + "JOIN [SWP].[dbo].[Products] p ON pd.ProductID = p.ProductID "
                + "JOIN [SWP].[dbo].[Categories] c ON p.CategoryID = c.CategoryID "
                + "WHERE o.OrderStatus = 5 AND o.OrderDate BETWEEN ? AND ? "
                + "GROUP BY c.CategoryName";

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            if (conn == null) {
                logger.severe("Database connection is null!");
                throw new SQLException("Database connection is null");
            }

            pstmt.setString(1, startDate);
            pstmt.setString(2, endDate);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    String categoryName = rs.getString("CategoryName");
                    double revenue = rs.getDouble("CategoryRevenue");
                    categories.add(categoryName);
                    categoryRevenue.add(rs.wasNull() ? 0.0 : revenue); // Xử lý NULL
                    logger.info("Category: " + categoryName + ", Revenue: " + revenue);
                }
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error fetching category revenue data: " + e.getMessage(), e);
        }

        categoryData.put("categories", categories);
        categoryData.put("categoryRevenue", categoryRevenue);
        logger.info("Returning category data - Categories: " + categories + ", Revenue: " + categoryRevenue);
        return categoryData;
    }

    public List<InventoryItem> getLowStockProducts(int threshold) {
        List<InventoryItem> products = new ArrayList<>();
        String sql = "SELECT pd.ID AS productDetailId, pd.ProductID, p.ProductName, pd.Size, pd.Color, pd.Quantity "
                + "FROM ProductDetail pd "
                + "JOIN Products p ON pd.ProductID = p.ProductID "
                + "WHERE pd.Quantity < ? AND pd.ProductStatus = 1";

        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, threshold);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                InventoryItem item = new InventoryItem(
                        rs.getInt("productDetailId"),
                        rs.getInt("ProductID"),
                        rs.getString("ProductName"),
                        rs.getString("Size"),
                        rs.getString("Color"),
                        rs.getInt("Quantity"),
                        0, // SoldQuantity không cần
                        0.0 // Price không cần
                );
                products.add(item);
            }
        } catch (SQLException e) {
            System.err.println("Error fetching low stock products: " + e.getMessage());
            e.printStackTrace();
        }
        return products;
    }

    public Map<String, Object> getNewCustomerData(String filterType, String startDate, String endDate) {
        Map<String, Object> customerData = new HashMap<>();
        List<String> timeLabels = new ArrayList<>();
        List<Integer> newCustomers = new ArrayList<>();
        String dateFormat;
        String sql;

        switch (filterType) {
            case "year":
                dateFormat = "YYYY";
                sql = "SELECT YEAR(CreateDate) AS dateLabel, COUNT(AccountID) AS NewCustomers "
                        + "FROM Accounts "
                        + "WHERE Role = 'Customer' AND AccountStatus = 1 AND CreateDate BETWEEN ? AND ? "
                        + "GROUP BY YEAR(CreateDate) "
                        + "ORDER BY YEAR(CreateDate)";
                break;
            case "month":
            default:
                dateFormat = "YYYY MM";
                sql = "SELECT CAST(YEAR(CreateDate) AS VARCHAR) + ' ' + DATENAME(month, CreateDate) AS dateLabel, COUNT(AccountID) AS NewCustomers "
                        + "FROM Accounts "
                        + "WHERE Role = 'Customer' AND AccountStatus = 1 AND CreateDate BETWEEN ? AND ? "
                        + "GROUP BY YEAR(CreateDate), DATENAME(month, CreateDate), MONTH(CreateDate) "
                        + "ORDER BY YEAR(CreateDate), MONTH(CreateDate)";
                break;
            case "day":
                dateFormat = "YYYY-MM-DD";
                sql = "SELECT CAST(CreateDate AS DATE) AS dateLabel, COUNT(AccountID) AS NewCustomers "
                        + "FROM Accounts "
                        + "WHERE Role = 'Customer' AND AccountStatus = 1 AND CreateDate BETWEEN ? AND ? "
                        + "GROUP BY CAST(CreateDate AS DATE) "
                        + "ORDER BY CAST(CreateDate AS DATE)";
                break;
        }

        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, startDate);
            pstmt.setString(2, endDate);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                timeLabels.add(rs.getString("dateLabel"));
                newCustomers.add(rs.getInt("NewCustomers"));
            }
        } catch (SQLException e) {
            System.err.println("Error fetching new customer data: " + e.getMessage());
            e.printStackTrace();
        }
        customerData.put("timeLabels", timeLabels);
        customerData.put("newCustomers", newCustomers);
        return customerData;
    }

    public Map<String, Object> getInventoryData() {
        Map<String, Object> inventoryData = new HashMap<>();
        List<String> productNames = new ArrayList<>();
        List<Integer> stockQuantities = new ArrayList<>();
        String sql = "SELECT p.ProductName, pd.Quantity "
                + "FROM ProductDetail pd "
                + "JOIN Products p ON pd.ProductID = p.ProductID "
                + "WHERE pd.ProductStatus = 1 "
                + "ORDER BY pd.Quantity DESC";

        try {
            ResultSet rs = conn.createStatement().executeQuery(sql);
            while (rs.next()) {
                productNames.add(rs.getString("ProductName"));
                stockQuantities.add(rs.getInt("Quantity"));
            }
        } catch (SQLException e) {
            System.err.println("Error fetching inventory data: " + e.getMessage());
            e.printStackTrace();
        }
        inventoryData.put("productNames", productNames);
        inventoryData.put("stockQuantities", stockQuantities);
        return inventoryData;
    }

   
}
