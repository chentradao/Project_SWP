<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List" %>
<%@page import="entity.Category" %>
<%@page import="model.CategoryRepository" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<div class="menu d-flex flex-column align-items-end justify-content-start text-right menu_mm trans_400">
    <div class="menu_close_container"><div class="menu_close"><div></div><div></div></div></div>
    <div class="logo menu_mm"><a href="${pageContext.request.contextPath}/ProductListServlet">Estée Lauder</a></div>
    <div class="search header_search">
                <form action="${pageContext.request.contextPath}/search.jsp" method="GET" id="searchForm">
                    <input type="search" name="keyword" class="search_input" placeholder="Tìm kiếm sản phẩm..." required="required" onclick="redirectToSearch()">
                    <button type="submit" id="search_button" class="search_button"><img src="images/magnifying-glass.svg" alt=""></button>
                </form>
            </div>
    <nav class="menu_nav">
        <ul class="menu_mm">
            <li class="menu_mm"><a href="${pageContext.request.contextPath}/ProductListServlet">Trang chủ</a></li>
            <li class="menu_mm"><a href="OrderHistoryURL?service=orderHistory">Đơn Mua</a></li>
                <% for (Category category : categories) { %>
            <li><a href="categories.html?category=<%= category.getCategoryId() %>">
                    <%= category.getCategoryName() %>
                </a></li>
                <% } %>
            <li class="menu_mm"><a href="contact.jsp">contact</a></li>
            <li class="menu_mm">
                <c:choose>
                    <c:when test="${not empty sessionScope.acc}">
                        <a id="logout-btn" class="logout-btn" href="login?ac=logout">Đăng xuất</a>
                    </c:when>
                </c:choose>
            </li>
            <li class="menu_mm">
                <a href="viewUserFeedback.jsp">Phản hồi về dịch vụ</a>
            </li>
        </ul>
    </nav>
</div>
            
<script>
    function redirectToSearch() {
        document.getElementById("searchForm").submit();
    }
</script>