<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ taglib prefix="security"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="spring"
	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
	
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="cache-control" content="max-age=0" />
    <meta http-equiv="cache-control" content="no-cache" />
    <meta http-equiv="expires" content="Tue, 01 Jan 1980 1:00:00 GMT" />
    <meta http-equiv="pragma" content="no-cache" />
        
	<title>用戶编辑</title>
	<script src="<%=request.getContextPath()%>/resources/jquery/jquery-2.0.3.min.js"></script>
	<link href="<%=request.getContextPath()%>/resources/main.css" rel="stylesheet">
	<link href="<%=request.getContextPath()%>/resources/w3.css" rel="stylesheet">
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

	<c:if test="${error != null}">
		<div class="w3-panel w3-red">
		    <h3>出错了</h3>
		    <p><c:out value="${error}"/></p>
		</div>
	</c:if>
	
	<c:if test="${user != null}">
	<form:form method="POST"
		action="${pageContext.request.contextPath }/do/user/update/"
		modelAttribute="user">
		<div class="container">
			<label for="username"><b>用户ID，用于登陆系统，创建后不可修改</b></label> 
			<form:input placeholder="请输入用户ID" path="username" readonly="true"/>
			
		    <label for="username"><b>用户名</b></label> 
			<form:input placeholder="请输入用户名" path="userDispName" required="required"/> 
			
			<label for="email"><b>Email</b></label> 
			<form:input placeholder="请输入邮件" path="email" /> 
			
			<label for="psw"><b>密码</b></label> 
			<form:password placeholder="请输入密码" path="password" /> 
			
			<label for="psw-repeat"><b>密码确认</b></label> 
			<form:password placeholder="请输入密码确认" path="password2"/>
			<br/>
			<label for="role"><b>权限</b></label>
			<form:select path="userRole">
				<form:option value="ROLE_USER">一般</form:option>
				<form:option value="ROLE_ADMIN">管理员</form:option>
			</form:select>
			
			<label for="enabled"><b>启用帐号</b></label>
			<div>
				<form:radiobutton path="enabled" value="1"/>启用 
				<form:radiobutton path="enabled" value="0"/>停用
			</div> 
			<hr>
			
			<input type="submit" class="registerbtn" value="保存"></input>
		</div>
	</form:form>
	</c:if>
	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>