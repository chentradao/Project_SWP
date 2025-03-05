/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

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
import model.DAOVoucher;

/**
 *
 * @author nguye
 */
@WebServlet(name="CartController", urlPatterns={"/CartURL"})
public class CartController extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        DAOCart dao = new DAOCart();
        DAOVoucher d = new DAOVoucher();
        HttpSession session = request.getSession(true);
        try (PrintWriter out = response.getWriter()) {
            String service = request.getParameter("service");
            if(service == null){
                service.equals("showCart");
            }
            if(service.equals("add2cart")){
                int id = Integer.parseInt(request.getParameter("id"));
                Cart newCart = dao.getCart(id);
                if(session.getAttribute(id + "")== null){
                    newCart.setQuantity(1);
                    session.setAttribute(id + "", newCart);
                }else{
                    Cart oldCart = (Cart) session.getAttribute(id + "");
                    oldCart.setQuantity(oldCart.getQuantity() + 1);
                    session.setAttribute(id + "", oldCart);
                }
                response.sendRedirect(request.getHeader("Referer"));
            }
            if(service.equals("showCart")){
                Vector<Cart> vector = new Vector<>();
                Enumeration enu = session.getAttributeNames();
                while (enu.hasMoreElements()){
                    String key = (String) enu.nextElement();
                    Object obj = session.getAttribute(key);
                    if(obj instanceof Cart){
                        Cart cart = (Cart) obj;
                        vector.add(cart);
                    }
                }
                request.setAttribute("error", session.getAttribute("error"));
                request.setAttribute("voucher", session.getAttribute("voucher"));
                request.setAttribute("vectorCart", vector);
                request.getRequestDispatcher("/jsp/Cart.jsp").forward(request, response);
            }
            if(service.equals("removeCart")){
                int id = Integer.parseInt(request.getParameter("id"));
                Enumeration enu = session.getAttributeNames();
                while(enu.hasMoreElements()){
                    String key = (String)enu.nextElement();
                    Object obj = session.getAttribute(key);
                    if(obj instanceof Cart){
                        Cart cart = (Cart)obj;
                        if(cart.getID() == id){
                        session.removeAttribute(key);
                        }
                    }  
                }
                response.sendRedirect("CartURL?service=showCart");
            }
            if(service.equals("clearCart")){
        Enumeration enu = session.getAttributeNames();
        while(enu.hasMoreElements()){
        String key = (String)enu.nextElement();
        Object obj = session.getAttribute(key);
        if(obj instanceof Cart){
            session.removeAttribute(key);
        }
    }
    response.sendRedirect("CartURL?service=showCart");
}
            if(service.equals("addVoucher")){
                    String VoucherID = request.getParameter("VoucherID");
                    if(VoucherID == null){
                    Voucher voucher = d.getVoucherByID(1);
                    session.setAttribute("voucher", voucher);
                    }else{
                        int vid = Integer.parseInt(VoucherID);
                        Voucher voucher = d.getVoucherByID(vid);
                        if(voucher == null){
                            String error = "Voucher không hợp lệ";
                            session.setAttribute("error", error);
                            session.removeAttribute("voucher");
                        }else{
                            session.setAttribute("voucher", voucher);
                        }
                    }
                    request.getRequestDispatcher("CartURL?service=showCart").forward(request, response);
                }
                
            
            if(service.equals("updateCart")){
                String submit = request.getParameter("submit");
                if(submit != null){
                Enumeration enu = session.getAttributeNames();
                while(enu.hasMoreElements()){
                    String key = (String)enu.nextElement();
                    Object obj = session.getAttribute(key);
                    if(obj instanceof Cart){
                        Cart cart = (Cart)obj;
                        int id = cart.getID();
                        int Quantity = Integer.parseInt(request.getParameter("Quantity_"+id));
                        if(Quantity == 0){
                        session.removeAttribute(key);
                        }else{
                            cart.setQuantity(Quantity);
                            session.setAttribute(key, cart);
                        }
                    }
                }
                response.sendRedirect("CartURL?service=showCart");
            }
          }
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
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
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
