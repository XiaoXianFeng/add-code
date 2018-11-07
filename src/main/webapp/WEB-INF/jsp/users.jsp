<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ taglib prefix="security"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="spring"
	uri="http://www.springframework.org/tags"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="cache-control" content="max-age=0" />
    <meta http-equiv="cache-control" content="no-cache" />
    <meta http-equiv="expires" content="Tue, 01 Jan 1980 1:00:00 GMT" />
    <meta http-equiv="pragma" content="no-cache" />
        
	<title>用戶管理</title>
	<script src="<%=request.getContextPath()%>/resources/jquery/jquery-2.0.3.min.js"></script>
	<link href="<%=request.getContextPath()%>/resources/main.css" rel="stylesheet">
	<!-- bootstrap -->
	<link href="<%=request.getContextPath()%>/resources/bootstrap300/css/bootstrap.css" rel="stylesheet">
	<script src="<%=request.getContextPath()%>/resources/bootstrap300/js/bootstrap.js"></script>
		
	<style>
		#users {
		    font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
		    border-collapse: collapse;
		    width: 100%;
		}
		
		#users td, #users th {
		    border: 1px solid #ddd;
		    padding: 8px;
		}
		
		#users tr:nth-child(even){background-color: #f2f2f2;}
		
		#users tr:hover {background-color: #ddd;}
		
		#users th {
		    padding-top: 12px;
		    padding-bottom: 12px;
		    text-align: left;
		    background-color: #4CAF50;
		    color: white;
		}
		
		input[type=submit] {
			background-color: #4CAF50;
			color: white;
			padding: 12px 20px;
			border: none;
			border-radius: 4px;
			cursor: pointer;
		}
		
		input[type=submit]:hover {
			background-color: #45a049;
		}
		
		input[type=button] {
			background-color: #4CAF50;
			color: white;
			padding: 12px 20px;
			border: none;
			border-radius: 4px;
			cursor: pointer;
		}
		
		input[type=button]:hover {
			background-color: #45a049;
		}
	</style>
</head>
<body>
	<jsp:include page="navi.jsp">
		<jsp:param name="page" value="setting" />
	</jsp:include>

	<c:if test="${not empty users}">
		<table style="width: 700px;" id="users">
			<tr>
				<th style="width: 200px;">用户名</th>
				<th style="width: 200px;">邮件</th>
				<th style="width: 100px;">是否有效</th>
				<th style="width: 100px;">权限</th>
				<th style="width: 100px;"></th>
			</tr>
			<c:forEach var="u" items="${users}" varStatus="status">
				<tr>
					<td><c:out value="${u.username}"></c:out></td>
					<td><c:out value="${u.email}"></c:out></td>
					<td>
						<c:if test="${u.enabled == '1'}">有效</c:if>
						<c:if test="${u.enabled != '1'}">无效</c:if>
					</td>
					<td>
						<c:forEach var="r" items="${u.roles}" varStatus="status">
							<c:if test="${r == 'ROLE_USER'}">一般</c:if>
							<c:if test="${r == 'ROLE_ADMIN'}">管理员</c:if>
						</c:forEach>
					</td>
					<td><a href="<c:url value = "/do/user/edit/?username=${u.username}"/>">编辑</a></td>
				</tr>
			</c:forEach>
		</table>
	</c:if>
	
	<c:if test="${empty users}">
		还没有用户
	</c:if>
	<br/>
	<form method="GET" action="<%=request.getContextPath()%>/do/user/create/">
		<input type="submit" name="Create" value="创建用户">
	</form>
	
	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>