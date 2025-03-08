/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import entity.Accounts;
import entity.Cart;
import entity.Order;
import entity.Voucher;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.time.LocalDate;
import java.sql.Date;
import java.sql.ResultSet;
import java.text.NumberFormat;
import java.time.format.DateTimeFormatter;
import java.util.Enumeration;
import java.util.Locale;
import java.util.Vector;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.mail.internet.AddressException;
import model.DAOOrder;
import model.DAOVoucher;
import model.EmailHandler;

/**
 *
 * @author nguye
 */
@WebServlet(name = "OrderController", urlPatterns = {"/OrderURL"})
public class OrderController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession(true);
        Accounts acc = (Accounts) session.getAttribute("acc");
        Voucher voucher = (Voucher) session.getAttribute("voucher");
        DAOOrder dao = new DAOOrder();
        DAOVoucher d = new DAOVoucher();
        try (PrintWriter out = response.getWriter()) {
            String service = request.getParameter("service");

            if (service.equals("deleteOrder")) {
                String cancel = request.getParameter("cancel");
                Order order;
                int oid = Integer.parseInt(request.getParameter("oid"));
                Vector<Order> vector = dao.getOrders("select * from Orders where OrderID =" + oid);
                for (Order or : vector) {
                    or.setCancelNotification(cancel);
                    dao.updateOrder(or);
                }
                dao.deleteOrder(oid);
                response.sendRedirect(request.getHeader("Referer"));
            }

            if (service.equals("orderHistory")) {
                if (acc != null) {
                    String sortColumn = request.getParameter("sortColumn");
                    String sortOrder = request.getParameter("sortOrder");
                    int page = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;
                    int pageSize = 10; // Số bản ghi mỗi trang (có thể thay đổi)
                    // Tổng số bản ghi
                    int totalRecords = dao.getTotalOrders("SELECT COUNT(*) FROM Orders WHERE CustomerID = " + acc.getAccountID());
                    int totalPages = (int) Math.ceil((double) totalRecords / pageSize);
                    // Đảm bảo page hợp lệ
                    if (page < 1) {
                        page = 1;
                    }
                    if (page > totalPages) {
                        page = totalPages;
                    }
                    // Tính vị trí bắt đầu
                    int start = (page - 1) * pageSize;

                    String orderByClause = " ORDER BY OrderDate DESC"; // Mặc định
        if (sortColumn != null && sortOrder != null) {
            String direction = sortOrder.equals("asc") ? "ASC" : "DESC";
            switch (sortColumn) {
                case "orderDate":
                    orderByClause = " ORDER BY OrderDate " + direction;
                    break;
                case "customerName":
                    orderByClause = " ORDER BY CustomerName " + direction;
                    break;
                case "phone":
                    orderByClause = " ORDER BY Phone " + direction;
                    break;
                case "totalCost":
                    orderByClause = " ORDER BY TotalCost " + direction;
                    break;
                case "paymentMethod":
                    orderByClause = " ORDER BY PaymentMethod " + direction;
                    break;
                case "orderStatus":
                    orderByClause = " ORDER BY OrderStatus " + direction;
                    break;
            }
        }

                    // Lấy dữ liệu theo trang
                    Vector<Order> vector = dao.getOrders("SELECT * FROM Orders WHERE CustomerID = " + acc.getAccountID()
                            + orderByClause + " OFFSET " + start + " ROWS FETCH NEXT " + pageSize + " ROWS ONLY");

                    // Truyền dữ liệu cho JSP
                    request.setAttribute("vector", vector);
                    request.setAttribute("currentPage", page);
                    request.setAttribute("totalPages", totalPages);
                    request.setAttribute("sortColumn", sortColumn);
                    request.setAttribute("sortOrder", sortOrder);
                    request.setAttribute("service", "orderHistory");
                    request.getRequestDispatcher("/jsp/OrderHistory.jsp").forward(request, response);
                } else {
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                }
            }

            if (service.equals("orderFilter")) {
                if (acc == null) {
                    response.sendRedirect("OrderURL?service=orderHistory");
                } else {
                    String status = request.getParameter("status");
                    String startDate = request.getParameter("start");
                    String endDate = request.getParameter("end");
                    String payment = request.getParameter("payment");
                    String sortColumn = request.getParameter("sortColumn");
                    String sortOrder = request.getParameter("sortOrder");

                    if (endDate == null || endDate.trim().isEmpty()) {
                        endDate = LocalDate.now().toString();
                    }
                    if (startDate == null) {
                        startDate = "2000-01-01";
                    }

                    // Tham số phân trang
                    int page = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;
                    int pageSize = 10;

                    // Tổng số bản ghi với bộ lọc
                    String countQuery = "SELECT COUNT(*) FROM Orders WHERE OrderStatus LIKE '%" + status + "%' "
                            + "AND OrderDate BETWEEN '" + startDate + "' AND '" + endDate + "' "
                            + "AND PaymentMethod LIKE '%" + payment + "%' AND CustomerID = " + acc.getAccountID();
                    int totalRecords = dao.getTotalOrders(countQuery);
                    int totalPages = (int) Math.ceil((double) totalRecords / pageSize);

                    // Đảm bảo page hợp lệ
                    if (page < 1) {
                        page = 1;
                    }
                    if (page > totalPages) {
                        page = totalPages;
                    }

                    int start = (page - 1) * pageSize;

                    // Xử lý sắp xếp
                    String orderByClause = " ORDER BY OrderDate DESC"; // Mặc định
                    if (sortColumn != null && sortOrder != null) {
                        String direction = sortOrder.equals("asc") ? "ASC" : "DESC";
                        switch (sortColumn) {
                            case "orderDate":
                                orderByClause = " ORDER BY OrderDate " + direction;
                                break;
                            case "customerName":
                                orderByClause = " ORDER BY CustomerName " + direction;
                                break;
                            case "phone":
                                orderByClause = " ORDER BY Phone " + direction;
                                break;
                            case "totalCost":
                                orderByClause = " ORDER BY TotalCost " + direction;
                                break;
                            case "paymentMethod":
                                orderByClause = " ORDER BY PaymentMethod " + direction;
                                break;
                            case "orderStatus":
                                orderByClause = " ORDER BY OrderStatus " + direction;
                                break;
                        }
                    }

                    // Truy vấn dữ liệu theo trang
                    String sql = "SELECT * FROM Orders "
                            + "WHERE OrderStatus LIKE '%" + status + "%' "
                            + "AND OrderDate BETWEEN '" + startDate + "' AND '" + endDate + "' "
                            + "AND PaymentMethod LIKE '%" + payment + "%' "
                            + "AND CustomerID = " + acc.getAccountID() + orderByClause
                            + " OFFSET " + start + " ROWS FETCH NEXT " + pageSize + " ROWS ONLY";
                    Vector<Order> vector = dao.getOrders(sql);

                    // Truyền dữ liệu cho JSP
                    request.setAttribute("vector", vector);
                    request.setAttribute("currentPage", page);
                    request.setAttribute("totalPages", totalPages);
                    request.setAttribute("status", status);
                    request.setAttribute("startDate", startDate);
                    request.setAttribute("endDate", endDate);
                    request.setAttribute("payment", payment);
                    request.setAttribute("sortColumn", sortColumn);
                    request.setAttribute("sortOrder", sortOrder);
                    request.setAttribute("service", "orderFilter");
                    request.getRequestDispatcher("/jsp/OrderHistory.jsp").forward(request, response);
                }
            }

            if (service.equals("checkout")) {
                String submit = request.getParameter("submit");
                if (submit == null) {
                    Vector<Cart> vector = new Vector<>();
                    Enumeration enu = session.getAttributeNames();
                    while (enu.hasMoreElements()) {
                        String key = (String) enu.nextElement();
                        Object obj = session.getAttribute(key);
                        if (obj instanceof Cart) {
                            Cart cart = (Cart) obj;
                            vector.add(cart);
                        }
                    }
                    request.setAttribute("voucher", voucher);
                    request.setAttribute("vectorCart", vector);
                    request.setAttribute("acc", acc);
                    request.getRequestDispatcher("/jsp/Checkout.jsp").forward(request, response);
                } else {
                    Integer CustomerID = null;
                    if (acc != null) {
                        CustomerID = acc.getAccountID();
                    }
                    int VoucherID = 1;
                    if (voucher != null) {
                        VoucherID = voucher.getVoucherID();
                    }
                    String CustomerName = request.getParameter("CustomerName");
                    Date OrderDate = Date.valueOf(LocalDate.now());
                    Date ShippedDate = null;
//                    int ShippingFee = Integer.parseInt(request.getParameter("ShippingFee1"));
                    int ShippingFee = 0;
                    int TotalCost = Integer.parseInt(request.getParameter("totalPrice1"));
                    String Email = request.getParameter("Email");
                    String Phone = request.getParameter("Phone");
                    String city = request.getParameter("city");
                    String district = request.getParameter("district");
                    String ward = request.getParameter("ward");
                    String address = request.getParameter("address");
                    String ShipAddress = address + ", " + ward + ", " + district + ", " + city;
                    String CancelNotification = null;
                    String Note = request.getParameter("Note");
                    int OrderStatus = 1;
                    String PaymentMethod = request.getParameter("payment");
                    if (PaymentMethod.equalsIgnoreCase("cod")) {
                        Order o = new Order(CustomerID, CustomerName, OrderDate, ShippedDate, ShippingFee, TotalCost, Email, Phone, ShipAddress, VoucherID, CancelNotification, Note, PaymentMethod, OrderStatus);
                        int n = dao.insertOrder(o);
                        sendOrderConfirmationEmail(session, CustomerName, ShipAddress, Phone, Email, ShippingFee, TotalCost, Note);
                        if (n > 0) {
                            // Insert các mục giỏ hàng vào OrderDetails
                            Enumeration<String> enu = session.getAttributeNames();
                            while (enu.hasMoreElements()) {
                                String key = enu.nextElement();
                                Object obj = session.getAttribute(key);

                                if (obj instanceof Cart) {
                                    Cart cart = (Cart) obj;
                                    dao.addToOrder(cart);
                                    session.removeAttribute(key);
                                    session.removeAttribute("cartQuantiry");
                                }
                            }
                            response.sendRedirect("ProductListServlet");
                        }
                    }
                    if (PaymentMethod.equalsIgnoreCase("VNPAY")) {
                        session.setAttribute("CustomerName", CustomerName);
                        session.setAttribute("OrderDate", OrderDate);
                        session.setAttribute("ShippingFee", ShippingFee);
                        session.setAttribute("TotalCost", TotalCost);
                        session.setAttribute("Email", Email);
                        session.setAttribute("Phone", Phone);
                        session.setAttribute("ShipAddress", ShipAddress);
                        session.setAttribute("Note", Note);
                        response.sendRedirect("paymentvnpay");
                    }
                }

            }

        }

    }

    private void sendOrderConfirmationEmail(HttpSession session, String name, String address, String phone, String email, int shipping, int total, String note) {
        NumberFormat formatter = NumberFormat.getNumberInstance(new Locale("vi", "VN")); // Sử dụng getNumberInstance thay vì getCurrencyInstance
        formatter.setGroupingUsed(true); // Bật tính năng nhóm số
        Voucher voucher = (Voucher) session.getAttribute("voucher");
        String subject = "ESTÉE LAUDER - Xác nhận đơn hàng!";
        int shippingFee = shipping;
        String content = "<!DOCTYPE html>"
                + "<html>"
                + "<head>"
                + "    <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">"
                + "    <title>Xác thực đơn hàng</title>"
                + "    <style>"
                + "        .container { margin: 50px 200px; background-color: #F3F3F3; padding: 25px; }"
                + "    </style>"
                + "</head>"
                + "<body style=\" padding: 30px;\">"
                + "    <div>"
                + "        <h2 style=\"font-size: 25px;\">Cảm ơn " + name + " đã đặt hàng tại <a href=\"http://localhost:8080/Cosmetic/index.jsp\">ESTÉE LAUDER</a></h2>"
                + "        <p>Đơn hàng của bạn đã được đặt thành công!</p>"
                + "        <h1 style=\"margin-top: 50px; font-size: 28px\">Chi tiết đơn hàng của bạn</h1>"
                + "        <table style=\"width:100%;border-spacing:inherit;border:1px solid #ddd\">"
                + "            <tr style=\"background-color:#ce0707;font-weight:bold\">"
                + "                <td style=\"padding:10px;border-right:1px solid #ddd;color:white\">THÔNG TIN THANH TOÁN</td>"
                + "                <td style=\"padding:10px;color:white\">ĐỊA CHỈ GIAO HÀNG</td>"
                + "            </tr>"
                + "            <tr style=\"color:#ce0707\">"
                + "                <td style=\"padding:10px;border-right:1px solid #ddd\">Tên khách hàng : " + name + "</td>"
                + "                <td style=\"padding:10px\">Địa chỉ : " + address + "</td>"
                + "            </tr>"
                + "            <tr style=\"color:#ce0707\">"
                + "                <td style=\"padding:10px;border-right:1px solid #ddd;\">Số điện thoại : " + phone + "</td>"
                + "            </tr>"
                + "            <tr style=\"color:#ce0707\">"
                + "                <td style=\"padding:10px;border-right:1px solid #ddd;\">Hình thức thanh toán : COD</td>"
                + "            </tr>"
                + "        </table>"
                + "        <table style=\"border-collapse:collapse;width:100%;color:#333; margin-top: 50px\" border=\"1\">"
                + "            <tbody>"
                + "                <tr style=\"background-color:#ce0707;font-weight:bold;color:white\">"
                + "                    <td style=\"padding:10px;width: 25%;\">Sản phẩm</td>"
                + "                    <td style=\"padding:10px;width: 15%;\">Màu sắc | Size</td>"
                + "                    <td style=\"padding:10px;width: 15%;\">Giá Tiền</td>"
                + "                    <td style=\"padding:10px;width: 15%;\">Số lượng</td>"
                + "                    <td style=\"padding:10px;width: 25%;\">Thành tiền</td>"
                + "                </tr>";
        Vector<Cart> vector = new Vector<>();
        Enumeration enu = session.getAttributeNames();
        while (enu.hasMoreElements()) {
            String key = (String) enu.nextElement();
            Object obj = session.getAttribute(key);
            if (obj instanceof Cart) {
                Cart cart = (Cart) obj;
                vector.add(cart);
            }
        }
        int subtotal = 0;
        for (Cart cart : vector) {
            content += "<tr>"
                    + "    <td style=\"padding:4px;\">" + cart.getProductName() + "</td>"
                    + "    <td style=\"padding:4px;\">" + cart.getColor() + "|" + cart.getSize() + "</td>"
                    + "    <td style=\"padding:4px;align-content: center;justify-content: center\">" + formatter.format(cart.getPrice()) + " VNĐ</td>"
                    + "    <td style=\"padding:4px;align-content: center;justify-content: center\">" + cart.getQuantity() + "</td>"
                    + "    <td class=\"price\" style=\"padding:4px;align-content: center;justify-content: center\">" + formatter.format(cart.getPrice() * cart.getQuantity()) + " VNĐ</td>"
                    + "</tr>";
            subtotal += cart.getPrice() * cart.getQuantity();
        }
        int discount = 0;
        if (voucher != null) {
            discount = (voucher.getDiscount() * subtotal) / 100;
        }
        content += "<tr>"
                + "<tr>"
                + "    <td colspan=\"4\" style=\"padding:4px;text-align:right\"> Giảm giá  </td>"
                + "    <td class=\"price\">" + formatter.format(discount) + " VNĐ</td>"
                + "</tr>"
                + "<tr>"
                + "    <td colspan=\"4\" style=\"padding:4px;text-align:right\"> Phí vận chuyển </td>"
                + "    <td class=\"price\">" + formatter.format(shippingFee) + " VNĐ</td>"
                + "</tr>"
                + "    <td colspan=\"4\" style=\"padding:4px;text-align:right\"> Tổng thanh toán </td>"
                + "    <td class=\"price\">" + formatter.format(total) + " VNĐ</td>"
                + "</tr>"
                + "<tr>"
                + "            </tbody>"
                + "        </table>"
                + "        <p>Trân trọng,</p>"
                + "        <h2>ESTÉE LAUDER</h2>"
                + "    </div>"
                + "</body>"
                + "</html>";
        session.removeAttribute("voucher");
        try {
            EmailHandler.sendEmail(email, subject, content);
        } catch (AddressException ex) {
            Logger.getLogger(OrderController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
