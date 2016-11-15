<%@page import="org.apache.ibatis.javassist.bytecode.annotation.AnnotationImpl"%>
<%@page import="com.remind.model.AnnoInter"%>
<%@page import="com.remind.model.DataDao"
	import="com.remind.model.WishlistDto" import="java.util.List"
	import="com.remind.controller.WishlistBean"
	import="com.fasterxml.jackson.annotation.JsonInclude.Include"
	language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>ReMind : [RE:AD MIND]</title>
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>

<meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0' name='viewport' />
<link href="http://netdna.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css" rel="stylesheet">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<link href="resources/css/bootstrap.css" rel="stylesheet" />
<link href="resources/css/rotating-card.css" rel="stylesheet" />
<script src="resources/js/jquery-1.10.2.js" type="text/javascript"></script>
<script src="resources/js/bootstrap.min.js" type="text/javascript"></script>

<script type="text/javascript">
/*WishList Group관련 Jquery!!!!!!!!!!!!!!!*/
$(document).ready(function() {
	
	$("#btn_wishgroup_submit").click(function() {
		//alert("hi");
		if ($("#wg_detail").val() == "") {
			alert("새로운 목록의 이름을 넣어주세요!");
		} else {
			document.wishGroupForm.action = "insertWishGroup";
			document.wishGroupForm.method = "post";
			document.wishGroupForm.submit();
		}
	});
		
	$("#bt_editConfirm").click(function() {
		//alert("hi");
		if ($("#new_wg_detail").val() == "") {
			alert("변경하실 새 이름을 넣어주세요!");
		} else {
			document.wishGroupForm.action = "updateWishGroup";
			document.wishGroupForm.method = "post";
			document.wishGroupForm.submit();
		}
	});
});
	
function groupEdit(wg_no){
	$('#edit'+wg_no).modal();
	//$('#edit'+wg_no).modal('hide')
}
	
function groupDelete(wg_no){
	//alert("Delete");
	 $('#delete').modal();
}
	
function changeWgrp(wg_no, wg_detail){
	$('#edit'+wg_no).modal('hide')
	jQuery.ajax({
		type:"post",
		url:"updateWishGroup",
		data:{"wg_no":wg_no, "wg_detail":jQuery("#new_wg_detail"+wg_no).val()},
		dataType:'json',
		success:function(WishGroupData){
			
			var list = WishGroupData.WishGroupList
			str = '<h4 class="panel-title" >';
			jQuery(list).each(function(index, objArr){
				str+= '<a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseTwo_"+'+ objArr.wg_no+ '>' +  objArr.wg_detail + '</a>';
			})
			str +="</h4>";
			jQuery("#wishGrpChange"+wg_no).html(str)
			jQuery("#myModalLabel"+wg_no).html(jQuery("#new_wg_detail"+wg_no).val());
		}
	})
}
	
	
/*카드 Filp관련  */
$().ready(function() {
	$('[rel="tooltip"]').tooltip();
});

function rotateCard(btn) {
	var $card = $(btn).closest('.card-container');
	console.log($card);
	if ($card.hasClass('hover')) {
		$card.removeClass('hover');
	} else {
		$card.addClass('hover');
	}
}
	
(function(i, s, o, g, r, a, m) {
	i['GoogleAnalyticsObject'] = r;
	i[r] = i[r] || function() {
		(i[r].q = i[r].q || []).push(arguments)
	},
	i[r].l = 1 * new Date();
	a = s.createElement(o), m = s.getElementsByTagName(o)[0];
	a.async = 1;
	a.src = g;
	m.parentNode.insertBefore(a, m)
})
(window, document, 'script', '//www.google-analytics.com/analytics.js', 'ga');
ga('create', 'UA-46172202-4', 'auto');
ga('send', 'pageview');
	
	
/*WishList 상품관련 Jquery~~~~~~~~~~~~~*/	
$(document).ready(function(){									//insert후 카드 나열	
	$("#reset").click(function(){				//insert card reset시키기
		$("#w_mno").val("");
		$("#w_addr").val("");
		$("#w_pname").val("");
		$("#w_price").val("");
		$("#w_image").attr("src", "");
		$("#w_detail").val("");
	});	
});
		
		//Insert부분 BEGINNING--------------------------------
$(document).ready(function(){							//Parsing 정보 추가창에 입력
	$("#btnfetch").click(function(){
		$.ajax({
			type:"post",
			url:"urltest",
			data: {"url":$("#itemUrl").val()},
			dataType: "json",
			success: function(productData){
				var w_pname, w_price, w_image, insimg, url ;
						
				var list = productData.productlist;
				$(list).each(function(index, objArr){
					w_pname  = objArr["name"];
					w_price = objArr["price"];
					w_image= objArr["image"];
					url = objArr["url"];
				});
						
				$("#insertModal #itemName").val(w_pname);
				$("#insertModal #itemPrice").val(w_price);
				$("#insertModal #itemImage").attr("src", w_image);
				$("#insertModal #submitImage").val(w_image);
			},
			error: function(){
				alert("에러 발생");
			}
		});
	});
});
		
function insert(mno, g_num){
	$("#insertModal #itemGnum").val(g_num);
	$("#insertModal #itemMno").val(mno);
	$("#insertModal").modal();	
}
//Insert부분 END--------------------------------
		
function del(mno, no){
	$("#deleteModal #itemNo").val(no);
	$("#deleteModal #itemMno").val(mno);
	$("#deleteModal").modal();
}
		
function update(no){
	 $.ajax({
		type:"post",
		url:"showInsertedList",
		data:  {"w_no":no},
		dataType: "json",
		success: function(insertedData){
			//var w_addr, w_pname, w_price, w_image, w_detail;
			var w_no, w_addr, w_mno, w_pname, w_price, w_image, w_detail;		
			var list = insertedData.insertedList;
			$(list).each(function(index, objArr){
				w_no = objArr["w_no"];
				w_image = objArr["w_image"];
				w_pname =  objArr["w_pname"];
				w_detail = objArr["w_detail"];
				w_price = objArr["w_price"];
				w_mno = objArr["w_mno"];
			});
			$("#updateModal #itemNo").val(w_no);
			$("#updateModal #itemName").val(w_pname);
			$("#updateModal #itemDetail").val(w_detail);
			$("#updateModal #itemPrice").val(w_price);
			$("#updateModal #itemMno").val(w_mno);
			$("#updateModal").modal();
		},
		error: function(){
			alert("에러 발생");
		}
	}); 
}

/*상품 lock & unlock 관련  */
function lock(lockstat, w_no, num, mno){
	$.ajax({
		type:"post",
		url:"updatelock",
		data:  {"w_lock":lockstat, "w_no":w_no, "w_mno":mno},
		dataType: "json",
		success: function(insertedData){
			
			var w_lock, str;		
			var list = insertedData.insertedList;
			
			$(list).each(function(index, objArr){
				w_lock = objArr["w_lock"];
				w_mno = objArr["w_mno"];
			});
			
			
			if(w_lock == '1'){
				$("#i_lock" + num).attr("src", "resources/image/Lock-Unlock-icon.png");
				$("#locka" + num).attr("onclick", "lock('2', '" + w_no + "','" + num + "','" + mno + "')");
				
				$("#stat" + num).remove();
				$("#status" + num).empty();
				$("#status" + num).append("<h5 id='stat" + num +"'>Available</h5>");
				//$("#stat").val("Available");
				
			}else if(w_lock == '2'){
				$("#i_lock" + num).attr("src", "resources/image/Lock-Lock-icon.png");
				$("#locka" + num).attr("onclick", "lock('1', '" + w_no + "','" + num + "','" + mno + "')");
				
				$("#stat" + num).remove();
				$("#status" + num).empty();
				$("#status" + num).append("Hold by<h5 id='stat" + num + "'><a href='javascript:void(0);' id='reve" + num + "' onclick='reveal('" + mno + "','" + num + "')'>reveal name</a></h5>");
												//<h5 id="stat${lock}"><a href="javascript:void(0);" id="reve${lock}" onclick="reveal('${wlist.w_mno}', '${lock}')">reveal name</a></h5>
				//$("#stat").val("Hold by <a href='javascript:void(0);'>reveled name</a>");
			}
		},
		error: function(e){
			alert("에러 발생" + e);
		}
	}); 
}

function reveal(mno, num){
	alert(mno + " " + num);
	$.ajax({
		type:"post",
		url:"showInsertedList",
		data:  {"w_mno":mno},
		dataType: "json",
		success: function(insertedData){
			var m_name;		
			var list = insertedData.insertedList;
			
			$(list).each(function(index, objArr){
				m_name = objArr["m_name"];
			});
			alert(m_name);
			
			$("#reve"+ num).remove();
			$("#stat" + num).append(m_name);//("<h5 id='stat" + num + "'>Hold by " + m_name + "</h5>");
			
		},
		error: function(e){
			alert("에러 발생" + e);
		}
	});
}

/*WishList 상품관련 Jquery~~~~~~~~~~~~~*/	
</script>
<style type="text/css">
.list-group li {
	list-style: none;
}

.panel-body {
	
}

.panel-info, .panel-rating {
	float: left;
	margin: 0 10px;
}

.panel-more1 {
	float: right;
	margin: 0 10px;
}

.sss {
	height: auto;
	margin: auto;
	overflow: hidden;
	max-width: 1100px;
}

.sss input[type=text] {
	float: left;
	outline: none;
	height: 30px;
	width: calc(100% - 100px);
	align-self: center;
	border: none;
	padding: 0 0 0 10px;
	box-sizing: border-box;
	background-color: white;
	border-top-left-radius: 3px;
	border-bottom-left-radius: 3px;
}

.sss input[type=submit] {
	float: right;
	color: white;
	height: 30px;
	width: 100px;
	border: none;
	font-size: 14px;
	text-transform: uppercase;
	background-color: #4285f4;
	border-top-right-radius: 3px;
	border-bottom-right-radius: 3px;
}

.sss input[type=submit]:hover {
	cursor: pointer;
	background-color: #2a75f3;
}
</style>
</head>

<%@ include file="top.jsp"%>
<body>
<label>${wg_detail}</label>
	<div class="container col-md-10 col-md-offset-1">
		<div class="row">
			<div class="col-md-12">
				<div class="thumbnail">
					<div class="list-group">
						<a class="list-group-item list-group-item-action active">
							<h2 class="list-group-item-heading">나의 소원 목록</h2>
						</a>
					</div>
					<!-- ------------------------------소원목록 어코디언------------------------------------- -->
					<div class="panel-group" id="accordion">

						<!-- ----------------새로운 소원목록 작성-------------------------- -->
						<div class="panel panel-default">
							<div class="panel-heading">
								<h4 class="panel-title">
									<a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseThree" aria-expanded="true"> 새로운 소원목록 작성하기</a>
								</h4>
							</div>
							<div id="collapseThree" class="panel-collapse collapse">
								<div class="panel-body">

									<form name="wishGroupForm">
										<div class="input-group">
											<input type="text" name="wg_detail" id="wg_detail" class="form-control" placeholder="새로운 소원목록명..."> 
											<input type="hidden" name="wg_mno" id="wg_mno" value="<%=session.getAttribute("mno")%>"> 
											<input type="hidden" name="w_mno" id="w_mno" value="<%=session.getAttribute("mno")%>"> 
											<span class="input-group-btn">
												<button class="btn btn-success" id="btn_wishgroup_submit" type="button">추가</button>
											</span>
										</div>
										<!-- /input-group -->
									</form>
								</div>
							</div>
						</div>
						<!-- ----------------새로운 소원목록 작성 끝------------------------ -->

						<!-- ---------------기존 등록된 소원목록 뽑기----------------------- -->
						<c:set var="lock" value="${0}" /><!--자물쇠 이미지 변환을 위한 변수  -->
						<c:forEach var="wgroup" items="${wishgroup }" varStatus="status">
							<div class="panel panel-default">
								<div class="panel-heading">
									<table width="100%">
										<tr>
											<td width="86%">
												<h4 class="panel-title" id="wishGrpChange${wgroup.wg_no }">
													<span class="badge">${itemcnt.count }</span>
													<a class="accordion-toggle" data-toggle="collapse" id="${wgroup.wg_detail}" data-parent="#accordion" href="#collapseTwo_${wgroup.wg_no}">${wgroup.wg_detail}</a>
													<c:set var="wgdetail" value="${wgroup.wg_detail}"/>
												</h4>
											</td>
											<td width="92px">
												<!-- 버튼그룹 삽입 -->
												<div class="btn-group btn-group-margin-right" role="group" aria-label="...">
													<div class="btn-group" role="group">
														<button type="button" id="btn_groupEdit" onclick="groupEdit(${wgroup.wg_no})" class="btn btn-warning btn-sm">수정</button>
													</div>
													<div class="btn-group" role="group">
														<button type="button" id="btn_groupDelete" onclick="groupDelete(${wgroup.wg_no},'${wgroup.wg_detail}')" class="btn btn-danger btn-sm">삭제</button>
													</div>
												</div> <!-- 버튼그룹 삽입 끝 -->
											</td>
										</tr>
									</table>
								</div>
								<div id="collapseTwo_${wgroup.wg_no}" class="panel-collapse collapse">
									<div class="panel-body col-md-12">

										<!-- ---------각 상품 내용이 들어갈 자리-----------  -->
										<table border="1" width="100%" class="table table-striped table-bordered table-hover" style="text-align: center; vertical-align: center;">
											<c:set var="cnt" value="0"/>

											<!--상품 카드 시작자리  -->
											<div class="container">
												<div class="row">
													<div class="col-sm-12 col-sm-offset col-md-10" style="padding-left: 0; padding-right: 0;">
														
														<c:forEach var="wlist" items="${wishlist }" varStatus="itemcnt">
															<c:if test="${wgroup.wg_no eq wlist.g_num}">
																<c:set var="cnt" value="${cnt += 1 }" />
																<c:set var="insertgnum" value="${wgroup.wg_no}" /><!--insert에 g_num을 넣기위한 변수생성  -->
																<div id="cardlist"></div>
																<div class="col-md-4 col-sm-4">
																	<div class="card-container manual-flip">
																		<div class="card">
																			<div class="front">

																				<div class="cover" align="center">
																					<img id="i_image" name="i_image" src="${wlist.w_image }" />
																				</div>
																				<div class="content">
																					<div class="main">
																						<h5 class="name motto">${wlist.w_pname}</h5>
																						<p class="text-center col-md-8-offset-2">실험삼아 아무거나 써보는 건데 한글은 안넘어 가는데 도대체가 영어는 카드를 넘어가냐?</p>
																					</div>
																					<div class="footer">
																						<button class="btn btn-simple" onclick="rotateCard(this)">
																							<i class="fa fa-mail-forward"></i> 수동 Rotation
																						</button>
																					</div>
																				</div>
																			</div>
																			<!-- end front panel -->

																			<div class="back">
																				<div class="header">
																					<h5 class="motto" id="i_pname">${wlist.w_pname}</h5>
																				</div>
																				<div class="content" style="padding-bottom: 30px">
																					<div class="main" align="center">
																						<textarea class="text-center col-md-12" id="i_detail" name="i_detail" rows="6" readonly="readonly">${wlist.w_detail }</textarea>
																						<!--<ssibal:set var="mno" value="${s.w_mno }"/>-->
																						<div class="stats-container col-md-12">
																							<div class="stats">
																								<p>가격</p>
																								<h5 id="i_price">${wlist.w_price }</h5>
																							</div>
																							<div class="stats">
																								<p>Status</p>
																								<c:choose>
																									<c:when test="${wlist.w_lock eq 1}">
																										<div id="status${lock}"><h5 id="stat${lock}">Available</h5></div>
																									</c:when>
																									<c:when test="${wlist.w_lock eq 2}">
																										<div id="status${lock}">Hold by<h5 id="stat${lock}"><a href="javascript:void(0);" id="reve${lock}" onclick="reveal('${wlist.w_mno}', '${lock}')">reveal name</a></h5></div>
																									</c:when>
																								</c:choose>
																							</div>
																							<div class="stats">
																								<p>추천</p>
																								<!-- <div id="lockimg"> -->
																									<c:choose>
																										<c:when test="${wlist.w_lock eq 1}">
																											<a href="javascript:void(0);" id="locka${lock}" onclick="lock('2', '${wlist.w_no}', '${lock}', '${wlist.w_mno}')"><!--${wlist.w_mno}  -->            
																												<img id="i_lock${lock}" src="resources/image/Lock-Unlock-icon.png" style="width: 35px; height: 30px">
																											</a>
																										</c:when>
																										<c:when test="${wlist.w_lock eq 2}">
																											<a href="javascript:void(0);" id="locka${lock}" onclick="lock('1', '${wlist.w_no}', '${lock}', '${wlist.w_mno}')">              
																												<img id="i_lock${lock}" src="resources/image/Lock-Lock-icon.png" style="width: 35px; height: 30px">
																											</a>
																										</c:when>
																									</c:choose>
																								<!-- </div> -->	
																							</div>
																						</div>
																					</div>
																				</div>
																				<div class="footer">
																					<button class="btn btn-simple" rel="tooltip" title="Flip Card" onclick="rotateCard(this)">
																						<i class="fa fa-reply"></i> Back
																					</button>
																					<div class="social-links text-center">
																						<a href="javascript:void(0)" onclick="update('${wlist.w_no}')">
																							<i class="glyphicon glyphicon-edit"></i>
																						</a> 
																						<a href="javascript:void(0)" onclick="del('${wlist.w_mno}', '${wlist.w_no}')">
																							<i class="glyphicon glyphicon-trash"></i>
																						</a>
																					</div>
																				</div>
																			</div><!-- end back panel -->
																		</div><!-- end card -->
																	</div><!-- end card-container -->
																</div><!-- end col-sm-3 -->
																<c:set var="mno" value="${wlist.w_mno}" />
																<c:set var="lock" value="${lock + 1}"/>
															</c:if>
														</c:forEach>
														
														<!--추가카드 시작~~~~~~  -->
														<div class="col-md-4 col-sm-4">
															<div class="card-container manual-flip">

																<div class="card">
																	<div class="front">
																		<div class="cover" align="center">
																			<a href="javascript:void(0);" id="iteminsert" name="iteminsert" onclick="insert('${mno}','${insertgnum}')"> 
																				<img src="resources/image/add-icon.png" style="margin-left: 0; margin-right: 0;"/>
																			</a>
																		</div>
																		<!-- <div class="user">
																		<img class="img-circle" src="resources/cardimg/add-icon.png" />
																	</div> -->
																		<div class="content">
																			<div class="main">
																				<h3 class="name">여기서 추가가 가능합니다</h3>
																				<p class="profession">Product Manager</p>
																				<p class="text-center col-md-8-offset-2">URL을 붙여넣으면 자동으로 정보가 입력됩니다</p>
																			</div>
																			<div class="footer">
																				<!-- <div class="rating"> -->
																				<!-- <i class="fa fa-mail-forward"></i> 자동 Rotation -->
																				<div class="social-links text-center">
																					<a href="javascript:void(0);" id="iteminsert" name="iteminsert">
																						<i class="glyphicon glyphicon-ok-circle"></i>
																					</a> 
																					<a href="javascript:void(0);" id="reset" name="reset">
																						<i class="glyphicon glyphicon-repeat"></i>
																					</a>
																				</div>
																			</div>
																		</div>
																	</div><!-- end front panel -->
																</div><!-- end card-container -->
															</div><!-- end col-sm-3 -->
														</div><!-- end col-sm-10 -->
														<!--추가카드 끝~~~~~~  -->


													</div><!-- end row -->
												</div><!-- end row -->
												<div class="space-100"></div>
											</div>
											<!--상품 카드 끝자리  -->

										</table>
										<%-- <c:if test="${wgroup.wg_no == null}"> --%>
										<c:if test="${cnt == 0}">
											<p>새로운 물품을 추가하세요</p>
										</c:if>
									</div>
								</div>
							</div>
						</c:forEach>
						<!-- ---------------기존 등록된 소원목록 뽑기 끝------------------------ -->
					</div>
				</div>
			</div>
		</div>


		<!-- --------수정 모달 팝업-------- -->
		<c:forEach var="wishgrp" items="${wishgroup}">


			<div class="modal fade" id="edit${wishgrp.wg_no }" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal">
								<span aria-hidden="true">×</span><span class="sr-only">Close</span>
							</button>
							<h4 class="modal-title" id="myModalLabel${wishgrp.wg_no }">${wishgrp.wg_detail }</h4>
						</div>
						<div class="modal-body">
							<div class="input-group">
								<input type="text" class="form-control" id="new_wg_detail${wishgrp.wg_no }" placeholder="변경할 목록이름">
								<input type="hidden" value=""> <span class="input-group-btn">
									<button class="btn btn-success" type="button" onclick="changeWgrp(${wishgrp.wg_no}, '${wishgrp.wg_detail}')">변경</button>
								</span>
							</div>
							<!-- /input-group -->
						</div>
						<!-- <div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
				<button type="button" class="btn btn-primary" id="btn_editConfirm" >저장하기</button>
	      		</div> -->
					</div>
				</div>
			</div>

		</c:forEach>
		<!-- --------수정 모달 팝업 끝-------- -->
		<!-- --------삭제 모달 팝업-------- -->
		<div class="modal fade" id="delete" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">
							<span aria-hidden="true">×</span><span class="sr-only">Close</span>
						</button>
						<h4 class="modal-title" id="myModalLabel">현재 선택된 소망 리스트를 삭제하시겠습니까?</h4>
					</div>
					<!-- <div class="modal-body">
					<div class="input-group">
				      	현재 선택된 소망 리스트를 삭제하시겠습니까? 
				    </div>/input-group
	      		</div> -->
					<div class="modal-footer">
						<button type="button" class="btn btn-primary" data-dismiss="modal">취소</button>
						<button type="button" class="btn btn-danger" id="btn_deleteConfirm">삭제하기</button>
					</div>
				</div>
			</div>
		</div>
		<!-- --------삭제 모달 팝업 끝-------- -->
	</div>


	<!-- Insert 모달 팝업 BEGINNING-->
	<div class="modal fade" id="insertModal" tabindex="-1" role="dialog" aria-labelledby="insertModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="insertModalLabel">수정</h4>
				</div>
				<div class="modal-body">
					<form action="insertWishList" method="post">
						<label class="form-control-label">URL:</label>
						<div class="form-group sss">
							<input type="text" class="form-control" placeholder="URL" id="itemUrl" name="w_addr" style="width: 480px"> 
							<input type="button" value="Fetch" class="form-control" id="btnfetch" style="width: 60px">
						</div>
						<div class="row">
							<div class="col-md-7">
								<div class="form-group">
									<label class="form-control-label">Item Name:</label> 
									<input type="text" class="form-control" placeholder="Item Name" id="itemName" name="w_pname">
								</div>
								<div class="form-group">
									<label class="form-control-label">Item Price:</label> 
									<input type="text" class="form-control" placeholder="price" id="itemPrice" name="w_price">
								</div>
							</div>
							<div class="col-md-5">
								<div class="form-group ">
									<img id="itemImage" class="img-responsive" alt="Responsive image"> 
									<input type="hidden" id="submitImage" name="w_image">
								</div>
							</div>
						</div>
						<div class="form-group">
							<label for="message-text" class="form-control-label">Write Your Item Detail:</label>
							<textarea class="form-control" id="itemDetail" name="w_detail"></textarea>
							<input type="hidden" id="itemMno" name="w_mno"> 
							<input type="hidden" id="itemGnum" name="g_num">
							<input type="hidden" id="lockstatus" name="w_lock" value="1">
							<input type="hidden" id="wg" name="wg_detail" value="${wgdetail}">
						</div>
						<div class="modal-footer">
							<button type="submit" class="btn btn-primary" id="insertconfirm">Insert</button>
							<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<!-- Insert 모달 팝업 END-->


	<!-- 수정모달 팝업 BEGINNING-->
	<div class="modal fade" id="updateModal" tabindex="-1" role="dialog"
		aria-labelledby="updateModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="updateModalLabel">수정</h4>
				</div>
				<div class="modal-body">
					<form action="updateWishList" method="post">
						<div class="form-group">
							<label class="form-control-label">Item Name:</label> 
							<input type="text" class="form-control" id="itemName" name="w_pname">
						</div>
						<div class="form-group">
							<label class="form-control-label">Item Price:</label> 
							<input type="text" class="form-control" id="itemPrice" name="w_price">
						</div>
						<div class="form-group">
							<label for="message-text" class="form-control-label">Rewrite Your Item Detail:</label>
							<textarea class="form-control" id="itemDetail" name="w_detail"></textarea>
							<input type="hidden" id="itemMno" name="w_mno"> <input type="hidden" id="itemNo" name="w_no">
						</div>
						<div class="modal-footer">
							<button type="submit" class="btn btn-primary" id="updateconfirm">Confirm</button>
							<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<!-- 수정모달 팝업 END-->

	<!-- 삭제 모달 팝업 BEGINNING -->
	<div class="modal fade" id="deleteModal" tabindex="-1" role="dialog" aria-labelledby="deleteModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="deleteModalLabel">삭제?</h4>
				</div>
				<div class="modal-body">
					<form action="deleteWishList" method="get">
						<div class="form-group">
							<input type="hidden" id="itemNo" name="w_no"> 
							<input type="hidden" id="itemMno" name="w_mno">
						</div>
						<button type="submit" class="btn btn-primary" id="deleteconfirm">Confirm</button>
						<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
					</form>
				</div>
			</div>
		</div>
	</div>
	<!-- 삭제 모달 팝업 END -->

</body>
<%@ include file="bottom.jsp"%>
</html>























