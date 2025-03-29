<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Feedback detail</title>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="description" content="Wish shop project">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" type="text/css" href="styles/bootstrap4/bootstrap.min.css">
        <link href="plugins/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
        <link rel="stylesheet" type="text/css" href="styles/product.css">
        <link rel="stylesheet" type="text/css" href="styles/product_responsive.css">
    </head>
    <body>
        <style>
            /* Modern styling for the review statistics */
            .review-statistics-container {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: #fff;
                border-radius: 10px;
                padding: 20px;
                box-shadow: 0 2px 15px rgba(0, 0, 0, 0.1);
                max-width: 650px;
                margin: 0 auto;
            }

            .section-title {
                color: #333;
                font-size: 24px;
                margin-bottom: 20px;
                border-bottom: 2px solid #f0f0f0;
                padding-bottom: 10px;
            }

            .stats-grid {
                display: flex;
                flex-direction: column;
                gap: 12px;
                margin-bottom: 25px;
            }

            .rating-row {
                display: flex;
                align-items: center;
                gap: 15px;
            }

            .rating-label {
                width: 80px;
                display: flex;
                align-items: center;
                gap: 5px;
                font-weight: 500;
            }

            .star-icon {
                color: #FFD700;
            }

            .rating-bar-container {
                flex-grow: 1;
                height: 12px;
                background-color: #f0f0f0;
                border-radius: 6px;
                overflow: hidden;
            }

            .rating-bar {
                height: 100%;
                border-radius: 6px;
                transition: width 0.5s ease;
            }

            .five-star {
                background-color: #4CAF50;
            }

            .four-star {
                background-color: #8BC34A;
            }

            .three-star {
                background-color: #FFC107;
            }

            .two-star {
                background-color: #FF9800;
            }

            .one-star {
                background-color: #F44336;
            }

            .rating-count {
                width: 90px;
                text-align: right;
                color: #666;
                font-size: 14px;
            }

            .average-rating {
                display: flex;
                flex-direction: column;
                align-items: center;
                background-color: #f9f9f9;
                padding: 15px;
                border-radius: 8px;
            }

            .average-stars {
                font-size: 28px;
                color: #FFD700;
                margin-bottom: 5px;
            }

            .star-full, .star-half {
                color: #FFD700;
                display: inline-block;
            }

            .star-empty {
                color: #e0e0e0;
                display: inline-block;
            }

            .average-value {
                font-size: 16px;
                color: #333;
            }

            .review-count {
                color: #666;
                font-size: 14px;
                margin-left: 5px;
            }

            @media (max-width: 600px) {
                .rating-row {
                    flex-wrap: wrap;
                }

                .rating-label {
                    width: 70px;
                    font-size: 14px;
                }

                .rating-count {
                    width: 80px;
                    font-size: 13px;
                }
            }
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

            .btn-outline-brown {
                color: var(--brown-secondary);
                border-color: var(--brown-light);
                background-color: white;
            }

            .btn-outline-brown:hover {
                background-color: var(--brown-very-light);
                color: var(--brown-dark);
                border-color: var(--brown-secondary);
            }

            .btn-check:checked + .btn-outline-brown {
                background-color: var(--brown-primary);
                color: white;
                border-color: var(--brown-primary);
            }

            .brown-focus:focus {
                border-color: var(--brown-light);
                box-shadow: 0 0 0 0.25rem rgba(139, 90, 43, 0.25);
            }

            .feedback-form {
                border-color: var(--brown-light);
                background-color: white;
                border-radius: 10px;
            }

            .input-group-text {
                border: none;
            }

            .form-control {
                border: 1px solid #E5D3B9;
            }

            .rating-stars .btn {
                min-width: 45px;
            }

            /* Better hover effect for stars */
            .rating-stars .btn-outline-brown:hover {
                transform: scale(1.1);
            }


            .rating-stars {
                display: flex;
                flex-direction: row-reverse;
            }

            .rating-stars .star {
                font-size: 24px;
                color: #ccc;
                cursor: pointer;
                transition: color 0.2s;
            }

            .rating-stars .star:hover,
            .rating-stars .star.hovered,
            .rating-stars .star.selected {
                color: gold;
            }


            .review_image1 img {
                width: 100px;
                height: 100px;
                object-fit: cover;
            }

            .review_reply {
                margin-top: 10px;
                padding: 10px;
                background-color: #f9f9f9;
                border-left: 3px solid #007bff;
                border-radius: 5px;
            }

            .reply_header {
                font-weight: bold;
                color: #333;
                display: flex;
                justify-content: space-between;
                font-size: 14px;
            }

            .reply_text {
                margin-top: 5px;
                font-size: 14px;
                color: #555;
            }

            .admin-badge {
                font-size: 0.8rem;
                background-color: var(--brown-primary);
            }

            .reply-content {
                position: relative;
                background-color: var(--brown-very-light) !important;
            }

            .reply-content:before {
                content: "";
                position: absolute;
                top: -8px;
                left: 20px;
                border-left: 8px solid transparent;
                border-right: 8px solid transparent;
                border-bottom: 8px solid white;
            }

            .brown-focus:focus {
                border-color: var(--brown-light);
                box-shadow: 0 0 0 0.25rem rgba(139, 90, 43, 0.25);
            }

            .border-brown {
                border-color: var(--brown-primary) !important;
            }

            .admin-reply {
                animation: fadeIn 0.5s ease;
            }

            @keyframes fadeIn {
                from {
                    opacity: 0;
                    transform: translateY(10px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

        </style>
        <div class="super_container">


            <!-- Header -->

            <%@ include file="header.jsp" %>


            <!-- Menu -->

            <%@ include file="menu.jsp" %>

            <c:set var="currentUser" value="${sessionScope.acc}" />

            <!-- Home -->

            <div class="home">
                <div class="home_background parallax-window" data-parallax="scroll" data-image-src="P_images/categories.jpg" data-speed="0.8"></div>
                <div class="container">
                    <div class="row">
                        <div class="col">
                            <div class="home_container">
                                <div class="home_content">
                                    <div class="home_title">Đánh giá sản phẩm</div>
                                    <div class="breadcrumbs">
                                        <ul>
                                            <li><a href="ProductListServlet">Home</a></li>
                                            <li><a href="categories.jsp">Danh sách sản phẩm</a></li>
                                            <li><a href="javascript:history.back()">Sản phẩm chi tiết</a></li>
                                            <li>Xem phản hồi</li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Product -->

            <div class="product">
                <div class="container">
                    <div class="row">
                        <div class="col">
                            <div class="current_page">
                                <ul>
                                    <li><a href="categories.jsp">Danh sách sản phẩm</a></li>
                                    <li><a href="javascript:history.back()">${productDetail.productName}</a></li>
                                    <li>Xem phản hồi</li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="row product_row">

                        <!-- Product Image -->
                        <div class="col-lg-7">
                            <div class="product_image">
                                <div class="product_image_large">
                                    <!-- Use the dynamic product image -->
                                    <img src="${productDetail.image}" alt="${productDetail.productName}">
                                </div>
                                <!-- Optionally, add thumbnails if available -->
                            </div>
                        </div>

                        <!-- Product Content -->
                        <div class="col-lg-5">
                            <div class="product_content">
                                <!-- Dynamic product name -->
                                <div class="product_name">${productDetail.productName}</div>
                                <!-- Dynamic product price (format as needed) -->
                                <div class="product_price">${productDetail.price} VND</div>
                                <div class="rating rating_4" data-rating="4">
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                </div>
                                <!-- In Stock -->
                                <div class="in_stock_container">
                                    <div class="in_stock in_stock_true"></div>
                                    <span>còn hàng</span>
                                </div>
                                <!-- Dynamic product description -->
                                <div class="product_text">
                                    <p>${productDetail.description}</p>
                                </div>
                                <!-- Display product details such as size and color -->
                                <div class="product_details">
                                    <p><strong>Kích cỡ:</strong> ${productDetail.size}</p>
                                    <p><strong>Màu:</strong> ${productDetail.color}</p>
                                </div>

                                <div class="button cart_button">
                                    <a href="javascript:history.back()">Quay lại</a>
                                </div>
                            </div>
                        </div>
                    </div>





                    <!-- Review Statistics Section -->
                    <div class="container">
                        <div class="card shadow-sm p-4 mb-5">
                            <h2 class="mb-4 fw-bold">Đánh giá tổng quan</h2>

                            <!-- Star Distribution -->
                            <div class="mb-4">
                                <!-- 5 Stars -->
                                <div class="row mb-2 align-items-center">
                                    <div class="col-md-2 col-3">
                                        <span class="text-warning"><i class="bi bi-star-fill"></i> 5 sao</span>
                                    </div>
                                    <div class="col-md-8 col-7">
                                        <div class="progress" style="height: 10px;">
                                            <div class="progress-bar bg-success" role="progressbar" 
                                                 style="width: calc(${stats.fiveStar} / ${stats.totalReviews} * 100%);" 
                                                 aria-valuenow="${stats.fiveStar}" aria-valuemin="0" aria-valuemax="${stats.totalReviews}">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-2 col-2 text-end">
                                        <small class="text-muted">${stats.fiveStar}</small>
                                    </div>
                                </div>

                                <!-- 4 Stars -->
                                <div class="row mb-2 align-items-center">
                                    <div class="col-md-2 col-3">
                                        <span class="text-warning"><i class="bi bi-star-fill"></i> 4 sao</span>
                                    </div>
                                    <div class="col-md-8 col-7">
                                        <div class="progress" style="height: 10px;">
                                            <div class="progress-bar bg-success" role="progressbar" 
                                                 style="width: calc(${stats.fourStar} / ${stats.totalReviews} * 100%);" 
                                                 aria-valuenow="${stats.fourStar}" aria-valuemin="0" aria-valuemax="${stats.totalReviews}">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-2 col-2 text-end">
                                        <small class="text-muted">${stats.fourStar}</small>
                                    </div>
                                </div>

                                <!-- 3 Stars -->
                                <div class="row mb-2 align-items-center">
                                    <div class="col-md-2 col-3">
                                        <span class="text-warning"><i class="bi bi-star-fill"></i> 3 sao</span>
                                    </div>
                                    <div class="col-md-8 col-7">
                                        <div class="progress" style="height: 10px;">
                                            <div class="progress-bar bg-warning" role="progressbar" 
                                                 style="width: calc(${stats.threeStar} / ${stats.totalReviews} * 100%);" 
                                                 aria-valuenow="${stats.threeStar}" aria-valuemin="0" aria-valuemax="${stats.totalReviews}">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-2 col-2 text-end">
                                        <small class="text-muted">${stats.threeStar}</small>
                                    </div>
                                </div>

                                <!-- 2 Stars -->
                                <div class="row mb-2 align-items-center">
                                    <div class="col-md-2 col-3">
                                        <span class="text-warning"><i class="bi bi-star-fill"></i> 2 sao</span>
                                    </div>
                                    <div class="col-md-8 col-7">
                                        <div class="progress" style="height: 10px;">
                                            <div class="progress-bar bg-warning" role="progressbar" 
                                                 style="width: calc(${stats.twoStar} / ${stats.totalReviews} * 100%);" 
                                                 aria-valuenow="${stats.twoStar}" aria-valuemin="0" aria-valuemax="${stats.totalReviews}">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-2 col-2 text-end">
                                        <small class="text-muted">${stats.twoStar}</small>
                                    </div>
                                </div>

                                <!-- 1 Star -->
                                <div class="row mb-2 align-items-center">
                                    <div class="col-md-2 col-3">
                                        <span class="text-warning"><i class="bi bi-star-fill"></i> 1 sao</span>
                                    </div>
                                    <div class="col-md-8 col-7">
                                        <div class="progress" style="height: 10px;">
                                            <div class="progress-bar bg-danger" role="progressbar" 
                                                 style="width: calc(${stats.oneStar} / ${stats.totalReviews} * 100%);" 
                                                 aria-valuenow="${stats.oneStar}" aria-valuemin="0" aria-valuemax="${stats.totalReviews}">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-2 col-2 text-end">
                                        <small class="text-muted">${stats.oneStar}</small>
                                    </div>
                                </div>
                            </div>

                            <!-- Average Rating -->
                            <div class="text-center p-3 bg-light rounded">
                                <div class="mb-2">
                                    <c:set var="fullStars" value="${Math.floor(stats.averageStars)}" />
                                    <c:set var="hasHalfStar" value="${stats.averageStars % 1 >= 0.5}" />

                                    <c:forEach begin="1" end="5" var="i">
                                        <c:choose>
                                            <c:when test="${i <= fullStars}">
                                                <i class="bi bi-star-fill text-warning fs-4"></i>
                                            </c:when>
                                            <c:when test="${i == fullStars + 1 && hasHalfStar}">
                                                <i class="bi bi-star-half text-warning fs-4"></i>
                                            </c:when>
                                            <c:otherwise>
                                                <i class="bi bi-star text-warning fs-4"></i>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                </div>
                                <h4 class="mb-0">${stats.averageStars} <span class="text-muted fs-6">trên 5</span></h4>
                                <p class="text-muted mb-0">${stats.totalReviews} lượt đánh giá</p>
                            </div>
                        </div>
                    </div>
                    <!-- Reviews -->

                    <div class="row">
                        <div class="col">
                            <div class="reviews">
                                <div class="reviews_title">Phản hồi</div>
                                <div class="reviews_container">
                                    <ul>
                                        <c:choose>
                                            <c:when test="${not empty feedbacks}">
                                                <c:forEach var="feedback" items="${feedbacks}">
                                                    <!-- Review -->
                                                    <li class="review clearfix">
                                                        <div class="review_content">
                                                            <div class="review_name">
                                                                <a href="#">${feedback.accountName}</a>
                                                            </div>
                                                            <div class="review_date">
                                                                <fmt:formatDate value="${feedback.date}" pattern="dd/MM/yyyy" />
                                                            </div>
                                                            <div class="rating review_rating" data-rating="${feedback.rateStar}">
                                                                <c:forEach var="i" begin="1" end="5">
                                                                    <c:choose>
                                                                        <c:when test="${i <= feedback.rateStar}">
                                                                            <i class="fa fa-star" style="color: gold;"></i>  
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <i class="fa fa-star-o"></i> 
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </c:forEach>
                                                            </div>
                                                            <div class="review_image1">
                                                                <img src="img/${feedback.imageURL}" alt="">
                                                            </div>
                                                            <div class="review_text">
                                                                <p>${feedback.feedback}</p>
                                                            </div>


                                                            <div class="mt-3">
                                                                <c:if test="${not empty feedback.feedbackReply}">
                                                                    <div class="admin-reply mt-2 ms-md-4 ms-2">
                                                                        <div class="d-flex align-items-center mb-2">
                                                                            <div class="admin-badge bg-brown text-white px-2 py-1 rounded-pill me-2">
                                                                                <i class="bi bi-person-check-fill me-1"></i>Dịch vụ chăm sóc khách hàng
                                                                            </div>
                                                                            <small class="text-muted">
                                                                                <i class="bi bi-clock me-1"></i>${feedback.feedbackReply.replyDate}
                                                                            </small>
                                                                        </div>
                                                                        <div class="reply-content p-3 bg-white rounded shadow-sm border-start border-3 border-brown">
                                                                            <p class="mb-0">${feedback.feedbackReply.replyText}</p>
                                                                        </div>
                                                                    </div>
                                                                </c:if>

                                                                <c:if test="${empty feedback.feedbackReply}">
                                                                    <c:if test="${currentUser != null and (currentUser.role eq 'admin' or currentUser.role eq 'staff')}">
                                                                        <div class="reply-form mt-3 ms-md-4 ms-2">
                                                                            <form action="ReplyFeedbackController" method="post">
                                                                                <input type="hidden" name="feedbackID" value="${feedback.feedbackID}">
                                                                                <input type="hidden" name="productId" value="${param.productId}">
                                                                                <div class="input-group">
                                                                                    <span class="input-group-text bg-brown text-white border-0">
                                                                                        <i class="bi bi-reply-fill"></i>
                                                                                    </span>
                                                                                    <textarea name="replyText" class="form-control brown-focus" rows="2" 
                                                                                              placeholder="Nhập phản hồi của bạn" required></textarea>
                                                                                    <button type="submit" class="btn btn-brown">
                                                                                        <i class="bi bi-send-fill me-1"></i>Gửi
                                                                                    </button>
                                                                                </div>
                                                                                <div class="form-text text-muted small">
                                                                                    <i class="bi bi-info-circle me-1"></i>Tin nhắn này sẽ được để dưới dạng công khai
                                                                                </div>
                                                                            </form>
                                                                        </div>
                                                                    </c:if>
                                                                </c:if>
                                                            </div>


                                                        </div>
                                                    </li>
                                                </c:forEach>
                                            </c:when>
                                            <c:otherwise>
                                                <li>No Feedback</li>
                                                </c:otherwise>
                                            </c:choose>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>

                    <c:if test="${currentUser != null && currentUser.role == 'Customer'}">

                        <div class="feedback-form card p-4 mt-4 shadow">
                            <h3 class="mb-4 fw-bold text-brown">Để lại phản hồi của bạn</h3>
                            <form action="submitFeedback" method="post" enctype="multipart/form-data">
                                <!-- Upload Image -->
                                <div class="mb-3">
                                    <label class="form-label fw-medium text-brown">Đăng ảnh</label>
                                    <div class="input-group">
                                        <label for="photo" class="btn btn-brown">
                                            <i class="bi bi-upload me-2"></i> Chọn ảnh
                                        </label>
                                        <input type="file" id="photo" name="photo" required accept="image/*" 
                                               class="d-none" onchange="previewImage(event)">
                                    </div>
                                    <div class="mt-3 text-center">
                                        <img id="imagePreview" src="#" alt="Image Preview" class="img-thumbnail d-none" 
                                             style="max-width: 200px; max-height: 200px;">
                                    </div>
                                </div>


                                <input type="hidden" name="productId" value="${param.productId}">


                                <!-- Star Rating -->
                                <div class="mb-4">
                                    <label class="form-label fw-medium text-brown">Đánh giá:</label>
                                    <div class="rating-stars d-flex flex-row-reverse justify-content-end">
                                        <input type="radio" id="star5" name="rateStar" value="5" class="btn-check">
                                        <label for="star5" class="star" data-value="5"><i class="bi bi-star-fill"></i></label>

                                        <input type="radio" id="star4" name="rateStar" value="4" class="btn-check">
                                        <label for="star4" class="star" data-value="4"><i class="bi bi-star-fill"></i></label>

                                        <input type="radio" id="star3" name="rateStar" value="3" class="btn-check">
                                        <label for="star3" class="star" data-value="3"><i class="bi bi-star-fill"></i></label>

                                        <input type="radio" id="star2" name="rateStar" value="2" class="btn-check">
                                        <label for="star2" class="star" data-value="2"><i class="bi bi-star-fill"></i></label>

                                        <input type="radio" id="star1" name="rateStar" value="1" class="btn-check">
                                        <label for="star1" class="star" data-value="1"><i class="bi bi-star-fill"></i></label>
                                    </div>
                                    <div class="text-muted small mt-1">
                                        Đánh giá của bạn: <span id="selected-rating">0</span> sao
                                    </div>
                                </div>


                                <!-- Feedback -->
                                <div class="mb-4">
                                    <label class="form-label fw-medium text-brown">Bình luận:</label>
                                    <textarea name="feedback" class="form-control brown-focus" rows="4" required></textarea>
                                </div>

                                <!-- Submit Button -->
                                <button type="submit" class="btn btn-brown w-100 py-2 fw-medium">
                                    <i class="bi bi-send-fill me-2"></i>Gửi phản hồi
                                </button>
                            </form>
                        </div>
                    </c:if>



                </div>		
            </div>

            <!-- Footer -->

            <footer class="footer">
                <div class="container">
                    <div class="row">
                        <div class="col text-center">
                            <div class="footer_logo"><a href="ProductListServlet">Estée Lauder</a></div>
                            <nav class="footer_nav">
                                <ul>
                                    <li><a href="ProductListServlet">Trang chủ</a></li>
                                    <li><a href="categories.html">Chăm sóc da</a></li>
                                    <li><a href="categories.html">Trang điểm</a></li>
                                    <li><a href="categories.html">Nước hoa</a></li>
                                    <li><a href="contact.html">Chăm sóc mắt</a></li>
                                </ul>
                            </nav>
                            <div class="footer_social">
                                <ul>
                                    <li><a href="#"><i class="fa fa-pinterest" aria-hidden="true"></i></a></li>
                                    <li><a href="#"><i class="fa fa-linkedin" aria-hidden="true"></i></a></li>
                                    <li><a href="#"><i class="fa fa-instagram" aria-hidden="true"></i></a></li>
                                    <li><a href="#"><i class="fa fa-reddit-alien" aria-hidden="true"></i></a></li>
                                    <li><a href="#"><i class="fa fa-twitter" aria-hidden="true"></i></a></li>
                                </ul>
                            </div>
                            <div class="copyright"><!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
                                Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved | This template is made with <i class="fa fa-heart-o" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">Colorlib</a>
                                <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. --></div>
                        </div>
                    </div>
                </div>
            </footer>
        </div>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Include Bootstrap Icons -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css" rel="stylesheet">
        <script src="js/jquery-3.2.1.min.js"></script>
        <script src="styles/bootstrap4/popper.js"></script>
        <script src="styles/bootstrap4/bootstrap.min.js"></script>
        <script src="plugins/easing/easing.js"></script>
        <script src="plugins/parallax-js-master/parallax.min.js"></script>
        <script src="js/product_custom.js"></script>
        <script>

                                    document.addEventListener("DOMContentLoaded", function () {
                                        const stars = document.querySelectorAll(".rating-stars .star");
                                        const ratingDisplay = document.getElementById("selected-rating");
                                        let selectedRating = 0;

                                        stars.forEach(star => {
                                            star.addEventListener("mouseover", function () {
                                                highlightStars(this.dataset.value);
                                            });

                                            star.addEventListener("mouseout", function () {
                                                highlightStars(selectedRating);
                                            });

                                            star.addEventListener("click", function () {
                                                selectedRating = this.dataset.value;
                                                ratingDisplay.textContent = selectedRating;
                                            });
                                        });

                                        function highlightStars(rating) {
                                            stars.forEach(star => {
                                                if (star.dataset.value <= rating) {
                                                    star.classList.add("hovered");
                                                } else {
                                                    star.classList.remove("hovered");
                                                }
                                            });
                                        }
                                    });


                                    function previewImage(event) {
                                        const input = event.target;
                                        const preview = document.getElementById('imagePreview');

                                        if (input.files && input.files[0]) {
                                            const reader = new FileReader();
                                            reader.onload = function (e) {
                                                preview.src = e.target.result;
                                                preview.classList.remove('d-none');
                                            };
                                            reader.readAsDataURL(input.files[0]);
                                        }
                                    }
        </script>
    </body>
</html>