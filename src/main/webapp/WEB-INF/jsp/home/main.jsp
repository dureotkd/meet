<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../part/head.jspf"%>

<style>
h1 {
	margin-top:100px;
}
.search-box {
	display:flex;
	flex-direction:column;
	align-items:center;
}
.search-box {
	margin-top:300px;
}
.search {
	width:500px;
	height:100px;
	font-size:1.5rem;
}
</style>

<h1> [비매너 유저 검색 사이트] </h1>

<a href="../prison/register">비매너 유저등록</a>
<a href="../member/login">로그인</a>

<form action="detail" method="POST" onsubmit="PrisonSearchForm_submit(this) return false;">
<div class="search-box">
<input type="search" class="search" name="searchKeyword"  placeholder="비매너 소환사명을 입력해주세요."/>
<input type="submit" class="submit" value="검색"/>
</div>
</form>


<%@ include file="../part/foot.jspf"%>