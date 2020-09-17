<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../part/head.jspf"%>

<link
	href="https://fonts.googleapis.com/css2?family=Nanum+Myeongjo:wght@400;700;800&display=swap"
	rel="stylesheet">

<script>
var MemberJoinForm__submitDone = false;
function MemberJoinForm__submit(form) {
	if (MemberJoinForm__submitDone) {
		alert('처리중입니다.');
		return;
	}

	var maxSizeMb = 50;
	var maxSize = maxSizeMb * 1024 * 1024 //50MB

	if (form.file__story__0__common__attachment__1.value) {
		if (form.file__story__0__common__attachment__1.files[0].size > maxSize) {
			alert(maxSizeMb + "MB 이하의 파일을 업로드 해주세요.");
			return;
		}
	}

	var startUploadFiles = function(onSuccess) {
		if (form.file__story__0__common__attachment__1.value.length == 0) {
			onSuccess();
			return;
		}

		var fileUploadFormData = new FormData(form);

		$.ajax({
			url : './../file/doUploadAjax',
			data : fileUploadFormData,
			processData : false,
			contentType : false,
			dataType : "json",
			type : 'POST',
			success : onSuccess
		});
	}

	MemberJoinForm__submitDone = true;
	startUploadFiles(function(data) {
		var fileIdsStr = '';

		if (data && data.body && data.body.fileIdsStr) {
			fileIdsStr = data.body.fileIdsStr;
		}

		form.fileIdsStr.value = fileIdsStr;
		form.file__story__0__common__attachment__1.value = '';
		form.submit();

	});
}
</script>

<style>
.total-wrap {
	width: 100%;
	height: 100vh;
	background: #fafafa;
}

.fa-plus {
	color: #484848;
}

.im-co-plus {
	color: black !important;
}

.submit {
	background: none;
	border: 1px solid #f50057;
	color: #f50057;
	font-size: 13px;
	padding: 10px;
	cursor: pointer;
	width: 100px;
	border-radius: 15px;
	outline: none;
	margin: 0 auto;
	margin-bottom: 10px;
}

.write-wrap {
	display: flex;
	justify-content: center;
	align-items: center;
	margin: 100px auto;
	box-sizing: border-box;
	max-width: 940px;
	position: relative;
	box-shadow: rgba(0, 0, 0, 0.1) 0px 1px 20px 0px;
}

.logined-wrap {
	display: flex;
	align-items: center;
	margin: 100px auto;
	box-sizing: border-box;
	max-width: 940px;
	padding: 8px;
	position: relative;
	box-shadow: rgba(0, 0, 0, 0.1) 0px 1px 20px 0px;
}

.form-box {
	display: flex;
	flex-direction: column;
	width: 100%;
}

.font3 {
	font-family: 'Nanum Myeongjo', serif;
}

textarea {
	background: none;
	padding: 10px;
	font-size: 1.3rem;
	border: none;
	outline: none;
}

.input-img {
	display: flex;
	justify-content: space-between;
	width: 100%;
}

.board-item {
	display: flex;
	margin-bottom: 20px;
	align-items: center;
	jusitfy-content: center;
	text-align: center;
}

.board-item>a {
	width: 100%;
}

.wrapping {
	display: flex;
}

.file-upload {
	width: 100%;
	height: 100%;
	object-fit: cover;
}

.file-con {
	height: 400px;
	overflow: hidden;
	margin: 0 auto;
}

.none {
	display: none;
}

.file1 {
	position: absolute;
	width: 1px;
	height: 1px;
	padding: 0;
	magin: -1px;
	overflow: hidden;
	clip: rect(0, 0, 0, 0);
	border: 0;
}

.textarea-box {
	display: flex;
	flex-direction: column;
	width: 50%;
	justify-content: space-between;
}

.img-logo {
	border-radius: 50%;
	font-size: 1.3rem;
	padding: 13px;
	position: absolute;
	top: -60px;
	box-shadow: 0 10px 10px -12px rgba(0, 0, 0, 0.56), 0 4px 10px 0px
		rgba(0, 0, 0, 0.12), 0 8px 10px -10px rgba(0, 0, 0, 0.2);
}

.label-1, .label-2, .label-3 {
	width: 1px;
}

.login-box {
	width: 100px;
	height: 100px;
	overflow: hidden;
}

.login-profile {
	width: 100%;
	height: 100%;
	object-fit: cover;
}

.login-reco {
	display: flex;
	flex-direction: column;
	margin-left: 20px;
}

.small-font {
	font-size: 18px;
	color: #bdbdbd;
	line-height: 35px;
}

.wrapping {
	display: flex;
}

@media ( max-width :800px) {
	.input-img {
		flex-direction: column;
	}
}
</style>

<div class="total-wrap">

	<div class="logined-wrap">
		<div class="login-box">
			<img class="login-profile"
				src="/meet/file/showImg?id=${loginedMember.extra.file__common__attachment['1'].id}&updateDate=${loginedMember.extra.file__common__attachment['1'].updateDate}" />
		</div>
		<div class="login-reco">
			<h2 class="font3">${loginedMember.nickname}님의
				${articleIdCount+1}번째 스토리입니다 .</h2>
		</div>
	</div>

	<div class="write-wrap">
		<form class="form-box" method="POST"
			onsubmit="MemberJoinForm__submit(this); return false;"
			action="../article/doWriteStory">
			<input type="hidden" name="memberId" value="${loginedMemberId}" /> <input
				type="hidden" name="redirectUri"
				value="../member/showOther?id=${loginedMemberId}" /> <input
				type="hidden" name="fileIdsStr"> <input type="hidden"
				name="title" placeholder="제목" value="1" />

			<div class="f-box">
				<label for="video"></label>
				<div class="wrapping">
					<input type="hidden" name="tag" /> 
					<input type="file" id="ex_file" class="login-input-box"
					placeholder="프로필" accept="video/*"
					name="file__story__0__common__attachment__1">
					<div class="textarea-box">
						<textarea name="title" class="font3" cols="30" rows="10"
							placeholder="제목을 입력해주세요." autofocus></textarea>
						<input type="submit" class="submit" value="저장"
							onclick="articleWriteNotify()" />
					</div>

				</div>
			</div>
		</form>
	</div>
</div>
<%@ include file="../part/foot.jspf"%>
