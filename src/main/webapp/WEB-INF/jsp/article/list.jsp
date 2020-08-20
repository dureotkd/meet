<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../part/head.jspf"%>

<h1>리스트</h1>
<div class="table-box article-list-box">
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
				<th>제목</th>
				<th>프로필</th>
				<th>비고</th>
			</tr>			
		</thead>
		<tbody class="article-body">
		</tbody>
	</table>
</div>	




<script>
	var articleList__$box = $('.article-list-box');
	var articleList__$tbody = articleList__$box.find('tbody');
	var articleList__lastLodedId = 0;

	articleList__loadMoreInterval = 1 * 3000

	function articleList__loadMoreCallback(data){
		if(data.body.articles && data.body.articles.length > 0){
			articleList__lastLodedId = data.body.articles[data.body.articles.length -1].id;
			articleList__drawArticles(data.body.articles);
			}

		setTimeout(articleList__loadMore,articleList__loadMoreInterval);
	}
		function articleList__loadMore() {

			$.get('../article/listAjax', {
				from : articleList__lastLodedId + 1
			}, articleList__loadMoreCallback, 'json');
		}

		function articleList__drawArticles(articles) {
			for (var i = 0; i < articles.length; i++) {
				var article = articles[i];
				articleList__drawArticle(article);
			}
		}

		function articleList__drawArticle(article) {
			var html = '';
			html += '<tr data-id="' + article.id + '">';
			html += '<td>' + article.id + '</td>';
			html += '<td>' + article.regDate + '</td>';
			html += '<td>' + article.extra.writer + '</td>';
			
			html += '<td>';
			html += '<a href="detail?id='+article.id+'"><div class="article-body">' + article.title + '</div></a>';

			html += '</td>';

			html += '<td>';
			// 회원가입시 
			html += '<a href="../member/showOther?id='+article.memberId+'"><img class="reply-img-Avatar" src="' + article.extra.writerAvatarImgUrl + '"></a>';
			html += '</td>';
			
			html += '<td>';

			html += '<button type="button" onclick="ReplyList__delete(this);">삭제</button>';
			
			html += '<button type="button" onclick="ReplyList__showModifyFormModal(this);">수정</button>';
			
			html += '</td>';
			html += '</tr>';
			var $tr = $(html);
			articleList__$tbody.prepend($tr);
		}

		articleList__loadMore();
</script>
<%@ include file="../part/foot.jspf"%>
