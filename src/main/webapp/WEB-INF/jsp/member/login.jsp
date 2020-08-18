<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../part/head.jspf" %>





<div class="login-form-box">
<form action="doLogin" class="login-form" onsubmit="loginForm_submit(this); return false;" >
<input type="hidden" name="redirectUri" value="${param.redirectUri}" />
<input type="hidden" name="loginPwReal"  />
<input type="text"  name="nickname" class="login-input-box" placeholder="소환사명"/>
<input type="password" name="loginPw" class="login-input-box" placeholder="비밀번호"/>
<input type="submit" class="submit" value="Go" />
</form>

<div class="join-box"><p>if you wanna Join ?</p> <a href="./join"><div class="join-item">Join</div></a></div>

</div>


<%@ include file="../part/foot.jspf" %>