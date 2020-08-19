<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../part/head.jspf"%>
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
   				<td>${article.body} 
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
							<img src="/file/showImg?id=${article.extra.file__common__attachment['3'].id}&updateDate=${article.extra.file__common__attachment['3'].updateDate}" alt="" />
						</div>
					</td>
				</tr>
			</c:if>
			<c:if test="${article.extra.file__common__attachment['4'] != null}">
				<tr>
					<th>첨부 파일 4 이미지</th>
					<td>
						<div class="img-box"><img src="/file/showImg?id=${article.extra.file__common__attachment['4'].id}&updateDate=${article.extra.file__common__attachment['4'].updateDate}" /></div>
					</td>
				</tr>
			
			</c:if>
			
   				
   			</tr>
   		</tbody>
   	</table>
   	</div> 
<%@ include file="../part/foot.jspf"%>