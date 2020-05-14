function level1(){
	$.ajax({
		type:"get",
		url:getContext()+"/aus/category",
		dataType:"json",
		success:function(args){
			var arr = [];
			args.FJL1.forEach(e => arr.push("<option value='"+e+"'>"+e+"</option>"))
			$("#job1").html(arr.join(''));
			
			arr = [];
			args.FLL1.forEach(e => arr.push("<option value='"+e+"'>"+e+"</option>"))
			$("#local1").html(arr.join(''));
			
			setLevel2("#job2",args.FJL2);
			setLevel2("#local2",args.FLL2);
		}
	});
}

function getLevel2(element){
	var id = "#"+$(element).attr("id").replace("1","2");
	
	$.ajax({
		type : "get",
		url : getContext()+"/aus/category/"+$(element).val(),
		dataType : "json",
		success : function(list) {
			setLevel2(id,list)
		}
	});
}

function setLevel2(id,list){
	$(id+" option").each(function() {
		$(id+" option:eq(0)").remove();
	});
	
	list.forEach(e => $(id).append("<option value='"+e+"'>"+e+"</option>"));
}

function add(element) {
	var category = $(element).attr("value"), 
		str = $("#"+category+"1").val()+">"+ $("#"+category+"2").val()
		html = "";
	
	var list = document.getElementById(category+"_list");
	
	if(list.innerText.indexOf(str) !== -1){
		alert("이미 추가된 조건 입니다.");
	}else if(list.childElementCount >= 3){
		alert("카테고리별 3개만 지정가능합니다.");
	}else{
		html = "<span><input type='hidden' name='"+category+"' value='"+str+"'>"+str;
		html += "<i class='fa fa-fw fa-times-circle del_btn'></i></span>";
		$('#'+category+'_list').append(html);
	}
}

function del(elements) {
	$(elements).parents("span").remove();
}

$('.show-level2').on('change', function() {
	getLevel2(this);
});

$('.add_btn').on('click', function() {
	add(this);
});

$('#result').on('click', '.del_btn', function() {
	del(this);
});

