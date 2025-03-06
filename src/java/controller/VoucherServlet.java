/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import entity.Voucher;
import model.DAOVoucher;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@WebServlet("/VoucherController")
public class VoucherServlet extends HttpServlet {

    private final DAOVoucher daoVoucher = new DAOVoucher();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "create":
                request.getRequestDispatcher("voucher-form.jsp").forward(request, response);
                break;
            case "edit":
                int id = Integer.parseInt(request.getParameter("id"));
                Voucher voucher = daoVoucher.getVoucher(id);
                request.setAttribute("voucher", voucher);
                request.getRequestDispatcher("voucher-form.jsp").forward(request, response);
                break;
            case "delete":
                daoVoucher.deleteVoucher(Integer.parseInt(request.getParameter("id")));
                response.sendRedirect("VoucherController");
                break;
            default:
                List<Voucher> vouchers = daoVoucher.listVouchers();
                request.setAttribute("vouchers", vouchers);
                request.getRequestDispatcher("voucher-list.jsp").forward(request, response);
                break;
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String id = request.getParameter("id");
        String name = request.getParameter("name");
        int discount = Integer.parseInt(request.getParameter("discount"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        String description = request.getParameter("description");
        int status = Integer.parseInt(request.getParameter("status"));
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date startDate = null, endDate = null;
        try {
            startDate = sdf.parse(request.getParameter("startDate"));
            endDate = sdf.parse(request.getParameter("endDate"));
        } catch (ParseException e) {
            e.printStackTrace();
        }

        Voucher voucher = new Voucher(id == null ? 0 : Integer.parseInt(id), name, discount, quantity, startDate, endDate, description, status);

        if (id == null || id.isEmpty()) {
            daoVoucher.createVoucher(voucher);
        } else {
            daoVoucher.updateVoucher(voucher);
        }

        response.sendRedirect("VoucherController");
    }
}
