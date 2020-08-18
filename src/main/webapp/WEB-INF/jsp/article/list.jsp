<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../part/head.jspf"%>

<style>
.table-box {
	margin-left: auto;
	margin-right: auto;
	display:flex;
	justify-content:center;
}

.table-box>table {
	width: 50%;
	border-collapse: collapse;
}

.table-box>table th, .table-box>table td {
	border: 1px solid black;
	padding: 10px;
	text-align: left;
}


</style>

<h1>리스트</h1>
<div class="table-box">
	<table>
		<colgroup>
			<col width="100" />
			<col width="200" />
		</colgroup>
		<thead>
			<tr>
				<th>번호</th>
				<th>날짜</th>
				<th>제목</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${articles}" var="article">
				<tr>
					<td>${article.id}</td>
					<td>${article.regDate}</td>
					<td>${article.title}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>
<%@ include file="../part/foot.jspf"%>
