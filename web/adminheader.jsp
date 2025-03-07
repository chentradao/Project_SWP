<%@page contentType="text/html" pageEncoding="UTF-8"%>


<header class="header">
    <div class="header_inner d-flex flex-row align-items-center justify-content-start">
        <div class="logo"><a href="adminindex.jsp">Estée Lauder</a></div>
        <nav class="main_nav">
            <ul>
                <li><a href="index.jsp">Quản lý đơn hàng</a></li>
                <li><a href="index.jsp">Quản lý kho hàng</a></li>
                <li><a href="index.jsp">Quản lý nhân viên</a></li>
                <li><a href="index.jsp">Quản lý bài đăng</a></li>
                <li><a href="feedbacks">Xem phản hồi</a></li>
                <li><a href="slider">Quản lý Slider</a></li>
            </ul>
        </nav>
        <div class="header_content ml-auto">
            
            <div class="shopping">
                <!-- Cart -->
                <a href="CartURL?service=showCart">
                    <div class="cart">
                        <img src="images/shopping-bag.svg" alt="">
                        <div class="cart_num_container">
                            <div class="cart_num_inner">
                                <div class="cart_num">1</div>
                            </div>
                        </div>
                    </div>
                </a>
                <!-- Star -->
                <a href="#">
                    <div class="star">
                        <img src="images/star.svg" alt="">
                        <div class="star_num_container">
                            <div class="star_num_inner">
                                <div class="star_num">0</div>
                            </div>
                        </div>
                    </div>
                </a>
                <!-- Avatar -->
                <a href="#">
                    <div class="avatar">
                        <img src="images/avatar.svg" alt="">
                    </div>
                </a>
            </div>
        </div>

    </div>
</header>