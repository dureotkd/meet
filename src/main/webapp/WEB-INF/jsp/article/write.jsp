<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../part/head.jspf"%>

<script>
	var sel_file;

$(document).ready(function() {
	$("#ex_file").on("change", handleImgFileSelect);
});

function handleImgFileSelect(e1) {
	var files1 = e.target.files;
	var filesArr1 = Array.prototype.slice.call(files1);

	filesArr1.forEach(function(f1) {
		if (!f1.type.match("image.*")) {
			alert("확장자는 이미지 확장자만 가능합니다.");
			return;
		}
		sel_file = f1;

		var reader1 = new FileReader();

		reader1.onload = function(e1) {
			$("#img").attr("src", e1.target.result);
		}
		reader.readAsDataURL(f1);
	});
}


var sel_file2;

$(document).ready(function() {
	$("#ex_file2").on("change", handleImgFileSelect);
});

function handleImgFileSelect(e) {
	var files = e.target.files;
	var filesArr = Array.prototype.slice.call(files);

	filesArr.forEach(function(f) {
		if (!f.type.match("image.*")) {
			alert("확장자는 이미지 확장자만 가능합니다.");
			return;
		}
		sel_file2 = f;

		var reader = new FileReader();

		reader.onload = function(e) {
			$("#img2").attr("src", e.target.result);
		}
		reader.readAsDataURL(f);
	});
}


var sel_file3;

$(document).ready(function() {
	$("#ex_file3").on("change", handleImgFileSelect);
});

function handleImgFileSelect(e) {
	var files = e.target.files;
	var filesArr = Array.prototype.slice.call(files);

	filesArr.forEach(function(f) {
		if (!f.type.match("image.*")) {
			alert("확장자는 이미지 확장자만 가능합니다.");
			return;
		}
		sel_file3 = f;

		var reader = new FileReader();

		reader.onload = function(e) {
			$("#img3").attr("src", e.target.result);
		}
		reader.readAsDataURL(f);
	});
}

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
			if (form.file__article__0__common__attachment__1.files[0].size > maxSize) {
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

.write-wrap {
	display: flex;
	justify-content: center;
	align-items: center;
	margin-top:100px;
}

.form-box {
	display: flex;
	padding: 50px;
	border: 1px solid #bdbdbd;
	margin-top: 50px;
	flex-direction: column;
}

textarea {
	background: none;
	padding: 10px;
	font-size: 1.3rem;
}

.input-img {
	display: flex;
	flex-direction: column;
	justify-content: space-between;
	margin-left: 15px;
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
	border-radius: 50%;
}
.file-con {
	width: 100px;
	height: 100px;
	overflow: hidden;
	margin: 0 auto;
	margin-bottom: 20px;
}
input[type="file"] {
	position: absolute;
	width: 1px;
	height: 1px;
	padding: 0;
	magin: -1px;
	overflow: hidden;
	clip: rect(0, 0, 0, 0);
	border: 0;
}
</style>

<div class="total-wrap">
	<div class="write-wrap">
		<form class="form-box" method="POST"	
			onsubmit="ArticleWriteForm__submit(this); return false;"
			action="doWriteArticle">
			<input type="hidden" name="redirectUri" value="detail?id=#id" /> <input
				type="hidden" name="fileIdsStr"> <input type="hidden"
				name="title" placeholder="제목" value="1" />
			<div class="wrapping">
				<textarea name="body" id="" cols="30" rows="10"
					placeholder="지금 무슨일이 일어나고 있나요?" autofocus></textarea>
				<input type="hidden" name="memberId" value="${loginedMemberId}" /> <input
					type="hidden" name="tag" />
				<div class="input-img">
					<label for="">Video</label> 
					<input type="file" accept="video/*"  name="file__article__0__common__attachment__1" />
					<input type="hidden" accept="video/*"  name="file__article__0__common__attachment__2" />				
					<label for="">Image</label>
					
					<div class="file-con">
					<label for="ex_file">
					<img src="https://scontent-cph2-1.cdninstagram.com/v/t51.2885-19/44884218_345707102882519_2446069589734326272_n.jpg?_nc_ht=scontent-cph2-1.cdninstagram.com&_nc_ohc=7xEzH-b7neEAX8-u4aK&oh=03aa0383a46332fd1b76eaa62a308799&oe=5F72988F&ig_cache_key=YW5vbnltb3VzX3Byb2ZpbGVfcGlj.2"
					 id="img" class="file-upload" />
					</label>
					</div>
					
					<div class="file-con">
					<label for="ex_file2">
					<img src="https://scontent-cph2-1.cdninstagram.com/v/t51.2885-19/44884218_345707102882519_2446069589734326272_n.jpg?_nc_ht=scontent-cph2-1.cdninstagram.com&_nc_ohc=7xEzH-b7neEAX8-u4aK&oh=03aa0383a46332fd1b76eaa62a308799&oe=5F72988F&ig_cache_key=YW5vbnltb3VzX3Byb2ZpbGVfcGlj.2"
					id="img2" class="file-upload"  />
					</label>				
					</div>
					
					<div class="file-con">
					<label for="ex_file3">
					<img id="img3" class="file-upload" src="https://scontent-cph2-1.cdninstagram.com/v/t51.2885-19/44884218_345707102882519_2446069589734326272_n.jpg?_nc_ht=scontent-cph2-1.cdninstagram.com&_nc_ohc=7xEzH-b7neEAX8-u4aK&oh=03aa0383a46332fd1b76eaa62a308799&oe=5F72988F&ig_cache_key=YW5vbnltb3VzX3Byb2ZpbGVfcGlj.2" />
					</label>
					</div>
					<input type="file" accept="image/*" id="ex_file" name="file__article__0__common__attachment__3"> 
					<input type="file" accept="image/*" id="ex_file2" name="file__article__0__common__attachment__4">
					<input type="file" accept="image/*" id="ex_file3" name="file__article__0__common__attachment__5">
					<input type="submit" class="submit" onclick="articleWriteNotify()" />
				</div>
			</div>
		</form>
	</div>
</div>
<%@ include file="../part/foot.jspf"%>

