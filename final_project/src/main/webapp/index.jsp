<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE HTML">
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<meta name="description" content="">
<meta name="author" content="">
<link rel="icon" href="../../favicon.ico">

<title>RE:MIND [READ MIND]</title>

<!-- Bootstrap core CSS -->
<link href="resources/css/bootstrap.min.css"
   rel="stylesheet">

<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
<link
   href="http://getbootstrap.com/assets/css/ie10-viewport-bug-workaround.css"
   rel="stylesheet">

<!-- Just for debugging purposes. Don't actually copy these 2 lines! -->
<!--[if lt IE 9]><script src="../../assets/js/ie8-responsive-file-warning.js"></script><![endif]-->
<script
   src="http://getbootstrap.com/assets/js/ie-emulation-modes-warning.js"></script>

<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->

<!-- Custom styles for this template -->
<link href="resources/css/carousel.css" rel="stylesheet">

<script type="text/javascript">
/*    $(document).ready(function() {
      $("#showjoin").hide()
   })

   function login() {
      $("#showjoin").hide()
      $("#showlogin").show()
   }

   function join() {
      $("#showlogin").hide()
      $("#showjoin").show()
   } */
   
   function logsubmit(){
	   
	      $.ajax({
	           type:"post",
	           url:"loginsub",
	           data:$("#loginform").serialize(),
	           dataType:"text",
	           success:function(result){
	               if(result =="fail"){
	                  
	                 jQuery("#loginresult").html("로그인 정보가 틀렸습니다.");
	                 
	                 
	              }
	              else if(result == "success"){
	                 window.location.href = "snslist";
	              }
	           }
	        
	      });}
</script>

</head>
<!-- NAVBAR
================================================== -->
<body>
   <div class="navbar-wrapper">
      <div class="container">

         <nav class="navbar navbar-inverse navbar-static-top" style="background-color: white; opacity: 0.7">
            <div class="container" style="background-color: white;">
               <div class="navbar-header">
                  <button type="button" class="navbar-toggle collapsed"
                     data-toggle="collapse" data-target="#navbar"
                     aria-expanded="false" aria-controls="navbar">
                     <span class="sr-only">Toggle navigation</span> <span
                        class="icon-bar"></span> <span class="icon-bar"></span> <span
                        class="icon-bar"></span>
                  </button>
                  <a class="navbar-brand" href="index.jsp"><span
                     class="glyphicon glyphicon-gift" aria-hidden="true">
                        RE:MIND</span></a>
               </div>
               <div id="navbar" class="navbar-collapse collapse">
                  <ul class="nav navbar-nav">
                     <li><a href="snslist"><span
                           class="glyphicon glyphicon-home" aria-hidden="true"></span></a></li>
                     <li><a
                        href="showWishList?w_mno=<%=session.getAttribute("mno")%>"><span
                           class="glyphicon glyphicon-gift" aria-hidden="true"></span></a></li>
                     <li><a href="javascript:myinfo()"><span
                           class="glyphicon glyphicon-user" aria-hidden="true"></span></a></li>
                     <li class="dropdown"><a href="#" class="dropdown-toggle"
                        data-toggle="dropdown" role="button" aria-haspopup="true"
                        aria-expanded="false">Dropdown <span class="caret"></span></a>
                        <ul class="dropdown-menu">
                           <li><a href="#">Action</a></li>
                           <li><a href="#">Another action</a></li>
                           <li><a href="#">Something else here</a></li>
                           <li role="separator" class="divider"></li>
                           <li class="dropdown-header">Nav header</li>
                           <li><a href="#">Separated link</a></li>
                           <li><a href="#">One more separated link</a></li>
                        </ul></li>
                  </ul>
                  <ul class="nav navbar-nav navbar-right">
                     <li><a href="../navbar/">About</a></li>
                     <li><a href="../navbar-static-top/">Static top</a></li>
                     <%
                        if (session.getAttribute("mno") != null) {
                     %>
                     <li><a href="logout">LogOut <span class="sr-only">(current)</span></a></li>
                     <%
                        } else {
                     %>
                     <li><a href="login">LogIn <span class="sr-only">(current)</span></a></li>
                     <%
                        }
                     %>
                  </ul>
               </div>
            </div>
         </nav>

      </div>
   </div>


   <!-- Carousel
    ================================================== -->
   <div id="myCarousel" class="carousel slide" data-ride="carousel">
      <!-- Indicators -->
      <ol class="carousel-indicators">
         <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
         <li data-target="#myCarousel" data-slide-to="1"></li>
         <li data-target="#myCarousel" data-slide-to="2"></li>
      </ol>
      <div class="carousel-inner" role="listbox">
         <div class="item active">
            <img class="first-slide" src="resources/image/mainimg.jpg"
               alt="원하는 선물을 받는 즐거움 오늘부터 경험하세요" width="100%">
            <div class="container">
               <div class="carousel-caption">
                  <div class="input-group col-md-5 col-sm-12">
                     <h1>선물을 받는 즐거운 경험</h1><p/>
                     <p>오늘부터 내가 정말 원하는 선물을 받는 
                     <p>즐거움을 만끽하세요~</p>
                     <p>
                        <a class="btn btn-lg btn-danger" href="#about" role="button">알아보기</a>
                     </p>
                  </div>
                   <% if (session.getAttribute("mno") == null) { %>
                  <form id="loginform"> 
                  <div class="input-group col-md-5 col-sm-12">
                     <span class="input-group-addon" id="basic-addon1"><span
                        class="glyphicon glyphicon-user" aria-hidden="true"></span></span> <input
                        type="email" class="form-control" placeholder="이메일" name="m_email" required autofocus
                        id="inputEmail" aria-describedby="basic-addon1" required="required">
                     <!-- <span class="input-group-btn"><button class="btn btn-default" type="button"> 가 입</button></span> -->
                  </div>
                  <br>
                  <div class="input-group col-md-5 col-sm-12">
                     <span class="input-group-addon" id="basic-addon1"><span
                        class="glyphicon glyphicon-lock" aria-hidden="true"></span></span> <input
                        type="password" class="form-control" placeholder="비밀번호"
                        aria-describedby="basic-addon1" id="inputPassword"
                     name="m_password" required>
                  </div>
                  <div class="input-group col-md-5 col-sm-12">
						<br><br><a class="btn btn-lg btn-primary" role="button" onclick="logsubmit()">로그인</a><a class="btn btn-lg btn-success" href="#about" role="button">가입하기</a>                  
                  </div>                          
                  </form>
                  <%} else { %>
                  <br><br><br><br><br><br>
                  <%}  %>
                  <br>
                  <br>
                  <br>
                  <br>

               </div>
            </div>
         </div>
         <div class="item">
            <img class="second-slide" src="resources/image/childbox.jpg"
               alt="Second slide">
            <div class="container">
               <div class="carousel-caption">
                  <h1>상대를 생각한 선물</h1>
                  <p>지금까지는 가족, 친척, 친구들에게 어떤 선물을 해야하나 고민많으셨죠?</p>
                  <p>이제는 고민하지 말고 RE:MIND에서 찾아보세요! </p><br>
                  </p>
                     <a class="btn btn-lg btn-primary" href="#" role="button">Learn
                        more</a>
                  </p>
               </div>
            </div>
         </div>
         <div class="item">
            <img class="third-slide" src="resources/image/ladyopenbox.jpg"
               alt="Third slide">
            <div class="container">
               <div class="carousel-caption">
                  <h1>선물을 풀러볼 때의 만족감</h1><br>
                  <p>내 맘에 드는 선물이면 좋겠는데...</p>
                  <p>열어볼 때의 설레임, 기쁨! RE:MIND에서 경험하세요</p>
                  </p>                  
                     <a class="btn btn-lg btn-primary" href="#" role="button">Browse
                        gallery</a>
                  </p>
               </div>
            </div>
         </div>
      </div>
      <a class="left carousel-control" href="#myCarousel" role="button"
         data-slide="prev"> <span class="glyphicon glyphicon-chevron-left"
         aria-hidden="true"></span> <span class="sr-only">Previous</span>
      </a> <a class="right carousel-control" href="#myCarousel" role="button"
         data-slide="next"> <span
         class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
         <span class="sr-only">Next</span>
      </a>
   </div>
   <!-- /.carousel -->

   <!-- Marketing messaging and featurettes
    ================================================== -->
   <!-- Wrap the rest of the page in another container to center all the content. -->


   <div class="container marketing" id="about" style="padding-top: 100px;">
      <!-- Three columns of text below the carousel -->
      <div class="row">
         <div class="col-lg-4">
            <img class="img-circle"
               src="data:image/gif;base64,R0lGODlhAQABAIAAAHd3dwAAACH5BAAAAAAALAAAAAABAAEAAAICRAEAOw=="
               alt="Generic placeholder image" width="140" height="140">
            <h2>Heading</h2>
            <p>Donec sed odio dui. Etiam porta sem malesuada magna mollis
               euismod. Nullam id dolor id nibh ultricies vehicula ut id elit.
               Morbi leo risus, porta ac consectetur ac, vestibulum at eros.
               Praesent commodo cursus magna.</p>
            <p>
               <a class="btn btn-default" href="#" role="button">View details
                  &raquo;</a>
            </p>
         </div>
         <!-- /.col-lg-4 -->
         <div class="col-lg-4">
            <img class="img-circle"
               src="data:image/gif;base64,R0lGODlhAQABAIAAAHd3dwAAACH5BAAAAAAALAAAAAABAAEAAAICRAEAOw=="
               alt="Generic placeholder image" width="140" height="140">
            <h2>Heading</h2>
            <p>Duis mollis, est non commodo luctus, nisi erat porttitor
               ligula, eget lacinia odio sem nec elit. Cras mattis consectetur
               purus sit amet fermentum. Fusce dapibus, tellus ac cursus commodo,
               tortor mauris condimentum nibh.</p>
            <p>
               <a class="btn btn-default" href="#" role="button">View details
                  &raquo;</a>
            </p>
         </div>
         <!-- /.col-lg-4 -->
         <div class="col-lg-4">
            <img class="img-circle"
               src="data:image/gif;base64,R0lGODlhAQABAIAAAHd3dwAAACH5BAAAAAAALAAAAAABAAEAAAICRAEAOw=="
               alt="Generic placeholder image" width="140" height="140">
            <h2>Heading</h2>
            <p>Donec sed odio dui. Cras justo odio, dapibus ac facilisis in,
               egestas eget quam. Vestibulum id ligula porta felis euismod semper.
               Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum
               nibh, ut fermentum massa justo sit amet risus.</p>
            <p>
               <a class="btn btn-default" href="#" role="button">View details
                  &raquo;</a>
            </p>
         </div>
         <!-- /.col-lg-4 -->
      </div>
      <!-- /.row -->


      <!-- START THE FEATURETTES -->

      <hr class="featurette-divider">

      <div class="row featurette">
         <div class="col-md-7">
            <h2 class="featurette-heading">
               First featurette heading. <span class="text-muted">It'll
                  blow your mind.</span>
            </h2>
            <p class="lead">Donec ullamcorper nulla non metus auctor
               fringilla. Vestibulum id ligula porta felis euismod semper.
               Praesent commodo cursus magna, vel scelerisque nisl consectetur.
               Fusce dapibus, tellus ac cursus commodo.</p>
         </div>
         <div class="col-md-5">
            <img class="featurette-image img-responsive center-block"
               data-src="holder.js/500x500/auto" alt="Generic placeholder image">
         </div>
      </div>

      <hr class="featurette-divider">

      <div class="row featurette">
         <div class="col-md-7 col-md-push-5">
            <h2 class="featurette-heading">
               Oh yeah, it's that good. <span class="text-muted">See for
                  yourself.</span>
            </h2>
            <p class="lead">Donec ullamcorper nulla non metus auctor
               fringilla. Vestibulum id ligula porta felis euismod semper.
               Praesent commodo cursus magna, vel scelerisque nisl consectetur.
               Fusce dapibus, tellus ac cursus commodo.</p>
         </div>
         <div class="col-md-5 col-md-pull-7">
            <img class="featurette-image img-responsive center-block"
               data-src="holder.js/500x500/auto" alt="Generic placeholder image">
         </div>
      </div>

      <hr class="featurette-divider">

      <div class="row featurette">
         <div class="col-md-7">
            <h2 class="featurette-heading">
               And lastly, this one. <span class="text-muted">Checkmate.</span>
            </h2>
            <p class="lead">Donec ullamcorper nulla non metus auctor
               fringilla. Vestibulum id ligula porta felis euismod semper.
               Praesent commodo cursus magna, vel scelerisque nisl consectetur.
               Fusce dapibus, tellus ac cursus commodo.</p>
         </div>
         <div class="col-md-5">
            <img class="featurette-image img-responsive center-block"
               data-src="holder.js/500x500/auto" alt="Generic placeholder image">
         </div>
      </div>

      <hr class="featurette-divider">

      <!-- /END THE FEATURETTES -->


      <!-- FOOTER -->
      <footer>
         <p class="pull-right">
            <a href="#">Back to top</a>
         </p>
         <p>
            &copy; 2016 Company, Inc. &middot; <a href="#">Privacy</a> &middot;
            <a href="#">Terms</a>
         </p>
      </footer>

   </div>
   <!-- /.container -->


   <!-- Bootstrap core JavaScript
    ================================================== -->
   <!-- Placed at the end of the document so the pages load faster -->
   <script
      src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
   <script>
      window.jQuery
            || document
                  .write('<script src="http://getbootstrap.com/assets/js/vendor/holder.min.js"><\/script>')
   </script>
   <script src="http://getbootstrap.com/dist/js/bootstrap.min.js"></script>
   <!-- Just to make our placeholder images work. Don't actually copy the next line! -->
   <script src="http://getbootstrap.com/assets/js/vendor/holder.min.js"></script>
   <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
   <script
      src="http://getbootstrap.com/assets/js/ie10-viewport-bug-workaround.js"></script>
</body>
</html>