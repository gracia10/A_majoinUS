<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="texxt/html; charset=utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>A_majoinUs</title>

<link
	href="https://fonts.googleapis.com/css?family=Work+Sans:300,400,700"
	rel="stylesheet">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/MainTemplate/css/bootstrap/bootstrap.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/MainTemplate/css/animate.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/MainTemplate/fonts/ionicons/css/ionicons.min.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/MainTemplate/css/owl.carousel.min.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/MainTemplate/fonts/flaticon/font/flaticon.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/MainTemplate/fonts/fontawesome/css/font-awesome.min.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/MainTemplate/css/bootstrap-datepicker.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/MainTemplate/css/select2.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/MainTemplate/css/helpers.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/MainTemplate/css/style.css">
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.4.2/css/all.css">

<script
	src="<%=request.getContextPath()%>/MainTemplate/js/jquery.min.js"></script>
<script
	src="<%=request.getContextPath()%>/MainTemplate/js/popper.min.js"></script>
<script
	src="<%=request.getContextPath()%>/MainTemplate/js/bootstrap.min.js"></script>
<script
	src="<%=request.getContextPath()%>/MainTemplate/js/owl.carousel.min.js"></script>
<script
	src="<%=request.getContextPath()%>/MainTemplate/js/jquery.waypoints.min.js"></script>
<script
	src="<%=request.getContextPath()%>/MainTemplate/js/jquery.easing.1.3.js"></script>
<script
	src="<%=request.getContextPath()%>/MainTemplate/js/select2.min.js"></script>
<script src="<%=request.getContextPath()%>/MainTemplate/js/main.js"></script>

<script src="http://code.jquery.com/jquery-3.1.0.min.js"></script>

</head>

<body>

	<!-- 맨위 로고 단 -->
	<nav class="navbar navbar-expand-lg navbar-dark probootstrap_navbar"
		id="probootstrap-navbar">
		<div class="container">
			<a class="navbar-brand" href="<%=request.getContextPath()%>/aus/main">A_majoinUs</a>
		</div>
	</nav>


	<!-- 아래 헤딩 사진단 -->
	<section class="probootstrap-cover overflow-hidden relative"
		style="background-image: url('<%=request.getContextPath()%>/MainTemplate/images/bg_1.jpg');"
		data-stellar-background-ratio="0.5" id="section-home">
		<div class="overlay"></div>
		<div class="container">
			<div class="row align-items-center text-center">
				<div class="col-md">
					<h2 class="heading mb-1 display-4 font-bold ">
						<i class="fas fa-dizzy"></i>
					</h2>
					<h2 class="heading mb-1 display-4 font-bold ">Oops!
						Something went wrong</h2>
					<h2 class="heading mb-1 display-4" style="font-size: x-large; padding-top: 10px;">${exception.message}</h2>
					<p class="lead mb-5 probootstrap-animate "></p>
				</div>
			</div>
		</div>
	</section>


	<section class="probootstrap_section" id="section-feature-testimonial"
		style="padding-top: 2em;">
		<div class="container">
			<div class="row justify-content-center mb-5">
				<a class="btn btn-primary"
					href="<%=request.getContextPath()%>/aus/main">메인으로</a>
			</div>
		</div>
	</section>

</body>
</html>