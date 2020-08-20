<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../part/head.jspf"%>

<h1>총 게시글 : ${articleCount}</h1>
<h1>${member.name}</h1>
<h1>${member.nickname }</h1>
<h1>${member.introduce}</h1>
<form action="follow" >
<input type="text" name="loginedMemberId" value="${loginedMemberId}" />
<input type="text" name="memberId" value="${member.id }" />
<input type="submit"  value="팔로우" />
</form>
<%@ include file="../part/foot.jspf"%>