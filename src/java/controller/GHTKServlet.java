package controller;

import entity.Order;
import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;
import java.util.Vector;
import model.DAOOrder;
import org.json.JSONArray;
import org.json.JSONObject;

@WebServlet("/ghtkservlet")
public class GHTKServlet extends HttpServlet {
    private static final String API_KEY = "1CAz4CeBUCHvpuwQU0n2s5ghjZVOSq4ttvBdQEy";
    private static final String API_REGISTER_URL = "https://services.giaohangtietkiem.vn/services/shipment/order/";
    private static final String API_STATUS_URL = "https://services.giaohangtietkiem.vn/services/shipment/v2/";
    DAOOrder daoOrder = new DAOOrder();
    private Connection getConnection() throws SQLException {
        String dbURL = "jdbc:sqlserver://localhost:1433;databaseName=SWP";
        String user = "sa";
        String pass = "123456";
        return DriverManager.getConnection(dbURL, user, pass);
    }

    private String registerOrderGHTK(int orderID) throws Exception {
        Connection conn = getConnection();
        String orderCode = null;
        
        String orderSQL = "SELECT o.CustomerName, o.ShipAddress,o.Phone, o.TotalCost FROM Orders o WHERE o.OrderID = ?";
        
        PreparedStatement orderStmt = conn.prepareStatement(orderSQL);
        orderStmt.setInt(1, orderID);
        ResultSet orderRs = orderStmt.executeQuery();

        if (orderRs.next()) {
            String addressDetail[] = orderRs.getString("ShipAddress").split(",");
            JSONObject orderInfo = new JSONObject();
            int totalCost = orderRs.getInt("TotalCost");
            //Thông tin người gửi hàng
            orderInfo.put("pick_name", "Kho A");
            orderInfo.put("pick_address", "Số 6A, Ngõ 294, Phường Trúc Bạch, Quận Ba Đình, Hà Nội");
            orderInfo.put("pick_province", "Hà Nội");
            orderInfo.put("pick_district", "Cầu Giấy");
            orderInfo.put("pick_ward", "Dịch Vọng Hậu");
            orderInfo.put("pick_tel", "0123456789");
            orderInfo.put("id", "ORDER_" + orderID);
            orderInfo.put("pick_money", totalCost);
            orderInfo.put("pick_date", LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd")));

            
            //Thông tin người nhận hàng            
            orderInfo.put("name", orderRs.getString("CustomerName"));
            orderInfo.put("address",addressDetail[0] );//orderRs.getString("ShipAddress")
            orderInfo.put("province", addressDetail[3]);//orderRs.getString("ShipCity")
            orderInfo.put("district",addressDetail[2] ); // ✅ Lấy quận/huyện từ DBorderRs.getString("ShipDistrict")
            orderInfo.put("ward", addressDetail[1]); // ✅ Lấy xã từ DB
            orderInfo.put("hamlet", "Khác"); // ✅ Lấy thôn/xóm từ DB
            orderInfo.put("tel", orderRs.getString("Phone"));          
            orderInfo.put("value", totalCost); 
            
            //Thông tin phương thức giao hàng
            orderInfo.put("transport", "road");
            orderInfo.put("pick_option", "cod");
            orderInfo.put("deliver_option", "6h");
            
            JSONArray productArray = new JSONArray();
            
            String productSQL = "SELECT p.ProductID, p.ProductName, od.Quantity FROM OrderDetail od JOIN Products p ON od.ProductID = p.ProductID WHERE od.OrderID = ?";
            
            PreparedStatement productStmt = conn.prepareStatement(productSQL);
            productStmt.setInt(1, orderID);
            ResultSet productRs = productStmt.executeQuery();

            while (productRs.next()) {
                JSONObject product = new JSONObject();
                product.put("name", productRs.getString("ProductName"));
                product.put("weight", 0.5); // Giá trị mặc định do không có trong DB
                product.put("quantity", productRs.getInt("Quantity"));
                product.put("product_code", productRs.getInt("ProductID"));
                productArray.put(product);
            }
            
            JSONObject orderData = new JSONObject();
            orderData.put("products", productArray);
            orderData.put("order", orderInfo);
            System.out.println("📤 JSON gửi đến GHTK: " + orderData.toString(2));

            URL url = new URL(API_REGISTER_URL);
            HttpURLConnection connAPI = (HttpURLConnection) url.openConnection();
            connAPI.setRequestMethod("POST");
            connAPI.setRequestProperty("Token", API_KEY);
            connAPI.setRequestProperty("Content-Type", "application/json");
            connAPI.setDoOutput(true);

            OutputStream os = connAPI.getOutputStream();
            os.write(orderData.toString().getBytes("UTF-8"));
            os.flush();
            os.close();

            InputStream is = (connAPI.getResponseCode() >= 400) ? connAPI.getErrorStream() : connAPI.getInputStream();
            BufferedReader br = new BufferedReader(new InputStreamReader(is));
            String response = br.readLine();

            JSONObject jsonResponse = new JSONObject(response);
            if (jsonResponse.getBoolean("success")) {
                orderCode = jsonResponse.getJSONObject("order").getString("label");

                String updateSQL = "UPDATE Orders SET orderCode = ? AND OrderStatus = ? WHERE OrderID = ?";                
                PreparedStatement updateStmt = conn.prepareStatement(updateSQL);
                updateStmt.setString(1, orderCode);
                updateStmt.setInt(2, 2);
                updateStmt.setInt(3, orderID);
                updateStmt.executeUpdate();
                System.err.println("Update in orderID="+orderID);
                updateStmt.close();
            } else {
                System.err.println("❌ LỖI: API GHTK trả về thất bại - " + jsonResponse);
            }
            
            productRs.close();
            productStmt.close();
        }

        orderRs.close();
        orderStmt.close();
        conn.close();

        return orderCode;
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String action = request.getParameter("action");
            if ("register".equals(action)) {
                int orderID = Integer.parseInt(request.getParameter("orderID"));
                String orderCode = registerOrderGHTK(orderID);
                response.sendRedirect("managerDashboard.jsp");

                
            }
            else if("status".equals(action)){
                int orderID = Integer.parseInt(request.getParameter("orderID"));
                Order order = daoOrder.getOrderByOrderID(orderID);
                String orderCode = order.getOrderCode();
                if (orderCode != null && !orderCode.isEmpty()) {
                    int status = getOrderStatusFromGHTK(orderCode);
                    Date deliveryDate = getShippedDateFromGHTK(orderCode);
                    order.setOrderStatus(status);
                    order.setShippedDate(deliveryDate);
                    response.sendRedirect("manager");
                } 
            }
            else if("order".equals(action)){
                Vector<Order> vectorOrder = daoOrder.getOrders("select * from Orders where OrderCode IS NOT NULL");
                for(Order order : vectorOrder){
                    int status = getOrderStatusFromGHTK(order.getOrderCode());
                    Date deliveryDate = getShippedDateFromGHTK(order.getOrderCode());
                    if(status != -1){
                        order.setShippedDate(deliveryDate);
                        order.setOrderStatus(status);
                        daoOrder.changeStatus(order.getOrderID(), status);
                    }
                }
                request.setAttribute("vectorOrder", vectorOrder);
                request.getRequestDispatcher("orderManagement.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    private int getOrderStatusFromGHTK(String orderCode) throws Exception {
    String apiUrl = "https://services.giaohangtietkiem.vn/services/shipment/v2/" + orderCode;
    
    URL url = new URL(apiUrl);
    HttpURLConnection connAPI = (HttpURLConnection) url.openConnection();
    connAPI.setRequestMethod("GET");
    connAPI.setRequestProperty("Token", API_KEY);
    connAPI.setRequestProperty("Content-Type", "application/json");

    InputStream is = (connAPI.getResponseCode() >= 400) ? connAPI.getErrorStream() : connAPI.getInputStream();
    BufferedReader br = new BufferedReader(new InputStreamReader(is));
    String response = br.readLine();
    
    System.out.println("📩 Phản hồi từ GHTK: " + response);

    JSONObject jsonResponse = new JSONObject(response);
    if (jsonResponse.getBoolean("success")) {
        String statusText = jsonResponse.getJSONObject("order").getString("status_text");
        return mapGHTKStatusTextToDB(statusText);
    } else {
        System.err.println("❌ LỖI: API GHTK trả về thất bại - " + jsonResponse);
        return -1;
    }
}
    private Date getShippedDateFromGHTK(String orderCode) throws Exception {
    String apiUrl = "https://services.giaohangtietkiem.vn/services/shipment/v2/" + orderCode;
    
    URL url = new URL(apiUrl);
    HttpURLConnection connAPI = (HttpURLConnection) url.openConnection();
    connAPI.setRequestMethod("GET");
    connAPI.setRequestProperty("Token", API_KEY);
    connAPI.setRequestProperty("Content-Type", "application/json");

    InputStream is = (connAPI.getResponseCode() >= 400) ? connAPI.getErrorStream() : connAPI.getInputStream();
    BufferedReader br = new BufferedReader(new InputStreamReader(is));
    String response = br.readLine();
    
    System.out.println("📩 Phản hồi từ GHTK: " + response);

    JSONObject jsonResponse = new JSONObject(response);
    
    if (jsonResponse.getBoolean("success")) {
        JSONObject orderObj = jsonResponse.getJSONObject("order");

        // Kiểm tra xem "deliver_date" có tồn tại và có giá trị hợp lệ không
        if (!orderObj.has("deliver_date") || orderObj.isNull("deliver_date")) {
            return null; // Không có ngày giao hàng, trả về null
        }

        String deliveryDateStr = orderObj.getString("deliver_date").trim();

        // Kiểm tra nếu chuỗi bị rỗng
        if (deliveryDateStr.isEmpty()) {
            return null;
        }

        try {
            SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            return (Date)inputFormat.parse(deliveryDateStr); // Trả về kiểu Date
        } catch (Exception e) {
            System.err.println("❌ Lỗi parse ngày: " + e.getMessage());
            return null;
        }
    }

    return null;
}

private int mapGHTKStatusTextToDB(String statusText) {
    switch (statusText.trim().toLowerCase()) {
        case "đang lấy hàng": return 1;
        case "đang giao hàng": return 2;
        case "đã tiếp nhận": return 2;
        case "đã giao hàng thành công": return 3;
        case "giao hàng thất bại": return 4;
        case "đang hoàn hàng": return 5;
        case "đã hoàn hàng thành công": return 6;
        case "hủy đơn hàng": return 7;
        case "chờ xác nhận": return 8;
        default: return -1; // Không xác định
    }
}

}
