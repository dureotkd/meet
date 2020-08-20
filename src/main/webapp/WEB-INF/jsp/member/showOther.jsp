<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../part/head.jspf"%>

<h1>총 게시글 : ${articleCount}</h1>
<h1>성명 : ${member.name}</h1>
<h1>활동명 : ${member.nickname}</h1>
<h1>소개 : ${member.introduce}</h1>
<h1>
	<c:forEach items="${articles}" var="article">
		<c:if test="${article.extra.file__common__attachment['1'] != null}">
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
		</c:if>
		<c:if test="${article.extra.file__common__attachment['2'] != null}">
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
		</c:if>
		<c:if test="${article.extra.file__common__attachment['3'] != null}">
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
		</c:if>
		<c:if test="${article.extra.file__common__attachment['4'] != null}">
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
	</c:forEach>
</h1>
<form action="follow">
	<input type="hidden" name="loginedMemberId" value="${loginedMemberId}" />
	<input type="hidden" name="memberId" value="${member.id}" /> <input
		type="submit" value="팔로우" />
</form>
<%@ include file="../part/foot.jspf"%>