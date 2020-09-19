<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../part/head.jspf"%>

<script>
	var followId = parseInt('${article.memberId}');
	var followerId = parseInt('${loginedMemberId}');
</script>


<script>
	// 이게 왜 안되지?
	$(function() {
		var $parent = $('.article-sub');
		$(".heart").click(function() {
			var $heart = $(this).siblings('.heart');
			$heart.toggleClass("press", 1000);
			if ($heart.hasClass('press')) {
				callDoLike();
			} else {
				cancleLike();
			}
		});
	});

	// closest 가 안됨 

	function callDoLike(el) {
		var $div = $(el).closest('.articles-item');
		// 가장 가까운 li를 찾아라
		var id = parseInt($div.attr('data-id2'));
		// 정수화 -> data-id2
		$.post('./doLike', {
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

	function cancleLike(el) {

		var $div = $(el).closest('.articles-item');
		// 가장 가까운 li를 찾아라
		var id = parseInt($div.attr('data-id2'));
		// 정수화 -> data-id2

		$.post('./cancleLike', {
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
		$(".direct").on('click', function() {
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

	function doFollow(el) {
		var $div = $(el).closest('.recomend-item');
		// 가장 가까운 li를 찾아라
		var followId = parseInt($div.attr('data-id'));
		// 정수화 -> data-id
		$.post('../member/doActionFollow', {
			followId : followId,
			followerId : followerId
		}, 'json');
		location.href = location.href;
	}

	function doDeleteFollow(el) {
		if (confirm("팔로우를 취소하시겠습니까 ?") == true) {
			var $div = $(el).closest('.articles-item');
			// 가장 가까운 li를 찾아라
			var followId = parseInt($div.attr('data-id'));
			// 정수화 -> data-id

			$.post('../member/doDeleteFollow', {
				followId : followId,
				followerId : followerId
			}, 'json');
			location.reload();
		} else {
			return;
		}
	}

	$(document).ready(function() {
		$('.slider').bxSlider({
			mode : 'fade'
		});
	});

	function increaseHit(el) {
		var $div = $(el).closest('.image-wrapper');
		// 가장 가까운 li를 찾아라
		var id = parseInt($div.attr('data-id'));
		// 정수화 -> data-id

		$.post('../article/increaseHit', {
			id : id
		},'json');
	}
</script>

<style>
.fa-home {
	color: #484848;
}

.heart.press {
	color: #e23b3b;
}

.popup {
	display: none;
	position: fixed;
	border-radius: 2px;
	left: 50%;
	top: 50%;
	z-index: 100;
	padding: 25px 60px;
	transform: translate(-50%, -50%);
	box-sizing: border-box;
	background: #fff;
}

.popup h2 {
	padding: 0 0 20px;
	font-weight: normal;
	font-family: 'Courgette', cursive;
	color: #d81b60;
	text-align: center;
	line-height: 100%;
}

.popup .close {
	position: absolute;
	right: 10px;
	top: 27px;
	width: 41px;
	height: 41px;
	color: black;
	text-align: center;
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

.type1 {
	width: 100%;
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
	text-align: center;
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

.total-box {
	max-width: 940px;
	align-items: center;
	justify-content: center;
}

.article-img {
	width: 300px;
}

.articles-box {
	width: 100%;
}

.article-img {
	object-fit: cover;
	width: 100%;
	height: 100%;
}

.article-writer-Avatar {
	width: 100%;
	height: 100%;
	object-fit: cover;
}

.article-info-box {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 15px;
}

.writer-wrap {
	width: 50px;
	height: 50px;
	border-radius: 50%;
	overflow: hidden;
}

.article-info-wrap {
	display: flex;
	flex-direction: column;
}

.writer-center>span {
	margin-left: 15px;
}

.writer-center {
	display: flex;
	align-items: center;
}

.article-body-box {
	padding-left: 20px;
	overflow: scroll;
	height: 200px;
}

.article-body-box::-webkit-scrollbar {
	display: none;
}

.article-body {
	line-height: 25px;
}

.article-sub {
	font-size: 15px;
	padding-left: 20px;
}

.padding-top {
	padding-top: 20px;
	margin-bottom: 10px;
}

.like {
	color: #d81b60;
}

.gogo {
	padding: 20px;
	text-align: center;
	border: 1px solid #d81b60;
	width: 200px;
	height: 20px;
	display: flex;
	/* text-align: center; */
	align-items: center;
	justify-content: center;
	margin: 0 auto;
	color: #d81b60;
}

.direct {
	width: 30px;
	border-radius: 50%;
	cursor: pointer;
}

.following {
	color: #0d47a1;
}

.regDate {
	color: #bdbdbd;
	margin-top: 10px;
	font-size: 12px;
}

.recomend-box {
	max-width: 940px;
	width: 100%;
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 15px;
	flex-direction: column;
}

.recomend-con {
	display: flex;
	flex-direction: column;
	box-shadow: rgba(0, 0, 0, 0.1) 0px 1px 20px 0px;
	box-sizing: border-box;
	width: 50%;
	margin-bottom: 50px;
	position: relative;
}

.recomend-text {
	display: flex;
	justify-content: space-between;
}

.recomend-text>p {
	padding: 15px;
}

.recomend-text>a {
	padding: 15px;
}

.video {
	width: 483px;
	height: 500px;
	outline: none;
}

.recomend-item {
	display: flex;
	width: 100%;
	margin-bottom: 25px;
	align-items: center;
}

.reco-img {
	width: 100%;
	height: 100%;
	object-fit: cover;
	border-radius: 50%;
}

.im-co-home {
	color: black !important;
}

h4 {
	font-size: 20px;
	color: #484848;
	font-weight: normal;
}

.reco-column {
	display: flex;
	flex-direction: column;
	justify-content: center;
	margin-left: 15px;
	width: 300px;
}

.intro-hdn {
	color: #9e9e9e;
	font-size: 14px;
	overflow: hidden;
	height: 18px;
	white-space: nowrap;
	text-overflow: ellipsis;
}

.submit-item, .msgSubmit {
	padding: 5px;
	background: #0095f6;
	border-radius: 3px;
	border: none;
	cursor: pointer;
	color: white;
	font-size: 15px;
	height: 20px;
	margin-right: 15px;
}

.reco-img-wrap {
	width: 50px;
	height: 50px;
	overflow: hidden;
	text-align: center;
}

.fa-check {
	color: #0095f6;
}

.blue {
	color: #0095f6;
}

.p13 {
	font-size: 13px;
}

.heart {
	cursor: pointer;
	transition: .2s;
	font-size: 1.3rem;
	margin-right: 15px;
}

.comment {
	font-size: 1.3rem;
}

.redA {
	color: red;
}

.heart:hover {
	color: #e23b3b;
}

.heart.press {
	color: #e23b3b;
}


@
keyframes fade { 0% {
	color: #transparent;
}

50
%
{
color












:












#e23b3b










;
}
100
%
{
color












:












#transparent










;
}
}
@
keyframes size { 0% {
	padding: 10px 12px 8px;
}

50
%
{
padding












:












14
px












16
px












12
px










;
margin-top












:












-4
px










;
}
100
%
{
padding












:












10
px












12
px












8
px










;
}
}
@media ( max-width :800px ) {
	.articles-item {
		display: flex;
		flex-direction: column;
		align-items: center;
		width: 100%;
		margin-bottom: 10px;
	}
	.article-info-wrap {
		width: 100%;
		height: 400px;
	}
	.article-img-box {
		width: 100%;
		overflow: hidden;
	}
	h4 {
		margin-left: 15px;
	}
	.reco-img-wrap {
		margin-left: 15px;
	}
	.mal {
		margin-left: 15px;
		margin-bottom: 15px;
	}
	.total-box {
		margin: 41px auto;
	}
	iframe {
		max-width:700px;
		height:272px;
	}
	.image-wrapper2{
		margin-left:10px;
	}
	.s-title {
		margin-left:10px;
	}
	.marl-10 {
	margin-left:10px;
	}
	.image-wrapper2 {
		bottom: 0;
	}
	.image-wrapper {
		width: 50px;
		height: 50px;
	}
}

@media ( min-width :801px ) {
	.articles-item {
		display: flex;
		box-shadow: rgba(0, 0, 0, 0.1) 0px 1px 20px 0px;
		align-items: center;
		width: 100%;
		margin-bottom: 50px;
	}
	.article-info-wrap {
		width: 50%;
		height: 500px;
	}
	.article-img-box {
		width: 500px;
		height: 500px;
		overflow: hidden;
	}
	h4 {
		margin: 0 auto;
		max-width: 940px;
	}
	.recomend-box {
		margin: 0 auto;
		margin-top: 30px;
	}
	.mal {
		max-width: 940px;
		margin: 0 auto;
	}
	.total-box {
		margin: 100px auto;
	}
	.popup {
		width: 600px;
		height: 400px;
	}
	.popup .con {
		padding: 35px 50px;
		border: 1px solid #e8e8e8;
	}
	.video-wrapping {
		border-radius:30px;
		max-height: 600px;
  
	}
	iframe {
		max-width:700px;
		height:350px;
	}
	.image-wrapper2 {
		bottom: -10px;
	}
	.image-wrapper {
		width: 65px;
		height: 65px;
	}
}

.articleReplies-box {
	display: flex;
}

.margin-left {
	margin-left: 20px;
}

.reply-regDate {
	color: #bdbdbd;
	font-size: 14px;
	margin-bottom: 10px;
}

.count-unit {
	font-size: 14px;
	margin-left: 5px;
}

.stories-box {
	max-width: 940px;
	height: 100px;
	background: #fff;
	border: 1px solid #e0e0e0;
	margin-bottom : 50px;
	position:relative;
	display: flex;
	align-items: center;
	margin-bottom: 50px;
	margin-top:80px;
}

.profile_wrapper {
	margin-left: 15px;
	margin-right: 15px;
}

.profile_wrapper>p {
	color: #262626;
	font-size: 14px;
	margin-left: 5px;
	margin-top: 5px;
	text-align:center;
}

.image-wrapper {
	border-radius: 50%;
	overflow: hidden;
}

.storyAvatar {
	object-fit: cover;
	width: 100%;
	height: 100%;
}

#video-view {
	display: none;
	position: fixed;
	top: 0;
	right: 0;
	left: 0;
	bottom: 0;
	z-index: 10000000;
	height: 100%;
	width: 100%;
}

.overlay {
	background: #000;
	position:fixed;
	height: 100%;
	width: 100%;
	opacity:0.8;
	z-index: 9999999;
}

.class-video {
	z-index: 9999999999;
	position: fixed;
	top: 15%;
	right: 0;
	left: 0;
	bottom: 0;
	text-align: center;
}

.close-video {
	z-index: 9999999999999;
	position: fixed;
	top: 10%;
	right: 0;
	left: 0;
	bottom: 0;
	text-align: center;
	color: black;
	font-size: 1.2rem;
}
.close-video > i {
	position:absolute;
}

.image-wrapper2 {
	z-index: 9999999999999;
	top: 14%;
	right: 0;
	left: 50%;
	text-align: center;
	font-weight: bold;
	width: 50px;
	height: 50px;
	border-radius: 50%;
	overflow: hidden;
	
}
.ss-video-holder {
	margin-bottom: 40px;
	max-width: 520px;
}

.ss-popup {
	max-width: 50px;
	position: relative;
	background-size: cover;
}

iframe {
	border:none;
	outline:none;
	width:100%;
}
.video-wrapping {
    z-index: 9999999;
    position: relative;
    max-width: 800px;
    height:100%;
    width:100%;
    background: white;
    left: 50%;
    top: 50%;
    transform: translate(-50%, -50%);
 }
.story-info {
	z-index: 9999999;
    max-width: 700px;
    width:100%;
    bottom: 30px;
    position: absolute;
    display: flex;
    flex-direction:column;
    left: 50%;
    transform: translate(-50%,0%);
 }
.story-container {
	display:flex;
	width:100%;
	margin-top:10px;
}
.story-sub > span {
	margin-left:10px;
}
.story-sub {
	display:flex;
	flex-direction:column;
	width:20%;
	justify-content:center;
}
.silver {
	color:#909090;
}
.f14  {
	font-size:12px;
}
.story-main {
    display: flex;
    align-items:center;
}
.story-btn {
	position: absolute;
    right: 0;
    right: 15px;
    padding: 10px;
    color: #e23b3b;
    font-family: 'Courgette', cursive;
    font-size:20px;  
}
.s-title {
	font-weight:normal;
}

</style>

<nav class="total-box">
	<c:if test="${isLogined}">
		<div class="stories-box">
			<c:forEach items="${stories}" var="story">
			<c:if test="${story.extra.file__common__attachment['1'] != null}">
				<div class="profile_wrapper">
					<div class="image-wrapper" data-id="${story.id}">
						<a class="ss-popup" href="#!" onclick="increaseHit(this);"
							data-link="/meet/file/streamVideo?id=${story.extra.file__common__attachment['1'].id}&updateDate=${story.extra.file__common__attachment['1'].updateDate}">
							<img class="storyAvatar" src="${story.extra.storyAvatarImgUrl}"
							alt="" />
						</a>
					</div>
					<p>${story.extra.writer}</p>
				</div>
			</c:if>
			</c:forEach>
			<a href="../member/storyWrite" class="story-btn">Meet In Story +</a>
		</div>
	</c:if>
	<div class="articles-box">
		<c:forEach items="${articles}" var="article">
			<div class="articles-item" data-id="${article.memberId}"
				data-id2="${article.id}">
				<c:if test="${article.extra.file__common__attachment['3'] != null}">
					<div class="article-img-box">
						<img class="article-img"
							src="/meet/file/showImg?id=${article.extra.file__common__attachment['3'].id}&updateDate=${article.extra.file__common__attachment['3'].updateDate}"
							alt="" />
					</div>
				</c:if>
				<c:if test="${article.extra.file__common__attachment['1'] != null}">
					<div class="article-img-box">
						<video class="video" controls
							src="/meet/file/streamVideo?id=${article.extra.file__common__attachment['1'].id}&updateDate=${article.extra.file__common__attachment['1'].updateDate}"
							class="article-video"></video>
					</div>
				</c:if>
				<nav class="article-info-wrap">
					<div class="article-info-box">
						<a href="../member/showOther?id=${article.memberId}"
							class="writer-center">
							<div class="writer-wrap">
								<img class="article-writer-Avatar"
									src="${article.extra.writerAvatarImgUrl}">
							</div> <span>${article.extra.writer}</span>
						</a> <a href="#" onclick="doDeleteFollow(this);" class="following">언팔로우</a>
						<img class="direct"
							src="https://i.pinimg.com/originals/7b/66/ac/7b66ac2787335ebcb565960d482f0846.png"
							alt="" />
						<ul class="setting-box">
							<li><i class="fas fa-ellipsis-h" data-id="${article.id}"></i></li>
							<ul class="setting-items">
								<li><a href="#" class="redA"
									onclick="blockWhoClickedUser(this);">사용자 차단</a></li>
								<li><a href="../article/detail?id=${article.id}">게시물로
										이동하기</a></li>
								<li><a href="#">공유하기</a></li>
							</ul>
						</ul>
					</div>
					<div class="article-body-box">
						<p class="article-body">${article.body}</p>
						<p class="regDate">${article.regDateFormat}</p>
					</div>
					<div class="article-sub padding-top">
						<i class="far fa-heart heart"><span class="count-unit">${article.extra.heartPoint}</span></i>
						<i class="far fa-comment comment"><span class="count-unit">${article.extra.replyCount}</span></i>
					</div>

					<div class="article-sub">
						<c:forEach items="${articleRepliesBig}" var="articleReplies">
							<c:forEach items="${articleReplies}" var="articleReply">
								<c:if test="${articleReply.articleId == article.id }">
									<div class="articleReplies-box">
										<a href="../member/showOther?id=${articleReply.memberId}">
											<span>${articleReply.extra.writer}</span> <span
											class="margin-left">${articleReply.body}</span>
										</a>
									</div>
									<p class="reply-regDate">${articleReply.regDateFormat}</p>
								</c:if>
							</c:forEach>
						</c:forEach>
					</div>
				</nav>
			</div>
		</c:forEach>
</nav>
<c:if test="${followerCount == 0}">
	<h4>회원님을 위한 추천</h4>
	<p class="blue p13 mal">게시글이 마음에 들거나 아는 분이 있으면 팔로우를 먼저 걸어보세요.</p>
	<div class="recomend-box">
		<c:forEach items="${members}" var="members">
			<div class="recomend-item" data-id="${members.id}">
				<div class="reco-img-wrap">
					<img src="${members.extra.recomendAvatarImgUrl}" class="reco-img"
						alt="" />
				</div>
				<div class="reco-column">
					<p>${members.nickname}</p>
					<span class="intro-hdn">${members.introduce}</span>
				</div>
				<a href="#" class="submit-item" onclick="doFollow(this);">팔로우</a>
			</div>
		</c:forEach>
	</div>
</c:if>


<c:forEach items="${stories}" var="story">
	<c:forEach items="${files}" var="file">
	<c:if test="${ file.relId == story.id }">
<div id="video-view">
	<div class="overlay"></div>
	<span class="close-video"><i class="far fa-times-circle"></i></span>
	<div class="video-wrapping">
	<div class="story-info">
	<h2 class="s-title">${story.title} ${file.relId} ${story.id}</h2>
	<span class="silver f14 marl-10 ">${story.regDateFormat} &nbsp; 조회수 : ${story.hit} </span>
	<div class="story-container">
	<div class="image-wrapper2">
	<img class="storyAvatar" src="${story.extra.storyAvatarImgUrl}" alt="" />
	</div>
	<div class="story-sub">
	<span>${story.extra.writer}</span>
	<span class="silver f14">팔로워 ${story.extra.followCount}</span>
	</div>
	<div class="story-main">
	<i class="fas fa-heart heart red"></i>
	</div>
	</div>
	</div>
	</div>
</div>
</c:if>
	</c:forEach>
	</c:forEach>

<script>
	$(".ss-popup").click(
			function() {
				$("#video-view").show();
				var $this = $(this);
				var autoplay = "&amp;autoplay=1"
				var $iframe = $("<iframe>").attr("src",
						($this.data("link") + autoplay));
				$("#video-view").append($iframe);
				$iframe.wrap("<div class='class-video'>");
			});

	$(".close-video").click(function() {
		$("#video-view").hide();
		$("#video-view iframe").attr("src", "");
	});

	$("#video-view .overlay").click(function() {
		$("#video-view").hide();
	});
</script>


<!--  메시지 팝업  -->
<div class="popup">
	<h2>Meet In Direct</h2>
	<form class="con" action=""
		onsubmit="WriteMessage__submitForm(this); return false;">
		<input type="hidden" value="${loginedMemberId}" name="fromId">
		<input type="hidden" value="../message/list" name="redirectUri" />
		<table class="type1">
			<colgroup>
				<col style="width: 111px">
				<col>
			</colgroup>
			<tbody>
				<tr>
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

<%@ include file="../part/foot.jspf"%>