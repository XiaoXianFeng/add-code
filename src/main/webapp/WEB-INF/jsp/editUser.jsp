<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="security"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/resources/main.css">
<style>
* {
    box-sizing: border-box;
}

/* Add padding to containers */
.container {
    padding: 15px;
    background-color: white;
    width: 400px;
}

/* Full-width input fields */
input[type=text], input[type=password] {
    width: 100%;
    padding: 15px;7
    margin: 10px 0 22px 0;
    display: inline-block;
    border: none;
    background: #f1f1f1;
}

input[type=text]:focus, input[type=password]:focus {
    background-color: #ddd;
    outline: none;
}

/* Overwrite default styles of hr */
hr {
    border: 1px solid #f1f1f1;
    margin-bottom: 25px;
}

/* Set a style for the submit button */
.registerbtn {
    background-color: #4CAF50;
    color: white;
    padding: 8px 10px;
    margin: 8px 0;
    border: none;
    cursor: pointer;
    width: 100%;
    opacity: 0.9;
}

.registerbtn:hover {
    opacity: 1;
}

/* Add a blue text color to links */
a {
    color: dodgerblue;
}

/* Set a grey background color and center the text of the "sign in" section */
.signin {
    background-color: #f1f1f1;
    text-align: center;
}
</style>	
</head>
<body>
	<jsp:include page="navi.jsp">
		<jsp:param name="page" value="setting" />
	</jsp:include>

	<c:if test="${not empty user}">
	<form:form method="POST"
		action="${pageContext.request.contextPath }/do/user/update/update.htm"
		modelAttribute="user" servletRelativeAction="aa">
		<div class="container">
		    <label for="username"><b>用户名，不可修改</b></label> 
			<form:input path="username" disabled="true"/> 
			
			<label for="email"><b>Email</b></label> 
			<form:input path="email"/> 
			
			<label for="psw"><b>密码</b></label> 
			<form:password path="password"/> 
			
			<label for="psw-repeat"><b>密码确认</b></label> 
			<input type="password" placeholder="请输入密码确认" name="psw-repeat" required>
			
			<label for="psw-repeat"><b>权限</b></label> 
			<input type="checkbox" name="riyu" value="1" checked="checked">一般
				<input type="checkbox" name="riyu" value="2">役に立つ
				<input type="checkbox" name="riyu" value="3">系统管理
			<hr>
			
			<button type="submit" class="registerbtn">更新用户</button>
		</div>
	</form:form>
	</c:if>

	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>