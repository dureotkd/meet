<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../part/head.jspf"%>

<style>
.reply-body {
	width:100%;
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

</script>

<h1>디테일</h1>
<div class="table-box">
	<table>
		<colgroup>
			<col width="100" />
			<col width="200" />
		</colgroup>
		<thead>
			<tr>
				<td>번호</td>
				<td>날짜</td>
				<td>글쓴이</td>
				<td>제목</td>
				<td>내용</td>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>${article.id}</td>
				<td>${article.regDate}</td>
				<td>${article.extra.writer }</td>
				<td class="title">${article.title}</td>
				<td>${article.body}<c:if
						test="${article.extra.file__common__attachment['1'] != null}">
						<tr>
							<th>첨부 파일 1</th>
							<td>
								<div class="z">
									<video controls
										src="/file/streamVideo?id=${article.extra.file__common__attachment['1'].id}&updateDate=${article.extra.file__common__attachment['1'].updateDate}">video
										not supported
									</video>
								</div>
							</td>
						</tr>
					</c:if> <c:if
						test="${article.extra.file__common__attachment['2'] != null}">
						<tr>
							<th>첨부 파일 2</th>
							<td>
								<div class="video-box">
									<video controls
										src="/file/streamVideo?id=${article.extra.file__common__attachment['2'].id}&updateDate=${article.extra.file__common__attachment['2'].updateDate}">video
										not supported
									</video>
								</div>
							</td>
						</tr>
					</c:if> <c:if
						test="${article.extra.file__common__attachment['3'] != null}">
						<tr>
							<th>첨부 파일 3 이미지</th>
							<td>
								<div class="img-box">
									<img
										src="/file/showImg?id=${article.extra.file__common__attachment['3'].id}&updateDate=${article.extra.file__common__attachment['3'].updateDate}"
										alt="" />
								</div>
							</td>
						</tr>
					</c:if> <c:if
						test="${article.extra.file__common__attachment['4'] != null}">
						<tr>
							<th>첨부 파일 4 이미지</th>
							<td>
								<div class="img-box">
									<img
										src="/file/showImg?id=${article.extra.file__common__attachment['4'].id}&updateDate=${article.extra.file__common__attachment['4'].updateDate}" />
								</div>
							</td>
						</tr>
					</c:if>
			</tr>
		</tbody>
	</table>
</div>

<h1>댓글 리스트</h1>

<div class="table-box reply-list-box">
	<table>
		<colgroup>
			<col width="80">
			<col width="180">
			<col width="180">
			<col>
			<col width="200">
		</colgroup>
		<thead>
			<tr>
				<th>번호</th>
				<th>날짜</th>
				<th>작성자</th>
				<th>내용</th>
				<th>프로필</th>
				<th>비고</th>
			</tr>			
		</thead>
		<tbody class="reply-body">

		</tbody>
	</table>
</div>	
	
	<script>
	var ReplyList__$box = $('.reply-list-box');
	var ReplyList__$tbody = ReplyList__$box.find('tbody');
	var ReplyList__lastLodedId = 0;


	// 1초댓글불러오기
	 ReplyList__loadMoreInterval = 1 * 1000

	function ReplyList__loadMoreCallback(data) {
		if (data.body.articleReplies && data.body.articleReplies.length > 0) {
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
		html += '<td>' + articleReply.id + '</td>';
		html += '<td>' + articleReply.regDate + '</td>';
		html += '<td>' + articleReply.extra.writer + '</td>';
		
		html += '<td>';
		html += '<div class="reply-body">' + articleReply.body + '</div>';

		html += '</td>';

		html += '<td>';
		// 회원가입시 
		html += '<img class="reply-img-Avatar" src="' + articleReply.extra.writerAvatarImgUrl + '">';
		html += '</td>';
		
		html += '<td>';

		html += '<button type="button" onclick="ReplyList__delete(this);">삭제</button>';
		
		html += '<button type="button" onclick="ReplyList__showModifyFormModal(this);">수정</button>';
		
		html += '</td>';
		html += '</tr>';
		var $tr = $(html);
		ReplyList__$tbody.prepend($tr);
	}

	ReplyList__loadMore();

	
</script>



<c:if test="${isLogined}">
<h1>댓글 작성</h1>

<form action="" onsubmit="WriteReply__submitForm(this); return false;">
<div class="table-box">
<input type="hidden" name="articleId" value="${article.id}" />
	<table>
		<tbody>
			<tr>
				<th>내용</th>
				<td><textarea class="reply-body" name="body" cols="30" rows="10"
						placeholder="내용입력해주세요!"></textarea></td>
			</tr>
			<tr>
				<th>작성</th>
				<td><input type="submit" class="submit" /></td>
			</tr>
		</tbody>
	</table>
</div>
</form>
</c:if>







<%@ include file="../part/foot.jspf"%>