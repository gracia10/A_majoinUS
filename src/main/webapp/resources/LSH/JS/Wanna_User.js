$('body').on('click','.plus_btn', function() {
	global.receiver = $(this).parents("tr").attr('id');
	
	if(global.receiver === getSessionId()){
		$(this).attr('data-target',"");
		global.receiver = "";
		alert("본인은 초대할 수 없습니다");
	}else{
		get_myPro();	
	}
});

$('body').on('click','.plus_btnF', function() {
	global.receiver = $(this).attr('id');
	get_myPro();	
});

$('.send_btn').on('click', function() {
	if($('#my_project').attr('disabled') !== 'disabled'){
		joinUs();	
	}
});

function get_myPro(){
	var url= getContext()+"/aus/show";
	
		$.ajax({
		type:"post",
		url:url,
		data : { "id": getSessionId()},
		dataType:"json",
		success:function(list){
			show_myPro(list);
		}
	});
}

function show_myPro(list){
	var html = "",
		i = 0,
		len = list.length;
	if(len === 0){
			$('#my_project').attr('disabled', 'disabled');
			html += "<option>개설한 프로젝트가 없습니다</option>"
	}else{
		for(;i<len;i+=1){
			html += "<option value='"+list[i]['PJ_NUM']+"'>"+list[i]['PJ_NAME']+"</option>";
		}
	}
	$("#my_project").html(html);
}


function joinUs(){
	
	var pj_num = $("#my_project").val();
	var url=getContext()+"/aus/insert_Message";
	var params = "receiver="+global.receiver+"&sender="+getSessionId()+"&pj_num="+pj_num+"&a_type=초대";
	
	$.ajax({
		type:"post",
		url:url,
		data : params
	});
}
