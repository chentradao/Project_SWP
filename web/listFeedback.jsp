<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.List" %>
<%@ page import="model.DAOProductDetail" %>
<%@ page import="entity.ProductDetail" %>
<%@ page import="entity.Feedback" %>
<html>
    <head>
        <title>Feedbacklist</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="description" content="Wish shop project">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" type="text/css" href="styles/bootstrap4/bootstrap.min.css">
        <link href="plugins/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
        <link rel="stylesheet" type="text/css" href="plugins/OwlCarousel2-2.2.1/owl.carousel.css">
        <link rel="stylesheet" type="text/css" href="plugins/OwlCarousel2-2.2.1/owl.theme.default.css">
        <link rel="stylesheet" type="text/css" href="plugins/OwlCarousel2-2.2.1/animate.css">
        <link href="plugins/colorbox/colorbox.css" rel="stylesheet" type="text/css">
        <link rel="stylesheet" type="text/css" href="styles/main_styles.css">
        <link rel="stylesheet" type="text/css" href="styles/responsive.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">
    </head>
    <body>
        <%@ include file="AminHeader.jsp" %>
        <div class="container py-4">
            <div class="row mb-4 align-items-center">
                <div class="col">
                    <h3 class="text-brown fw-bold mb-0">
                        <i class="bi bi-chat-square-text-fill me-2"></i>Quản lý đánh giá
                    </h3>
                </div>
            </div>

            <div class="card shadow-sm border-0">
                <div class="card-body p-0">
                    <c:choose>
                        <c:when test="${not empty feedbacks}">
                            <div class="table-responsive">
                                <table class="table table-striped table-hover mb-0">
                                    <thead class="bg-brown text-white">
                                        <tr>
                                            <th scope="col">Người dùng</th>
                                            <th scope="col">Sản phẩm</th>
                                            <th scope="col">Ảnh sản phẩm</th>
                                            <th scope="col">Đánh giá</th>
                                            <th scope="col">Ảnh</th>
                                            <th scope="col">Ngày</th>
                                            <th scope="col">Hành động</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="feedback" items="${feedbacks}">
                                            <tr>
                                                <td>${feedback.accountName}</td>
                                                <td>${feedback.productName}</td>
                                                <% 
                                                    DAOProductDetail dao = new DAOProductDetail();
                                                    Feedback currentFeedback = (Feedback)pageContext.getAttribute("feedback");
                                                    ProductDetail productDetail = dao.getProductDetailById(currentFeedback.getProductID());
                                                %>
                                                <td><img src="<%= productDetail.getImage() %>" alt="Product Image" width="100"></td>

                                                <td>
                                                    <div class="star-rating">
                                                        <c:forEach var="i" begin="1" end="5">
                                                            <c:choose>
                                                                <c:when test="${i <= feedback.rateStar}">
                                                                    <i class="bi bi-star-fill text-warning"></i>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <i class="bi bi-star text-muted"></i>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </c:forEach>
                                                        <span class="ms-2 text-muted small">(${feedback.rateStar}/5)</span>
                                                    </div>
                                                    <p class="mb-0 small text-muted">${feedback.feedback}</p>
                                                </td>
                                                <td>
                                                    <img src="img/${feedback.imageURL}" alt="Feedback Image" class="rounded-circle me-2" 
                                                         style="width: 50px; height: 50px; object-fit: cover;">
                                                </td>
                                                <td>
                                                    <small class="text-muted">
                                                        <i class="bi bi-calendar3 me-1"></i>
                                                        <fmt:formatDate value="${feedback.date}" pattern="dd/MM/yyyy" />
                                                    </small>
                                                </td>
                                                <td>
                                                    <!-- Nút xem đánh giá -->
                                                    <a href="FeedbackDisplayController?productId=${feedback.productID}" 
                                                       class="btn btn-sm btn-outline-primary">
                                                        <i class="bi bi-eye-fill"></i> Xem
                                                    </a>

                                                    <!-- Nút xóa đánh giá -->
                                                    <!-- Nút xóa đánh giá -->
                                                    <a href="#" 
                                                       class="btn btn-sm btn-outline-primary delete-btn" 
                                                       data-bs-toggle="modal" 
                                                       data-bs-target="#deleteConfirmModal" 
                                                       data-feedback-id="${feedback.feedbackID}">
                                                        <i class="bi bi-trash-fill"></i> Xóa
                                                    </a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>

                            <!-- Phân trang -->
                            <nav aria-label="Page navigation" class="mt-4">
                                <ul class="pagination justify-content-center">
                                    <!-- Nút Previous -->
                                    <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                        <a class="page-link" href="feedbacks?page=${currentPage - 1}" aria-label="Previous">
                                            <span aria-hidden="true">«</span>
                                        </a>
                                    </li>

                                    <!-- Số trang -->
                                    <c:forEach var="i" begin="1" end="${totalPages}">
                                        <li class="page-item ${currentPage == i ? 'active' : ''}">
                                            <a class="page-link" href="feedbacks?page=${i}">${i}</a>
                                        </li>
                                    </c:forEach>

                                    <!-- Nút Next -->
                                    <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                        <a class="page-link" href="feedbacks?page=${currentPage + 1}" aria-label="Next">
                                            <span aria-hidden="true">»</span>
                                        </a>
                                    </li>
                                </ul>
                            </nav>
                        </c:when>
                        <c:otherwise>
                            <div class="text-center py-5">
                                <i class="bi bi-chat-square-x fs-1 text-muted mb-3"></i>
                                <h5 class="text-muted">Chưa có đánh giá nào</h5>
                                <p class="text-muted">Hãy thêm đánh giá đầu tiên bằng cách nhấn nút "Thêm đánh giá mới"</p>
                                <a href="add_feedback.jsp" class="btn btn-brown mt-2">
                                    <i class="bi bi-plus-circle me-1"></i>Thêm đánh giá mới
                                </a>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>

        <!-- Modal xác nhận xóa -->
        <div class="modal fade" id="deleteConfirmModal" tabindex="-1" aria-labelledby="deleteConfirmModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header bg-brown text-white">
                        <h5 class="modal-title" id="deleteConfirmModalLabel">Xác nhận xóa</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body text-center">
                        <i class="bi bi-exclamation-triangle-fill text-danger fs-1 mb-3"></i>
                        <p class="mb-0">Bạn có chắc chắn muốn xóa đánh giá này?</p>
                        <small class="text-muted">Hành động này không thể hoàn tác.</small>
                    </div>
                    <div class="modal-footer justify-content-center">
                        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                            <i class="bi bi-x-circle me-1"></i> Hủy
                        </button>
                        <a id="confirmDeleteBtn" href="#" class="btn btn-brown">
                            <i class="bi bi-trash-fill me-1"></i> Xóa
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <!-- JavaScript cho modal -->
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                const deleteButtons = document.querySelectorAll('.delete-btn');
                const confirmDeleteBtn = document.getElementById('confirmDeleteBtn');

                deleteButtons.forEach(button => {
                    button.addEventListener('click', function () {
                        const feedbackID = this.getAttribute('data-feedback-id');
                        confirmDeleteBtn.setAttribute('href', 'feedbacks?page=${currentPage}&action=delete&feedbackID=' + feedbackID);
                    });
                });
            });
        </script>
    </body>
    <style>
        /* Brown theme custom styling */
        :root {
            --brown-primary: #8B5A2B;
            --brown-secondary: #A67C52;
            --brown-light: #D2B48C;
            --brown-very-light: #F5F0E7;
            --brown-dark: #654321;
        }

        .text-brown {
            color: var(--brown-primary);
        }

        .text-brown-dark {
            color: var(--brown-dark);
        }

        .bg-brown {
            background-color: var(--brown-primary);
        }

        .bg-brown-light {
            background-color: var(--brown-light);
        }

        .btn-brown {
            background-color: var(--brown-primary);
            color: white;
            border: none;
            transition: all 0.3s;
        }

        .btn-brown:hover, .btn-brown:focus {
            background-color: var(--brown-dark);
            color: white;
        }

        .btn-outline-brown {
            color: var(--brown-primary);
            border-color: var(--brown-light);
            background-color: white;
            transition: all 0.3s;
        }

        .btn-outline-brown:hover {
            background-color: var(--brown-very-light);
            color: var(--brown-dark);
            border-color: var(--brown-secondary);
        }

        .border-brown {
            border-color: var(--brown-primary) !important;
        }

        .list-group-item {
            transition: all 0.2s;
        }

        .list-group-item:hover {
            background-color: var(--brown-very-light);
        }

        .feedback-content {
            background-color: var(--brown-very-light) !important;
            border-left: 3px solid var(--brown-light);
        }

        .star-rating .bi-star-fill {
            color: #FFD700 !important;
        }

        /* Cải thiện nút btn-outline-primary (dùng cho cả Xem và Xóa) */
        .btn-outline-primary {
            border: 2px solid var(--brown-primary);
            color: var(--brown-primary);
            padding: 5px 15px;
            border-radius: 50px;
            transition: all 0.3s ease;
        }

        .btn-outline-primary:hover {
            background-color: var(--brown-primary);
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(139, 90, 43, 0.3);
        }

        .btn-outline-primary i {
            margin-right: 5px;
        }

        /* Định dạng phân trang */
        .pagination .page-link {
            color: var(--brown-primary);
            border: 1px solid var(--brown-light);
            transition: all 0.3s ease;
        }

        .pagination .page-item.active .page-link {
            background-color: var(--brown-primary);
            border-color: var(--brown-primary);
            color: white;
        }

        .pagination .page-item.disabled .page-link {
            color: #ccc;
            cursor: not-allowed;
        }

        .pagination .page-link:hover {
            background-color: var(--brown-very-light);
            color: var(--brown-dark);
        }
    </style>
</html>