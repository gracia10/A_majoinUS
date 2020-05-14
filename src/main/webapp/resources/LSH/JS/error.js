$.ajaxSetup({
	beforeSend : function(xmlHttpRequest) {
		xmlHttpRequest.setRequestHeader("AJAX", "true");
	},
	error : function(jqXHR, exception) {
        if (jqXHR.status == 400) {
        	alert("요청을 수행하지 못했습니다.");
        }
        else if (jqXHR.status == 403) {
        	document.writeln(jqXHR.responseText);
        }
        else if (jqXHR.status == 404) {
        	document.writeln(jqXHR.responseText);
        }
        else if (jqXHR.status == 405) {
        	alert("요청을 수행하지 못했습니다.");
        }
        else if (jqXHR.status == 500) {
        	alert("서버에 문제가 발생했습니다. 잠시 후 이용해주세요.");
        }
	}
});
