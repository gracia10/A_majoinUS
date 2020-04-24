<%@ page contentType="text/html; charset=UTF-8"%>
<html lang="en">
   <head>
   <style type="text/css">
   .parent{
  width: 100%;
  height: 100%;
  border: 1px solid #aaa;
  overflow: hidden;  
}    
.child{
  height: 100%;
  margin-right: -80px; /* maximum width of scrollbar */
  padding-right: 50px; /* maximum width of scrollbar */
  overflow-y: scroll;          
}    
   </style>
      <meta http-equiv="Content-Type" content="texxt/html; charset=utf-8">
      <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

      <title>A_majoinUs</title>
      <meta name="description" content="Free Bootstrap 4 Theme by ProBootstrap.com">
      <meta name="keywords" content="free website templates, free bootstrap themes, free template, free bootstrap, free website template">
    
    
    <link href="https://fonts.googleapis.com/css?family=Work+Sans:300,400,700" rel="stylesheet">
   <link rel="stylesheet" href="<%=request.getContextPath() %>/MainTemplate/css/bootstrap/bootstrap.css">
    <link rel="stylesheet" href="<%=request.getContextPath() %>/MainTemplate/css/animate.css">
    <link rel="stylesheet" href="<%=request.getContextPath() %>/MainTemplate/fonts/ionicons/css/ionicons.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath() %>/MainTemplate/css/owl.carousel.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath() %>/MainTemplate/fonts/flaticon/font/flaticon.css">
    <link rel="stylesheet" href="<%=request.getContextPath() %>/MainTemplate/fonts/fontawesome/css/font-awesome.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath() %>/MainTemplate/css/bootstrap-datepicker.css">
    <link rel="stylesheet" href="<%=request.getContextPath() %>/MainTemplate/css/select2.css">
    <link rel="stylesheet" href="<%=request.getContextPath() %>/MainTemplate/css/helpers.css">
    <link rel="stylesheet" href="<%=request.getContextPath() %>/MainTemplate/css/style.css">

   </head>
   
   <body>
  
<div class="parent">    
  <div class="child">

    <nav class="navbar navbar-expand-lg navbar-dark probootstrap_navbar" id="probootstrap-navbar">
      <div class="container">
      <!-- 위 메뉴 하이퍼 링크 -->
        <a class="navbar-brand" href="<%=request.getContextPath() %>/aus/main">A_majoinUs</a>    
        <button class="navbar-toggler"  type="button" data-toggle="collapse" data-target="#probootstrap-menu" aria-controls="probootstrap-menu" aria-expanded="false" aria-label="Toggle navigation">
          <span><i class="ion-navicon"></i></span>
        </button>  
        

       </div>
    </nav>  
    <!-- END nav -->
    

    <section class="probootstrap-cover overflow-hidden relative"  style="background-image: url('<%=request.getContextPath() %>/MainTemplate/images/bg_1.jpg');" data-stellar-background-ratio="0.5"  id="section-home">
      <div class="overlay"></div>
      <div class="container">
        <div class="row align-items-center">
          <div class="col-md">
            <h2 class="heading mb-2 display-4 font-light probootstrap-animate">Start your project, simpler and new!</h2>
            <p class="lead mb-5 probootstrap-animate">
              
                             
          </div>
          <div class="col-md-6 text-center probootstrap-animate">
            <form method="post" class="probootstrap-form probootstrap-form-box mb50" action="loginCheck">
           <h3>create you are project and team </h3>
           <h5 class="display-4 border-bottom probootstrap-section-heading"></h5>
           <h3></h3>
           
              <div class="form-group">
                <label for="email" class="sr-only sr-only-focusable">Id</label>
                <input type="email" class="form-control" id="Id" name="id" placeholder="Id">
              </div>
              
              <div class="form-group">
                <label for="message" class="sr-only sr-only-focusable">Password</label>
                <input type="password" class="form-control" id="Password" name="password" placeholder="Password">
              </div>  
                    
             <h6 style="color:red;" align="center">${msg}</h6>
             <div class="col-md-14 text-center">
              <div class="form-group">
                <input type="submit" class="btn btn-primary" id="login_submit" name="submit" value="Login">
       
              </div> 
              </div>
                
              <h3></h3> 
              <div class="col-md-12 text-center">
              Did you forget your <a href="findMain">ID</a> or <a href="findMain">password</a>?
             </div>
             <div class="col-md-12 text-center">
              Are you not a joinUs member yet? <a href="regist">Join a Member</a> 
             </div>  
            </form>
            <br><br>          
          </div>      
          
                 
             </div>    
          </div>            
       
           
             
    </section>
   </div>
   </div>  
    <!-- END section -->
    
    <script src="<%=request.getContextPath() %>/MainTemplate/js/jquery.min.js"></script>
    <script src="<%=request.getContextPath() %>/MainTemplate/js/popper.min.js"></script>
    <script src="<%=request.getContextPath() %>/MainTemplate/js/bootstrap.min.js"></script>
    <script src="<%=request.getContextPath() %>/MainTemplate/js/owl.carousel.min.js"></script>
    <script src="<%=request.getContextPath() %>/MainTemplate/js/bootstrap-datepicker.js"></script>
    <script src="<%=request.getContextPath() %>/MainTemplate/js/jquery.waypoints.min.js"></script>
    <script src="<%=request.getContextPath() %>/MainTemplate/js/jquery.easing.1.3.js"></script>
    <script src="<%=request.getContextPath() %>/MainTemplate/js/select2.min.js"></script>
    <script src="<%=request.getContextPath() %>/MainTemplate/js/main.js"></script>
  <script>
  var msg = "${msg}";
  if(msg == "REGISTERED"){
     alert("회원가입이 완료 되었습니다. 로그인 해주세요.");
  }else if (msg == "FAILURE"){
     alert("아이디와 비밀번호를 확인해 주세요.");
  }
  
  </script>
  
   </body>
</html>