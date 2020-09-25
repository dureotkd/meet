<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../part/head.jspf"%>

<link
	href="https://fonts.googleapis.com/css2?family=Nanum+Myeongjo:wght@400;700;800&display=swap"
	rel="stylesheet">

<script>

$(function() {
     $('#selectBox2').change(function(){
    if ($('#selectBox2').val() == 'videoBox'){
      $('#selectBox').hide();
      $('#selectBoxVideo').show();
      $('.input3').hide();
	  $('.input2').hide();
	  $('.input1').hide();
	  $('.input4').show();
    } else {
      $('#selectBox').show();
      $('#selectBoxVideo').hide();
      $('.input4').hide();
      $('.input1').show();
    }
  });
		$('#selectBox').change(function() {
			if ($('#selectBox').val() == 'img1') {
				$('.input1').show();
				$('.input2').hide();
				$('.input3').hide();
        		$('.input4').hide();
			}
			if ($('#selectBox').val() == 'img2') {
				$('.input1').show();
				$('.input2').show();
				$('.input3').hide();
        		$('.input4').hide();
			}
			if ($('#selectBox').val() == 'img3') {
				$('.input3').show();
				$('.input2').show();
				$('.input1').show();
       		    $('.input4').hide();
			}
		});
	});

	var ArticleWriteForm__submitDone = false;
	function ArticleWriteForm__submit(form) {
		if (ArticleWriteForm__submitDone) {
			alert('처리중입니다.');
			return;
		}
		form.title.value = form.title.value.trim();
		if (form.title.value.length == 0) {
			form.title.focus();
			alert('제목을 입력해주세요.');
			return;
		}
		form.body.value = form.body.value.trim();
		if (form.body.value.length == 0) {
			form.body.focus();
			alert('내용을 입력해주세요.');
			return;
		}
		var maxSizeMb = 50;
		var maxSize = maxSizeMb * 1024 * 1024 //50MB

		if (form.file__article__0__common__attachment__1.value) {
			if (form.file__article__0__common__attachment__1.size > maxSize) {
				alert(maxSizeMb + "MB 이하의 파일을 업로드 해주세요.");
				return;
			}

		}
		if (form.file__article__0__common__attachment__2.value) {
			if (form.file__article__0__common__attachment__2.files[0].size > maxSize) {
				alert(maxSizeMb + "MB 이하의 파일을 업로드 해주세요.");
				return;
			}
		}
		if (form.file__article__0__common__attachment__3.value) {
			if (form.file__article__0__common__attachment__3.files[0].size > maxSize) {
				alert(maxSizeMb + "MB 이하의 파일을 업로드 해주세요.");
				return;
			}
		}
		if (form.file__article__0__common__attachment__4.value) {
			if (form.file__article__0__common__attachment__4.files[0].size > maxSize) {
				alert(maxSizeMb + "MB 이하의 파일을 업로드 해주세요.");
				return;
			}
		}
		if (form.file__article__0__common__attachment__5.value) {
			if (form.file__article__0__common__attachment__5.files[0].size > maxSize) {
				alert(maxSizeMb + "MB 이하의 파일을 업로드 해주세요.");
				return;
			}
		}
		var startUploadFiles = function(onSuccess) {
			if (form.file__article__0__common__attachment__1.value.length == 0
					&& form.file__article__0__common__attachment__2.value.length == 0
					&& form.file__article__0__common__attachment__3.value.length == 0
					&& form.file__article__0__common__attachment__4.value.length == 0
					&& form.file__article__0__common__attachment__5.value.length == 0) {
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
		ArticleWriteForm__submitDone = true;
		startUploadFiles(function(data) {
			var fileIdsStr = '';
			if (data && data.body && data.body.fileIdsStr) {
				fileIdsStr = data.body.fileIdsStr;
			}
			form.fileIdsStr.value = fileIdsStr;
			form.file__article__0__common__attachment__1.value = '';
			form.file__article__0__common__attachment__2.value = '';
			form.file__article__0__common__attachment__3.value = '';
			form.file__article__0__common__attachment__4.vlaue = '';
			form.file__article__0__common__attachment__5.value = '';
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
#selectBoxVideo {
	display:none;
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
	.wrapping {
		flex-direction: column;
	}
	.file-con {
		display: none;
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
				${articleIdCount+1}번째 글입니다 .</h2>
		</div>
	</div>

	<div class="write-wrap">
		<form class="form-box" method="POST"
			onsubmit="ArticleWriteForm__submit(this); return false;"
			action="doWriteArticle">
			<input
				type="hidden" name="memberId" value="${loginedMemberId}" /> <input
				type="hidden" name="redirectUri" value="detail?id=#id" /> <input
				type="hidden" name="fileIdsStr"> <input type="hidden"
				name="title" placeholder="제목" value="1" />

			<div class="f-box">
				<label for="video"></label> <input type="hidden" accept="video/*"
					name="file__article__0__common__attachment__1" /> <select
					name="selectBox2" id="selectBox2">
					<option selected value="imgBox">이미지</option>
					<option value="videoBox">비디오</option>
				</select> <select name="selectBoxVideo" id="selectBoxVideo">
					<option selected value="video1">비디오 1개</option>
				</select> <select name="selectBox" id="selectBox">
					<option selected value="img1">이미지 1개</option>
					<option value="img2">이미지 2개</option>
					<option value="img3">이미지 3개</option>
				</select>

				<div class="wrapping">
					<div class="input1">
						<input type="file" accept="image/*"
							name="file__article__0__common__attachment__3">
					</div>

					<div class="input2 none">

						<input type="file" accept="image/*"
							name="file__article__0__common__attachment__4">
					</div>

					<div class="input3 none">
						<input type="file" accept="image/*"
							name="file__article__0__common__attachment__5">
					</div>

					<div class="input4 none">
							<input type="file" accept="video/*"
				name="file__article__0__common__attachment__2" /> 
					</div>
				</div>

			</div>
			<div class="wrapping">
				<input type="hidden" name="tag" />
				<div class="input-img">
					<div class="file-con">
						<img
							src="https://data.photo-ac.com/data/thumbnails/7a/7acf9df1e8b0588d23c8b36530540aa0_t.jpeg"
							id="imgpreview1" class="file-upload" />
					</div>

					<div class="textarea-box">
						<textarea name="body" class="font3" cols="30" rows="10"
							placeholder="내용을 입력해주세요." autofocus></textarea>
						<input type="submit" class="submit" value="저장" />
					</div>
				</div>
			</div>
		</form>
	</div>
</div>
<%@ include file="../part/foot.jspf"%>
