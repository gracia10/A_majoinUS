<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<html>
<head>
<script>
	function Failed(){
		window.close();
	}
</script>
<title>Insert title here</title>
</head>
<tiles:insertDefinition name="header" />
<body onload="setTimeout(Failed(), 2)">
�õ��� �����Ͽ����ϴ�. �������� �̵��� �� �ٽ� �õ����ּ���.
</body>
<tiles:insertDefinition name="left" />
<tiles:insertDefinition name="footer" />
</html>
