<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../part/head.jspf"%>

<style>
.other-show-box {
	display: flex;
	margin: 50px auto;
	justify-content: left;
	width:75%;
}

.other-text-box {
	display: flex;
	flex-direction: column;
	justify-content: center;
	width: 300px;
	margin-left: 50px;
}

.other-follow-box {
	display: flex;
}

.other-img {
	width: 200px;
	height: 200px;
	border-radius: 50%;
	border: 1px solid red;
}

.articles-box {
	max-width:1080px;
	margin:0 auto;
	border-top:1px solid #ccc;
}

@media ( min-width:901px ) {
  .articles-box > ul > li {
    margin-top:20px;
    width:calc(100% / 3 - (20px * (3 - 1) / 3));
  }
  .articles-box > ul > li:not(:nth-child(3n)) {
    margin-right:20px;
  }
}

.articles-box > ul {
	display:flex;
	flex-flow:row wrap;
	justify-content:center;
}
.other-articleImg {
	width:300px;
	height:300px;
}
.other-articleVideo{
	width:300px;
	height:300px;
}
.img-wrap {
	text-align:center;
}
.other-nick {
	font-size:1.5rem;
}
</style>


<nav class="other-show-box">
	<div class="other-img-box">
		<img class="other-img"
			src="${articleForPrintOneImg.extra.writerAvatarImgUrl}" alt="" />
	</div>
	<div class="other-text-box">
		<div class="other-nick">${member.nickname}</div>
		<span class="article-count">게시글 ${articleCount}</span>
		<div class="other-follow-box">
			<form action="follow" class="center">
				<input type="hidden" name="loginedMemberId" value="${loginedMemberId}" />
				<input type="hidden" name="memberId" value="${member.id}" />
				<input type="submit" value="팔로우"
					class="submit" />
			</form>
			<form action="follower" class="center">
				<input type="hidden" name="loginedMemberId"
					value="${loginedMemberId}" /> <input type="hidden" name="memberId"
					value="${member.id}" /> <input type="submit" value="팔로워"
					class="submit" />
			</form>
		</div>
		<div class="other-introduce">
			<p>${member.introduce}</p>
		</div>
	</div>
</nav>

<div class="articles-box">
<ul>
<c:forEach items="${articles}" var="article">
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
	 <!--  이미지  	 -->
	<c:if test="${article.extra.file__common__attachment['3'] != null}">
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
</c:forEach>
</ul>
</div>
<%@ include file="../part/foot.jspf"%>