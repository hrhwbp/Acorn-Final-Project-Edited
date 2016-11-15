<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>MyInfo</title>
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<style type="text/css">
.thumbnail-wrappper {
    width: 25%; 
}

.thumbnail {
    position: relative;
    padding-top: 100%;  /* 1:1 ratio */
    overflow: hidden;
}

.thumbnail .centered  {
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    -webkit-transform: translate(50%,50%);
    -ms-transform: translate(50%,50%);
    transform: translate(50%,50%);
}

.thumbnail .centered img {
    position: absolute;
    top: 0;
    left: 0;   
    max-width: 100%;
    height: auto;
    -webkit-transform: translate(-50%,-50%);
    -ms-transform: translate(-50%,-50%);
    transform: translate(-50%,-50%);
}

.thumbnail img.portrait {
  width: 100%;
  max-width: none;
  height: auto;
}
.thumbnail img.landscape {
  width: auto;
  max-width: none;
  height: 100%;
}

} 
</style>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	$('#updateSubmit').click(function() {
		$('#boardUpdatefrm').submit()
	});
	$('#infoSubmit').click(function() {
		if($('#password').val() == $('#m_password').val()){
			$('#infofrm').submit()
		}else{
			$('#passwordErr').modal('show');
		}
	});
	$('#boardInsertBtn').click(function() {
		$('#boardInsert').modal('show');
		$('#boardInsertImg').hide();
	});
	$('#boardInsertSubmit').click(function() {
		/* alert(boardInsertFile.files[0]); */
		if(boardInsertFile.files[0] == undefined){
			$('#boardInsertErr').modal('show');
			return;
		}else if($('#modalInsertContent').val() == ''){
			$('#modalInsertContent').attr('placeholder','내용을 입력 해주세요!!');
			$('#modalInsertContent').focus();
			return;
		}
		$('#boardInsertfrm').submit();
	})
})

function modalToggle(b_no) {
	/* alert(b_no) 보드 번호 받기. */ 
	 jQuery.ajax({
         type:"post",
         url:"boardDetail",
         data: {"b_no":b_no},
         dataType: "json",
         success : function(data) {
        	 /* alert(data.detailDto.b_no); */
        	 var dto = data.detailDto;
        	 /* alert(dto.b_image); */
        	 /* modalContent modalLike modalDate */
        	 /* document.getElementById("modalimg").src = dto.b_image;  */
        	 $("#modalimg").attr('src', dto.b_image);
        	 $('#modalContent').val(dto.b_content);
        	 $('#modalLike').text('좋아요 ' + dto.b_like);
        	 $('#modalDate').text(dto.b_date);
        	 $('#hiddenNo').val(dto.b_no); 
        	 $('#hiddenImage').val(dto.b_image); 
        	 $('#boardDetail').modal('show');
         },
         error : function(xhr, status, error) {
               alert("에러발생 " + error);
         }
   });
	
}

function follower(m_no) {
	$('#followHead').text('팔로워');
	$('#followDiv').text('');
	 jQuery.ajax({
         type:"post",
         url:"showMyFollower",
         data: {"m_no":m_no},
         dataType: "json",
         success : function(data) {
        	 var list = data.Mylist;
        	 var m_no = data.m_no;
        	 var m_no2 = data.m_no2;
        	 var str = "";
        	 $.each(list,function(i,ss){
        		 /* alert(ss.m_email); */
        		 str += "<div class='row' style='padding-bottom: 1%;'>" +
        		 		"<div class='col-md-12'>" +
        		 		"<div class='col-md-2' style='height: 50px'>" +
        		 		"<img src='http://wbp.synology.me/profileimg/" + ss.m_image + "' alt='Responsive image' class='img-circle img-responsive' style='height: 100%; width: 100%'>" +
        		 		"</div>" +
        		 		"<div class='col-md-8'>" +
 						"<div class='row' style='cursor: default;'>" +
 						"" + ss.m_name + "" +
        		 		"</div>" +
 						"<div class='row'>" +
 						"<a href='myinfo?m_no=" + ss.f_sno + "'>" + ss.m_email + "</a>" +
 						"</div>" +
 						"</div>" +
 						"<div class='col-md-2' style='padding-top: 1%;'>";
 				if(ss.f_ms == '2' && m_no == m_no2 ){
 					str +=	"<button type='button' class='btn btn-default' id='followBtn" + ss.f_sno + "' style='background-color: #70c050; color: white;' onclick='cancelFollow("+ ss.f_sno + "," + ss.f_mno +")'>팔로잉</button>";
 				}else if(ss.f_ms == '1' && m_no == m_no2){
 					str +=	"<button type='button' class='btn btn-default' id='followBtn" + ss.f_sno + "' onclick='upFollow(" + ss.f_mno + "," + ss.f_sno + ")'>팔로우</button>"; 					
 				}else if(ss.f_ms == '1' || ss.f_ms == '2'){
 					str +=	"<button type='button' class='btn btn-default' id='followBtn" + ss.f_sno + "' style='background-color: #70c050; color: white;' onclick='cancelFollow("+ ss.f_sno + "," + ss.f_mno +")'>팔로잉</button>";
 				}else{
 					str +=	"<button type='button' class='btn btn-default' id='followBtn" + ss.f_sno + "' onclick='upFollow(" + ss.f_mno + "," + ss.f_sno + ")'>팔로우</button>";
 				}
 				str += "</div>" +
 						"</div>" +
 		      			"</div>";
        		 
        	 })        	
        	 $('#followDiv').append(str);
        	 /* modalContent modalLike modalDate */
        	 /* document.getElementById("modalimg").src = dto.b_image;  */
        	 $('#myFollow').modal('show');
         },
         error : function(xhr, status, error) {
               alert("에러발생 " + error);
         }
   });
}

function follow(m_no) {
	$('#followHead').text('팔로잉');
	$('#followDiv').text('');
	 jQuery.ajax({
        type:"post",
        url:"showIFollow",
        data: {"m_no":m_no},
        dataType: "json",
        success : function(data) {
       	 var list = data.Mylist;
       	 var str = "";
       	 $.each(list,function(i,ss){
       		 /* alert(ss.m_email); */
       		 str += "<div class='row' style='padding-bottom: 1%;'>" +
       		 		"<div class='col-md-12'>" +
       		 		"<div class='col-md-2' style='height: 50px'>" +
       		 		"<img src='http://wbp.synology.me/profileimg/" + ss.m_image + "' alt='Responsive image' class='img-circle img-responsive' style='height: 100%; width: 100%'>" +
       		 		"</div>" +
       		 		"<div class='col-md-8'>" +
					"<div class='row' style='cursor: default;'>" +
					"" + ss.m_name + "" +
       		 		"</div>" +
					"<div class='row'>" +
					"<a href='myinfo?m_no=" + ss.f_mno + "'>" + ss.m_email + "</a>" +
					"</div>" +
					"</div>" +
					"<div class='col-md-2' style='padding-top: 1%;'>";
			if(ss.f_ms == '2' || ss.f_ms == '1'){
				str +=	"<button type='button' class='btn btn-default' id='followBtn" + ss.f_mno + "' style='background-color: #70c050; color: white;' onclick='cancelFollow("+ ss.f_mno + "," + ss.f_sno +")'>팔로잉</button>";
			}else{
				str +=	"<button type='button' class='btn btn-default' id='followBtn" + ss.f_mno + "' onclick='upFollow(" + ss.f_sno + "," + ss.f_mno + ")'>팔로우</button>";
			}	
			str +=	"</div>" +
					"</div>" +
	      			"</div>";
       		 /* rgb(168,133,239) */
       	 })        	
       	 $('#followDiv').append(str);
       	 /* modalContent modalLike modalDate */
       	 /* document.getElementById("modalimg").src = dto.b_image;  */
       	 $('#myFollow').modal('show');
        },
        error : function(xhr, status, error) {
              alert("에러발생 " + error);
        }
  });
}

function upFollow(f_mno,f_sno) {
	/* alert(m_no + " " + f_sno); */
	var array = {"f_mno":f_mno,"f_sno":f_sno};
	jQuery.ajax({
        type:"post",
        url:"insertFollow",
        data: array,
        success : function() {
        	$("#followBtn"+f_sno).attr('onclick','cancelFollow('+ f_sno + ',' + f_mno +')');
        	$("#followBtn"+f_sno).attr('style','background-color: #70c050; color: white;');
        },
        error : function(xhr, status, error) {
              alert("에러발생 insert" + error + "" + status );
        }
	}); 
}
function up2Follow(m_no,f_sno) {
	/* alert(m_no + " " + f_sno); */
	
	$("#follow").attr('onclick','cancelFollow('+ m_no + ',' + f_sno +')');
	$("#follow").attr('style','background-color: #70c050; color: white;');
	$("#follow").attr('value','팔로잉');
	var array = {"f_mno":m_no,"f_sno":f_sno};
	
	jQuery.ajax({
        type:"post",
        url:"insertFollow",
        data: array,
        success : function() {
       		alert('성공');
        },
        error : function(xhr, status, error) {
              alert("에러발생 " + error);
        }
	}); 
}

function cancelFollow(f_mno,f_sno) {
	/* alert(f_mno + " " + f_sno); */
	var array = {"f_mno":f_sno,"f_sno":f_mno};
	jQuery.ajax({
        type:"post",
        url:"followCancel",
        data: array,
        success : function() {
        	$("#followBtn"+f_mno).attr('onclick','upFollow('+ f_sno + ',' + f_mno +')');
        	$("#followBtn"+f_mno).attr('style','background-color: white; color: black;');
        },
        error : function(xhr, status, error) {
              alert("에러발생 " + error);
        }
	}); 
	/* $("#followBtn"+f_mno).attr('onclick','upFollow('+ m_no + ',' + f_mno +')');
	$("#followBtn"+f_mno).attr('style','background-color: white; color: black;'); */
}

function hoverHide(b_no) {
	$('#showHover'+b_no).hide();
}

function hoverShow(b_no) {
	var showh = $("#showHover"+b_no);
	var tagA = $("#tagA"+b_no);
	/* tagA.removeAttr('onmouseover'); */
	
	showh.attr('style','background-color: rgba(0,0,0,.3); bottom: 0; -webkit-box-pack: center; justify-content: center; right: 0; left: 0;position: absolute; top: 0;');
	if(tagA.attr('class') == 'hover'){
		tagA.attr('class','');
		jQuery.ajax({
			 type:"post",
		     url:"rlCount",
		     data: {'b_no':b_no},
		     dataType: 'json',
		     success : function(data) {
		      	var like = data.likeCount;
		      	var reply = data.replyCount;
				var str = "";
				str += "<ul style='display: flex; font-size: 16px;font-weight: 600; color: #fff; list-style: none; justify-content: center; margin: 0; padding: 0; border: 0; font: inherit; padding-top: 32%;' class='' >" +
						"<li style='line-height: 19px;margin: 0 auto;padding-left: 26px;position: relative; display: table;'> 좋아요 :" + like + "</li>" +
						"<li style='line-height: 19px;margin: 0 auto;padding-left: 26px;position: relative; display: table;'>  댓글 :" + reply +  "</li>" +
						"</ul>";
				showh.append(str);
		     },
		     error : function(xhr, status, error) {
		   	    alert("에러발생 " + error);
		     }
		});
	}
	
}
</script>
</head>

<%@ include file="../../top.jsp" %>
<body style="">
<div class="container">
<div class="container"  style="padding-top: 2%; padding-bottom: 5%;">
<div class="row" style="background-color: rgb(253,253,253); padding-top: 30px; padding-bottom: 30px; ">
	<div class="col-md-2 col-md-offset-2" style="height: 170px">
	
		<a style="color: buttontext; border: 0; cursor: pointer; height: 100%; padding: 0; width: 100%;" data-toggle="modal" data-target="#updateInfo">
		
			<img src="http://wbp.synology.me/profileimg/${myinfo.m_image }" alt="Responsive image" class="img-circle img-responsive" style="height: 100%; width: 100%">
		
		</a>
	</div>
	<div class="col-md-6">
		<div class="row">
		<div class="col-md-12">
			<div class="col-md-6">
				<blockquote>
				  <p>${myinfo.m_name}</p>
				</blockquote>
			</div>
			<div class="col-md-3 col-md-offset-1 top_pd">
				<c:choose>
				<c:when test="${mno == myinfo.m_no }">
				<button type="button" class="btn btn-default col-md-12" data-toggle="modal" data-target="#updateInfo">프로필 변경</button>
				</c:when>
				<c:otherwise>
				<button type="button" id="follow" class="btn btn-default col-md-12" onclick="up2Follow(${mno},${myinfo.m_no })">팔로우</button>
				
				</c:otherwise>
				</c:choose>
				
			</div>		
		
		</div>
		</div>
		<div class="row">
			
			<button type="button" class="btn btn-link col-md-3" disabled="disabled">게시물  ${fn:length(board)}개</button> 
			<button type="button" class="btn btn-link col-md-3" onclick="follower(${myinfo.m_no})">팔로워 ${fn:length(mylist)}</button>
			<button type="button" class="btn btn-link col-md-3" onclick="follow(${myinfo.m_no})">팔로우 ${fn:length(ilist)}</button>
		
		</div>
	</div>
</div>
<c:if test="${mno == myinfo.m_no }">
<div class="row" style="padding-bottom: 2%">
	<div class="col-md-10 col-md-offset-1">
			<button type="button" id="boardInsertBtn" class="btn btn-link col-md-12" style="background-color: rgb(255,230,231);"><h4><span class="glyphicon glyphicon-plus"></span>&nbsp;&nbsp;&nbsp;게시물 추가하기</h4></button>
	</div>
</div>
</c:if>
<div class="row" style="background-color: rgb(253,253,253);"><!-- row  -->
<div class="col-md-12">
  <c:forEach var="board" items="${board}">  
    	<div class="col-md-4"  >
    		<div class="thumbnail-wrapper" >
    			<div class="thumbnail" style="height: 250px; background-color: #000;">
    				<a class="hover" href="javascript:modalToggle(${board.b_no})" id="tagA${board.b_no}" onmouseover="hoverShow(${board.b_no})" onmouseout="hoverHide(${board.b_no})" >
        			<div class="centered">
		  				 <img src="${board.b_image }" class=" landscape"> <!-- portrait -->
			   		</div>
			    	<div id="showHover${board.b_no}" style="display: none">
			    		
			    	</div>
    				</a>
			   </div>
		   </div>
    	</div>
  </c:forEach>
</div>	
</div> <!-- row -->
</div>


	<!-- 프로필 수정 모달 -->
	
	<div class="modal fade" id="updateInfo" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >
	  <div class="modal-dialog" style="margin: 150px auto;">
	    <div class="modal-content">
	     <form action="updateInfo" id="infofrm" method="post" enctype="multipart/form-data">
	      <div class="modal-header">
	      
	     
		<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">Close</span></button>
			<div class="row">
				<div class="col-md-4 col-md-offset-4 text-center">
				<div style="color: buttontext; border: 0; cursor: pointer; height: 180px; padding: 0; width: 100%;">
					<a  onclick="$('#file').click();">
					<img id="image" src="http://wbp.synology.me/profileimg/${myinfo.m_image }" alt="Responsive image" class="img-circle img-responsive" style="height: 100%; width: 100%">
					</a>
	      			<input type="file" id="file"  name="fileUp" class="sr-only">
				</div>
				</div>
			</div>
	     </div>
	      	<div class="modal-body">
			
				<input type="hidden" name="m_no" value="${myinfo.m_no}">
				<div class="row">
					<div class="col-md-12">
						<label for="Email1">E-mail</label>
						<input type="email" class="form-control" id="Email1" name="m_email" value="${myinfo.m_email}" required>
					</div>
				</div>
				<div class="row">
					<div class="col-md-12">
						<label for="name">이름</label>
						<input type="text" class="form-control" name="m_name" id="name" value="${myinfo.m_name }" required>
					</div>
				</div>
				<div class="row">
					<div class="col-md-12">
						<label for="inputOldPassword" class="">현재 비밀번호</label> 
						<input type="password" name="m_password" id="m_password" class="form-control" placeholder="Password" required>
						<input type="hidden" id="password" value="${myinfo.m_password}">				
					</div>
				</div>
				<div class="row form-group">
						<div class="col-md-2">
							
						</div>
						<div class="col-md-4 top_pd text-right">
							<c:set var="date" value="${myinfo.m_bdate}"/>
							<label class="">년도</label>
							<jsp:useBean id="toDay" class="java.util.Date" />
							<fmt:formatDate value="${toDay}" var = "viewYear" pattern="yyyy" />
							<select class="form-control" name="year">
								<option>${fn:substring(date,0,4) }</option>
								<c:forEach var="i" begin="0" end ="100" step="1">
								<option>${viewYear -i }</option>
								</c:forEach>

							</select>
						</div>

						<div class="col-md-3 top_pd text-right">
							<label class="">월</label> 
							<select class="form-control" name="month">
								<option>${fn:substring(date,5,7) }</option>
								<c:forEach var="i" begin="1" end ="12" step="1">
								<option>${i}</option>
								</c:forEach>
							</select>
						</div>

						<div class="col-md-3 top_pd text-right">
							<label class="" for="ss">일</label> 
							<select id="ss" name="day"
								class="form-control" >
								<option>${fn:substring(date,8,10) }</option>
								<c:forEach var="i" begin="1" end ="31" step="1">
								<option>${i}</option>
								</c:forEach>
							</select>
						</div>
					</div>
		
	      	</div>
	    	<div class="modal-footer">
	    	
	    	<button class="btn btn-primary" id="infoSubmit" type="button">Save changes</button>
	    	
			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			</div>
			
				
			</form>
	    </div>
	    
	  </div>
	  	
	</div>
	<!-- 게시물 수정 모달 -->

	<div class="modal fade" id="boardDetail" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >
	  <div class="modal-dialog" style="margin: 180px auto">
	    <div class="modal-content">
	     <form id="boardUpdatefrm" action="updateBoard" method="post" enctype="multipart/form-data">
	      <div class="modal-header">
			
			<div class="row">
				<div class="col-md-12">
				<c:choose>
					
					<c:when test="${mno == myinfo.m_no }">
			    		<div class="thumbnail-wrapper" >
			    			<div class="thumbnail" style="height: 350px; background-color: #000;">
			        			<div class="centered">
									<a  onclick="$('#boardFile').click();" style="cursor: pointer">
									<img alt="Responsive image" id="modalimg" class="landscape" src="">
									</a>
								</div>
							</div>
						</div>
					</c:when>
					<c:otherwise>
					<img alt="Responsive image" id="modalimg" class="img-responsive center-block" src="">
					</c:otherwise>
					
					</c:choose>
					<input type="file" name="fileUpload"  id="boardFile" class="sr-only" >
				</div>
			</div>
	      </div>
	      <div class="modal-body">
	     
	 
	      <div class="row">	      
			<h3 class="col-md-12">
			<c:choose>
			<c:when test="${mno == myinfo.m_no }">
			<input name="b_content" id="modalContent" type="text" class="form-control" value="">
			</c:when>
			<c:otherwise>
			<input name="b_content" id="modalContent" type="text" class="form-control" value="" readonly="readonly">
			</c:otherwise>
			</c:choose>
			</h3>
			
			<p class="col-md-6" id="modalLike"></p><p id="modalDate" class="text-right col-md-6"></p>
	      </div>
	      </div>
	      <input type="hidden" value="" id="hiddenNo" name="b_no">
	      <input type="hidden" value="" id="hiddenImage" name="b_image">
	     </form>
	      <div class="modal-footer">
			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			<c:if test="${mno == myinfo.m_no }">
			<button id="updateSubmit" type="button" class="btn btn-primary">Save changes</button>
			</c:if>
	      </div>
	      
	    </div>
	  </div>
	</div>

		<!-- 새 게시물 모달 -->

	<div class="modal fade" id="boardInsert" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >
	  <div class="modal-dialog" style="margin: 180px auto">
	    <div class="modal-content">
	     <form id="boardInsertfrm" action="insertBoard" method="post" enctype="multipart/form-data">
	      <div class="modal-header">
			
			<div class="row">
				<div class="col-md-12 text-center" style="">
					<a  onclick="$('#boardInsertFile').click();" style="cursor: pointer; padding-top: 40%" >
					<b id="insertBtag">클릭해서 이미지 추가</b>
					<img alt="Responsive image" id="boardInsertImg" class="img-responsive center-block" src="" style="">
					</a>
					<input type="file" name="fileUpload" id="boardInsertFile" class="sr-only">
				</div>
			</div>
	      </div>
	      <div class="modal-body">
	     
	 
	      <div class="row">	      
			<h3 class="col-md-12"><input name="b_content" id="modalInsertContent" type="text" class="form-control" placeholder="게시글 내용은 제목으로 보여 집니다."></h3>
			<input type="hidden" value="${myinfo.m_no}" name="b_mno">
	      </div>
	      </div>
	     </form>
	      <div class="modal-footer">
			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			<button id="boardInsertSubmit" type="button" class="btn btn-primary" >Save changes</button>
	      </div>
	      
	    </div>
	  </div>
	</div>

			<!-- 팔로우 모달 -->

	<div class="modal" id="myFollow" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >
	  <div class="modal-dialog" style="margin: 180px auto">
	    <div class="modal-content">
	     <form id="boardInsertfrm" action="insertBoard" method="post" enctype="multipart/form-data">
	      <div class="modal-header">
			<div class="row">
				<div class="col-md-12 text-center" id="followHead">
					<h3 id="followHead"></h3>
				</div>
			</div>
	      </div>
	      <div class="modal-body" id="followDiv" style="max-height: 400px">
		      
	      </div>
	     </form>
	      
	    </div>
	  </div>
	</div>
	

	<!-- 비밀번호 모달 팝업 -->
	<div class="modal fade bs-example-modal-sm" id="passwordErr" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true" >
	  <div class="modal-dialog modal-sm" style="margin: 350px auto;">
	    <div class="modal-content">
	      <div class="row text-center">
	      	비밀번호가 틀립니다.
	      </div>
	    </div>
	  </div>
	</div>

	<!-- 새 게시글 이미지 없음 -->
	<div class="modal fade bs-example-modal-sm" id="boardInsertErr" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true" >
	  <div class="modal-dialog modal-sm" style="margin: 260px auto;">
	    <div class="modal-content">
	      <div class="row text-center">
	      	이미지를 선택해주세요.
	      </div>
	    </div>
	  </div>
	</div>
	
	
</div> <!-- container -->
<script>
/* 프로필 수정 이미지 미리보기 */
var upload = document.getElementById('file'),
 	image = document.getElementById('image');
upload.onchange = function (e) {
  e.preventDefault();
  var file = upload.files[0],
      reader = new FileReader();
  reader.onload = function (event) {
    image.src = event.target.result;
  };
  reader.readAsDataURL(file);
};
/* 게시물 수정 이미지 미리보기 */
var boardFile = document.getElementById('boardFile'),
	modalimg = document.getElementById('modalimg');
boardFile.onchange = function (e) {
  e.preventDefault();
  var file2 = boardFile.files[0],
      reader2 = new FileReader();
  reader2.onload = function (event) {
	  modalimg.src = event.target.result;
  };
  reader2.readAsDataURL(file2);
};
/* 게시물 쓰기 이미지 미리보기 */
var boardInsertFile = document.getElementById('boardInsertFile'),
	boardInsertImg = document.getElementById('boardInsertImg');
boardInsertFile.onchange = function (e) {
  e.preventDefault();
  var file3 = boardInsertFile.files[0],
      reader3 = new FileReader();
  reader3.onload = function (event) {
	  boardInsertImg.src = event.target.result;
  };
  reader3.readAsDataURL(file3);
  /* $('#insertBtag').text(''); */
  $('#boardInsertImg').show();
};
</script>
</body>
<%@ include file="../../bottom.jsp" %>
</html>