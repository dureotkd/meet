<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../part/head.jspf"%>

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

li:hover .heart {
	opacity:1;
}
li:hover .comment {
	opacity:1;
}

li:hover .dark-box{
	opacity:0.1;
}
li:hover .img-wrap {
	opacity:0.4;
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
		<a class="board" href="videoList"><i class="fas fa-video"></i></a> <a
			class="board" href="textList"><i class="fas fa-quote-left"></i></a>
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
						<i class="fas fa-heart heart" onclick="callDoLike(this);">&nbsp;${article.extra.heartPoint}&nbsp;</i>
						<i class="far fa-comment-dots comment">&nbsp;${article.extra.replyCount}</i>
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
