<%-- 
    Document   : AminHeader
    Created on : Mar 28, 2025, 10:12:25 AM
    Author     : nguye
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="entity.Accounts,jakarta.servlet.http.HttpSession" %>
<!DOCTYPE html>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        .header_inner {
            height: 150px;
            padding: 0 20px;
            background: #f8f9fa;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        .logo a {
            font-size: 24px;
            font-weight: bold;
            color: #333;
            text-decoration: none;
        }
        .main_nav ul {
            gap: 20px;
        }
        .nav-item a {
            font-size: 16px;
            font-weight: 600;
            transition: color 0.3s;
        }
        .nav-item a:hover {
            color: #007bff;
        }
        .dropdown-menu {
            min-width: 150px;
        }
    </style>
<header class="header_inner d-flex align-items-center justify-content-between">
    
    <%
         session = request.getSession();
        Accounts acc = (Accounts) session.getAttribute("acc");
        if (acc == null) {
            response.sendRedirect("login.jsp");
        }
        else if (acc.getRole().equals("staff")) { %>
        <div class="logo">
        <a href="manager">Estée Lauder</a>
        </div>
            <nav class="main_nav flex-grow-1 text-center">
        <ul class="navbar-nav d-flex flex-row justify-content-center">
            <li class="nav-item"><a class="nav-link text-dark" href="<%= request.getContextPath() %>/ghtkservlet?action=order">Đơn hàng</a></li>
            <li class="nav-item"><a class="nav-link text-dark" href="<%= request.getContextPath() %>/staff/products">Kho hàng</a></li>
            <li class="nav-item"><a class="nav-link text-dark" href="<%= request.getContextPath() %>/slider">Quảng Cáo</a></li>
            <li class="nav-item"><a class="nav-link text-dark" href="<%= request.getContextPath() %>/FlashSaleURL?service=flashSaleList">FlashSale</a></li>
            <li class="nav-item"><a class="nav-link text-dark" href="<%= request.getContextPath() %>/BlogManager?service=listAllBlogs">Bài đăng</a></li>
            <li class="nav-item"><a class="nav-link text-dark" href="<%= request.getContextPath() %>/ListCus">Tài khoản</a></li>
            <li class="nav-item"><a class="nav-link text-dark" href="<%= request.getContextPath() %>/feedbacks">Phản hồi khách hàng</a></li>
        </ul>
    </nav>
        <%} else { %>
            <div class="logo">
        <a href="admin">Estée Lauder</a>
        </div>
            <nav class="main_nav flex-grow-1 text-center">
        <ul class="navbar-nav d-flex flex-row justify-content-center">
            <li class="nav-item"><a class="nav-link text-dark" href="<%= request.getContextPath() %>/revenue">Doanh thu</a></li>
            <li class="nav-item"><a class="nav-link text-dark" href="<%= request.getContextPath() %>/staff/products">Kho hàng</a></li>
            <li class="nav-item"><a class="nav-link text-dark" href="<%= request.getContextPath() %>/slider">Quảng Cáo</a></li>
            <li class="nav-item"><a class="nav-link text-dark" href="<%= request.getContextPath() %>/FlashSaleURL?service=flashSaleList">FlashSale</a></li>
            <li class="nav-item"><a class="nav-link text-dark" href="<%= request.getContextPath() %>/ListUser">Tài khoản</a></li>
            <li class="nav-item"><a class="nav-link text-dark" href="<%= request.getContextPath() %>/feedbacks">Phản hồi khách hàng</a></li>
        </ul>
    </nav>
        <%}%>
    
    <div class="nav-item dropdown">
        <a class="nav-link dropdown-toggle text-dark" href="#" id="userDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            ${sessionScope.acc.fullName}
        </a>
        <ul class="dropdown-menu dropdown-menu-end shadow" aria-labelledby="userDropdown">
            <li><a class="dropdown-item" href="login?ac=logout">Đăng xuất</a></li>
        </ul>
    </div>
</header>