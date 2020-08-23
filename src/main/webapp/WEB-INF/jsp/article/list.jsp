<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../part/head.jspf"%>

<style>

.articles-box {
	max-width:1080px;
	margin:0 auto;
}

@media ( min-width:901px ) {
  .articles-box > ul > li {
    margin-top:20px;
    width:calc(100% / 3 - (20px * (3 - 1) / 3));
  }
  .articles-box > ul > li:not(:nth-child(3n)) {
  }
}


.total-wrap {
	background:#fafafa;
	width:100%;
	height:100%;
}

.articles-box > ul {
	display:flex;
	flex-flow:row wrap;
	justify-content:center;
}
.other-articleImg {
	width:300px;
	transition:all.3s;
}
.img-wrap:hover .good-item{
	opacity:1;
}
.img-wrap:hover .fa-comment-dots{
	opacity:1;
}
.img-wrap:hover .other-articleImg{
	opacity:0.8;
}

.other-articleVideo{
	height:300px;
}
.img-wrap {
	text-align:center;
	position:relative;
	transition:all.3s;
}

.board-bar {
	display:flex;
	justify-content:center;
	align-items:center;
}
.board {
	font-size:1.2rem;
	padding:15px;
	margin-top:20px;
}
.good-item {
	position:absolute;
	color:#d81b60;
	top:10px;
	left:40px;
	font-size:25px;
	transition:all.3s;
	opacity:0;
}
.fa-comment-dots {
	position:absolute;
	color:white;
	top:10px;
	left:100px;
	font-size:25px;
	transition:all.3s;
	opacity:0;
}
</style>
<div class="total-wrap">
	<div class="board-bar">
	<a class="board" href="#">Photo</a>
	<a class="board" href="#">Video</a>
	<a class="board" href="#">Article</a>
	</div>
<div class="articles-box">
	<ul>
	<c:forEach items="${articles}" var="article">
		<c:if test="${article.extra.file__common__attachment['3'] != null}">
		<li>
		<div class="img-wrap">
		<a href="../article/detail?id=${article.id}">
		<img class="other-articleImg" src="/file/showImg?id=${article.extra.file__common__attachment['3'].id}&updateDate=${article.extra.file__common__attachment['3'].updateDate}" alt="" /></a>
		<i class="fas fa-heart good-item "></i>
		<i class="fas fa-comment-dots"></i>
		</div>
		</li>
	</c:if>
	</c:forEach>
	</ul>
	</div>
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
