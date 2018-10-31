<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="security"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<html>
	<head>
		<meta http-equiv="cache-control" content="max-age=0" />
        <meta http-equiv="cache-control" content="no-cache" />
        <meta http-equiv="expires" content="Tue, 01 Jan 1980 1:00:00 GMT" />
        <meta http-equiv="pragma" content="no-cache" />
        
		<title>出错了</title>
		
		<link href="<%=request.getContextPath()%>/resources/main.css" rel="stylesheet">
		<link href="<%=request.getContextPath()%>/resources/w3.css" rel="stylesheet">
		<!-- bootstrap -->
		<link href="<%=request.getContextPath()%>/resources/bootstrap300/css/bootstrap.css" rel="stylesheet">
		
	</head>
	<body style=" width: 100%;">
		<jsp:include page="navi.jsp">
			<jsp:param name="page" value="home" />
		</jsp:include>

		<div class="w3-panel w3-red">
		    <h3>出错了</h3>
		    <p><c:out value="${error}"/></p>
		</div>
		<a href="<%=request.getContextPath()%>${returnPage}">返回</a>
		
	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>
