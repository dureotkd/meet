<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../part/head.jspf"%>

<h1>글쓰기</h1>

<form action="registered" method="POST" onsubmit="ArticleRegisterForm_submit(this); return false;">
<input type="hidden" name="redirectUri" value="../home/main" />
<input type="text" name="title" placeholder="제목" />
<textarea name="body"  id="" cols="30" rows="10" placeholder="내용" ></textarea>
<input type="hidden" name="memberId"  value="${loginedMemberId}" />
<input type="submit" class="submit" />
</form>

<%@ include file="../part/foot.jspf"%>

