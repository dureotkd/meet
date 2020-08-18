<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../part/head.jspf"%>

<h1>비매너 유저를 등록해주세요!</h1>

<form action="registered" method="POST" onsubmit="PrisonRegisterForm_submit(this); return false;">
<input type="hidden" name="redirectUri" value="../home/main" />
<input type="text" name="nickname" placeholder="소환사명" />
<input type="text" name="tier" placeholder="티어" />
<input type="submit" class="submit" />
</form>

<%@ include file="../part/foot.jspf"%>

