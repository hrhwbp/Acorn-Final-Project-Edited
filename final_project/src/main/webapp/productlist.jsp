<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html">
<html>
<head>
<meta charset="UTF-8">
<title>Home</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$("#btn1").click(function(){
		$.ajax({
			type:"post",
			url:"urltest",
			data: {"url":$("#url").val()},
			dataType: "json",
			success: function(productData){
				var str = "<table border='1'>";
				str += "<tr><th>이름</th><th>가격</th><th>가격</th></tr>";
				
				var list = productData.productlist;
				$(list).each(function(index, objArr){
					str += "<tr>"
					str += "<td>" + objArr["name"] + "</td>";
					str += "<td>" + objArr["price"] + "</td>";
					str += "<td><img src='" + objArr["image"] + "'></td>";
					str += "</tr>";
				});
				str += "</table><br>";
				
				//str += "<img src='" + list.image + "'>";
				
				/* $(list).each(function(index, objArr){
					str += "<img src='" + objArr["image"] + "'>";
				}); */
				
				$("#list").append(str);
				
			},
			error: function(){
				alert("에러 발생");
			}
		});
	});
});
</script>
</head>
<body>
<h1>parsing test</h1>

url: <input type="text" id="url" name="url">	
<input type="button" id="btn1" value="확인">
<img src="">
<div id="list"></div><br>	

</body>
</html>