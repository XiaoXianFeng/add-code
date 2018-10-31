<%@ page contentType="text/html;charset=utf-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/resources/main.css">
</head>
<body>

	<jsp:include page="navi.jsp">
		<jsp:param name="page" value="home" />
	</jsp:include>
	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>
