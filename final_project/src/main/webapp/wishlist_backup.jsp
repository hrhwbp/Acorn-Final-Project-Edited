<%@page import="org.apache.ibatis.javassist.bytecode.annotation.AnnotationImpl"%>
<%@page import="com.remind.model.AnnoInter"%>
<%@page 
import="com.remind.model.DataDao"
import="com.remind.model.WishlistDto"
import="java.util.List"
import="com.remind.controller.WishlistBean"
import="com.fasterxml.jackson.annotation.JsonInclude.Include"
language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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

<script type="text/javascript">
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

</script>
<style type="text/css">


</style>
</head>

<%@ include file="top.jsp" %>
<body>

<div class="container col-md-8 col-md-offset-2">
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
								<a class="accordion-toggle" data-toggle="collapse"
									data-parent="#accordion" href="#collapseThree"> 새로운 소원목록
									작성하기</a>
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
					<c:forEach var="wgroup" items="${wishgroup }" varStatus="status">
					<div class="panel panel-default">
						<div class="panel-heading">
							<table width="100%">
								<tr>
									<td width="86%">
									
									<h4 class="panel-title" id="wishGrpChange${wgroup.wg_no }">										
										<span class="badge">${itemcnt.count }</span><a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseTwo_${wgroup.wg_no}"> ${wgroup.wg_detail}</a>
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
										</div> 
									<!-- 버튼그룹 삽입 끝 -->
									</td>
								</tr>
							</table>
						</div>
						<div id="collapseTwo_${wgroup.wg_no}"
							class="panel-collapse collapse">
							<div class="panel-body">
								<!-- ---------각 상품 내용이 들어갈 자리-----------  -->
								
								<table border="1"  width="100%" class="table table-striped table-bordered table-hover" style="text-align: center; vertical-align: center;">
									<c:set var="cnt" value="0" />
									<c:forEach var="wlist" items="${wishlist }" varStatus="itemcnt">
												<c:if test="${wgroup.wg_no eq wlist.g_num}">
													<c:set var="cnt" value="${cnt += 1 }" />
													<c:if test="${cnt == 1 }">
														<tr class="success">
															<td width="20%">상품사진</td>
															<td width="20%">상품명</td>
															<td width="15%">가격정보</td>
															<td width="45%">상세정보</td>
														</tr>
													</c:if>
													<tr>
														<td><img alt="${wlist.w_pname}"
															src="${wlist.w_image}" width="100%" /></td>
														<td>${wlist.w_pname}</td>
														<td>${wlist.w_price}</td>
														<td>${wlist.w_detail}</td>
													</tr>
												</c:if>
											</c:forEach>
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
					<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">Close</span></button>
					<h4 class="modal-title" id="myModalLabel${wishgrp.wg_no }">${wishgrp.wg_detail }</h4>
	      		</div>
	      		<div class="modal-body">
					<div class="input-group">
				      <input type="text" class="form-control" id="new_wg_detail${wishgrp.wg_no }" placeholder="변경할 목록이름">
				      <input type="hidden" value="">
				      <span class="input-group-btn">
				        <button class="btn btn-success" type="button" onclick="changeWgrp(${wishgrp.wg_no}, '${wishgrp.wg_detail}')">변경</button>
				      </span>
				    </div><!-- /input-group -->
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
	<div class="modal fade" id="delete" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">Close</span></button>
					<h4 class="modal-title" id="myModalLabel">현재 선택된 소망 리스트를 삭제하시겠습니까?</h4>
	      		</div>
	      		<!-- <div class="modal-body">
					<div class="input-group">
				      	현재 선택된 소망 리스트를 삭제하시겠습니까? 
				    </div>/input-group
	      		</div> -->
	      		<div class="modal-footer">
				<button type="button" class="btn btn-primary" data-dismiss="modal">취소</button>
				<button type="button" class="btn btn-danger" id="btn_deleteConfirm" >삭제하기</button>
	      		</div>
	    	</div>
		</div>
	</div>
	<!-- --------삭제 모달 팝업 끝-------- -->
</div>

</body>
<%@ include file="bottom.jsp" %>
</html>