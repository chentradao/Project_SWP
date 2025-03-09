/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.text.NumberFormat;
import java.util.List;
import java.util.Locale;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.mail.internet.AddressException;
import entity.Accounts;
import entity.Cart;
import entity.Order;
import entity.Voucher;
import model.EmailHandler;
import java.util.Date;
import java.util.Enumeration;
import java.util.Vector;
import model.DAOOrder;

/**
 *
 * @author admin
 */
@WebServlet(name = "PaymentStatusServlet", urlPatterns = {"/paymentstatus"})
public class PaymentStatusServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(true);

        String CustomerName = (String) session.getAttribute("CustomerName");
        Date OrderDate = (Date) session.getAttribute("OrderDate");
        Integer ShippingFee = (Integer) session.getAttribute("ShippingFee");
        int TotalCost = (int) session.getAttribute("TotalCost");
        String Email = (String) session.getAttribute("Email");
        String Phone = (String) session.getAttribute("Phone");
        String ShipAddress = (String) session.getAttribute("ShipAddress");
        Voucher voucher = (Voucher) session.getAttribute("voucher");
        int VoucherID = 1;
        if (voucher != null) {
            VoucherID = voucher.getVoucherID();
        }
        String Note = (String) session.getAttribute("Note");
        Accounts acc = (Accounts) session.getAttribute("acc");
        Integer CustomerID = null;
        if (acc != null) {
            CustomerID = acc.getAccountID();
        }
        DAOOrder dao = new DAOOrder();
        Order o = new Order(CustomerID, CustomerName, OrderDate, null, ShippingFee, TotalCost, Email, Phone, ShipAddress, VoucherID, null, Note, "VNPay", 1);
        int n = dao.insertOrder(o);
        if (n > 0) {
            // Insert các mục giỏ hàng vào OrderDetails
            Enumeration<String> enu = session.getAttributeNames();
            while (enu.hasMoreElements()) {
                String key = enu.nextElement();
                Object obj = session.getAttribute(key);

                if (obj instanceof Cart) {
                    Cart cart = (Cart) obj;
                    dao.addToOrder(cart);
                }
            }
        }
        NumberFormat formatter = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
        String subject = "ESTÉE LAUDER - Xác nhận đơn hàng";

        // Build the HTML content for email
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
                + "        <h2 style=\"font-size: 25px;\">Cảm ơn " + CustomerName + " đã đặt hàng tại <a href=\"http://localhost:8080/Project_SWP/ProductListServlet\">ESTÉE LAUDER</a></h2>"
                + "        <p>Đơn hàng của bạn đã được đặt thành công!</p>"
                + "        <h1 style=\"margin-top: 50px; font-size: 28px\">Chi tiết đơn hàng của bạn</h1>"
                + "        <table style=\"width:100%;border-spacing:inherit;border:1px solid #ddd\">"
                + "            <tr style=\"background-color:#ce0707;font-weight:bold\">"
                + "                <td style=\"padding:10px;border-right:1px solid #ddd;color:white\">THÔNG TIN THANH TOÁN</td>"
                + "                <td style=\"padding:10px;color:white\">ĐỊA CHỈ GIAO HÀNG</td>"
                + "            </tr>"
                + "            <tr style=\"color:#ce0707\">"
                + "                <td style=\"padding:10px;border-right:1px solid #ddd\">Tên khách hàng : " + CustomerName + "</td>"
                + "                <td style=\"padding:10px\">Địa chỉ : " + ShipAddress + "</td>"
                + "            </tr>"
                + "            <tr style=\"color:#ce0707\">"
                + "                <td style=\"padding:10px;border-right:1px solid #ddd;\">Số điện thoại : " + Phone + "</td>"
                + "            </tr>"
                + "            <tr style=\"color:#ce0707\">"
                + "                <td style=\"padding:10px;border-right:1px solid #ddd;\">Hình thức thanh toán : VNPAY</td>"
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
                session.removeAttribute(key);
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
        int discount =0;
        if(voucher != null){
            discount = (voucher.getDiscount() * subtotal) / 100;
        }
        content += "<tr>"
                + "<tr>"
                + "    <td colspan=\"4\" style=\"padding:4px;text-align:right\"> Giảm giá  </td>"
                + "    <td class=\"price\">" + formatter.format(discount) + " VNĐ</td>"
                + "</tr>"
                + "<tr>"
                + "    <td colspan=\"4\" style=\"padding:4px;text-align:right\"> Phí vận chuyển </td>"
                + "    <td class=\"price\">" + formatter.format(ShippingFee) + " VNĐ</td>"
                + "</tr>"
                + "    <td colspan=\"4\" style=\"padding:4px;text-align:right\"> Tổng thanh toán </td>"
                + "    <td class=\"price\">" + formatter.format(TotalCost) + " VNĐ</td>"
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
        session.removeAttribute("cartQuantiry");
        try {
            EmailHandler.sendEmail(Email, subject, content);
        } catch (AddressException ex) {
            Logger.getLogger(OrderController.class.getName()).log(Level.SEVERE, null, ex);
        }
        request.getRequestDispatcher("ProductListServlet").forward(request, response);
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}