/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import entity.Accounts;
import entity.Cart;
import entity.Voucher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.Enumeration;
import java.util.Vector;
import model.DAOCart;
import jakarta.servlet.RequestDispatcher;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.mail.internet.AddressException;
import model.DAOAccountVoucher;
import model.DAOVoucher;
import model.EmailHandler;

/**
 *
 * @author nguye
 */
@WebServlet(name = "CartController", urlPatterns = {"/CartURL"})
public class CartController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        DAOCart dao = new DAOCart();
        DAOVoucher d = new DAOVoucher();
        DAOAccountVoucher av = new DAOAccountVoucher();
        HttpSession session = request.getSession(true);
        Accounts acc = (Accounts) session.getAttribute("acc");
        try (PrintWriter out = response.getWriter()) {
            String service = request.getParameter("service");
            String quality = request.getParameter("qty");
            int qty = -1;
            if (quality == null || quality.equals("")) {
                qty = 1;
            }
            try {
                qty = Integer.parseInt(quality);
            } catch (Exception e) {
            }
            if (service == null) {
                service = "showCart";
            }
            int cartQuantiry = session.getAttribute("cartQuantiry") != null ? (int) session.getAttribute("cartQuantiry") : 0;
            if (service.equals("add2cart")) {
                int id = Integer.parseInt(request.getParameter("id"));
                Cart newCart = dao.getCart(id);
                if (session.getAttribute(id + "") == null) {
                    newCart.setQuantity(qty);
                    session.setAttribute(id + "", newCart);
                    cartQuantiry += 1;
                } else {
                    Cart oldCart = (Cart) session.getAttribute(id + "");
                    oldCart.setQuantity(oldCart.getQuantity() + 1);
                    session.setAttribute(id + "", oldCart);
                }
                session.setAttribute("cartQuantiry", cartQuantiry);
                response.sendRedirect(request.getHeader("Referer"));
            }
            if (service.equals("showCart")) {
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
                if (acc != null) {
                    String sql = "SELECT V.*\n"
                            + "FROM Voucher V\n"
                            + "LEFT JOIN AccountVoucher AV ON V.VoucherID = AV.VoucherID AND AV.AccountID = \n"+acc.getAccountID()
                            + "WHERE AV.VoucherID IS NULL AND V.VoucherStatus = 1;";
                    Vector<Voucher> voucherlist = d.getVouchers(sql);
                    request.setAttribute("voucherlist", voucherlist);
                }
                request.setAttribute("acc", acc);
                request.setAttribute("error", session.getAttribute("error"));
                request.setAttribute("voucher", session.getAttribute("voucher"));
                request.setAttribute("vectorCart", vector);
                request.getRequestDispatcher("/jsp/Cart.jsp").forward(request, response);
            }
            if (service.equals("removeCart")) {
                int id = Integer.parseInt(request.getParameter("id"));
                Enumeration enu = session.getAttributeNames();
                while (enu.hasMoreElements()) {
                    String key = (String) enu.nextElement();
                    Object obj = session.getAttribute(key);
                    if (obj instanceof Cart) {
                        Cart cart = (Cart) obj;
                        if (cart.getID() == id) {
                            session.removeAttribute(key);
                            cartQuantiry -= 1;
                        }
                    }
                }
                session.setAttribute("cartQuantiry", cartQuantiry);
                response.sendRedirect("CartURL?service=showCart");
            }
            if (service.equals("clearCart")) {
                Enumeration enu = session.getAttributeNames();
                while (enu.hasMoreElements()) {
                    String key = (String) enu.nextElement();
                    Object obj = session.getAttribute(key);
                    if (obj instanceof Cart) {
                        session.removeAttribute(key);
                        session.removeAttribute("cartQuantiry");
                    }
                }
                response.sendRedirect("CartURL?service=showCart");
            }
            if (service.equals("addVoucher")) {
                String VoucherID = request.getParameter("VoucherID");
                if (acc == null) {
                    session.setAttribute("error", "Vui lòng đăng nhập để sử dụng voucher");
                } else {
                    if (VoucherID == null || VoucherID.isEmpty()) {
                        session.setAttribute("error", "Vui lòng nhập voucher");
                    } else {
                        Voucher voucher = d.getVoucherByName(VoucherID);
                        if (voucher == null || voucher.getVoucherStatus() == 0) {
                            String error = "Voucher không hợp lệ";
                            session.setAttribute("error", error);
                            session.removeAttribute("voucher");
                        } else {
                            if (av.hasUsedVoucher(voucher.getVoucherID(), acc.getAccountID())) {
                                session.setAttribute("error", "Voucher này đã được sử dụng trước đây");
                            } else {
                                session.setAttribute("voucher", voucher);
                            }
                        }
                    }
                }
                request.getRequestDispatcher("CartURL?service=showCart").forward(request, response);
            }

            if (service.equals("updateCart")) {
                String submit = request.getParameter("submit");
                if (submit != null) {
                    Enumeration enu = session.getAttributeNames();
                    while (enu.hasMoreElements()) {
                        String key = (String) enu.nextElement();
                        Object obj = session.getAttribute(key);
                        if (obj instanceof Cart) {
                            Cart cart = (Cart) obj;
                            int id = cart.getID();
                            int Quantity = Integer.parseInt(request.getParameter("Quantity_" + id));
                            if (Quantity == 0) {
                                session.removeAttribute(key);
                            } else {
                                cart.setQuantity(Quantity);
                                session.setAttribute(key, cart);
                            }
                        }
                    }
                    response.sendRedirect("CartURL?service=showCart");
                }
            }
            if (service.equals("voucherEmail")) {
                String email = request.getParameter("V_email");

                // Validate email
                if (email == null || email.trim().isEmpty()) {
                    session.setAttribute("V_error", "Vui lòng nhập email.");
                    response.sendRedirect(request.getHeader("Referer"));
                    return;
                }

                // Regex kiểm tra định dạng email
                String emailPattern = "^[^\\s@]+@[^\\s@]+\\.[a-zA-Z]{2,}$";
                if (!email.matches(emailPattern)) {
                    session.setAttribute("V_error", "Email không đúng định dạng.");
                    response.sendRedirect(request.getHeader("Referer"));
                    return;
                }

                if (email.length() < 5 || email.length() > 60) {
                    session.setAttribute("V_error", "Email phải có độ dài từ 5 - 60 ký tự.");
                    response.sendRedirect(request.getHeader("Referer"));
                    return;
                }

                // Nếu validate thành công, gửi email
                try {
                    sendVoucherEmail(email, 4, 5);
                    session.setAttribute("success", "Voucher đã được gửi đến email của bạn!");
                } catch (Exception e) {
                    session.setAttribute("V_error", "Có lỗi khi gửi email. Vui lòng thử lại.");
                    Logger.getLogger(CartController.class.getName()).log(Level.SEVERE, null, e);
                }
                response.sendRedirect(request.getHeader("Referer"));
            }
        }
    }

    private void sendVoucherEmail(String email, int voucherCode, int discount) {
        String subject = "ESTÉE LAUDER - Mã Voucher Giảm Giá Dành Cho Bạn!";
        String content = "<!DOCTYPE html>"
                + "<html>"
                + "<head>"
                + "    <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">"
                + "    <title>Mã Voucher Giảm Giá</title>"
                + "    <style>"
                + "        .container { margin: 50px 200px; background-color: #F3F3F3; padding: 25px; text-align: center; }"
                + "        .voucher-code { font-size: 24px; font-weight: bold; color: #ce0707; margin-top: 20px; }"
                + "        .discount { font-size: 20px; margin-top: 10px; color: #333; }"
                + "    </style>"
                + "</head>"
                + "<body style=\" padding: 30px;\">"
                + "    <div class=\"container\">"
                + "        <p>Cảm ơn bạn đã mua sắm tại <a href=\"http://localhost:8080/Project_SWP/ProductListServlet\">ESTÉE LAUDER</a>!</p>"
                + "        <p>Chúng tôi gửi tặng bạn một mã giảm giá đặc biệt.</p>"
                + "        <div class=\"voucher-code\">" + voucherCode + "</div>"
                + "        <div class=\"discount\">Giảm ngay " + discount + "% trên tổng giá trị đơn hàng</div>"
                + "        <p>Hãy sử dụng mã này trong lần mua sắm tiếp theo để nhận ưu đãi!</p>"
                + "        <p>Trân trọng,</p>"
                + "        <h2>ESTÉE LAUDER</h2>"
                + "    </div>"
                + "</body>"
                + "</html>";
        try {
            EmailHandler.sendEmail(email, subject, content);
        } catch (AddressException ex) {
            Logger.getLogger(OrderController.class.getName()).log(Level.SEVERE, null, ex);
        }
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
