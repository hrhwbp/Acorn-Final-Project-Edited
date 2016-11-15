<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<!DOCTYPE html">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>RE:MIND [READ MIND]</title>
<%@include file="common.jsp"%>

<script type="text/javascript">
   $(document).ready(function() {
      $("#showjoin").hide()
   })

   function login() {
      $("#showjoin").hide()
      $("#showlogin").show()
   }

   function join() {
      $("#showlogin").hide()
      $("#showjoin").show()
   }
</script>
</head>
<% 
String mno = (String)session.getAttribute("mno");
   
if (session.getAttribute("mno") != null){   
   response.sendRedirect("snslist");   
}
%>
<body class="center-block()">
   <div class="container main_pd">
      <div class="container col-md-5 col-md-offset-1">
         <div class="row">
            <img alt="Responsive image" src="resources/image/logo.png"
               class="img-rounded img-responsive">
         </div>
      </div>
      <div class="container col-md-5">
         <div class="row col-md-12" title="" id="showlogin"
            style="padding-top: 18%">
            <form class="form-signin" method="post" action="login   ">
               <h2 class="form-signin-heading text-center">로그인</h2>
               <div class="col-md-12">
                  <label for="inputEmail" class="sr-only">Email address</label> <input
                     type="email" id="inputEmail" class="form-control"
                     placeholder="Email address" name="m_email" required autofocus>
               </div>
               <div class="col-md-12 top_pd">
                  <label for="inputPassword" class="sr-only">Password</label> <input
                     type="password" id="inputPassword" class="form-control"
                     name="m_password" placeholder="Password" required>
               </div>
               <div class="col-md-12 top_pd">
                  <button class="btn btn-lg btn-primary btn-block" type="submit">로그인</button>
               </div>
            </form>
            <div class="col-md-12 top_pd">
               <button class="btn btn-lg btn-primary btn-block" type="button"
                  onclick="join()">회원가입</button>
            </div>
         </div>

         <!-- -------------------------------------- -->
         <div class="row col-md-12" id="showjoin">
            <form class="form-signin" action="join" method="post">
               <h2 class="form-signin-heading text-center">회원가입</h2>
               <div class="row-md-12">
                  <label for="inputEmail" class="sr-only">Email address</label> <input
                     name="m_email" type="email" id="inputEmail" class="form-control"
                     placeholder="Email address" required autofocus>
               </div>
               <div class="row-md-12 top_pd">
                  <label for="inputPassword" class="sr-only">Password</label> <input
                     type="password" id="inputPassword" class="form-control"
                     placeholder="Password" required>
               </div>
               <div class="row-md-12 top_pd">
                  <label for="passwordCheck" class="sr-only">PasswordCheck</label> <input
                     name="m_password" type="password" id="passwordCheck"
                     class="form-control" placeholder="PasswordCheck" required>
               </div>
               <div class="row-md-12 top_pd">
                  <label for="inputName" class="sr-only">Name</label> <input
                     name="m_name" type="text" class="form-control" id="inputName"
                     placeholder="Name" required>
               </div>
               <div class="row form-group">
                  <div class="col-md-4 top_pd text-right">
                     <label class="">년도</label>
                     
                     <jsp:useBean id="toDay" class="java.util.Date" />
                     <fmt:formatDate value="${toDay}" var = "viewYear" pattern="yyyy" />
                     <select class="form-control" name="year">
                        <c:forEach var="i" begin="0" end ="100" step="1">
                        <option>${viewYear -i }</option>
                        </c:forEach>

                     </select>
                  </div>

                  <div class="col-md-3 col-md-offset-2 top_pd text-right">
                     <label class="">월</label> <select class="form-control" name="month">
                        <c:forEach var="i" begin="1" end ="12" step="1">
                        <option>${i}</option>
                        </c:forEach>
                     </select>
                  </div>

                  <div class="col-md-3 top_pd text-right">
                     <label class="" for="ss">일</label> <select id="ss" name="day"
                        class="form-control" >
                        <c:forEach var="i" begin="1" end ="31" step="1">
                        <option>${i}</option>
                        </c:forEach>
                     </select>
                  </div>
               </div>
               <div class="row">
                  <label class="col-md-6">성별을 선택해주세요</label>
                  <div class="col-md-4 col-md-offset-2">
                     <label class="radio-inline"> <input type="radio"
                        name="m_gender" id="inlineRadio1" value="1">
                        남
                     </label> <label class="radio-inline"> <input type="radio"
                        name="m_gender" id="inlineRadio2" value="2">
                        여
                     </label>
                  </div>
               </div>
               <div class="row-md-12 top_pd">
                  <button class="btn btn-lg btn-primary btn-block" type="submit">가입완료</button>
               </div>
            </form>
            <div class="row-md-12 text-right">
               아이디가 있으십니까? &nbsp; <a href="javascript:login()">로그인</a>
            </div>

         </div>
      </div>
   </div>
   
   <%@include file="bottom.jsp"%>
</body>
</html>