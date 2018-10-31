<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
	
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
	<link href="<%=request.getContextPath()%>/resources/w3.css" rel="stylesheet">
	
	<!-- bootstrap -->
	<link href="<%=request.getContextPath()%>/resources/bootstrap300/css/bootstrap.css" rel="stylesheet">
	<script src="<%=request.getContextPath()%>/resources/bootstrap300/js/bootstrap.js"></script>
		
	<!-- X-editable -->
	<link href="<%=request.getContextPath()%>/resources/bootstrap3-editable/css/bootstrap-editable.css" rel="stylesheet">
	<script src="<%=request.getContextPath()%>/resources/bootstrap3-editable/js/bootstrap-editable.min.js"></script>
	
	<link href="<%=request.getContextPath()%>/resources/x-editable/select2/select2.css" rel="stylesheet">
	<script src="<%=request.getContextPath()%>/resources/x-editable/select2/select2.js"></script>
		
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

	<c:if test="${template == null or error != null}">
		<div class="w3-panel w3-red">
		    <h3>出错了</h3>
		    <p><c:out value="${error}"/></p>
		</div>
	</c:if>
	
	<form:form method="POST" action="${pageContext.request.contextPath }/do/template/add.html" modelAttribute="template" >
		<table id="user" class="table table-bordered table-striped" style="clear: both">
			<tbody>
				<tr>         
	                <td width="15%">模板名称</td>
	                <td width="45%"><form:input path="name" required="required"/> </td>
	                <td width="40%">显示用，会默认作为客户名显示</td>
	            </tr>
	            <tr>         
	                <td>模板文件名</td>
	                <td><form:input path="viewName" required="required"/></td>
	                <td>
	                	模板的设计文件，如template.jsp，请将此文件放到服务器的/WEB-INF/jsp/目录
	                </td>
	            </tr> 
	             <tr>         
	                <td>文件号码格式</td>
	                <td><form:input path="notifiyNoFormat" required="required"/></td>
	                <td>
	                	如HX%yy%%mm%%dd%-%02d将会生成HX20181021-001<br>
	                	%yy%:年<br>
	                	%mm%:月<br>
	                	%dd%:日<br>
	                	%02d:序号, 2表示位数，0表示不足2位前面补零<br>
	                </td>
	            </tr> 
	            <tr>         
	                <td>制作权限</td>
	                <td>
						<a href="#" id="creatorNames" data-type="select2" data-pk="creatorNames" data-value="${template.creatorNames}" data-url="<%=request.getContextPath()%>/do/template/addUser.html" data-title="制作者"></a>
						<script>
							$(function(){
								$('#creatorNames').editable({
									source: [
							        	<c:forEach var="u" items="${users}" varStatus="status">
							        		{id: '${u.username}', text: '${u.userDispName}'},
							        	</c:forEach>
							           ],
							        select2: {
							           placeholder: '选择制作者',
							           multiple: true,
							           width:'100%'
							        }
							    });
							});
						</script>
					</td>
	                <td>定义谁可以利用该模板</td>
	            </tr> 
	            <tr>         
	                <td>审核权限</td>
	                <td>
	                	<a href="#" id="reviewerNames" data-type="select2" data-pk="reviewerNames" data-value="${template.reviewerNames}" data-url="<%=request.getContextPath()%>/do/template/addUser.html" data-title="审核者"></a>
						<script>
							$(function(){
								$('#reviewerNames').editable({
							        source: [
							        	<c:forEach var="u" items="${users}" varStatus="status">
							        		{id: '${u.username}', text: '${u.userDispName}'},
							        	</c:forEach>
							           ],
							        select2: {
							           placeholder: '选择审核者',
							           multiple: true,
							           width:'100%'
							        }
							    });
							});
						</script>
	                </td>
	                <td>定义谁可以审核利用该模板提交的单子</td>
	            </tr> 
	            <tr>         
	                <td>承认权限</td>
	                <td>
						<a href="#" id="approverNames" data-type="select2" data-pk="approverNames" data-value="${template.approverNames}" data-url="<%=request.getContextPath()%>/do/template/addUser.html" data-title="承认者"></a>
						<script>
							$(function(){
								$('#approverNames').editable({
									source: [
							        	<c:forEach var="u" items="${users}" varStatus="status">
							        		{id: '${u.username}', text: '${u.userDispName}'},
							        	</c:forEach>
							           ],
							        select2: {
							           placeholder: '选择承认者',
							           multiple: true,
							           width:'100%'
							        }
							    });
							});
						</script>
					</td>
	                <td>定义谁可以承认利用该模板提交的单子</td>
	            </tr> 
	            <tr>         
	                <td>可用</td>
	                <td>
	                	<form:radiobuttons path="enabled" items="${enabledList}" itemLabel="name" itemValue="value" delimiter=" " />
					</td>
	                <td></td>
	            </tr>  
			</tbody>
		</table>
		<c:if test="${not empty param.templateId}" >
			<input type="submit" value="更新"/>
		</c:if>
		<c:if test="${empty param.templateId}" >
			<input type="submit" value="创建"/>
		</c:if>
		
	</form:form>
	<br/>
	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>