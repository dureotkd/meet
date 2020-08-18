<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../part/head.jspf"%>
    <h1>디테일</h1>
   	<div class="table-box">
   	<table>
   		<colgroup>
			<col width="100" />
			<col width="200" />
		</colgroup>
   		<thead>
   			<tr>
   				<td>번호</td>
   				<td>날짜</td>
   				<td>제목</td>
   				<td>내용</td>
   			</tr>
   		</thead>
   		<tbody>
   			<tr>
   				<td>${article.id}</td>
   				<td>${article.title}</td>
   				<td>${article.regDate}</td>
   				<td>${article.body}</td>
   			</tr>
   		</tbody>
   	</table>
   	</div> 
<%@ include file="../part/foot.jspf"%>