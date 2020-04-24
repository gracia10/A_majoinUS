$.ajaxSetup({
	beforeSend: function(xmlHttpRequest){
		xmlHttpRequest.setRequestHeader("AJAX","true");	
	},
    error: function(jqXHR, exception) {
       document.writeln(jqXHR.responseText);
    }
});
