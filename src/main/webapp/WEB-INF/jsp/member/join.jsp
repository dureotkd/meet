<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../part/head.jspf"%>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/js-sha256/0.9.0/sha256.min.js"></script>

<style>
	h1 {
		text-align:center;
	}
	
	form {
		display:flex;
		justify-content:center;
		flex-direction:column;
		align-items:center;
	}
	
</style>

<h1>회원가입</h1>

<form action="doJoin" method="POST"
	onsubmit="MemberJoinForm__submit(this); return false;">
	<input type="hidden" name="redirectUri" value="member/login" /> <input
		type="hidden" name="loginPwReal" />
<table>
	<colgroup>
		<col width="100">
	</colgroup>
	<tr>
		<th>이메일</th>
		<td><div class="">
				<input type="email" name="email" />
			</div></td>
	</tr>
	<tr>
		<th>티어</th>
		<td><div class="">
				<input type="text" name="tier" />
			</div></td>
	</tr>
	<tr>
		<th>닉네임</th>
		<td><div class="">
				<input type="text" name="nickname" />
			</div></td>
	</tr>
	<tr>
		<th>비밀번호</th>
		<td><div class="">
				<input type="password" name="loginPw" />
			</div></td>
	</tr>
	
	
</table>
<input type="submit"  class="submit" />

</form>



<%@ include file="../part/foot.jspf"%>