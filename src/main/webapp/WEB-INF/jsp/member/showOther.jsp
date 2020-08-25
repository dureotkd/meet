<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../part/head.jspf"%>

<style>
.other-show-box {
	display: flex;
	margin: 50px auto;
	max-width: 1080px;
	justify-content: space-between;
	align-items: center;
}

.other-text-box {
	display: flex;
	flex-direction: column;
	justify-content: space-between;
	margin-left: 50px;
	width: 400px;
}

.other-follow-box {
	display: flex;
}

.other-img {
	width: 200px;
	height: 200px;
	border-radius: 50%;
}

.articles-box {
	max-width: 1080px;
	margin: 0 auto;
	border: 1px solid #ccc;
	box-shadow: 3px 3px 3px #ccc;
}

@media ( min-width :901px ) {
	.articles-box>ul>li {
		margin-top: 20px;
		width: calc(100%/ 3 - ( 20px * ( 3 - 1)/3));
	}
	.articles-box>ul>li:not (:nth-child(3n) ) {
		margin-right: 20px;
	}
}

.articles-box>ul {
	display: flex;
	flex-flow: row wrap;
	justify-content: center;
}

.other-articleImg {
	width: 300px;
	height: 300px;
}

.other-articleVideo {
	width: 300px;
	height: 300px;
}

.img-wrap {
	text-align: center;
}

.other-nick {
	font-size: 1.5rem;
}

.other-img-box {
	display: flex;
}

.other-followBox {
	display: flex;
	justify-content: space-between;
}

.other-followBox>span {
	padding-top: 10px;
}

.other-info-box {
	display: flex;
	align-items: center;
	justify-content: space-between;
}

.level10 {
	color: #ffb300;
}

.level5 {
	color: #3949ab;
}

.submit-item {
	padding: 10px;
	background: #0095f6;
	border: none;
	cursor: pointer;
	color: white;
}

.other-recomend-box {
	display: flex;
	height: 200px;
	width: 300px;
	justify-content: space-around;
	align-items: center;
	flex-direction: column;
}

.other-recomend-box>p {
	padding: 10px;
}
</style>


<nav class="other-show-box">
	<div class="other-img-box">
		<img class="other-img" src="${member.extra.writerAvatarImgUrl}" alt="" />
		<div class="other-text-box">
			<div class="other-info-box">
				<div class="other-nick">${member.nickname}</div>
				<c:if test="${member.level == 10 }">
					<i class="fas fa-crown level10"></i>
				</c:if>
				<c:if test="${member.level == 5 }">
					<i class="fas fa-certificate level5"></i>
				</c:if>
				<c:if test="${member.level < 5 }">
					<i class="fas fa-user-alt level"></i>
				</c:if>


				<input type="submit" value="메세지 보내기" class="submit-item" /> <input
					type="submit" value="팔로우" class="submit-item" /> <i
					class="fas fa-ellipsis-h"></i>
			</div>
			<div class="other-followBox">
				<span class="article-count">게시글 ${articleCount}</span> <span
					class="">팔로우 2</span> <span> 팔로워 2</span>
			</div>
			<div class="other-introduce">
				<p>${member.introduce}</p>
			</div>
		</div>
	</div>


	<div class="other-recomend-box">
		<h3>The Weeknd - I Fell it Coming</h3>
		<audio controls autoplay loop>
			<source src="dancing.mp3" type="audio/mp3" />
		</audio>
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
						<a href="../article/detail?id=${article.id}"> <img
							class="other-articleImg"
							src="/file/showImg?id=${article.extra.file__common__attachment['3'].id}&updateDate=${article.extra.file__common__attachment['3'].updateDate}"
							alt="" /></a>
					</div>
				</li>
			</c:if>
		</c:forEach>
	</ul>
</div>
<%@ include file="../part/foot.jspf"%>