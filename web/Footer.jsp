<%-- 
    Document   : Footer
    Created on : Feb 26, 2025, 10:29:36 AM
    Author     : nguye
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List" %>
<%@page import="entity.Category" %>
<%@page import="model.CategoryRepository" %>
<!-- Newsletter -->
<div class="newsletter">
    <div class="newsletter_content">
        <div class="newsletter_image parallax-window" data-parallax="scroll" data-image-src="P_images/Footer.jpg" data-speed="0.8"></div>
        <div class="container">
            <div class="row options">

                <!-- Options Item -->
                <div class="col-lg-3">
                    <div class="options_item d-flex flex-row align-items-center justify-content-start">
                        <div class="option_image"><img src="images/option_1.png" alt=""></div>
                        <div class="option_content">
                            <div class="option_title">Trả hàng trong 30 ngày</div>
                            <div class="option_subtitle">Không Cần Lý Do</div>
                        </div>
                    </div>
                </div>

                <!-- Options Item -->
                <div class="col-lg-3">
                    <div class="options_item d-flex flex-row align-items-center justify-content-start">
                        <div class="option_image"><img src="images/option_2.png" alt=""></div>
                        <div class="option_content">
                            <div class="option_title">Giao Hàng Tiết Kiệm</div>
                            <div class="option_subtitle">Trên Toàn Quốc</div>
                        </div>
                    </div>
                </div>

                <!-- Options Item -->
                <div class="col-lg-3">
                    <div class="options_item d-flex flex-row align-items-center justify-content-start">
                        <div class="option_image"><img src="images/option_3.png" alt=""></div>
                        <div class="option_content">
                            <div class="option_title">Thanh Toán Online</div>
                            <div class="option_subtitle">Ưu Tiên Bảo Mật</div>
                        </div>
                    </div>
                </div>

                <!-- Options Item -->
                <div class="col-lg-3">
                    <div class="options_item d-flex flex-row align-items-center justify-content-start">
                        <div class="option_image"><img src="images/option_4.png" alt=""></div>
                        <div class="option_content">
                            <div class="option_title">Hỗ Trợ Nhiệt Tình</div>
                            <div class="option_subtitle">Tận Tâm Lắng nghe</div>
                        </div>
                    </div>
                </div>

            </div>
            <%if(acc == null){%>
            <div class="row newsletter_row">
                <div class="col">
                    <div class="section_title_container text-center">
                        <div class="section_subtitle">Đăng Kí Tài Khoản</div>
                        <div class="section_title">Nhận Ngay Voucher Giảm 20%</div>
                    </div>
                </div>
            </div>
            <div class="row newsletter_container">
                <div class="col-lg-10 offset-lg-1">
                    <div class="newsletter_form_container">
                        <form action="CartURL" method="post" id="VoucherForm">
                            <!--                            <input type="hidden" name="service" value="voucherEmail">-->
                            <!--                            <input type="email" id="V_email" name="V_email" class="newsletter_input" placeholder="emailcuaban@email.com">-->
                            <button type="Button" onclick="window.location.href = 'signup.jsp'" class="newsletter_button">Đăng kí</button>
                        </form>
                    </div>
                    <div class="newsletter_text">Ngoài ra bạn có thể đăng kí tài khoản để nhận được hỗ trợ tốt nhất</div>
                </div>
            </div>
            <%} else{%>
            <div class="row newsletter_row">
                <div class="col">
                    <div class="section_title_container text-center">
                        <div class="section_subtitle">Chào Mừng Trở Lại, <%= acc.getFullName() %>!</div>
                        <div class="section_title">Khám Phá Sản Phẩm Mới Nhất</div>
                    </div>
                </div>
            </div>
            <div class="row newsletter_container">
                <div class="col-lg-10 offset-lg-1">
                    <div class="newsletter_form_container text-center">
                        <button type="button" onclick="window.location.href = 'categories.jsp?'" class="newsletter_button">Khám Phá Ngay</button>
                        <p class="newsletter_text">Hãy xem ngay những sản phẩm hot nhất hiện nay!</p>
                    </div>
                </div>
            </div>
            <%}%>
        </div>
    </div>
</div>
<!-- Footer -->
<footer class="footer">
    <div class="container">
        <div class="row">
            <div class="col text-center">
                <div class="footer_logo"><a href="ProductListServlet">ESTÉE LAUDER</a></div>
                <nav class="footer_nav">
                    <ul>
                        <li><a href="ProductListServlet">home</a></li>
                            <% for (Category category : categories) { %>
                        <li><a href="categories.jsp?category=<%= category.getCategoryId() %>">
                                <%= category.getCategoryName() %>
                            </a></li>
                            <% } %>
                    </ul>
                </nav>
                <div class="footer_social">
                    <ul>
                        <li><a href="#"><i class="fa fa-pinterest" aria-hidden="true"></i></a></li>
                        <li><a href="#"><i class="fa fa-linkedin" aria-hidden="true"></i></a></li>
                        <li><a href="#"><i class="fa fa-instagram" aria-hidden="true"></i></a></li>
                        <li><a href="#"><i class="fa fa-reddit-alien" aria-hidden="true"></i></a></li>
                        <li><a href="#"><i class="fa fa-twitter" aria-hidden="true"></i></a></li>
                    </ul>
                </div>
                <div class="copyright"><!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
                    Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved | This template is made with <i class="fa fa-heart-o" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">Colorlib</a>
                    <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. --></div>
            </div>
        </div>
    </div>
</footer>
