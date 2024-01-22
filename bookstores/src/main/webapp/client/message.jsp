<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html class="no-js" lang="zxx">
<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>EBooksStore</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
       <link rel="shortcut icon" type="image/x-icon" href="assets/img/icon.jpeg">

    <!-- CSS here -->
       <%@ include file="/includes/header.jsp"%>
</head>
<body>
   
 <header>
        <!-- Header Start -->
	
        <!-- Header End -->
<jsp:directive.include file="/includes/navbar.jsp" />
    </header>
    <main>
       <style>
       
      .text-center{
      
      margin:120px;
      }
       </style>
      <h3 class="text-center" style="color: red;">${message }</h3>
    </main>
    
    <!--? Search model Begin -->
    
  
<footer>
        <!-- Footer Start-->
    <%@ include file="/includes/footer.jsp"%>
        <!-- Footer End-->
    </footer>
    

</body>
    
</html>