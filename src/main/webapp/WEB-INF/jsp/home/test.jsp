<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../part/head.jspf"%>

<link
	href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.9/css/select2.min.css"
	rel="stylesheet" />
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.9/js/select2.min.js"></script>
	
	
	
<!--  toast 메시지 라이브러리 -->
<link rel="stylesheet" type="text/css" href="http://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/css/toastr.min.css" />
<script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
	

<style>

.select2-container--default .select2-selection--multiple .select2-selection__choice {
	display:none;
}

.select {
	margin: 300px auto;
    text-align: center;
    width:200px;
}
.select2-container--default.select2-container--focus .select2-selection--multiple {
	width:300px;
}
.select2-container--default .select2-results>.select2-results__options {
	width:300px;
	height:200px;
}
.select2-dropdown select2-dropdown--below {
	width:300px;
}
.select2-dropdown {
	z-index:10 !important;
}

.select2{
width:300px !important;
}
.select2-result-repository__avatar {
	width:100px;
	height:100px;
	border-radius:50%;
	overflow:hidden;
}
.repo-avatar {
	width:100%;
	height:100%;
	object-fit:cover;
}
.fa-quote-left {
	margin-right:6px;
}

</style>

<div class="select">
<!-- 속성에 multiple를 추가합시다. -->
<select class="form-control" multiple="multiple">
</select>
</div>

<div id="modal">
</div>

<script>

$(document).ready(function(){
	$('.form-control').select2({
		placeholder: '선택하여 주십시오.',
		closeOnSelect: false,		
		minimumInputLength: 1,
		templateResult: formatRepo,
		templateSelection: formatRepoSelection,
		ajax: {
			type: "GET",
			url: "../member/registory",
			dataType: 'json',
			delay: 400,
			catch: true,
			// 검색 쿼리
			data: function (params) {
				return {
					searchKeyword:params.term
					};
				},
				 processResults: function (response) {
				        return {
				            results:response
				        };
				    },	
			}
	});
});

function formatRepo (repo) {
	  if (repo.loading) {
	    return "잠시만 기다려 주세요.";
	  }

	  var $container = $(
	    "<div class='select2-result-repository clearfix'>" +
	    "<a href='../member/showOther?id="+repo.id+"'>"  + 
	      "<div class='select2-result-repository__avatar'><img class='repo-avatar' src=' " + repo.image.repoAvatarImg +"' /></div>" +
	      "<div class='select2-result-repository__meta'>" +
	        "<div class='select2-result-repository__title'><p>" + repo.text +  "</p></div>" +
	        "<div class='select2-result-repository__description'></div>" +
	        "<div class='select2-result-repository__statistics'>" +
	          "<div class='select2-result-repository__stargazers'><i class='fa fa-star'></i> </div>" +
	          "<div class='select2-result-repository__watchers'><i class='fas fa-quote-left'></i></div>" +
	        "</div>" +
	      "</div>" +
	      "</a>" + 
	    "</div>"
	  );

	  $container.find(".select2-result-repository__stargazers").append(repo.followerCount + " 팔로우	");
	  $container.find(".select2-result-repository__watchers").append(repo.articleCount + " 게시글 ");

	  return $container;
	}

	function formatRepoSelection (repo) {
	  return repo.full_name || repo.text;
	}
</script>



<%@ include file="../part/foot.jspf"%>