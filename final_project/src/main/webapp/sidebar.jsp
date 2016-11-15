<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
@import url(//netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.css);
}
@import url(http://fonts.googleapis.com/css?family=Titillium+Web:300);
.fa-2x {
font-size: 2em;
}
.fa {
position: relative;
display: table-cell;
width: 60px;
height: 32px;
text-align: center;
vertical-align: middle;
font-size:20px;
}


.main-menu:hover,nav.main-menu.expanded {
width:250px;
overflow:visible;
}

.main-menu {
background:#fbfbfb;
border-right:1px solid #e5e5e5;
position:absolute;
top:0;
bottom:0;
height:92%;
left:0;
width:60px;
overflow:hidden;
-webkit-transition:width .05s linear;
transition:width .05s linear;
-webkit-transform:translateZ(0) scale(1,1);
z-index:1000;
}

.main-menu>ul {
margin:7px 0;
}

.main-menu li {
position:relative;
display:block;
width:250px;
}

.main-menu li>a {
position:relative;
display:table;
border-collapse:collapse;
border-spacing:0;
color:#999;
 font-family: arial;
font-size: 14px;
text-decoration:none;
-webkit-transform:translateZ(0) scale(1,1);
-webkit-transition:all .1s linear;
transition:all .1s linear;
  
}

.main-menu .nav-icon {
position:relative;
display:table-cell;
width:60px;
height:34px;
text-align:center;
vertical-align:middle;
font-size:18px;
}

.main-menu .nav-text {
position:relative;
display:table-cell;
vertical-align:middle;
width:190px;
  font-family: 'Titillium Web', sans-serif;
}

.main-menu>ul.logout {
position:absolute;
left:0;
bottom:0;
}

.no-touch .scrollable.hover {
overflow-y:hidden;
}

.no-touch .scrollable.hover:hover {
overflow-y:auto;
overflow:visible;
}

a:hover,a:focus {
text-decoration:none;
}

nav {
-webkit-user-select:none;
-moz-user-select:none;
-ms-user-select:none;
-o-user-select:none;
user-select:none;
}

nav ul,nav li {
outline:0;
margin:0;
padding:0;
}
.main-menu li:hover>a,nav.main-menu li.active>a,.dropdown-menu>li>a:hover,.dropdown-menu>li>a:focus,.dropdown-menu>.active>a,.dropdown-menu>.active>a:hover,.dropdown-menu>.active>a:focus,.no-touch .dashboard-page nav.dashboard-menu ul li:hover a,.dashboard-page nav.dashboard-menu ul li.active a {
color:#fff;
background-color:#5fa2db;
}
.area {
float: left;
background: #e2e2e2;
width: 100%;
height: 100%;
}
@font-face {
  font-family: 'Titillium Web';
  font-style: normal;
  font-weight: 300;
  src: local('Titillium WebLight'), local('TitilliumWeb-Light'), url(http://themes.googleusercontent.com/static/fonts/titilliumweb/v2/anMUvcNT0H1YN4FII8wpr24bNCNEoFTpS2BTjF6FB5E.woff) format('woff');
}
</style>
</head>
<body>


	<div class="col-md-3 visible-lg" role="complementray" style="padding-top: 0%">
		<div class="row">
			<div class="">
				
				<nav class="main-menu float_sidebar">
		            <ul class="bs-docs-sidenav">
		                <li>
		                    <a href="#">
		                        <i class="fa fa-home fa-2x"></i>
		                        <span class="nav-text">Dashboard</span>
		                    </a>
		                </li>
		                <li class="has-subnav">
		                    <a href="#">
		                        <i class="fa fa-laptop fa-2x"></i>
		                        <span class="nav-text">
		                            UI Components
		                        </span>
		                    </a>
		
		                </li>
		                <li class="has-subnav">
		                    <a href="#">
		                       <i class="fa fa-list fa-2x"></i>
		                        <span class="nav-text">
		                            Forms
		                        </span>
		                    </a>
		                </li>
		                <li class="has-subnav">
		                    <a href="#">
		                       <i class="fa fa-folder-open fa-2x"></i>
		                        <span class="nav-text">
		                            Pages
		                        </span>
		                    </a>
		                </li>
		                <li>
		                    <a href="#">
		                        <i class="fa fa-bar-chart-o fa-2x"></i>
		                        <span class="nav-text">
		                            Graphs and Statistics
		                        </span>
		                    </a>
		                </li>
		                <li>
		                    <a href="#">
		                        <i class="fa fa-font fa-2x"></i>
		                        <span class="nav-text">
		                            Typography and Icons
		                        </span>
		                    </a>
		                </li>
		                <li>
		                   <a href="#">
		                       <i class="fa fa-table fa-2x"></i>
		                        <span class="nav-text">
		                            Tables
		                        </span>
		                    </a>
		                </li>
		                <li>
		                   <a href="#">
		                        <i class="fa fa-map-marker fa-2x"></i>
		                        <span class="nav-text">
		                            Maps
		                        </span>
		                    </a>
		                </li>
		                <li>
		                    <a href="#">
		                       <i class="fa fa-info fa-2x"></i>
		                        <span class="nav-text">
		                            Documentation
		                        </span>
		                    </a>
		                </li>
		            </ul>

		            <ul class="logout">
		                <li>
		                   <a href="logout">
		                         <i class="fa fa-power-off fa-2x"></i>
		                        <span class="nav-text">
		                            Logout
		                        </span>
		                    </a>
		                </li>  
		            </ul>
		            
        		</nav>
			</div>
		</div>
	</div>
	
<script>
$(function(){
    var $win = $(window);
    var top = $(window).scrollTop(); // 현재 스크롤바의 위치값을 반환합니다.
 
    /*사용자 설정 값 시작*/
    var speed          = 500;     // 따라다닐 속도 : "slow", "normal", or "fast" or numeric(단위:msec)
    var easing         = 'linear'; // 따라다니는 방법 기본 두가지 linear, swing
    var $layer         = $('.float_sidebar'); // 레이어 셀렉팅
    var layerTopOffset = 0;   // 레이어 높이 상한선, 단위:px
    $layer.css('position', 'relative').css('z-index', '1');
    /*사용자 설정 값 끝*/
 
    // 스크롤 바를 내린 상태에서 리프레시 했을 경우를 위해
    if (top > 0 )
        $win.scrollTop(layerTopOffset+top);
    else
        $win.scrollTop(0);
 
    //스크롤이벤트가 발생하면
    $(window).scroll(function(){
        yPosition = $win.scrollTop() - 0; //이부분을 조정해서 화면에 보이도록 맞추세요
        if (yPosition < 0)
        {
            yPosition = 0;
        }
        $layer.animate({"top":yPosition }, {duration:speed, easing:easing, queue:false});
    });
});
</script>		
</body>
</html>





















