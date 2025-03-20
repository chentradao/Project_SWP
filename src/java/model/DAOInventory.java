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
    String sql = "SELECT pd.ID AS productDetailId, pd.ProductID, p.ProductName, pd.Size, pd.Color, pd.Quantity, pd.SoldQuantity, pd.Price " +
                 "FROM ProductDetail pd " +
                 "JOIN Products p ON pd.ProductID = p.ProductID " +
                 "WHERE pd.DateCreate BETWEEN ? AND ?";

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

    // Lấy số lượng sản phẩm có tồn kho thấp (giả định ngưỡng < 10)
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

    // Lấy số lượng sản phẩm có tồn kho đủ (giả định >= 10)
    public int getNormalStockCount() {
        int count = 0;
        String sql = "SELECT COUNT(*) AS count FROM ProductDetail WHERE Quantity >= 10";

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

    // Cập nhật số lượng (ví dụ khi sửa)
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
    
    
    public Map<String, Object> getRevenueChartData(String filterType, String startDate, String endDate) {
    Map<String, Object> chartData = new HashMap<>();
    List<String> labels = new ArrayList<>();
    List<Double> data = new ArrayList<>();
    
    // Xây dựng câu SQL với WHERE trước GROUP BY và ORDER BY
    String sql = buildChartQuery(filterType, startDate, endDate);

    try {
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, startDate);
        pstmt.setString(2, endDate);
        try (ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                labels.add(rs.getString("dateLabel"));
                data.add(rs.getDouble("revenue"));
            }
        }
        chartData.put("labels", labels);
        chartData.put("data", data);
    } catch (SQLException e) {
        System.err.println("Error fetching revenue chart data: " + e.getMessage());
        e.printStackTrace();
    }
    return chartData;
}

private String buildChartQuery(String filterType, String startDate, String endDate) {
    String baseSql = "SELECT ";
    String whereClause = " WHERE pd.DateCreate BETWEEN ? AND ? ";
    String groupBy = " GROUP BY ";
    String orderBy = " ORDER BY ";

    switch (filterType) {
        case "year":
            baseSql += "YEAR(pd.DateCreate) AS dateLabel, SUM(pd.SoldQuantity * pd.Price) AS revenue ";
            groupBy += "YEAR(pd.DateCreate)";
            orderBy += "YEAR(pd.DateCreate)";
            break;
        case "quarter":
            baseSql += "CAST(YEAR(pd.DateCreate) AS VARCHAR) + ' Q' + DATENAME(quarter, pd.DateCreate) AS dateLabel, SUM(pd.SoldQuantity * pd.Price) AS revenue ";
            groupBy += "YEAR(pd.DateCreate), DATENAME(quarter, pd.DateCreate)";
            orderBy += "YEAR(pd.DateCreate), DATEPART(quarter, pd.DateCreate)";
            break;
        case "month":
        default:
            baseSql += "CAST(YEAR(pd.DateCreate) AS VARCHAR) + ' ' + DATENAME(month, pd.DateCreate) AS dateLabel, SUM(pd.SoldQuantity * pd.Price) AS revenue ";
            groupBy += "YEAR(pd.DateCreate), DATENAME(month, pd.DateCreate), MONTH(pd.DateCreate)";
            orderBy += "YEAR(pd.DateCreate), MONTH(pd.DateCreate)";
            break;
        case "day":
            baseSql += "CAST(pd.DateCreate AS DATE) AS dateLabel, SUM(pd.SoldQuantity * pd.Price) AS revenue ";
            groupBy += "CAST(pd.DateCreate AS DATE)";
            orderBy += "CAST(pd.DateCreate AS DATE)";
            break;
    }

    return baseSql + " FROM [SWP].[dbo].[ProductDetail] pd " + whereClause + groupBy + orderBy;
}

    // Lấy dữ liệu tóm tắt (giữ nguyên)
    public RevenueSummary getRevenueSummary(String startDate, String endDate) {
        RevenueSummary summary = new RevenueSummary();
        String sql = "SELECT SUM(pd.SoldQuantity * pd.Price) AS totalRevenue, SUM(pd.SoldQuantity) AS totalSold, SUM(pd.Quantity) AS totalStock " +
                     "FROM [SWP].[dbo].[ProductDetail] pd " +
                     "WHERE pd.DateCreate BETWEEN ? AND ?";

        if (startDate == null || startDate.trim().isEmpty()) {
            startDate = "2025-01-01";
        }
        if (endDate == null || endDate.trim().isEmpty()) {
            endDate = LocalDate.now().toString();
        }

        try {
             PreparedStatement pstmt = conn.prepareStatement(sql);

            pstmt.setString(1, startDate);
            pstmt.setString(2, endDate);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    BigDecimal totalRevenue = rs.getBigDecimal("totalRevenue");
                    int totalSold = rs.getInt("totalSold");
                    int totalStock = rs.getInt("totalStock");

                    summary.setTotalRevenue(rs.wasNull() ? BigDecimal.ZERO : totalRevenue);
                    summary.setTotalSold(rs.wasNull() ? 0 : totalSold);
                    summary.setTotalStock(rs.wasNull() ? 0 : totalStock);
                } else {
                    summary.setTotalRevenue(BigDecimal.ZERO);
                    summary.setTotalSold(0);
                    summary.setTotalStock(0);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error fetching revenue summary: " + e.getMessage());
            e.printStackTrace();
            
        }
        return summary;
    }

    // Lấy top sản phẩm bán chạy (giữ nguyên)
    public List<InventoryItem> getTopSellingProducts(int limit, String startDate, String endDate) {
        List<InventoryItem> topSellingList = new ArrayList<>();
        String sql = "SELECT TOP (?) pd.ID AS productDetailId, pd.ProductID, p.ProductName, pd.Size, pd.Color, pd.SoldQuantity, pd.Price " +
                     "FROM [SWP].[dbo].[ProductDetail] pd " +
                     "JOIN [SWP].[dbo].[Products] p ON pd.ProductID = p.ProductID " +
                     "WHERE pd.DateCreate BETWEEN ? AND ? " +
                     "ORDER BY pd.SoldQuantity DESC";

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
    // Phương thức mới
    public Map<String, Object> getCategoryRevenueData(String startDate, String endDate) {
        Map<String, Object> categoryData = new HashMap<>();
        List<String> categories = new ArrayList<>();
        List<Double> categoryRevenue = new ArrayList<>();
        String sql = "SELECT c.CategoryName, SUM(pd.SoldQuantity * pd.Price) as CategoryRevenue " +
                     "FROM ProductDetail pd " +
                     "JOIN Products p ON pd.ProductID = p.ProductID " +
                     "JOIN Categories c ON p.CategoryID = c.CategoryID " +
                     "WHERE pd.DateCreate BETWEEN ? AND ? " +
                     "GROUP BY c.CategoryName";

        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, startDate);
            pstmt.setString(2, endDate);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                categories.add(rs.getString("CategoryName"));
                categoryRevenue.add(rs.getDouble("CategoryRevenue"));
            }
        } catch (SQLException e) {
            System.err.println("Error fetching category revenue data: " + e.getMessage());
            e.printStackTrace();
        }
        categoryData.put("categories", categories);
        categoryData.put("categoryRevenue", categoryRevenue);
        return categoryData;
    }

    public List<InventoryItem> getLowStockProducts(int threshold) {
        List<InventoryItem> products = new ArrayList<>();
        String sql = "SELECT pd.ID AS productDetailId, pd.ProductID, p.ProductName, pd.Size, pd.Color, pd.Quantity " +
                     "FROM ProductDetail pd " +
                     "JOIN Products p ON pd.ProductID = p.ProductID " +
                     "WHERE pd.Quantity < ? AND pd.ProductStatus = 1";

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
                sql = "SELECT YEAR(CreateDate) AS dateLabel, COUNT(AccountID) AS NewCustomers " +
                      "FROM Accounts " +
                      "WHERE Role = 'Customer' AND AccountStatus = 1 AND CreateDate BETWEEN ? AND ? " +
                      "GROUP BY YEAR(CreateDate) " +
                      "ORDER BY YEAR(CreateDate)";
                break;
            case "month":
            default:
                dateFormat = "YYYY MM";
                sql = "SELECT CAST(YEAR(CreateDate) AS VARCHAR) + ' ' + DATENAME(month, CreateDate) AS dateLabel, COUNT(AccountID) AS NewCustomers " +
                      "FROM Accounts " +
                      "WHERE Role = 'Customer' AND AccountStatus = 1 AND CreateDate BETWEEN ? AND ? " +
                      "GROUP BY YEAR(CreateDate), DATENAME(month, CreateDate), MONTH(CreateDate) " +
                      "ORDER BY YEAR(CreateDate), MONTH(CreateDate)";
                break;
            case "day":
                dateFormat = "YYYY-MM-DD";
                sql = "SELECT CAST(CreateDate AS DATE) AS dateLabel, COUNT(AccountID) AS NewCustomers " +
                      "FROM Accounts " +
                      "WHERE Role = 'Customer' AND AccountStatus = 1 AND CreateDate BETWEEN ? AND ? " +
                      "GROUP BY CAST(CreateDate AS DATE) " +
                      "ORDER BY CAST(CreateDate AS DATE)";
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
        String sql = "SELECT p.ProductName, pd.Quantity " +
                     "FROM ProductDetail pd " +
                     "JOIN Products p ON pd.ProductID = p.ProductID " +
                     "WHERE pd.ProductStatus = 1 " +
                     "ORDER BY pd.Quantity DESC";

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
    
    public static void main(String[] args) {
        // Khởi tạo DAOInventory
        DAOInventory dao = new DAOInventory();

        // 1. Kiểm tra getAllInventory
        System.out.println("=== Kiểm tra getAllInventory ===");
        List<InventoryItem> allInventory = dao.getAllInventory();
        for (InventoryItem item : allInventory) {
            System.out.println("Product: " + item.getProductName() + ", Quantity: " + item.getQuantity() + ", Sold: " + item.getSoldQuantity());
        }

        // 2. Kiểm tra getInventoryByDateRange
        System.out.println("\n=== Kiểm tra getInventoryByDateRange ===");
        String startDate = "2025-01-01";
        String endDate = LocalDate.now().toString();
        List<InventoryItem> inventoryByDate = dao.getInventoryByDateRange(startDate, endDate);
        for (InventoryItem item : inventoryByDate) {
            System.out.println("Product: " + item.getProductName() + ", Quantity: " + item.getQuantity());
        }

        // 3. Kiểm tra getLowStockCount
        System.out.println("\n=== Kiểm tra getLowStockCount ===");
        int lowStockCount = dao.getLowStockCount();
        System.out.println("Số sản phẩm tồn kho thấp (< 10): " + lowStockCount);

        // 4. Kiểm tra getNormalStockCount
        System.out.println("\n=== Kiểm tra getNormalStockCount ===");
        int normalStockCount = dao.getNormalStockCount();
        System.out.println("Số sản phẩm tồn kho đủ (>= 10): " + normalStockCount);

        // 5. Kiểm tra updateQuantity (giả định productDetailId = 1)
        System.out.println("\n=== Kiểm tra updateQuantity ===");
        int productDetailId = 1; // Thay bằng ID thực tế trong DB
        int newQuantity = 15;
        dao.updateQuantity(productDetailId, newQuantity);
        System.out.println("Đã cập nhật Quantity cho productDetailId = " + productDetailId + " thành " + newQuantity);

        // 6. Kiểm tra deleteItem (giả định productDetailId = 1, chỉ để test, không thực hiện thật)
        // System.out.println("\n=== Kiểm tra deleteItem ===");
        // dao.deleteItem(productDetailId);
        // System.out.println("Đã xóa productDetailId = " + productDetailId);

        // 7. Kiểm tra getRevenueChartData
        System.out.println("\n=== Kiểm tra getRevenueChartData (month) ===");
        Map<String, Object> chartData = dao.getRevenueChartData("month", startDate, endDate);
        System.out.println("Labels: " + chartData.get("labels"));
        System.out.println("Data: " + chartData.get("data"));

        // 8. Kiểm tra getRevenueSummary
        System.out.println("\n=== Kiểm tra getRevenueSummary ===");
        RevenueSummary summary = dao.getRevenueSummary(startDate, endDate);
        System.out.println("Total Revenue: " + summary.getTotalRevenue());
        System.out.println("Total Sold: " + summary.getTotalSold());
        System.out.println("Total Stock: " + summary.getTotalStock());

        // 9. Kiểm tra getTopSellingProducts
        System.out.println("\n=== Kiểm tra getTopSellingProducts ===");
        List<InventoryItem> topSelling = dao.getTopSellingProducts(5, startDate, endDate);
        for (InventoryItem item : topSelling) {
            System.out.println("Product: " + item.getProductName() + ", Sold: " + item.getSoldQuantity());
        }

        // 10. Kiểm tra getCategoryRevenueData
        System.out.println("\n=== Kiểm tra getCategoryRevenueData ===");
        Map<String, Object> categoryData = dao.getCategoryRevenueData(startDate, endDate);
        System.out.println("Categories: " + categoryData.get("categories"));
        System.out.println("Category Revenue: " + categoryData.get("categoryRevenue"));

        // 11. Kiểm tra getLowStockProducts
        System.out.println("\n=== Kiểm tra getLowStockProducts ===");
        List<InventoryItem> lowStock = dao.getLowStockProducts(5); // Ngưỡng < 5
        for (InventoryItem item : lowStock) {
            System.out.println("Product: " + item.getProductName() + ", Quantity: " + item.getQuantity());
        }

        // 12. Kiểm tra getNewCustomerData
        System.out.println("\n=== Kiểm tra getNewCustomerData (month) ===");
        Map<String, Object> customerData = dao.getNewCustomerData("month", startDate, endDate);
        System.out.println("Time Labels: " + customerData.get("timeLabels"));
        System.out.println("New Customers: " + customerData.get("newCustomers"));

        // 13. Kiểm tra getInventoryData
        System.out.println("\n=== Kiểm tra getInventoryData ===");
        Map<String, Object> inventoryData = dao.getInventoryData();
        System.out.println("Product Names: " + inventoryData.get("productNames"));
        System.out.println("Stock Quantities: " + inventoryData.get("stockQuantities"));
    }
}


