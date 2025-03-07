///*
// * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
// * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
// */
//
//package controller;
//
//import entity.Cart;
//import java.io.IOException;
//import java.io.PrintWriter;
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import jakarta.servlet.http.HttpSession;
//import java.io.BufferedReader;
//import java.io.InputStreamReader;
//import java.net.HttpURLConnection;
//import java.net.URL;
//import java.net.URLEncoder;
//import java.util.Enumeration;
//import java.util.List;
//import java.util.Vector;
////import org.json.JSONObject;
//
//
///**
// *
// * @author nguye
// */
//@WebServlet(name="ShippingFeeController", urlPatterns={"/ShippingURL"})
//public class ShippingFeeController extends HttpServlet {
//   
//    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
//    throws ServletException, IOException {
//        response.setContentType("text/html;charset=UTF-8");
//        try (PrintWriter out = response.getWriter()) {
//           
//        }
//    } 
//
//    
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//    throws ServletException, IOException {
//        processRequest(request, response);
//        int total = Integer.parseInt(request.getParameter("total"));
//        String city = request.getParameter("city");
//        String district = request.getParameter("district");
//    String ward = request.getParameter("ward");
//         Vector<Cart> vector = new Vector<>();
//                Enumeration enu = request.getSession().getAttributeNames();
//                while (enu.hasMoreElements()){
//                    String key = (String) enu.nextElement();
//                    Object obj = request.getSession().getAttribute(key);
//                    if(obj instanceof Cart){
//                        Cart cart = (Cart) obj;
//                        vector.add(cart);
//                    }
//                }
//        int totalQuantity = 0;
//        for(Cart c : vector){
//            totalQuantity += c.getQuantity();
//        }
//        int weight = totalQuantity * 500;
//        
//        double shippingFee = getShippingFee(city, district, ward, weight, total);
//        response.setContentType("application/json");
//        response.setCharacterEncoding("UTF-8");
//        PrintWriter out = response.getWriter();
//        out.print("{\"shippingFee\":" + shippingFee + "}");
//        out.flush();
//    }
//
//    public double getShippingFee(String city, String district, String ward, int weight, int value) {
//        try {
//            String API_URL = "https://services.giaohangtietkiem.vn/services/shipment/fee";
//            String TOKEN = "13C9GJOiLh8zRzSXSIKkmYfTNPSvhO3a8sowSla";
//            String Source ="S22866023";
//            String encodedPickCity = URLEncoder.encode("Hà Nội", "UTF-8");
//            String encodedPickDistrict = URLEncoder.encode("Hà Đông", "UTF-8");
//            
//            // ma hoa tham so de tranh loi ki tu dac biet
//            String encodedCity = URLEncoder.encode(city, "UTF-8");
//            String encodedDistrict = URLEncoder.encode(district, "UTF-8");
//            String encodedWard = URLEncoder.encode(ward, "UTF-8");
//
//            // Xay dung url voi tham so
//            String requestUrl = API_URL + "?pick_province=" + encodedPickCity
//                    + "&pick_district=" + encodedPickDistrict
//                    + "&province=" + encodedCity
//                    + "&district=" + encodedDistrict
//                    + "&address=" + encodedWard
//                    + "&weight=" + weight
//                    + "&value=" + value;
//
//            URL url = new URL(requestUrl);
//            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
//            conn.setRequestMethod("GET");
//            conn.setRequestProperty("Token", TOKEN);
//            conn.setRequestProperty("X-Client-Source", Source);
//            conn.setRequestProperty("Content-Type", "application/json");
//
//            // kiem tra phan hoi tu server
//            int responseCode = conn.getResponseCode();
//            if (responseCode == 200) { // Nếu thành công
//                BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
//                String inputLine;
//                StringBuilder response = new StringBuilder();
//
//                while ((inputLine = in.readLine()) != null) {
//                    response.append(inputLine);
//                }
//                in.close();
//                // chuyen doi phan hoi thanh json
//                JSONObject jsonResponse = new JSONObject(response.toString());
//                if (jsonResponse.has("fee")) {
//                    return jsonResponse.getJSONObject("fee").getDouble("fee");
//                }
//            } else {
//                System.out.println("Lỗi HTTP: " + responseCode);
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//        return -1;
//    }
//
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//    throws ServletException, IOException {
//    }
//
//    @Override
//    public String getServletInfo() {
//        return "Short description";
//    }// </editor-fold>
//}
//
