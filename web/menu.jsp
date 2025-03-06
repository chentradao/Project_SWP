<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List" %>
<%@page import="entity.Category" %>
<%@page import="model.CategoryRepository" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<div class="menu d-flex flex-column align-items-end justify-content-start text-right menu_mm trans_400">
    <div class="menu_close_container"><div class="menu_close"><div></div><div></div></div></div>
    <div class="logo menu_mm"><a href="index.jsp">Estée Lauder</a></div>
    <div class="search">
        <form action="#">
            <input type="search" class="search_input menu_mm" required="required">
            <button type="submit" id="search_button_menu" class="search_button menu_mm"><img class="menu_mm" src="images/magnifying-glass.svg" alt=""></button>
        </form>
    </div>
    <nav class="menu_nav">
        <ul class="menu_mm">
            <li class="menu_mm"><a href="index.html">home</a></li>
                <% for (Category category : categories) { %>
            <li><a href="categories.html?category=<%= category.getCategoryId() %>">
                    <%= category.getCategoryName() %>
                </a></li>
                <% } %>
            <li class="menu_mm"><a href="#">contact</a></li>
            <li class="menu_mm">
                <c:choose>
                    <c:when test="${not empty sessionScope.acc}">
                        <a id="logout-btn" class="logout-btn" href="login?ac=logout">Đăng xuất</a>
                    </c:when>
                </c:choose>
            </li>
        </ul>
    </nav>
</div>