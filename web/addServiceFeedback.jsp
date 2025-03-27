<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Phản hồi về dịch vụ</title>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="description" content="Service Feedback Form">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" type="text/css" href="styles/bootstrap4/bootstrap.min.css">
        <link href="plugins/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
        <link rel="stylesheet" type="text/css" href="styles/product.css">
        <link rel="stylesheet" type="text/css" href="styles/product_responsive.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css" rel="stylesheet">
    </head>
    <body>
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
        </style>

        <div class="super_container">

            <!-- Header -->
            <%@ include file="header.jsp" %>

            <!-- Menu -->
            <%@ include file="menu.jsp" %>

            <!-- Home -->
            <div class="home">
                <div class="home_background parallax-window" data-parallax="scroll" data-image-src="P_images/categories.jpg" data-speed="0.8"></div>
                <div class="container">
                    <div class="row">
                        <div class="col">
                            <div class="home_container">
                                <div class="home_content">
                                    <div class="home_title">Phản hồi dịch vụ</div>
                                    <div class="breadcrumbs">
                                        <ul>
                                            <li><a href="ProductListServlet">Trang chủ</a></li>
                                            <li>Phản hồi dịch vụ</li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Feedback Form -->
            <div class="product">
                <div class="container">
                    <div class="row">
                        <div class="col">
                            <div class="feedback-form card p-4 mt-4 shadow">
                                <h3 class="mb-4 fw-bold text-brown">Để lại phản hồi về dịch vụ của chúng tôi</h3>
                                <form action="ServiceFeedbackURL" method="post" enctype="multipart/form-data">
                                    <input type="hidden" name="action" value="addFeedback">

                                    <!-- Upload Image -->
                                    <div class="mb-3">
                                        <label class="form-label fw-medium text-brown">Đăng ảnh (Tùy chọn)</label>
                                        <div class="input-group">
                                            <label for="imageURL" class="btn btn-brown">
                                                <i class="bi bi-upload me-2"></i> Chọn ảnh
                                            </label>
                                            <input type="file" id="imageURL" name="imageURL" accept="image/*" 
                                                   class="d-none" onchange="previewImage(event)">
                                        </div>
                                        <div class="mt-3 text-center">
                                            <img id="imagePreview" src="#" alt="Image Preview" class="img-thumbnail d-none" 
                                                 style="max-width: 200px; max-height: 200px;">
                                        </div>
                                    </div>

                                    <!-- Star Rating -->
                                    <div class="mb-4">
                                        <label class="form-label fw-medium text-brown">Đánh giá tổng quát:</label>
                                        <div class="rating-stars d-flex flex-row-reverse justify-content-end">
                                            <input type="radio" id="star5" name="rateStar" value="5" class="btn-check" required>
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

                                    <!-- Feedback Text -->
                                    <div class="mb-4">
                                        <label class="form-label fw-medium text-brown">Nội dung phản hồi:</label>
                                        <textarea name="feedbackText" class="form-control brown-focus" rows="4" 
                                                  placeholder="Nhập phản hồi của bạn tại đây..." required></textarea>
                                    </div>

                                    <!-- Submit Button -->
                                    <button type="submit" class="btn btn-brown w-100 py-2 fw-medium">
                                        <i class="bi bi-send-fill me-2"></i>Gửi phản hồi
                                    </button>
                                </form>

                                <!-- Back Button -->
                                <div class="mt-3">
                                    <a href="javascript:history.back()" class="btn btn-outline-brown w-100 py-2">
                                        <i class="bi bi-arrow-left me-2"></i>Quay lại
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
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
                            <div class="copyright">
                                Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved | This template is made with <i class="fa fa-heart-o" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">Colorlib</a>
                            </div>
                        </div>
                    </div>
                </div>
            </footer>
        </div>

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