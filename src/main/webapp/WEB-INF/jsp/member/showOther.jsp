<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../part/head.jspf"%>

<script>
	var id = parseInt('${loginedMemberId}');
	var followId = parseInt('${member.id}');
	var followerId = parseInt('${loginedMemberId}');
	var nickname = parseInt('${member.nickname}');
</script>

<script>
	function doFollow() {
		$.post('../member/doActionFollow', {
			followId : followId,
			followerId : followerId
		}, 'json');
		location.reload();
	}
	var ProfileChangeForm__submitDone = false;

	function ProfileChangeForm__submit(form) {

		var fileInput1 = form["file__member__" + id + "__common__attachment__1"];

		if (ProfileChangeForm__submitDone) {
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
			if (fileInput1.value.length == 0) {
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
		ProfileChangeForm__submitDone = true;
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

	function callDoLike(el) {
		var $li = $(el).closest('li');
		// 가장 가까운 li를 찾아라
		var id = parseInt($li.attr('data-id'));
		// 정수화 -> data-id

		$.post('../article/doLike', {
			id : id
		}, function(data) {
			if (data.msg) {
				alert(data.msg);
			}

			if (data.resultCode.substr(0, 2) == "S-") {
				ViewArticle1__updateLikePoint(data.likePoint);
			}
		}, 'json');

	}

	$(document).ready(function() {
		$(".msgSubmit").on('click', function() {
			$(".popup").show();
			$(".dim").show();
		});
		$(".popup .close").on('click', function() {
			$(this).parent().hide();
			$(".dim").hide();
		});
	});

	function WriteMessage__submitForm(form) {
		form.body.value = form.body.value.trim();
		if (form.body.value.length == 0) {
			alert('메세지를 입력해주세요.');
			form.body.focus();
			return;
		}
		$.post('../message/doWriteMessageAjax', {
			fromId : form.fromId.value,
			toId : form.toId.value,
			body : form.body.value,
			redirectUri : form.redirectUri.value
		}, function(data) {
			if (data.msg) {
				alert(data.msg);
			}
			if (data.resultCode.substr(0, 2) == 'S-') {
				location.reload(); // 임시
			}
		}, 'json');
		form.body.value = '';
	}

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

	function doDeleteFollow(el) {
		if (confirm("팔로우를 취소하시겠습니까 ?") == true) {

			$.post('../member/doDeleteFollow', {
				followId : followId,
				followerId : followerId
			}, function(data) {
				if (data.msg) {
					alert(data.msg);
				}

			}, 'json');
		} else {
			return;
		}

		location.reload();
	}

	function usePriavetAccount() {
		if (confirm("계정을 비공개모드로 전환하시겠습니까 ?") == true) {
			$.post('../member/usePrivateMode', {
				id : id
			}, function(data) {
			}, 'json');
		} else {
			return;
		}
		location.reload();
	}

	function disAblePrivateMode() {
		if (confirm("계정을 비공개모드를 해제하시겠습니까 ?") == true) {
			$.post('../member/disAblePrivateMode', {
				id : id
			}, function(data) {
			}, 'json');
		} else {
			return;
		}
		location.reload();
	}
</script>





<style>
.other-show-box {
	display: flex;
	margin: 50px auto;
	max-width: 940px;
	justify-content: space-between;
	align-items: center;
}

.other-text-box {
	display: flex;
	flex-direction: column;
	justify-content: space-between;
}

.other-follow-box {
	display: flex;
}

.other-img {
	width: 100%;
	height: 100%;
	border-radius: 50%;
	object-fit: cover;
}

.articles-box {
	max-width: 940px;
	margin: 0 auto;
}

.images-wrap {
	transition: all.3s;
	position: relative;
}

.good-item {
	position: absolute;
	color: #d81b60;
	top: 10px;
	left: 10px;
	transition: all.3s;
	opacity: 0;
	cursor: pointer;
	transition: all.3s;
}

.fa-comment-dots {
	position: absolute;
	color: white;
	top: 10px;
	opacity: 0;
	cursor: pointer;
}

.video-x {
	position: absolute;
	top: 10px;
	padding: 5px;
	right: 10px;
	background: #fff;
	border-radius: 50%;
}

.video {
	width: 100%;
	height: 100%;
	object-fit: cover;
}

.images-wrap:hover .video-x {
	display: none;
}

.articles-box>ul {
	display: flex;
	flex-flow: row wrap;
}

.other-articleImg {
	width: 100%;
	height: 100%;
	object-fit: cover;
	transition: all.3s;
	cursor: zoom-in;
}

.other-articleVideo {
	width: 300px;
	height: 300px;
}

.img-wrap {
	text-align: center;
	display: flex;
	flex-direction: column;
}

.img-wrap2 {
	text-align: center;
	display: flex;
	flex-direction: column;
	justify-content: center;
	height: 100%;
}

.other-nick {
	font-size: 1.2rem;
}

.other-followBox {
	display: flex;
	justify-content: left;
}

.other-followBox span {
	margin-right: 30px;
	margin-bottom: 20px;
	margin-top: 20px;
}

.other-info-box {
	display: flex;
	align-items: center;
	justify-content: space-between;
	color: #262626;
}

.level10 {
	color: #ffb300;
}

.level5 {
	color: #3949ab;
}

.submit-item, .msgSubmit {
	padding: 10px;
	background: #0095f6;
	border-radius: 3px;
	border: none;
	cursor: pointer;
	color: white;
	font-size: 15px;
}

.other-recomend-box {
	display: none;
	height: 200px;
	width: 300px;
	justify-content: space-around;
	align-items: center;
	flex-direction: column;
}

.other-recomend-box>p {
	padding: 10px;
}

html, body {
	width: 100%;
}

html {
	-webkit-touch-callout: none;
	-webkit-user-select: none;
	-webkit-tap-highlight-color: rgba(0, 0, 0, 0);
}

ul, ol, li {
	list-style: none;
}

table {
	width: 100%;
	border-spacing: 0;
	border-collapse: collapse;
}

img, fieldset {
	border: 0;
}

address, caption, cite, code, em {
	font-style: normal;
	font-weight: normal;
}

label, img, input, select, textarea, button {
	vertical-align: middle;
}

caption, legend {
	line-height: 0;
	font-size: 1px;
	overflow: hidden;
}

hr {
	display: none;
}

main, header, section, nav, footer, aside, article, figure {
	display: block;
}

a {
	color: #000;
	text-decoration: none;
}

* {
	outline: 0 !important;
	-webkit-tap-highlight-color: rgba(0, 0, 0, 0) !important;
	tap-highlight-color: rgba(0, 0, 0, 0) !important;
}

a:link, a:hover, a:active {
	text-decoration: none;
}

footer {
	text-align: center;
}

/* Form */
.popup {
	display: none;
	position: fixed;
	border-radius: 2px;
	left: 50%;
	top: 50%;
	z-index: 100;
	padding: 25px 60px 60px;
	width: 600px;
	height: 500px;
	transform: translate(-50%, -50%);
	box-sizing: border-box;
	background: #fff;
}

.popup h2 {
	padding: 0 0 42px;
	font-weight: normal;
	font-size: 30px;
	font-family: 'Courgette', cursive;
	color: #d81b60;
	text-align: center;
	line-height: 100%;
}

.popup .close {
	position: absolute;
	right: 30px;
	top: 30px;
	width: 41px;
	height: 41px;
	color: black;
	text-align: center;
}

.popup .con {
	padding: 35px 50px;
	border: 1px solid #e8e8e8;
}

.agree {
	position: relative;
	margin: 28px 0 0;
	padding: 0 30px;
	height: 60px;
	border: 1px solid #e8e8e8;
	line-height: 60px;
}

.agree label span {
	color: #de4f41;
}

.agree a.view {
	position: absolute;
	right: 30px;
	top: 15px;
	width: 93px;
	height: 30px;
	border: 1px solid #ddd;
	text-align: center;
	line-height: 30px;
	border-radius: 3px;
}

.dim {
	display: none;
	position: fixed;
	left: 0;
	top: 0;
	z-index: 99;
	width: 100%;
	height: 100%;
	background: rgba(0, 0, 0, 0.5);
}

table.type1 th, table.type1 td {
	padding: 0 0 20px;
}

table.type1 th {
	padding-top: 15px;
	font-size: 14px;
	color: #222;
	text-align: left;
	font-weight: normal;
	vertical-align: top;
}

table.type1 th span {
	color: #de4f41;
}

table.type1 th em {
	color: #999;
}

table.type1 textarea {
	height: 116px;
}

table.type1 tr:last-child th, table.type1 tr:last-child td {
	padding: 0 0 30px;
}

input[type="checkbox"] {
	position: absolute;
	left: -3000%;
}

input[type="checkbox"]+label {
	font-size: 14px;
	color: #666;
}

input[type="checkbox"]+label:before {
	content: "";
	display: inline-block;
	width: 20px;
	height: 20px;
	border: 1px solid #ddd;
	margin: 0 10px 0 0;
	background: #f4f4f4;
	vertical-align: middle;
	box-sizing: border-box;
	transition: all 0.3s;
}

input[type="checkbox"]:checked+label:before {
	border: 7px solid #666;
}

.txt_center {
	text-align: center;
	padding: 30px 0 0;
}

.btn_type1 {
	display: inline-block;
	width: 170px;
	height: 50px;
	background: #0095f6;
	line-height: 50px;
	color: #fff;
	text-align: center;
	border-radius: 3px;
	border: none;
	outline: none;
}

textarea {
	border: 1px solid #dbdbdb;
}

select {
	height: 32px;
	font-size: 13px;
	color: #373737;
	border: 1px solid #e9e9e9;
	background: #fff;
}

input[type=tel], input[type=time], input[type=text], input[type=password],
	input[type=email], input[type=file], input[type=url], input[type=number],
	input[type=date], textarea {
	width: 100%;
	height: 48px;
	font-size: 14px;
	color: #999;
	border: 1px solid #e8e8e8;
	background: #fff;
	text-decoration: none;
	text-indent: 20px;
	transition: all 0.5s;
	vertical-align: middle;
	border-radius: 3px;
}

textarea::-webkit-input-placeholder, input::-webkit-input-placeholder {
	color: #999;
	font-size: 13px;
}

textarea {
	padding: 5px 20px;
	text-indent: 0;
	box-sizing: border-box;
}

select:focus, textarea:focus, input:focus {
	border: 1px solid #727272;
}

input[type=tel][readonly], input[type=text][readonly], input[type=password][readonly],
	input[type=email][readonly], input[type=tel][disabled], input[type=text][disabled],
	input[type=password][disabled], input[type=email][disabled] {
	background: #eaeaea !important;
	border-color: #c0c0c0 !important;
	color: #666 !important;
	-webkit-appearance: none;
	font-size: 12px;
}

textarea[readonly], textarea[disabled] {
	padding: 11px;
	font-size: 16px;
	color: #666 !important;
	font-weight: normal;
	line-height: 140%;
	height: 78px;
	background: #eaeaea;
	border: 1px solid #c0c0c0;
}

.clear {
	zoom: 1;
	clear: both;
}

.clear:after {
	content: "";
	display: block;
	clear: both;
}

.hide {
	position: absolute;
	left: -5000px;
}

.skip {
	position: absolute;
	left: 0;
	top: -100px;
	width: 100%;
	height: 50px;
	line-height: 50px;
	background: #000;
	color: #fff;
	text-align: center;
	font-size: 14px;
	transition: all 0.5s;
}

.empty-img {
	font-size: 4rem;
}

.img-wrap2>p {
	font-size: 1.3rem;
}

.img-wrap2>span {
	color: #bdbdbd;
}

.edit-btn {
	padding: 7px;
	background: #0095f6;
	border: none;
	cursor: pointer;
	color: white;
	border-radius: 2px;
}

.other-img-wrap {
	border-radius: 50%;
	overflow: hidden;
}
.ef5350 {
	color:#ef5350;
}

#img {
	cursor: pointer;
}

.empty-text {
	padding: 100px;
	font-family: 'Nanum Myeongjo', serif;
	font-weight: normal;
	line-height: 50px;
}

input[type="file"] {
	position: absolute;
	width: 1px;
	height: 1px;
	overflow: hidden;
	clip: rect(0, 0, 0, 0);
}

.images-wrap:hover .good-item {
	opacity: 1;
}

.images-wrap:hover .fa-comment-dots {
	opacity: 1;
}

.images-wrap:hover .other-articleImg {
	opacity: 0.8;
}

.secret {
	text-align:center;
}

.secret > p {
	font-size:17px;
	color:#bdbdbd;
}
.w100 {
	width:100%;
}
.fa-camera-retro {
	font-size:40px;
}


@media ( min-width :800px ) {
	.articles-box>ul>li {
		margin-top: 20px;
		width: calc(100%/ 3 - ( 20px * ( 3 - 1)/3));
		height: 300px;
	}
	.articles-box>ul {
		margin-left: 20px;
	}
	.articles-box {
		box-shadow: rgba(0, 0, 0, 0.1) 0px 1px 20px 0px;
		padding-bottom: 20px;
		box-sizing: border-box;
	}
	.images-wrap {
		width: 90%;
		height: 100%;
		overflow: hidden;
	}
	.fa-comment-dots {
		left: 60px;
	}
	.good-item {
		left: 20px;
	}
	.other-img-wrap {
		width: 150px;
		height: 150px;
	}
	.other-img-box {
		display: flex;
		margin-top: 50px;
		align-items: center;
	}
	.other-text-box {
		margin-left: 50px;
	}
	.other-show-box {
		margin-bottom: 50px;
	}
	.other-text-box {
		justify-content: space-between;
		width: 500px;
	}
}

@media ( max-width :799px ) {
	.articles-box>ul>li {
		height: 150px;
		width: calc(100%/ 3 - ( 0px * ( 3 - 1)/3));
	}
	.images-wrap {
		width: 99%;
		height: 99%;
		overflow: hidden;
	}
	.fa-comment-dots, .good-item {
		font-size: 15px;
	}
	.fa-comment-dots {
		left: 40px;
	}
	.other-img-wrap {
		width: 120px;
		height: 120px;
	}
	.other-img-box {
		display: flex;
		flex-direction: column;
		width: 100%;
		margin-top: 50px;
		justify-content: center;
		align-items: center;
		margin-left:15px;
		margin-right:15px;
	}
	.other-text-box {
		margin-top: 20px;
		width:100%;
	}
}
</style>


<nav class="other-show-box">
	<div class="other-img-box">
		<div class="other-img-wrap">
			<label for="ex_file" class="file-upload"> <img id="img"
				class="other-img" src="${member.extra.writerAvatarImgUrl}" alt="" />
			</label>
			<form action="changeProfile"
				onsubmit="ProfileChangeForm__submit(this); return false;">
				<input type="file" id="ex_file" class="login-input-box"
					placeholder="프로필" accept="image/*"
					name="file__member__${loginedMemberId}__common__attachment__1">
			</form>
		</div>
		<div class="other-text-box">
			<div class="other-info-box">
				
				<div class="other-nick">
				<c:if test="${ usePrivateAccount == true }">
				<i class="fas fa-lock ef5350"></i>
				</c:if>
				${member.nickname} 
				</div>
				<c:if test="${member.level == 10 }">
					<i class="fas fa-crown level10"></i>
				</c:if>
				<c:if test="${member.level == 5 }">
					<i class="fas fa-certificate level5"></i>
				</c:if>
				<c:if test="${member.level < 5 }">
					<i class="fas fa-user-alt level"></i>
				</c:if>

				<c:if test="${loginedMemberId != member.id }">
					<a href="#" class="msgSubmit">메시지 보내기</a>
					<c:if test="${following == 0 }">
						<c:if test="${followCross == 0 }">
							<a href="#" class="submit-item" onclick="doFollow(this);">팔로우</a>
						</c:if>
						<c:if test="${followCross == 1 }">
							<a href="#" class="submit-item" onclick="doFollow(this);">맞팔로우</a>
						</c:if>
					</c:if>

					<c:if test="${following == 1 }">
						<a href="#" class="submit-item" onclick="doDeleteFollow(this);">언팔로우</a>
					</c:if>


				</c:if>

				<c:if test="${loginedMemberId == member.id }">
					<a href="./myInfoEdit" class="edit-btn">프로필 편집</a>
				</c:if>

				<c:if test="${loginedMemberId != member.id }">
					<ul class="setting-box">
						<li><i class="fas fa-ellipsis-h"></i></li>
						<ul class="setting-items">
							<li><a href="#" class="red">사용자 차단</a></li>
						</ul>
					</ul>
				</c:if>

				<c:if test="${loginedMemberId == member.id }">
					<ul class="setting-box">
						<li><i class="fas fa-ellipsis-h"></i></li>
						<ul class="setting-items">
							<c:if test="${usePrivateAccount == false }">
								<li><a href="#" class="red"
									onclick="usePriavetAccount(this);">계정 비공개모드</a></li>
							</c:if>
							<c:if test="${usePrivateAccount == true }">
								<li><a href="#" class="red"
									onclick="disAblePrivateMode(this);">계정 비공개모드 해제</a></li>
							</c:if>
						</ul>
					</ul>
				</c:if>
			</div>
			<div class="other-followBox">
				<span class="article-count">게시글 ${articleCount}</span> <span
					class="">팔로워 ${followCount}</span> <span> 팔로우
					${followerCount}</span>
			</div>
			<div class="other-introduce">
				<p>${member.introduce}</p>
			</div>
		</div>
	</div>

</nav>

<!--  메시지 팝업  -->
<div class="popup">
	<h2>Meet In Direct</h2>
	<form class="con" action=""
		onsubmit="WriteMessage__submitForm(this); return false;">
		<input type="hidden" value="${loginedMemberId}" name="fromId">
		<input type="hidden" value="${member.id}" name="toId" /> <input
			type="hidden" value="../message/list" name="redirectUri" />
		<table class="type1">
			<colgroup>
				<col style="width: 111px">
				<col>
			</colgroup>
			<tbody>
				<tr>
					<th><label for="txt3">내용</label><em>(0/300 byte)</em></th>
					<td><textarea id="txt3" name="body"></textarea></td>
				</tr>
				<tr>
					<td><input type="submit" class="btn_type1" value="메시지 보내기" /></td>
				</tr>
			</tbody>
		</table>
	</form>
	<div class="txt_center"></div>
	<a href="#a" class="close"><i class="fas fa-times"></i></a>
</div>
<div class="dim"></div>



<div class="articles-box">
	<ul>
		<c:if test="${usePrivateAccount == false }">
			<c:if test="${articleCount == 0 && member.delStatus == 0 }">
				<c:if test="${member.id != loginedMemberId }">
					<div class="empty-text">
						<h2>게시글은 멋지지만,</h2>
						<h2>텅 비어있음.</h2>
					</div>
				</c:if>
			</c:if>
		</c:if>
		
		<c:if test="${member.delStatus == 1 }">
		<div class="empty-text">
							<h2 class="secret">
								잠시 쉬는중.
							</h2>
						</div>
		</c:if>

		<c:if test="${usePrivateAccount == true && articlesCount != 0 }">
			<c:if test="${following + followCross == 1 }">
					<c:if test="${member.id != loginedMemberId}">
						<div class="empty-text">
							<h2 class="secret">
								비밀계정 <i class="fas fa-lock"></i>
								<p>게시글을 볼려면 서로 팔로우 상태여야 해요.</p>
							</h2>
						</div>
					</c:if>
				</c:if>
			</c:if>
		
			<c:if test="${following + followCross == 2 && member.id != loginedMemberId && usePrivateAccount == true}">
					<c:if test="${member.id != loginedMemberId}">
						<c:forEach items="${articles}" var="article">
						<li data-id="${article.id}">
					<div class="images-wrap">
						<a href="../article/detail?id=${article.id}"><c:if
								test="${article.extra.file__common__attachment['3'] != null}">
								<img class="other-articleImg"
									src="/meet/file/showImg?id=${article.extra.file__common__attachment['3'].id}&updateDate=${article.extra.file__common__attachment['3'].updateDate}"
									alt="" />
							</c:if> <c:if
								test="${article.extra.file__common__attachment['1'] != null}">
								<video class="video" controls
									src="/meet/file/streamVideo?id=${article.extra.file__common__attachment['1'].id}&updateDate=${article.extra.file__common__attachment['1'].updateDate}"></video>
							</c:if> <c:if
								test="${article.extra.file__common__attachment['1'] == null }">
								<c:if
									test="${article.extra.file__common__attachment['3'] == null }">
									<span>${article.body}</span>
								</c:if>
							</c:if> </a> <a onclick="callDoLike(this);"><i
							class="fas fa-heart good-item "></i></a> <i
							class="fas fa-comment-dots "></i> <img src="#" alt=""
							usemap="#map" />
						<c:if
							test="${article.extra.file__common__attachment['1'] != null}">
							<div class="video-x">
								<i class="fas fa-video"></i>
							</div>
						</c:if>
					</div>
				</li>
						</c:forEach>
					</c:if>
			</c:if>

		<c:if test="${articleCount == 0 }">
			<c:if test="${member.id == loginedMemberId }">
				<div class="w100">
					<div class="img-wrap2">
						<a href="../article/write" class="empty-img"><i
							class="fas fa-camera-retro"></i></a>
						<p>소중한 순간을 공유해보세요.</p>
						<span>${member.nickname}님의 첫 사진을 기다리고 있습니다.</span>
					</div>
				</div>
			</c:if>
		</c:if>
		
		

			<c:if test="${ usePrivateAccount == false || member.id == loginedMemberId }">
		<c:forEach items="${articles}" var="article">
						<li data-id="${article.id}">
					<div class="images-wrap">
						<a href="../article/detail?id=${article.id}"><c:if
								test="${article.extra.file__common__attachment['3'] != null}">
								<img class="other-articleImg"
									src="/meet/file/showImg?id=${article.extra.file__common__attachment['3'].id}&updateDate=${article.extra.file__common__attachment['3'].updateDate}"
									alt="" />
							</c:if> <c:if
								test="${article.extra.file__common__attachment['1'] != null}">
								<video class="video" controls
									src="/meet/file/streamVideo?id=${article.extra.file__common__attachment['1'].id}&updateDate=${article.extra.file__common__attachment['1'].updateDate}"></video>
							</c:if> <c:if
								test="${article.extra.file__common__attachment['1'] == null }">
								<c:if
									test="${article.extra.file__common__attachment['3'] == null }">
									<span>${article.body}</span>
								</c:if>
							</c:if> </a> <a onclick="callDoLike(this);"><i
							class="fas fa-heart good-item "></i></a> <i
							class="fas fa-comment-dots "></i> <img src="#" alt=""
							usemap="#map" />
						<c:if
							test="${article.extra.file__common__attachment['1'] != null}">
							<div class="video-x">
								<i class="fas fa-video"></i>
							</div>
						</c:if>
					</div>
				</li>
						</c:forEach>
						</c:if>
	
		<!--  맞팔 상태 + 비공계 true -->
					<c:if test="${usePriavteAccount == true && member.id != loginedMemberId && followCross + following = 2 }">
						<c:forEach items="${articles}" var="article">
						<li data-id="${article.id}">
					<div class="images-wrap">
						<a href="../article/detail?id=${article.id}"><c:if
								test="${article.extra.file__common__attachment['3'] != null}">
								<img class="other-articleImg"
									src="/meet/file/showImg?id=${article.extra.file__common__attachment['3'].id}&updateDate=${article.extra.file__common__attachment['3'].updateDate}"
									alt="" />
							</c:if> <c:if
								test="${article.extra.file__common__attachment['1'] != null}">
								<video class="video" controls
									src="/meet/file/streamVideo?id=${article.extra.file__common__attachment['1'].id}&updateDate=${article.extra.file__common__attachment['1'].updateDate}"></video>
							</c:if> <c:if
								test="${article.extra.file__common__attachment['1'] == null }">
								<c:if
									test="${article.extra.file__common__attachment['3'] == null }">
									<span>${article.body}</span>
								</c:if>
							</c:if> </a> <a onclick="callDoLike(this);"><i
							class="fas fa-heart good-item "></i></a> <i
							class="fas fa-comment-dots "></i> <img src="#" alt=""
							usemap="#map" />
						<c:if
							test="${article.extra.file__common__attachment['1'] != null}">
							<div class="video-x">
								<i class="fas fa-video"></i>
							</div>
						</c:if>
					</div>
				</li>
						</c:forEach>
					
					</c:if>
	</ul>
</div>

<%@ include file="../part/foot.jspf"%>