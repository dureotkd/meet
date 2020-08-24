<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../part/head.jspf"%>


<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<style>

.articles-box {
	max-width:1080px;
	margin:0 auto;
	border:1px solid #ccc;
	box-shadow:3px 3px 3px #ccc;
}

@media ( min-width:901px ) {
  .articles-box > ul > li {
    margin-top:20px;
    width:calc(100% / 2 - (20px * (2 - 1) / 2));
  }
  
  .total-wrap {
		height:100vh;
	}
}

@media ( max-width:900px ){
	.total-wrap {
	height:100%;
	}
}




.total-wrap {
	background:#fafafa;
	width:100%;
}

.articles-box > ul {
	display:flex;
	flex-flow:row wrap;
	justify-content:center;
}
.other-articleImg {
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
	font-size:1.5rem;
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
.video {
	width:500px;
}
</style>
<div class="total-wrap">
	<div class="board-bar">
	<a class="board" href="list"><i class="far fa-image"></i></a>
	<a class="board" href="videoList"><i class="fas fa-video"></i></a>
	<a class="board" href="#"><i class="fas fa-quote-left"></i></a>
	</div>
<div class="articles-box">
	<ul>
	<c:forEach items="${articles}" var="article">
		<c:if test="${article.extra.file__common__attachment['1'] != null}">
		<li>
		<div class="img-wrap">
		<a href="../article/detail?id=${article.id}">
		<video class="video"  controls
				src="/file/streamVideo?id=${article.extra.file__common__attachment['1'].id}&updateDate=${article.extra.file__common__attachment['1'].updateDate}"></video>
		</a>
		<i class="fas fa-heart good-item "></i>
		<i class="fas fa-comment-dots"></i>
		
		<!--<c:set var="articleReplyCount" value="0"/>
		<c:forEach var="articleReply" items="${articleReply}" >
		<c:if test="${articleReply.articleId == article.id}">	
		</c:if>
		</c:forEach>
		</div>
		</li> !-->
	</c:if>
	</c:forEach>
	</ul>
	</div>


</div>
<%@ include file="../part/foot.jspf"%>
