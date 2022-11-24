<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<!-- Required meta tags-->
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="au theme template">
<meta name="author" content="Hau Nguyen">
<meta name="keywords" content="au theme template">

<!-- Favicons -->
<link href="/resources/assets/brand/haja-logo.jpg" rel="icon">
<link href="/resources/assets/brand/haja-logo.jpg"
	rel="apple-touch-icon">

<!-- Title Page-->
<title>HAJA</title>

<!-- 2022-10-22 jquery -->
<script src="https://code.jquery.com/jquery-3.6.0.slim.js"></script>

<!-- 2022-10-22 Google Fonts -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link
	href="https://fonts.googleapis.com/css2?family=Open+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,600;1,700&family=Montserrat:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&family=Raleway:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&display=swap"
	rel="stylesheet">

<!-- Fontfaces CSS-->
<link href="/resources/assets/css/font-face.css" rel="stylesheet"
	media="all">
<link
	href="/resources/assets/vendor/font-awesome-4.7/css/font-awesome.min.css"
	rel="stylesheet" media="all">
<link
	href="/resources/assets/vendor/font-awesome-5/css/fontawesome-all.min.css"
	rel="stylesheet" media="all">
<link
	href="/resources/assets/vendor/mdi-font/css/material-design-iconic-font.min.css"
	rel="stylesheet" media="all">

<!-- Bootstrap CSS-->
<link
	href="/resources/assets/vendor/bootstrap-4.1/bootstrap.min.css"
	rel="stylesheet" media="all">

<!-- Vendor CSS-->
<link
	href="/resources/assets/vendor/animsition/animsition.min.css"
	rel="stylesheet" media="all">
<link
	href="/resources/assets/vendor/bootstrap-progressbar/bootstrap-progressbar-3.3.4.min.css"
	rel="stylesheet" media="all">
<link href="/resources/assets/vendor/wow/animate.css"
	rel="stylesheet" media="all">
<link
	href="/resources/assets/vendor/css-hamburgers/hamburgers.min.css"
	rel="stylesheet" media="all">
<link href="/resources/assets/vendor/slick/slick.css"
	rel="stylesheet" media="all">
<link href="/resources/assets/vendor/select2/select2.min.css"
	rel="stylesheet" media="all">
<link
	href="/resources/assets/vendor/perfect-scrollbar/perfect-scrollbar.css"
	rel="stylesheet" media="all">

<!-- Main CSS-->
<link href="/resources/assets/css/theme.css" rel="stylesheet"
	media="all">

<style type="text/css">/* Chart.js */
@
-webkit-keyframes chartjs-render-animation {
	from {opacity: 0.99
}

to {
	opacity: 1
}

}
@
keyframes chartjs-render-animation {
	from {opacity: 0.99
}

to {
	opacity: 1
}

}
.chartjs-render-monitor {
	-webkit-animation: chartjs-render-animation 0.001s;
	animation: chartjs-render-animation 0.001s;
}
</style>

<style type="text/css"> /* 2022-11-01 user-nav */
h2 {
	font-family: "Montserrat", sans-serif;
	margin-top: 0;
	margin-bottom: 0.5rem;
	font-weight: 500;
	line-height: 1.2;
	font-size: calc(1.325rem + .9vw);
}

@media all and (min-width: 1200px) {
	h2 {
		font-size: 2rem;
	}
}

.user-sub {
	position: relative;
}

.user-nav {
	padding-top: 5px;
	position: absolute;
	background: #fff;
	z-index: 3;
}

.ml40 {
	margin-left: 2vw;
}

.ml180 {
	margin-left: 8vw;
}

@media all and (max-width: 1200px) {
	.ml180 {
		margin-left: 5vw;
	}
}

.js-arrow {
	cursor: pointer;
}

.tal {
	text-align: left;
}

</style>