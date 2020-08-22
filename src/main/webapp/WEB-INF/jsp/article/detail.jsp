<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../part/head.jspf"%>

<style>
.reply-body {
	width: 100%;
}

.detail-box {
	display: flex;
	justify-content: center;
}

.total-wrap {
	width: 100%;
	height: 100%;
	background: #fafafa;
	padding-top: 50px;
}

.reply-img-Avatar {
	width: 40px;
	height: 40px;
	border-radius: 50%;
}

.article-writer-Avatar {
	width: 40px;
	height: 40px;
	border-radius: 50%;
	border: 1px solid pink;
}

.reply-writer {
	color: #262626;
	font-weight: 600;
}

.reply-list-box {
	width: 350px;
}

.article-user-box {
	display: flex;
	align-items: center;
	justify-content: space-between;
	padding: 15px;
}

.writer-center {
	display: flex;
	align-items: center;
}

.writer {
	color: #262626;
	font-weight: 600;
	margin-left: 15px;
}

.fa-certificate {
	color: #3f51b5;
}

.reply-item {
	padding: 15px;
}

.article-body {
	padding: 15px;
}

.article-img {
	height: 550px;
}

.abody {
	line-height: 25px;
}

.reply-write-box {
	padding: 15px;
	display: flex;
	flex-direction: column;
}

.textarea {
	padding: 10px;
	background: none;
	border: 1px solid #000a12;
}

/* Slideshow container */
.slideshow-container {
	position: relative;
}

/* Next & previous buttons */
.prev, .next {
	cursor: pointer;
	position: absolute;
	top: 50%;
	width: auto;
	padding: 16px;
	margin-top: -22px;
	color: #bdbdbd;
	font-weight: bold;
	font-size: 18px;
	transition: 0.6s ease;
	border-radius: 0 3px 3px 0;
}

/* Position the "next button" to the right */
.next {
	right: 0;
	border-radius: 3px 0 0 3px;
}

/* Fading animation */
.fade {
	-webkit-animation-name: fade;
	-webkit-animation-duration: 1.5s;
	animation-name: fade;
	animation-duration: 1.5s;
}

@
-webkit-keyframes fade {
	from {opacity: .4
}

to {
	opacity: 1
}

}
@
keyframes fade {
	from {opacity: .4
}

to {
	opacity: 1
}

}

/* On smaller screens, decrease text size */
@media only screen and (max-width: 300px) {
	.prev, .next, .text {
		font-size: 11px
	}
}
</style>

<script>
	function WriteReply__submitForm(form) {
		form.body.value = form.body.value.trim();
		if (form.body.value.length == 0) {
			alert('댓글을 입력해주세요.');
			form.body.focus();
			return;
		}
		$.post('../reply/doWriteReplyAjax', {
			articleId : form.articleId.value,
			body : form.body.value
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


	
	var slideIndex = 1;
	showSlides(slideIndex);

	function plusSlides(n) {
	  showSlides(slideIndex += n);
	}

	function currentSlide(n) {
	  showSlides(slideIndex = n);
	}

	function showSlides(n) {
	  var i;
	  var slides = document.getElementsByClassName("mySlides");
	  if (n > slides.length) {slideIndex = 1}    
	  if (n < 1) {slideIndex = slides.length}
	  for (i = 0; i < slides.length; i++) {
	      slides[i].style.display = "none";  
	  }
	  slides[slideIndex-1].style.display = "block";  
	  dots[slideIndex-1].className += " active";
	}
	
</script>
<div class="total-wrap">
	<div class="detail-box">
	
		<div class="slideshow-container">

			<c:if test="${article.extra.file__common__attachment['3'] != null}">
				<div class="mySlides fade">
					<img class="article-img"
						src="/file/showImg?id=${article.extra.file__common__attachment['3'].id}&updateDate=${article.extra.file__common__attachment['3'].updateDate}"
						alt="" />
				</div>
			</c:if>


			<c:if test="${article.extra.file__common__attachment['4'] != null}">
				<div class="mySlides fade" style="display: none;">
					<img class="article-img"
						src="/file/showImg?id=${article.extra.file__common__attachment['4'].id}&updateDate=${article.extra.file__common__attachment['4'].updateDate}" />
				</div>
			</c:if>
	
			<a class="prev" onclick="plusSlides(-1)">&#10094;</a> <a class="next" onclick="plusSlides(1)">&#10095;</a>
		</div>
		<c:if test="${article.extra.file__common__attachment['1'] != null}">
			<video controls
				src="/file/streamVideo?id=${article.extra.file__common__attachment['1'].id}&updateDate=${article.extra.file__common__attachment['1'].updateDate}"></video>
		</c:if>
		<c:if test="${article.extra.file__common__attachment['2'] != null}">
			<div class="video-box">
				<video controls
					src="/file/streamVideo?id=${article.extra.file__common__attachment['2'].id}&updateDate=${article.extra.file__common__attachment['2'].updateDate}"></video>
			</div>
		</c:if>

		<div class="table-box reply-list-box">
			<div class="article-user-box">
				<a href="../member/showOther?id=${article.memberId}"
					class="writer-center"> <img class="article-writer-Avatar"
					src="${article.extra.writerAvatarImgUrl}"> <span
					class="writer">${article.extra.writer}</span></a> <i
					class="fas fa-certificate"></i>
				<p>팔로우</p>
				<i class="fas fa-ellipsis-h"></i>
			</div>
			<div class="article-body">
				<p class="abody">${article.body}</p>
			</div>


			<div class="reply-item"></div>

			<c:if test="${isLogined}">
				<form action=""
					onsubmit="WriteReply__submitForm(this); return false;">
					<div class="reply-write-box">
						<input type="hidden" name="articleId" value="${article.id}" />
						<textarea class="textarea" name="body" cols="30" rows="1"
							placeholder="댓글 달기"></textarea>
						<input type="submit" class="submit" />
					</div>
				</form>
			</c:if>
		</div>

		<script>
			var ReplyList__$box = $('.reply-list-box');
			var ReplyList__$tbody = ReplyList__$box.find('.reply-item');
			var ReplyList__lastLodedId = 0;

			// 1초댓글불러오기
			ReplyList__loadMoreInterval = 1 * 1000

			function ReplyList__loadMoreCallback(data) {
				if (data.body.articleReplies
						&& data.body.articleReplies.length > 0) {
					ReplyList__lastLodedId = data.body.articleReplies[data.body.articleReplies.length - 1].id;
					ReplyList__drawReplies(data.body.articleReplies);

				}

				setTimeout(ReplyList__loadMore, ReplyList__loadMoreInterval);
			}

			function ReplyList__loadMore() {

				$.get('../reply/getForPrintRepliesAjax', {
					articleId : param.id,
					from : ReplyList__lastLodedId + 1
				}, ReplyList__loadMoreCallback, 'json');
			}

			function ReplyList__drawReplies(articleReplies) {
				for (var i = 0; i < articleReplies.length; i++) {
					var articleReply = articleReplies[i];
					ReplyList__drawReply(articleReply);
				}
			}

			function ReplyList__drawReply(articleReply) {
				var html = '';
				html += '<tr data-id="' + articleReply.id + '">';
				//	html += '<td>' + articleReply.id + '</td>';
				//	html += '<td>' + articleReply.regDate + '</td>';

				html += '<td>';
				// 회원가입시 
				html += '<a href="../member/showOther?id='
						+ articleReply.memberId
						+ '"><img class="reply-img-Avatar" src="' + articleReply.extra.writerAvatarImgUrl + '"></a>';
				html += '</td>';

				html += '<td class="reply-writer">' + articleReply.extra.writer
						+ '</td>';

				html += '<td>';
				html += '<div class="reply-body">' + articleReply.body
						+ '</div>';
				//	html += '<button type="button" onclick="ReplyList__delete(this);">삭제</button>';

				//	html += '<button type="button" onclick="ReplyList__showModifyFormModal(this);">수정</button>';
				html += '</td>';
				html += '</tr>';
				var $tr = $(html);
				ReplyList__$tbody.prepend($tr);
			}

			ReplyList__loadMore();
		</script>



	</div>
</div>






<%@ include file="../part/foot.jspf"%>