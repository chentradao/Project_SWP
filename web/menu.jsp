<%-- 
    Document   : menu
    Created on : Feb 9, 2025, 6:54:09 PM
    Author     : ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List" %>
<%@page import="entity.Category" %>
<%@page import="model.CategoryRepository" %>

<div class="menu d-flex flex-column align-items-end justify-content-start text-right menu_mm trans_400">
    <div class="menu_close_container"><div class="menu_close"><div></div><div></div></div></div>
    <div class="logo menu_mm"><a href="#">Wish</a></div>
    
    <nav class="menu_nav">
        <ul class="menu_mm">
            <li class="menu_mm"><a href="#">home</a></li>
            <% for (Category category : categories) { %>
                        <li><a href="categories.html?category=<%= category.getCategoryId() %>">
                            <%= category.getCategoryName() %>
                        </a></li>
                    <% } %>
            <li class="menu_mm"><a href="Blog">Blog</a></li>
            <li class="menu_mm"><a href="#">contact</a></li>
        </ul>
    </nav>
</div>