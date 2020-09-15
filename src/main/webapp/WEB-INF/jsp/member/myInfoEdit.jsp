<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../part/head.jspf"%>

<script>
var sel_file;

$(document).ready(function() {
	$("#ex_file").on("change", handleImgFileSelect);
});

function handleImgFileSelect(e) {
	var files = e.target.files;
	var filesArr = Array.prototype.slice.call(files);

	filesArr.forEach(function(f) {
		if (!f.type.match("image.*")) {
			alert("확장자는 이미지 확장자만 가능합니다.");
			return;
		}
		sel_file = f;

		var reader = new FileReader();

		reader.onload = function(e) {
			$("#img").attr("src", e.target.result);
		}
		reader.readAsDataURL(f);
	});
}

var MemberModifyForm__submitDone = false;
function MemberModifyForm__submit(form) {
	var fileInput1 = form["file__member__" + param.id
			+ "__common__attachment__1"];
	
	if (MemberModifyForm__submitDone) {
		alert('처리중입니다.');
		return;
	}

	var maxSizeMb = 50;
	var maxSize = maxSizeMb * 1024 * 1024 //50MB
	if (fileInput1.value) {
		if (fileInput1.files[0].size > maxSize) {
			alert(maxSizeMb + "MB 이하의 파일을 업로드 해주세요.");
			return;
		}
	}

	var startUploadFiles = function(onSuccess) {
		if (fileInput1.value.length == 0 ) {
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
	MemberModifyForm__submitDone = true;
	startUploadFiles(function(data) {
		var fileIdsStr = '';
		if (data && data.body && data.body.fileIdsStr) {
			fileIdsStr = data.body.fileIdsStr;
		}
		form.fileIdsStr.value = fileIdsStr;
		fileInput1.value = '';
		form.submit();
	});
}
</script>

<style>
.temp {
	margin-top:100px;
}
.imgBox {
	overflow:hidden;
	width:100px;
	height:100px;
	border-radius:50%;
	margin-bottom:20px;
}
.profile {
	width:100%;
	height:100%;
	object-fit:cover;
	cursor:pointer;
}
.menu {
	width:300px;
	border-right:1px solid #e0e0e0;
}
.column {
	display:flex;
	flex-direction:column;
	justify-content:space-around;
}
.wrap {
	margin:0px auto;
	margin-top:100px;
	max-width:940px;
	display:flex;
}
.padding25{
	padding:25px;
}
.silver {
	color:#262626;
}
.w100 {
	width:100%;
	display:flex;
	flex-direction:column;
	align-items:center;
}
.inputItem {
	width:320px;
	height:32px;
	border:1px solid #bdbdbd;
	border-radius:3px;
	padding:10px;
	outline:none;
	margin-bottom:20px;
}
.Big {
	height:70px;
}
.row {
	display:flex;
}
label {
	font-size:14px;
	color:#757575;
	margin-bottom:10px;
}
.label{
	font-size:14px;
	color:#757575;
}
.margin-bottom30 {
	margin-bottom:30px;
}
.w100px {
	width:100px;
}
.sp-b {
	justify-content:space-between;
}
.blue {
	color:#0095f6;
}
.size {
	font-size:14px;
}
.submit2 {
	border-radius:3px;
	background:#0095f6;
	color:#fff;
	border:none;
	outline:none;
	padding:5px;
}
.mini {
	font-size:13px;
	margin-bottom:10px;
}
.profile-file {
	position: absolute;
	width: 1px;
	height: 1px;
	padding: 0;
	magin: -1px;
	overflow: hidden;
	clip: rect(0, 0, 0, 0);
	border: 0;
}
@media ( max-width :800px ) {
	.visible-none {
		display: none;
	}
}
@media ( min-width:801px ){
	.wrap {
	background:#fff;
	border:1px solid  #e0e0e0;
	}
	.imgBox {
	margin-top:20px;
	}
	
}
</style>

<div class="wrap margin-bottom30">
<ul class="menu column visible-none">
	<li><a href="#" class="padding25 silver">프로필 편집</a></li>
	<li><a href="#" class="padding25 silver">비밀번호 변경</a></li>
	<li><a href="#" class="padding25 silver">공개 범위 및 보안</a></li>
	<li><a href="#" class="padding25 silver">푸시 알림</a></li>
	<li><a href="#" class="padding25 silver">계정 삭제</a></li>
</ul>
<form action="doMyInfoEdit" method="POST" onsubmit="MemberModifyForm__submit(this); return false;" class="w100">
<div class="imgBox">
<label for="ex_file">
<img class="profile file-upload" id="img" src="/meet/file/showImg?id=${loginedMember.extra.file__common__attachment['1'].id}&updateDate=${loginedMember.extra.file__common__attachment['1'].updateDate}" />
</label>
<input type="file" id="ex_file" class="profile-file"  accept="image/*" name="file__member__${loginedMember.id}__common__attachment__1"/>
</div>

<div class="column">
<input type="hidden" name="fileIdsStr" />
<input class="inputItem" type="hidden" name="redirectUri" value="../member/myInfoEdit" />
<input class="inputItem" type="hidden" name="id" value="${loginedMember.id}" />
<label for="">이메일</label>
<input class="inputItem" type="email"  name="email" value="${loginedMember.email}"/>
<label for="">이름</label>
<input class="inputItem" type="text"  name="name" value="${loginedMember.name}"/>
<label for="" class="label">사용자 이름</label>
<span class="mini red">*사용자 이름은 14일 안에 두 번만 변경할 수 있습니다.</span>
<input class="inputItem" type="text" name="nickname"  value="${loginedMember.nickname}" />
<label for="">소개</label>
<textarea class="inputItem Big" type="text" name="introduce" id="" cols="30" rows="10" name="introduce">${loginedMember.introduce}</textarea>
<div class="row sp-b">
<input type="submit" class="submit2 margin-bottom30 w100px " value="저장" />
<a href="./showDisAbledForm" class="blue size14 size" onclick="">계정을 일시적으로 비활성화</a>
</div>
</div>
</form>
</div>

<%@ include file="../part/foot.jspf"%>