<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List" %>
<%@page import="entity.Category"%>
<%@page import="model.CategoryRepository"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
        <div class="logo"><a href="${pageContext.request.contextPath}/ProductListServlet">Estée Lauder</a></div>
        <nav class="main_nav">
            <ul>
                <li><a href="ShoppingFlashSaleURL?service=flashSale">Flash Sale</a></li>
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
            <div class="search header_search">
                <form action="${pageContext.request.contextPath}/search.jsp" method="GET" id="searchForm">
                    <input type="search" name="keyword" class="search_input" placeholder="Tìm kiếm "  onclick="redirectToSearch()">
                    <button type="submit" id="search_button" class="search_button"><img src="images/magnifying-glass.svg" alt=""></button>
                </form>
            </div>
            <div class="shopping">
                <!-- Cart -->
                <a href="CartURL?service=showCart">
                    <div class="cart">
                        <img src="images/shopping-bag.svg" alt="">
                        <div class="cart_num_container">
                            <div class="cart_num_inner">
                                <div class="cart_num">${sessionScope.cartQuantiry!= null ? sessionScope.cartQuantiry : 0}</div>
                            </div>
                        </div>
                    </div>
                </a>
                <!-- Star -->
                <a href="${pageContext.request.contextPath}/getwishlist">
                    <div class="star">
                        <img src="images/star.svg" alt="">
                        <div class="star_num_container">
                            <div class="star_num_inner">
                                <div class="star_num">
                                    <c:out value="${wishlistItems != null ? wishlistItems.size() : 0}"/>
                                </div>
                            </div>
                        </div>
                    </div>
                </a>
                <!-- Avatar -->
                <c:choose>
                    <c:when test="${not empty sessionScope.acc}">
                        <c:choose>
                            <c:when test="${not empty sessionScope.acc.image}">
                                <a href="profile">
                                    <img src="./P_images/${sessionScope.acc.image}" style="height: 35px; width: 35px; margin-right: 5px; border-radius: 50%;"/>
                                </a>
                            </c:when>
                            <c:otherwise>
                                <a href="profile">
                                    <div class="avatar">
                                        <img src="images/avatar.svg" />
                                    </div>
                                </a>
                            </c:otherwise>
                        </c:choose>
                    </c:when>
                    <c:otherwise>
                        <a href="login.jsp">
                            <div class="avatar">
                                <img src="images/avatar.svg"/>
                            </div>
                        </a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <div class="burger_container d-flex flex-column align-items-center justify-content-around menu_mm">
            <div></div>
            <div></div>
            <div></div>   
        </div>
    </div>
</header>

<script>
    function redirectToSearch() {
        document.getElementById("searchForm").submit();
    }
</script>