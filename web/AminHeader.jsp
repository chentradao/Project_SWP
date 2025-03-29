<%-- 
    Document   : AminHeader
    Created on : Mar 28, 2025, 10:12:25 AM
    Author     : nguye
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="entity.Accounts" %>
<!DOCTYPE html>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        .header_inner {
            height: 80px;
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
    <div class="logo">
        <a href="admin">Estée Lauder</a>
    </div>
    <nav class="main_nav flex-grow-1 text-center">
        <ul class="navbar-nav d-flex flex-row justify-content-center">
            <li class="nav-item"><a class="nav-link text-dark" href="ghtkservlet?action=order">Quản lý đơn hàng</a></li>
            <li class="nav-item"><a class="nav-link text-dark" href="revenue">Doanh thu</a></li>
            <li class="nav-item"><a class="nav-link text-dark" href="orderManagement.jsp">Quản lý Đơn hàng</a></li>
            <li class="nav-item"><a class="nav-link text-dark" href="staff/products">Kho hàng</a></li>
            <li class="nav-item"><a class="nav-link text-dark" href="slider">Quảng Cáo</a></li>
            <li class="nav-item"><a class="nav-link text-dark" href="FlashSaleURL?service=flashSaleList">Quản lý FlashSale</a></li>
            <li><a href="Blog?service=listAllBlogs">Bài đăng</a></li>
            <li class="nav-item"><a class="nav-link text-dark" href="ListUser">Quản lý Tài khoản</a></li>
        </ul>
    </nav>
    <div class="nav-item dropdown">
        <a class="nav-link dropdown-toggle text-dark" href="#" id="userDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            ${sessionScope.acc.fullName}
        </a>
        <ul class="dropdown-menu dropdown-menu-end shadow" aria-labelledby="userDropdown">
            <li><a class="dropdown-item" href="login?ac=logout">Đăng xuất</a></li>
        </ul>
    </div>
</header>