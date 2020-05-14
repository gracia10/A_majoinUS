<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>

<script src="<%=request.getContextPath() %>/resources/bower_components/jquery/dist/jquery.min.js"></script>
<script src="<%=request.getContextPath() %>/resources/bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
<script src="<%=request.getContextPath() %>/resources/dist/js/adminlte.min.js"></script>

           
                   
<!--
This is a starter template page. Use this page to start your new project from
scratch. This page gets rid of all links and provides the needed markup only.
-->
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>A_majoinUs | my_Project</title>
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
  <link rel="stylesheet" href="<%=request.getContextPath() %>/resources/bower_components/bootstrap/dist/css/bootstrap.min.css">
  <link rel="stylesheet" href="<%=request.getContextPath() %>/resources/bower_components/font-awesome/css/font-awesome.min.css">
  <link rel="stylesheet" href="<%=request.getContextPath() %>/resources/bower_components/Ionicons/css/ionicons.min.css">
  <link rel="stylesheet" href="<%=request.getContextPath() %>/resources/dist/css/AdminLTE.min.css">
  <link rel="stylesheet" href="<%=request.getContextPath() %>/resources/dist/css/skins/skin-black.min.css">

<link href="https://fonts.googleapis.com/css?family=Roboto:100,100i,300,400,600,700,300i,400i,600i" rel="stylesheet"></head>

<body class="hold-transition skin-black sidebar-mini">
<!-- sidebar-collapse -->
        
  <!-- Main Header -->
  <header class="main-header">
    
 <!-- Logo -->
<a href="<%=request.getContextPath() %>/aus/main" class="logo">
      <!-- mini logo for sidebar mini 50x50 pixels -->
      <span class="logo-mini"><b>A</b>US</span>    
      <!-- logo for regular state and mobile devices -->
      <span class="logo-lg"><b>A_majoin</b>Us</span>
    </a>

    <!-- Header Navbar -->
    <nav class="navbar navbar-static-top" role="navigation">
      <!-- Sidebar toggle button-->
      <a href="#" class="sidebar-toggle" data-toggle="push-menu" role="button">
        <span class="sr-only">Toggle navigation</span>
      </a>
      
   <div class="navbar-custom-menu">
        <ul class="nav navbar-nav">
          
          <!-- User Account Menu -->
          <li class="dropdown user user-menu">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
              <img src="<%=request.getContextPath() %>/aus/userImg/${sessionScope.userphoto}" class="user-image" alt="User Image">
              <span class="hidden-xs">${sessionScope.name }</span>
            </a>
            <ul class="dropdown-menu">
              <!-- The user image in the menu -->
              <li class="user-header">
                <img src="<%=request.getContextPath() %>/aus/userImg/${sessionScope.userphoto}" class="img-circle" alt="User Image">

                <p>
                  Welcome! ${sessionScope.name }
                </p>
              </li>
              
              <!-- Menu Footer-->
              <li class="user-footer">
                <div class="pull-left">
                  <a href="<%=request.getContextPath() %>/aus/Pw" class="btn btn-default btn-flat">Profile</a>
                </div>
                <div class="pull-right">
                  <a href="<%=request.getContextPath() %>/aus/logout" class="btn btn-default btn-flat">Sign out</a>
                </div>
              </li>
            </ul>
          </li>
          <!-- Control Sidebar Toggle Button -->
          <li>   
          <a href="#" data-toggle="control-sidebar"><i class="fa fa-fw fa-magic"></i></a>
          </li>
        </ul>
      </div>
    </nav>
  </header>
  
</body>
</html>