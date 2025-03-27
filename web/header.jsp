<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List" %>
<%@page import="entity.Category"%>
<%@page import="model.CategoryRepository"%>

<%
    CategoryRepository categoryRepository = new CategoryRepository();
    List<Category> categories = categoryRepository.getAllCategories();
%>
<style>
    /* Hiển thị dropdown khi hover vào li có class 'dropdown' */
.nav-item.dropdown:hover .dropdown-menu {
    display: block;
}
.dropdown-menu {
    display: none;
}

</style>

<header class="header">
    <div class="header_inner d-flex flex-row align-items-center justify-content-start">
        <div class="logo"><a href="#">Wish</a></div>
        <nav class="main_nav">
            <ul>
                <li><a href="${pageContext.request.contextPath}/ProductListServlet">Trang chủ</a></li>
                <% for (Category category : categories) { %>
                
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="product-list?categoryId=<%= category.getCategoryId() %>" id="dropdownMenuLink" aria-haspopup="true" aria-expanded="false">
                        <%= category.getCategoryName() %>
                    </a>
                    <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
                        <% 
                            // Lấy danh mục con dưới 1 cấp của danh mục này
                            List<Category> subCategories = categoryRepository.getAllCategoriesByParentCategory(String.valueOf(category.getCategoryId()));
                            for (Category subCategory : subCategories) { 
                        %>
                        <a class="dropdown-item" href="product-list?categoryId=<%= subCategory.getCategoryId() %>"><%= subCategory.getCategoryName() %></a>
                        <% } %>
                    </div>
                </li>


                
                <% } %>
     
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
                <a href="wishlist.jsp">
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
                <a href="login.jsp">
                    <div class="avatar">
                        <img src="images/avatar.svg" alt="">
                    </div>
                </a>
            </div>
        </div>

        <div class="burger_container d-flex flex-column align-items-center justify-content-around menu_mm"><div></div><div></div><div></div></div>
    </div>
</header>