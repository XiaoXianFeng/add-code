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
        
	<title>模板管理</title>
	<script src="<%=request.getContextPath()%>/resources/jquery/jquery-2.0.3.min.js"></script>
	<link href="<%=request.getContextPath()%>/resources/main.css" rel="stylesheet">
	<!-- bootstrap -->
	<link href="<%=request.getContextPath()%>/resources/bootstrap300/css/bootstrap.css" rel="stylesheet">
	<script src="<%=request.getContextPath()%>/resources/bootstrap300/js/bootstrap.js"></script>
		
	<style>
		#plans {
		    font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
		    border-collapse: collapse;
		    width: 100%;
		}
		
		#plans td, #users th {
		    border: 1px solid #ddd;
		    padding: 8px;
		}
		
		#plans tr:nth-child(even){background-color: #f2f2f2;}
		
		#plans tr:hover {background-color: #ddd;}
		
		#plans th {
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
	</style>
</head>
<body>
	<jsp:include page="navi.jsp">
		<jsp:param name="page" value="template" />
	</jsp:include>

	
	<table style="" id="plans">
		<thead>
			<tr>
				<th style="">序号</th>
				<th style="">模板名称</th>
				<th style="">模板文件名</th>
				<th style="">通知书号码格式</th>
				<th style="">制作权限</th>
				<th style="">审核权限</th>
				<th style="">承认权限</th>
				<th style="">可用</th>
			</tr>
		</thead>
			<c:forEach var="t" items="${templates}" varStatus="status">
				<tr>
					<td style="width:40px">
						<c:out value="${status.index + 1}"></c:out>
					</td>
					
					<td style="width:300px">
						<a href="<%=request.getContextPath()%>/do/template/input.html?templateId=${t.id}"><c:out value="${t.name }"/></a>
					</td>
					
					<td style="width:100px">
						<c:out value="${t.viewName }"/>
					</td>
					<td style="width:100px">
						<c:out value="${t.notifiyNoFormat}"/>
					</td>
					<td style="">
						<c:forEach var="u" items="${t.creators}" varStatus="status">
							${u.userDispName}
						</c:forEach>
					</td>
					
					<td style="">
						<c:forEach var="u" items="${t.reviewers}">
							${u.userDispName}
						</c:forEach>
					</td>
					
					<td style="">
						<c:forEach var="u" items="${t.approvers}">
							${u.userDispName}
						</c:forEach>
					</td>
					<td style="width:100px">
						<c:if test="${t.enabled == 1}">
								可用
						</c:if>
						<c:if test="${t.enabled == 0}">
								不可用
						</c:if>
					</td>
				</tr>
			</c:forEach>
		</table>
	
	<c:if test="${empty templates}">
		还没有模板
	</c:if>
	<br/>
	<form method="GET" action="<%=request.getContextPath()%>/do/template/input.html">
		<input type="submit" value="创建模板"/>
	</form>
	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>