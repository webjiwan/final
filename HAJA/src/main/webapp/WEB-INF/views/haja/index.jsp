<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="include/header.jsp"%>

<meta content="" name="description">
<meta content="" name="keywords">

<!-- Google Fonts -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Open+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,600;1,700&family=Montserrat:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&family=Raleway:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&display=swap"
	rel="stylesheet">

<!-- Vendor CSS Files -->
<link href="/resources/assets/vendor/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="/resources/assets/vendor/bootstrap-icons/bootstrap-icons.css"
	rel="stylesheet">
<link href="/resources/assets/vendor/aos/aos.css" rel="stylesheet">
<link href="/resources/assets/vendor/glightbox/css/glightbox.min.css"
	rel="stylesheet">
<link href="/resources/assets/vendor/swiper/swiper-bundle.min.css"
	rel="stylesheet">

<!-- Template Main CSS File -->
<link href="/resources/assets/css/main.css" rel="stylesheet">
<link href="/resources/assets/css/theme.css" rel="stylesheet" media="all">

<!-- =======================================================
  * Template Name: Impact - v1.1.1
  * Template URL: https://bootstrapmade.com/impact-bootstrap-business-website-template/
  * Author: BootstrapMade.com
  * License: https://bootstrapmade.com/license/
  ======================================================== -->
</head>

<body>

	<%@ include file="include/body_header.jsp"%>

	<!-- ======= Hero Section ======= -->
	<section id="hero" class="hero" style="padding: 90px 0 0; background-color: #43bc9c;">
		<div class="container position-relative">
			<div class="row gy-5" data-aos="fade-in">
				<div
					class="col-lg-6 order-2 order-lg-1 d-flex flex-column justify-content-center text-center text-lg-start">
					<h2>
						<span>HAJA</span>에 오신걸 환영합니다
					</h2>
					<p>
						<span style="color: #e7e7e7;">HAJA는 사용자끼리 원하는 스포츠를 함께 즐길수 있도록 도와주는 사이트입니다</span>
					</p>
					<div class="d-flex justify-content-center justify-content-lg-start">
						<span class="btn-get-started" style="font-size: 20px; color: #efefef;">
							모집글 : <span style="font-weight: bold; color: white;">${map.isrec_count_all}</span>개
						</span>
					</div>
				</div>
				<div class="col-lg-6 order-1 order-lg-2" align="center">
					<img src="${path}/resources/assets/brand/main_illust.jpg" width="85%" height="85%"
						class="img-fluid" alt="" data-aos="zoom-out" data-aos-delay="100">
				</div>
			</div>
		</div>

		<div class="icon-boxes position-relative">
			<div class="container position-relative">
				<div class="row gy-4" style="margin-top: 0px;">

					<div class="col-xl-3 col-md-6" data-aos="fade-up" data-aos-delay="100">
						<div class="icon-box" style="background-color: #43bc9c; padding: 30px;">
							<div class="icon">
								<i>
									<img src="${path}/resources/assets/brand/football.png" width="80" height="80">
								</i>
							</div>
							<h4 class="title">
								<a href="${path}/board/list.do?category=soccer"
									class="stretched-link">축구</a>
							</h4>
							<span class="btn-get-started">모집글 :
								${map.isrec_count_soccer}개</span>
						</div>
					</div>
					<!--End Icon Box -->

					<div class="col-xl-3 col-md-6" data-aos="fade-up" data-aos-delay="200">
						<div class="icon-box" style="background-color: #43bc9c; padding: 30px;">
							<div class="icon">
								<i><img src="${path}/resources/assets/brand/basket.png"
									width="80" height="80"></i>
							</div>
							<h4 class="title">
								<a href="${path}/board/list.do?category=basketball"
									class="stretched-link">농구</a>
							</h4>
							<span class="btn-get-started">모집글 :
								${map.isrec_count_basketball}개</span>
						</div>
					</div>
					<!--End Icon Box -->

					<div class="col-xl-3 col-md-6" data-aos="fade-up" data-aos-delay="300">
						<div class="icon-box" style="background-color: #43bc9c; padding: 30px;">
							<div class="icon">
								<i><img src="${path}/resources/assets/brand/baseball.png"
									width="80" height="80"></i>
							</div>
							<h4 class="title">
								<a href="${path}/board/list.do?category=baseball"
									class="stretched-link">야구</a>
							</h4>
							<span class="btn-get-started">모집글 :
								${map.isrec_count_baseball}개</span>
						</div>
					</div>
					<!--End Icon Box -->

					<div class="col-xl-3 col-md-6" data-aos="fade-up" data-aos-delay="500">
						<div class="icon-box" style="background-color: #43bc9c; padding: 30px;">
							<div class="icon">
								<i>
									<img src="${path}/resources/assets/brand/etc.png" width="80" height="80">
								</i>
							</div>
							<h4 class="title">
								<a href="${path}/board/list.do?category=etc"
									class="stretched-link">기타</a>
							</h4>
							<span class="btn-get-started">모집글 :
								${map.isrec_count_etc}개</span>
						</div>
					</div>
					<!--End Icon Box -->

				</div>
			</div>
		</div>

		</div>
	</section>
	<!-- End Hero Section -->
	<!-- ======= Footer ======= -->
	<footer id="footer" class="footer" style="background-color: #43bc9c;">

		<div class="container mt-4">
			<div class="copyright">
				&copy; Copyright <strong><span>Impact</span></strong>. All Rights Reserved
			</div>
			<div class="credits">
				Designed by <span style="font-weight: bold; font-size: 15px;">I들</span>
			</div>
		</div>

	</footer>
	<!-- End Footer -->
	<!-- End Footer -->

	<a href="#"
		class="scroll-top d-flex align-items-center justify-content-center"><i
		class="bi bi-arrow-up-short"></i></a>

	<div id="preloader"></div>

	<!-- Vendor JS Files -->
	<script
		src="/resources/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
	<script src="/resources/assets/vendor/aos/aos.js"></script>
	<script src="/resources/assets/vendor/glightbox/js/glightbox.min.js"></script>
	<script
		src="/resources/assets/vendor/purecounter/purecounter_vanilla.js"></script>
	<script src="/resources/assets/vendor/swiper/swiper-bundle.min.js"></script>
	<script
		src="/resources/assets/vendor/isotope-layout/isotope.pkgd.min.js"></script>
	<script src="/resources/assets/vendor/php-email-form/validate.js"></script>

	<!-- Template Main JS File -->
	<%@ include file="include/body_js.jsp"%>
	<script src="/resources/assets/js/main.js"></script>

</body>

</html>