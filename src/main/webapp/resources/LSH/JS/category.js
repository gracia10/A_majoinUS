function level1(){
	$.ajax({
		type:"get",
		url:getContext()+"/aus/category",
		dataType:"json",
		contentType: "application/json; charset=utf-8",
		success:function(args){
			var array = [];
			
			for(i=0 ; i < args.FJL1.length; i += 1){
			    array[i] = "<option value='"+args.FJL1[i]+"'>"+args.FJL1[i]+"</option>";
			}
			$("#job1").html(array.join(''));
			
			for(i=0; i < args.FLL1.lengt; i += 1){
			    array[i] = "<option value='"+args.FLL1[i]+"'>"+args.FLL1[i]+"</option>";
			}
			$("#local1").html(array.join(''));
			
			setLevel2("job12",args.FJL2);
			setLevel2("local12",args.FLL2);
		}
	});
}

function getLevel2(element){
	var level1 = $(element).val();
	var id = $(element).attr("id")+"2";
	
	$.ajax({
		type : "get",
		url : getContext()+"/aus/category/"+level1,
		dataType : "json",
		success : function(list) {
			setLevel2(id,list)
		}
	});
}

function setLevel2(id,list){
	$("#" + id + " option").each(function() {
		$("#" + id + " option:eq(0)").remove();
	});
	for (var idx = 0; idx < list.length; idx++) {
		$("#" + id).append("<option value='"+list[idx]+"'>"+ list[idx] + "</option>");
	}
}

function add(element) {
	var list = [],
		html1 = "",
		html2 = "",
		i = 0,
		what = $(element).attr("value"), str = $("#" + what + "1").val() + ">"+ $("#" + what + "12").val(),
		len = $("input[name=" + what+ "]").length;

		for (; i < len; i += 1) {
			list.push($("input[name='" + what + "']:eq(" + i + ")").val());
		}

		if (list.indexOf(str) > -1) {
			alert("이미 추가된 검색어 입니다.");
		} else if (len >= 3) {
			alert("3개 까지 지정가능합니다. (현재 입력수:" + len + ")");
		} else {
			html1 += "<span id="+global.i+">" + str + " ";
			html1 += "<span id="+global.i+" class='del_btn'><i class='fa fa-fw fa-times-circle'></i></span></span>";
			html2 += "<input type='hidden' id='"+global.i+"' name='"+what+"' value='"+str+"'>";

			$('#' + what + '_list').append(html1);
			$('#hidden').append(html2);
			global.i+=1;
		}
}

function del(elements) {
	var num = $(elements).attr("id");
	
	$("#" +num).remove();
	$("#" +num).remove();
}

$('.show-level2').on('change', function() {
	getLevel2(this);
});

$('.add_btn').on('click', function() {
	console.log("3.에드");
	add(this);
});

$('#result').on('click', '.del_btn', function() {
	console.log("4.삭제");
	del(this);
});

