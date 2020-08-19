<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../part/head.jspf"%>

<style>
.Myinfo-profile {
	width:300px;
	height:300px;
	border-radius:50%;
}
</style>

<h1>${loginedMember.nickname}님 정보</h1>

<!-- 회원 프로필   -->
<c:if test="${loginedMember.extra.file__common__attachment['1'] != null}">
	<div class="img-box">
		<img class="Myinfo-profile" src="/file/showImg?id=${loginedMember.extra.file__common__attachment['1'].id}&updateDate=${loginedMember.extra.file__common__attachment['1'].updateDate}" />
	</div>
</c:if>
<p class="center">가입날짜 : ${loginedMember.regDate}</p>
<p class="center">이메일 : ${loginedMember.email}</p>
<p class="center">성명 : ${loginedMember.name}</p>
<p class="center">활동명 : ${loginedMember.nickname}</p>
<p class="center">소개 : ${loginedMember.introduce}</p>
<a class="center" href="myInfoEdit">프로필 편집</a>
<a href="passwordForPrivate" class="center">비밀번호 수정</a>

<%@ include file="../part/foot.jspf"%>