<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../part/head.jspf"%>

<h1>${loginedMember.nickname} 님 정보</h1>


<p class="center">가입날짜 : ${loginedMember.regDate}</p>
<p class="center">이메일 : ${loginedMember.email}</p>
<p class="center">성명 : ${loginedMember.name}</p>
<p class="center">활동명 : ${loginedMember.nickname}</p>
<a href="passwordForPrivate" class="center">회원정보수정</a>

<%@ include file="../part/foot.jspf"%>