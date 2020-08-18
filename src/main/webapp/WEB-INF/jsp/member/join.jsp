<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../part/head.jspf"%>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/js-sha256/0.9.0/sha256.min.js"></script>

<style>
	h1 {
		text-align:center;
	}
	
	
</style>

<h1>회원가입</h1>

<div class="login-form-box">
<form action="doJoin"  methofd="POST" class="login-form" onsubmit="MemberJoinForm__submit(this); return false;" >
<input type="hidden" name="redirectUri" value="login" />
<input type="hidden" name="loginPwReal"  />
<input type="text"  name="email" class="login-input-box" placeholder="이메일"/>
<input type="text"  name="name" class="login-input-box" placeholder="성명"/>
<input type="text"  name="nickname" class="login-input-box" placeholder="활동명"/>
<input type="password" name="loginPw" class="login-input-box" placeholder="비밀번호"/>
<input type="submit" class="submit" value="Go" />
</form>




<%@ include file="../part/foot.jspf"%>