<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Danh sách tất cả phản hồi</title>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">
        <link rel="stylesheet" type="text/css" href="styles/bootstrap4/bootstrap.min.css">
        <link href="plugins/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
        <style>
            /* Giữ nguyên style từ Feedbacklist.jsp */
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
            .bg-brown {
                background-color: var(--brown-primary);
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
            .pagination .page-link:hover {
                background-color: var(--brown-very-light);
                color: var(--brown-dark);
            }
            .star-rating .bi-star-fill {
                color: #FFD700 !important;
            }
        </style>
    </head>
    <body>
        <div class="super_container">
            <!-- Header và Menu giữ nguyên nếu có -->

            <!-- Home -->
            <div class="home">
                <div class="home_background parallax-window" data-parallax="scroll" data-image-src="images/cart.jpg" data-speed="0.8"></div>
                <div class="container">
                    <div class="row">
                        <div class="col">
                            <div class="home_container">
                                <div class="home_content">
                                    <div class="home_title">Quản lý phản hồi</div>
                                    <div class="breadcrumbs">
                                        <ul>
                                            <li><a href="ProductListServlet">Trang chủ</a></li>
                                            <li>Quản lý phản hồi</li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Feedback List -->
            <div class="container py-4">
                <div class="row mb-4 align-items-center">
                    <div class="col">
                        <h3 class="text-brown fw-bold mb-0">
                            <i class="bi bi-chat-square-text-fill me-2"></i>Quản lý phản hồi
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
                                                <th scope="col">Đánh giá</th>
                                                <th scope="col">Ảnh</th>
                                                <th scope="col">Ngày</th>
                                                <th scope="col">Hành động</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="feedback" items="${feedbacks}">
                                                <tr>
                                                    <td>${feedback.accountName} (ID: ${feedback.accountID})</td>
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
                                                        <p class="mb-0 small text-muted">${feedback.feedbackText}</p>
                                                    </td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${not empty feedback.imageURL}">
                                                                <img src="${feedback.imageURL}" alt="Feedback Image" class="rounded-circle me-2" style="width: 50px; height: 50px; object-fit: cover;">
                                                            </c:when>
                                                            <c:otherwise>
                                                                <img src="images/default-feedback.jpg" alt="No Image" class="rounded-circle me-2" style="width: 50px; height: 50px; object-fit: cover;">
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                        <small class="text-muted">
                                                            <i class="bi bi-calendar3 me-1"></i>
                                                            <fmt:formatDate value="${feedback.date}" pattern="dd/MM/yyyy" />
                                                        </small>
                                                    </td>
                                                    <td>
                                                        <a href="ServiceFeedbackURL?action=viewDetail&feedbackId=${feedback.feedbackID}" class="btn btn-sm btn-outline-primary">
                                                            <i class="bi bi-eye-fill"></i> Xem
                                                        </a>
                                                        <a href="#" class="btn btn-sm btn-outline-primary delete-btn" data-bs-toggle="modal" data-bs-target="#deleteConfirmModal" data-feedback-id="${feedback.feedbackID}">
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
                                        <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                            <a class="page-link" href="ServiceFeedbackURL?action=list&page=${currentPage - 1}" aria-label="Previous">
                                                <span aria-hidden="true">«</span>
                                            </a>
                                        </li>
                                        <c:forEach var="i" begin="1" end="${totalPages}">
                                            <li class="page-item ${currentPage == i ? 'active' : ''}">
                                                <a class="page-link" href="ServiceFeedbackURL?action=list&page=${i}">${i}</a>
                                            </li>
                                        </c:forEach>
                                        <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                            <a class="page-link" href="ServiceFeedbackURL?action=list&page=${currentPage + 1}" aria-label="Next">
                                                <span aria-hidden="true">»</span>
                                            </a>
                                        </li>
                                    </ul>
                                </nav>
                            </c:when>
                            <c:otherwise>
                                <div class="text-center py-5">
                                    <i class="bi bi-chat-square-x fs-1 text-muted mb-3"></i>
                                    <h5 class="text-muted">Chưa có phản hồi nào</h5>
                                    <p class="text-muted">Hiện tại chưa có phản hồi nào được gửi.</p>
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
                            <p class="mb-0">Bạn có chắc chắn muốn xóa phản hồi này?</p>
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

            <!-- Footer giữ nguyên nếu có -->
        </div>

        <script src="js/jquery-3.2.1.min.js"></script>
        <script src="styles/bootstrap4/popper.js"></script>
        <script src="styles/bootstrap4/bootstrap.min.js"></script>
        <script src="plugins/easing/easing.js"></script>
        <script src="plugins/parallax-js-mast   er/parallax.min.js"></script>
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                const deleteButtons = document.querySelectorAll('.delete-btn');
                const confirmDeleteBtn = document.getElementById('confirmDeleteBtn');

                deleteButtons.forEach(button => {
                    button.addEventListener('click', function () {
                        const feedbackID = this.getAttribute('data-feedback-id');
                        confirmDeleteBtn.setAttribute('href', 'ServiceFeedbackURL?action=delete&feedbackId=' + feedbackID + '&page=${currentPage}');
                    });
                });
            });
        </script>
    </body>
</html>