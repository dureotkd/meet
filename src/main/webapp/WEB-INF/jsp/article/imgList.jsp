<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Meet In here</title>

<!-- 모바일에서 사이트가 PC에서의 픽셀크기 기준으로 작동하게 하기(반응형 하려면 필요) -->
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- 폰트어썸 불러오기 -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.1/css/all.min.css">

<!--  구글 폰트 로고  -->
<link
	href="https://fonts.googleapis.com/css2?family=Courgette&display=swap"
	rel="stylesheet">

<!-- 제이쿼리 불러오기 -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<!-- 구글 폰트 불러오기 -->
<!-- rotobo(400/700/900), notosanskr(400/600/900) -->
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700;900&family=Roboto:wght@400;700;900&display=swap"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css2?family=Nanum+Myeongjo&display=swap"
	rel="stylesheet">

<!--  이미지 슬라이더 라이브러리  -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.css">
<script
	src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>

<!--  select2 라이브러리  -->
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.9/css/select2.min.css"
	rel="stylesheet" />
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.9/js/select2.min.js"></script>


<script>
	function btnToggleDropMenu__init() {
		var $btnToggleDropMenu = $('.myinfo');

		$btnToggleDropMenu.click(function() {
			if ($(this).hasClass('open')) {
			} else {
				$('.open').removeClass('open');
				$(this).addClass('open');
				$('.dropdown-menu').addClass('open');
				$('.caret').addClass('open');

				return false;
			}
		});

		$('body').click(function() {
			$('.open').removeClass('open');
		});
	}
	$(function() {
		btnToggleDropMenu__init();
	});

	function btnToggleDropMenu2__init() {
		var $btnToggleDropMenu2 = $('.heartM');

		$btnToggleDropMenu2.click(function() {
			if ($(this).hasClass('drop')) {
			} else {
				$('.drop').removeClass('drop');
				$(this).addClass('drop');
				$('.dropdown-menu2').addClass('drop');
				$('.msg-notice2').addClass('none');

				$.post('../member/readAct', 'json');

				return false;
			}

		});

		$('body').click(function() {
			$('.drop').removeClass('drop');
		});
	}

	$(function() {
		btnToggleDropMenu2__init();
	});

	function ViewActivity__updateAct(newAct) {
		$('.msg-notice').empty().append(newAct);
	}

	function btnToggleDot__init() {
		var $btnToggleDot = $('.fa-ellipsis-h');

		$btnToggleDot
				.click(function() {
					if ($(this).hasClass('opnbox')) {

					} else {
						$('.opnbox').removeClass('opnbox');
						$(this).addClass('opnbox');
						var $settingItems = $(this).parent().siblings(
								'.setting-items');
						$settingItems.addClass('opnbox');
						return false;
					}
				});
		$('body').click(function() {
			$('.opnbox').removeClass('opnbox');
		});
	}

	$(function() {
		btnToggleDot__init();
	});
</script>

<%="<script>"%>
var param = ${paramJson};
<%="</script>"%>




<style>
* {
	padding: 0px;
	margin: 0px;
	text-decoration: none;
	color: inherit;
}

html {
	/* 영문이면 roboto가 적용되고, 한글이면 Noto Sans KR가 적용되도록 아래와 같은 순서로 배치 */
	font-family: "Roboto", "Noto Sans KR", sans-serif;
}

html, body {
	margin: 0;
	height: 100%;
	background: #fafafa;
}

ul, li {
	list-style: none;
}

.center-box {
	display: flex;
	justify-content: center;
}

.center-box>img {
	width: 200px;
}

.login-form-box {
	display: flex;
	flex-direction: column;
	align-items: center;
	justify-content: center;
	border: 1px solid #ccc;
	height: 400px;
	width: 400px;
	margin: 50px auto;
	box-shadow: 3px 3px 3px #ccc;
}

.login-form {
	display: flex;
	flex-direction: column;
}

.login-input-box {
	width: 220px;
	margin-bottom: 15px;
	color: #262626;
	border: 1px solid #ccc;
	font-size: 13px;
	padding: 10px;
	outline: none;
}

.submit {
	background: none;
	background: #fff;
	border: 1px solid #f50057;
	color: #f50057;
	font-size: 13px;
	padding: 10px;
	cursor: pointer;
}

.join-box {
	display: flex;
	padding: 10px;
	width: 60%;
	align-items: center;
	justify-content: space-between;
}

.join-box>p {
	color: #1a237e;
	font-size: 13px;
}

.join-item {
	font-size: 13px;
	color: #1a237e;
	padding: 10px;
	border: 1px solid #1a237e;
}

.table-box>table {
	width: 50%;
	border-collapse: collapse;
	margin: 0 auto;
}

.table-box>table th, .table-box>table td {
	border: 1px solid black;
	padding: 10px;
	text-align: left;
}

.title {
	width: 200px;
}

.checkBox {
	width: 20px;
	height: 20px;
	margin-top: 10px;
	margin-bottom: 10px;
}

.left {
	text-align: left;
}

.logo {
	font-family: 'Courgette', cursive;
	color: #e23b3b;
	font-weight: normal;
}

h1 {
	text-align: center;
}

.top-bar {
	display: flex;
	align-items: center;
	width: 100%;
	max-width: 940px;
	position: fixed;
	background: #fff;
	top: 0;
	transform: translate(-50%, 0px);
}

.Myinfo-profile {
	width: 100%;
	height: 100%;
	object-fit: cover;
	border-radius: 50%;
}

.menu-box {
	display: flex;
	align-items: center;
}

.center {
	text-align: center;
}

.search {
	outline: none;
	border: solid 1px #dbdbdb;
	width: 220px;
	height: 25px;
	text-indent: 10px;
}

.caret {
	border-top: 3px solid;
	border-right: 4px solid transparent;
	border-left: 4px solid transparent;
	vertical-align: middle;
	display: inline-block;
	width: 0;
	height: 0;
	transition: all.5s;
	margin-right: 5px;
}

.dropdown-menu {
	top: 100%;
	right: 0;
	position: absolute;
	width: 180px;
	border: 1px solid #ccc;
	margin-top: 5px;
	box-shadow: 0 2px 5px 0 rgba(0, 0, 0, 0.26);
	transition: all.5s;
	display: none;
	background: white;
}

.dropdown-menu>li>a {
	transition: all.3s;
}

.dropdown-menu>li>a:hover {
	background: #eee;
}

.dropdown-menu.open {
	display: block;
}

.caret.open {
	transform: rotate(180deg);
}

.dropdown-menu>li {
	display: flex;
}

.dropdown-menu>li>a {
	padding: 10px;
	text-align: center;
	width: 100%;
}

.myinfo {
	z-index: 10000;
	position: relative;
	display: flex;
	align-items: center;
	cursor: pointer;
}

.menu-i {
	font-size: 20px;
	color: #9e9e9e;
}

.down-box {
	position: relative;
	cursor: pointer;
	z-index: 100;
	display: flex;
}

.top-line {
	width: 100%;
	border-bottom: 1px solid #e0e0e0;
	position: fixed;
	top: 0;
	z-index: 50;
	background: #fff;
}

.dropdown-menu2 {
	display: none;
}

.dropdown-menu2.drop {
	display: flex;
	flex-direction: column;
	position: absolute;
	align-items: center;
	justify-content: center;
	height: 400px;
	box-shadow: 1px 1px 1px 1px #eee;
	background: #fff;
	padding: 15px;
	font-weight: normal;
	font-size: 15px;
	border-radius: 5px;
	border: 1px solid #ccc;
}

.dropdown-act-menu {
	display: flex;
	flex-direction: column;
	align-items: center;
	justify-content: center;
	height: 400px;
	background: #fff;
	padding: 15px;
	font-weight: normal;
	font-size: 15px;
	border-radius: 5px;
	overflow: scroll;
	position: relative;
}

.dropdown-act-menu::-webkit-scrollbar {
	display: none;
}

.fa-gratipay {
	font-size: 3.5rem;
	color: #d81b60;
}

.dropdown-menu2.drop>li {
	margin-bottom: 15px;
}

.msg-notice-box {
	position: relative;
}

.msg-notice {
	color: red;
	position: absolute;
	top: 0;
}

.msg-notice.none {
	display: none;
}

.msg-notice2 {
	color: red;
	position: absolute;
	top: 0;
}

.msg-notice2.none {
	display: none;
}

.activity-box {
	postion: absolute;
	width: 100%;
	height: 20%;
	padding: 20px;
	transition: all.4s;
}

.act-profile {
	height: 100%;
	width: 100%;
	border-radius: 50%;
	object-fit: cover;
}

.act-img-wrap {
	width: 50px;
	height: 50px;
	overflow: hidden;
	position: relative;
}

.act-title {
	border-bottom: 1px solid #ccc;
	font-size: 1.3rem;
	position: absolute;
	top: 0;
}

.activity-box:hover {
	background: #fafafa;
}

.redA {
	color: red;
}

.setting-box {
	position: relative;
}

.setting-items.opnbox {
	position: absolute;
	border-radius: 10px;
	font-size: 14px;
	width: 150px;
	margin-top: 10px;
	text-align: center;
	box-shadow: 1px 1px 1px #ccc;
	border: 1px solid #ccc;
	display: block;
	background: #fff;
}

.setting-items {
	display: none;
}

.red {
	color: #e23b3b;
}

.setting-box ul li {
	display: flex;
	border-bottom: 1px solid #ccc;
}

.setting-box ul li a {
	padding: 10px;
	width: 100%;
	height: 100%;
}

.circle {
	position: absolute;
	width: 2px;
	height: 2px;
	border-radius: 50%;
	/* border: 0; */
	bottom: -5px;
	left: 50%;
	background: #e23b3b;
	transform: translate(-50%, 0px);
}

.select-m-box {
	display: flex;
    height: 100px;
    align-items: center;
    margin-top: 30px;
    justify-content: center;
}

/* 800px 이하면 안보이게 ( 모바일 버전 ) */
@media ( max-width :799px ) {
	.visible-on-sm-up {
		display: none !important;
	}
	
	.setting-items.opnbox {
		right: 0px;
	}
	.top-bar {
		justify-content: space-between;
		height: 40px;
		z-index:1000;
		left: 50%;
	}
	.top-line {
		height: 40px;
	}
	.logo {
		font-size: 25px;
	}
	.dropdown-act-menu {
		width: 300px;
	}
	.dropdown-menu2.drop {
		top: 30px;
	}
	.Myinfo-profile {
		margin-right: 10px;
	}
	.logo {
		margin-left: 10px;
	}
	.profile-box {
		width: 30px;
		height: 30px;
		margin-right: 10px;
	}
	.menu-box {
		margin-left: 10px;
	}
	
	
}

/* 800px 이하면 안보이게 ( 모바일 버전 ) */

/* 800px 이상이면 안보이게 ( pc 버전 ) */
@media ( min-width :800px ) {
	.visible-on-sm-down {
		display: none !important;
	}
	.dropdown-act-menu {
		width: 500px;
	}
	.setting-items.opnbox {
		left: -10px;
		right: 50%;
		transform: translate(-50%, 0%);
	}
	.top-bar {
		justify-content: space-between;
		height: 60px;
		z-index:50;
		left: 50%;
	}
	.top-line {
		height: 60px;
	}
	.dropdown-menu2.drop {
		right: 0px;
	}
	.profile-box {
		width: 50px;
		height: 50px;
	}
	.menu-i {
		padding: 15px;
	}
	.dropdown-menu2.drop {
		top: 60px;
	}
}

.fa-ellipsis-h {
	cursor: pointer;
}

.profile-box {
	border-radius: 50%;
	overflow: hidden;
}

.none {
	display: none;
}

.select2-container--default .select2-selection--multiple .select2-selection__choice
	{
	display: none;
}

.select2-container--default .select2-selection--multiple {
	border: 1px solid #e0e0e0 !important;
}

.select2-container {
	z-index: 100;
}

.select {
	margin: 300px auto;
	text-align: center;
	width: 300px;
	position:relative;
	font-size:15px;
}


.select2-container--default.select2-container--focus .select2-selection--multiple
	{
	width: 300px;
}

.select2-container--default .select2-results>.select2-results__options {
	width: 300px;
	max-height:100% !important;
}

.select2-dropdown select2-dropdown--below {
	width: 300px;
}

.select2-dropdown {
	z-index: 10 !important;
	border:1px solid #e0e0e0 !important;
}

.select2 {
	width: 300px !important;
}

.select2-result-repository__avatar {
	width: 80px;
	height: 80px;
	overflow: hidden;
}

.select2-result-repository__meta {
	margin-left: 10px;
}

.select2-result-repository__introduce {
	width: 170px;
	overflow: hidden;
	display: flex;
	text-overflow: ellipsis;
	color: #c6dcef;
	white-space: nowrap;
	font-size: 14px;
}
.select2-container--default .select2-results__option[aria-selected=true] {
	background:#fff !important;
}

.select2-result-repository__statistics {
	font-size: 14px;
}

.repo-avatar {
	width: 100%;
	height: 100%;
	border-radius:50%;
	object-fit: cover;
}

.repo-box {
	display: flex;
	align-items: center;
}

.fa-quote-left {
	margin-right: 6px;
}

.aqua {
	color: aqua;
}

.fa-star {
	color: yellow;
}

</style>


</head>
<body>

	<div class="top-line"></div>
	<div class="top-bar">
		<div class="logo-box visible-on-sm-up">
			<a href="../home/main"><h1 class="logo visible-on-sm-up">Meet
					In here</h1></a>
		</div>

		<div class="select">
			<select class="form-control" multiple="multiple">
			</select>
		</div>

		<div class="menu-box visible-on-sm-up" >
			<a href="../home/main"><i class="fas fa-home menu-i"></i></a> <a
				href="../message/list" class="msg-notice-box"> <i
				class="fas fa-envelope menu-i"></i> <c:if test="${isLogined}">
					<c:if test="${myMsgCount > 0 }">
						<p class="msg-notice">${myMsgCount}</p>
					</c:if>
				</c:if>
			</a> <a href="../article/imgList"><i class="far fa-compass menu-i"></i></a>
			<div class="down-box">
				<a href="#"><i class="far fa-heart menu-i  heartM"></i></a>
				<c:if test="${isLogined}">
					<c:if test="${myActivityCount > 0 }">
						<p class="msg-notice2">${myActivityCount}</p>
					</c:if>
				</c:if>
				<ul class="dropdown-menu2">
					<ul class="dropdown-act-menu">
						<!--  만약에 아무 activity 가 없다면 -->
						<c:if test="${myActivityCount == 0 }">
							<li><i class="fab fa-gratipay"></i></li>
							<li>게시물 활동</li>
							<li>다른 사람이 회원님의 게시물을 좋아하거나 댓글을 남기면 여기에 표시됩니다.</li>
						</c:if>


						<c:if test="${myActivityCount > 0 }">
							<li class="act-title">게시물 활동</li>
							<c:forEach items="${articleReplies}" var="articleReply">
								<c:if test="${articleReply.memberId != loginedMemberId}">
									<ul class="activity-box">
										<a href="../article/detail?id=${articleReply.articleId}">
											<li class="act-img-wrap"><img class="act-profile"
												src="${articleReply.extra.replyWriterAvatarImgUrl}" alt="" />
										</li> <span>${articleReply.extra.writer}님이 댓글을 남겼습니다.</span> <span>${articleReply.body}</span>
										</a>
									</ul>
								</c:if>
							</c:forEach>
						</c:if>

						<c:if test="${myActivityCount > 0 }">
							<c:forEach items="${articleLikes}" var="articleLike">
								<ul class="activity-box">
									<a href="../article/detail?id=${articleLike.articleId}">
										<div class="act-img-wrap">
											<img src="${articleLike.extra.likeSenderAvatarImgUrl}"
												class="act-profile" alt="" />
										</div>
										<li>${articleLike.extra.writer}님이좋아요를남겼습니다.</li>
									</a>
								</ul>
							</c:forEach>
						</c:if>

						<c:if test="${myActivityCount > 0 }">
							<c:forEach items="${friends}" var="friend">
								<ul class="activity-box">
									<a href="../member/showOther?id=${friend.followerId}">
										<div class="act-img-wrap">
											<img src="${friend.extra.followSenderAvatarImgUrl}"
												class="act-profile" alt="" />
										</div>
										<li>${friend.extra.writer}님이팔로우중입니다.</li>
									</a>
								</ul>
							</c:forEach>
						</c:if>
					</ul>
				</ul>
			</div>

			<c:if test="${isLogined}">
				<b class="caret"></b>
			</c:if>
			<div class="myinfo">
				<c:if test="${isLogined}">
					<div class="profile-box">
						<img class="Myinfo-profile"
							src="/meet/file/showImg?id=${loginedMember.extra.file__common__attachment['1'].id}&updateDate=${loginedMember.extra.file__common__attachment['1'].updateDate}" />
					</div>
					<!-- <c:if test="${loginedMember.extra.isNeedToChangePasswordForTemp}">
			<p class="needChange">
				현재 임시 비밀번호를 사용중입니다.<br>빠른 시일내에 변경해주세요.
			</p>
		</c:if>
		 일단 보류 !-->
				</c:if>
				<c:if test="${isLogined == false }">
					<li><a href="../member/login">로그인</a></li>
				</c:if>
				<c:if test="${isLogined}">
					<ul class="dropdown-menu">
						<li><a href="../article/write">글쓰기</a></li>
						<li><a href="../member/showOther?id=${loginedMemberId}">프로필</a></li>
						<li><a href="../member/mystatistics?id=${loginedMemberId}">통계</a></li>
						<li><a href="../member/doLogout" onclick="logOutNotify()">로그아웃</a></li>
					</ul>
				</c:if>
			</div>
		</div>
	</div>

	<script>

$(document).ready(function(){
	$('.form-control').select2({
		placeholder: 'Search',
		closeOnSelect: false,		
		minimumInputLength: 1,
		templateResult: formatRepo,
		templateSelection: formatRepoSelection,
		ajax: {
			type: "GET",
			url: "../member/registory",
			dataType: 'json',
			delay: 400,
			catch: true,
			// 검색 쿼리
			data: function (params) {
				return {
					searchKeyword:params.term
					};
				},
				 processResults: function (response) {
				        return {
				            results:response
				        };
				    },	
			}
	});
});

function formatRepo (repo) {
	  if (repo.loading) {
	    return "잠시만 기다려 주세요.";
	  }
	  var $container = $(
	    "<div class='select2-result-repository clearfix'>" +
	    "<a class='repo-box' href='../member/showOther?id="+repo.id+"'>"  +
		  "<div class='select2-result-repository__avatar'><img class='repo-avatar' src=' " + repo.image.repoAvatarImg +"' /></div>" +
	      "<div class='select2-result-repository__meta'>" +
	        "<div class='select2-result-repository__title'><p>" + repo.text +  "</p></div>" +
	        "<div class='select2-result-repository__introduce'><p>" + repo.introduce +  "</p></div>" +
	        "<div class='select2-result-repository__description'></div>" +
	        "<div class='select2-result-repository__statistics'>" +
	          "<div class='select2-result-repository__stargazers'><i class='fa fa-star'></i> </div>" +
	          "<div class='select2-result-repository__watchers'><i class='fas fa-quote-left aqua'></i></div>" +
	        "</div>" +
	      "</div>" +
	      "</a>" + 
	    "</div>"
	  );

	  $container.find(".select2-result-repository__stargazers").append(repo.followerCount + " 팔로우	");
	  $container.find(".select2-result-repository__watchers").append(repo.articleCount + " 게시글 ");
	  return $container;
	}

	function formatRepoSelection (repo) {
	  return repo.full_name || repo.text;
	}
</script>



<script>
$(function() {
	$(".heart").click(function() {
		$(".heart").toggleClass("press", 1000);
		if ($(".heart").hasClass('press')) {
			callDoLike();
			
		} else {
			cancleLike();
		}
	});
});

	function callDoLike(el) {
		var $li = $(el).closest('li');
		// 가장 가까운 li를 찾아라
		var id = parseInt($li.attr('data-id'));
		// 정수화 -> data-id
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

		var $li = $(el).closest('li');
		// 가장 가까운 li를 찾아라
		var id = parseInt($li.attr('data-id'));
		// 정수화 -> data-id

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

</script>


<style>
.articles-box>ul {
	display: flex;
	flex-flow: row wrap;
	justify-content: center;
}

.other-articleImg {
	width: 100%;
	height: 100%;
	object-fit: cover;
	transition: all.3s;
}

.dark-box {
	background:#4c4c4c;
	position:absolute;	
	height:100%;
	transition:all.3s;
	opacity:0;
}

.other-articleVideo {
	height: 300px;
}

.fa-compass {
	color: #484848;
}

.img-wrap {
	text-align: center;
	position: relative;
	transition: all.3s;
	overflow: hidden;
}

.board-bar {
	display: flex;
	justify-content: center;
	align-items: center;
	margin-top: 60px;
}

.board {
	margin-top: 20px;
	border: 1px solid #eee;
	border-radius: 50%;
	margin: 20px;
	box-shadow: 0 10px 10px -12px rgba(0, 0, 0, 0.56), 0 4px 10px 0px
		rgba(0, 0, 0, 0.12), 0 8px 10px -10px rgba(0, 0, 0, 0.2);
}

.action {
	color: #e23b3b;
}

.cursor1 {
	cursor: zoom-in;
}

.heart {
	cursor: pointer;
	color: #aaa;
	transition: .2s;
	position: absolute;
	top: 10px;
	left:10px;
	opacity: 0;
	color: black;
}
.comment {
	cursor: pointer;
	color: #aaa;
	transition: .2s;
	position: absolute;
	top: 10px;
	left:50px;
	opacity: 0;
	color: black;
}
.heart:hover {
	color: #666;
}

.heart.press {
	color: #e23b3b;
}
.fa-search {
	color:#484848;
}
.im-co-search{
	color:black !important;
}
.articles-box>ul>li {
	position:relative;
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
@media ( max-width :520px){
	.articles-box>ul>li {
		width: calc(100%/ 3 - ( 0px * ( 3 - 1)/3));
		height: 150px;
	}
	.img-wrap {
		width: 99%;
		height: 99%;
	}
	.fa-comment-dots, .heart {
		font-size: 15px;
	}
	.board {
	padding: 10px;	
	}
	.dark-box {
		width:100%;
	}
}
@media (max-width:800px) and (min-width:521px) {
	.img-wrap {
		width: 99%;
		height: 99%;
	}
	.articles-box>ul>li {
		width: calc(100%/ 3 - ( 0px * ( 3 - 1)/3));
		height: 250px;
	}
	.articles-box {
		max-width: 940px;
		margin: 0 auto;
	}
	.board {
	padding: 10px;	
	}
	.dark-box {
		width:100%;
	}
}

@media ( min-width :801px) {
	.img-wrap {
		width: 90%;
		height: 100%;
	}
	.dark-box {
		width:90%;
	}
	.articles-box>ul>li {
		margin-top: 20px;
		width: calc(100%/ 3 - ( 20px * ( 3 - 1)/3));
		height: 300px;
	}
	.articles-box {
		max-width: 940px;
		margin: 0 auto;
		box-shadow: rgba(0, 0, 0, 0.1) 0px 1px 20px 0px;
	}
	.articles-box>ul {
		margin-left: 20px;
	}
	.board {
	font-size: 1.5rem;
	padding: 15px;	
	}
}
}
</style>
<div class="total-wrap">
	<div class="board-bar">
		<a class="board action" href="imgList"><i class="fas fa-image"></i></a>
		<a class="board" href="videoList"><i class="fas fa-video"></i></a>	
		</div>
	<div class="articles-box">
		<ul>
			<c:forEach items="${articles}" var="article">
				<c:if test="${article.extra.file__common__attachment['3'] != null}">
					<li data-id="${article.id}">
					<div class="dark-box"></div>
						<div class="img-wrap">
							<a class="cursor1" href="../article/detail?id=${article.id}">
								<img class="other-articleImg"
								src="/meet/file/showImg?id=${article.extra.file__common__attachment['3'].id}&updateDate=${article.extra.file__common__attachment['3'].updateDate}"
								alt="" />
							</a>
						</div>
					</li>
				</c:if>
			</c:forEach>
		</ul>
	</div>
	<map name="map">
		<area shape="rect" coords="267,321,362,346" href="#"
			onclick="javascript:window.open('/article/detail','','width=900,height=900,scrollbars=yes,resizable=no');return false"
			onfocus='this.blur()'>
	</map>
	<!--  
		<c:if test="${article.extra.file__common__attachment['1'] != null}">
		<li>
		<div class="img-wrap">
		<video controls class="other-articleVideo"
			src="/file/streamVideo?id=${article.extra.file__common__attachment['1'].id}&updateDate=${article.extra.file__common__attachment['1'].updateDate}">video
			not supported
		</video>
		</div>
		</li>
	</c:if>
	<c:if test="${article.extra.file__common__attachment['2'] != null}">
		<li>
		<div class="img-wrap">
		<video controls class="other-articleVideo"
			src="/file/streamVideo?id=${article.extra.file__common__attachment['2'].id}&updateDate=${article.extra.file__common__attachment['2'].updateDate}">video
			not supported
		</video>
		</div>
		</li>
	</c:if>
	 -->
	<!--  이미지  		<c:if test="${article.extra.file__common__attachment['3'] != null}">
		<li>
		<div class="img-wrap">
		<a href="../article/detail?id=${article.id}">
		<img class="other-articleImg"
			src="/file/showImg?id=${article.extra.file__common__attachment['3'].id}&updateDate=${article.extra.file__common__attachment['3'].updateDate}"
			alt="" /></a>
		</div>
		</li>
	</c:if>
	<c:if test="${article.extra.file__common__attachment['4'] != null}">
		<li>
		<div class="img-wrap">
		<a href="../article/detail?id=${article.id}">
		<img class="other-articleImg"
			src="/file/showImg?id=${article.extra.file__common__attachment['4'].id}&updateDate=${article.extra.file__common__attachment['4'].updateDate}" />
		</a>
		</div>
		</li>
	</c:if>
	 -->
</div>
<%@ include file="../part/foot.jspf"%>
