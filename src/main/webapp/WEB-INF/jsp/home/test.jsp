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
	

<script>
function imagepreview(input){
    if(input.files && input.files[0]){
        var filerd = new FileReader();
        filerd.onload=function(e){
            $('#imgpreview' + $(input).attr('id').slice(-1)).attr('src', e.target.result);
        };
        filerd.readAsDataURL(input.files[0]);
    }
  }


$(document).ready(function(){
	$('.form-control').select2({
		placeholder : '선택하여 주십시오.',
		minimumInputLength: 1,
		ajax: {
			type: "GET",
			url: "../member/registory",
			dataType: 'json',
			delay: 300,
			catch: true,
			// 검색 쿼리
			data: function (params) {
				return {
					nickname:params.term
					};
				},
				 processResults: function (data) {
				        return {
				            results: data.members
				        };
				    },
			}
	
	});
});
</script>

<style>
h2 {
	margin-top: 300px;
}

.margin {
	margin-top: 300px;
}

.form-control {
	width: 300px;
}


body{
font-family:arial;
}
.wrap{
border:0px solid;
width:40%;
margin:10px auto;
}

input{
    display:none;
}
.input-label{
    background-color:#009688;
    color:#fff;
    padding:5px 15px;
}
</style>



<div class="margin center" style="margin-left: 10px;">
	<!-- 속성에 multiple를 추가합시다. -->
	<select class="form-control" multiple="multiple">
	</select>
</div>


<div class="wrap">
<img id="imgpreview1" src="" width="100" height="100">
<img id="imgpreview2" src="" width="100" height="100"> 
<img id="imgpreview3" src="" width="100" height="100">
 <label for="idupload-1" class="input-label"><i class="fa fa-arrow-up"></i>upload</label><input type="file" id="idupload-1" onchange="imagepreview(this);" />
 <label for="idupload-2" class="input-label"><i class="fa fa-arrow-up"></i>upload</label><input type="file" id="idupload-2" onchange="imagepreview(this);" />
<label for="idupload-3" class="input-label"><i class="fa fa-arrow-up"></i>upload</label><input type="file" id="idupload-3" onchange="imagepreview(this);" />
</div>






<%@ include file="../part/foot.jspf"%>