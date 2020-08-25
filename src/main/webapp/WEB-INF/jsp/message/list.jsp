<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../part/head.jspf"%>

<script>
	// article.id를 어떻게줘여하나..
</script>



<style>
.msg-con {
	max-width: 1080px;
	border: 1px solid #eee;
	display: flex;
	max-width: 1080px;
	border: 1px solid #eee;
	border-radius: 20px;
	box-shadow: 3px 3px 3px #ccc;
	align-items: center;
	justify-content: center;
	margin: 0 auto;
	margin-bottom: 50px;
}

.msg-box {
	display: flex;
	height: 450px;
	border-right: 1px solid #eee;
}

.msg-title {
	width: 350px;
	justify-content: space-between;
	display: flex;
	height: 50px;
	align-items: center;
	border-bottom: 1px solid #eee;
	padding:15px;
	font-size:1.2rem;
}

.total-wrap {
	background: #fafafa;
	width: 100%;
	height: 100%;
	padding-top: 50px;
}

.msg-send {
	width: 100%;
	height: 100%;
	display: flex;
	justify-content: center;
	flex-direction: column;
	align-items: center;
}

.circle {
	width: 100px;
	height: 100px;
	border: 1px solid;
	border-radius: 50%;
	position: relative;
}

.msgSubmit {
	color: white;
	border: none;
	outline: none;
	background: #0095f6;
	padding: 10px;
	cursor: pointer;
	display: flex;
	justify-content: center;
	width: 100px;
}

.msg-text {
	display: flex;
	flex-direction: column;
	margin-top: 10px;
	align-items: center;
	justify-content: center;
}

.msg-text>p {
	font-size: 2rem;
}

.msg-text>span {
	color: #bdbdbd;
	margin-bottom: 30px;
}

.fa-paper-plane {
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	font-size: 2rem;
}
</style>
<div class="total-wrap">
	<div class="msg-con">
		<div class="msg-box">
			<div class="msg-title">
				<i class="fas fa-ellipsis-h"></i>
				<p>Direct</p>
				<i class="far fa-edit"></i>
			</div>
		</div>
		<div class="msg-send">
			<div class="circle">
				<i class="far fa-paper-plane"></i>
			</div>
			<div class="msg-text">

				<p>내 메시지</p>
				<span>친구나 그룹에 메시지를 보내보세요.</span> <input type="submit"
					class="msgSubmit" value="메시지 보내기" />
			</div>
		</div>
	</div>
</div>
<%@ include file="../part/foot.jspf"%>
