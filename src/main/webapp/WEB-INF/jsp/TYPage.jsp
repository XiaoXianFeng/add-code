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
        
		<title>生产计划</title>

		<script src="<%=request.getContextPath()%>/resources/jquery/jquery-2.0.3.min.js"></script>
		
		<link href="<%=request.getContextPath()%>/resources/main.css" rel="stylesheet">
		<link href="<%=request.getContextPath()%>/resources/w3.css" rel="stylesheet">
		<!-- bootstrap -->
		<link href="<%=request.getContextPath()%>/resources/bootstrap300/css/bootstrap.css" rel="stylesheet">
		<script src="<%=request.getContextPath()%>/resources/bootstrap300/js/bootstrap.js"></script>
		
		<!-- X-editable -->
		<link href="<%=request.getContextPath()%>/resources/bootstrap3-editable/css/bootstrap-editable.css" rel="stylesheet">
		<script src="<%=request.getContextPath()%>/resources/bootstrap3-editable/js/bootstrap-editable.min.js"></script>
		
		<!-- wysihtml5 -->
		
		<link href="<%=request.getContextPath()%>/resources/x-editable/inputs-ext/wysihtml5/bootstrap-wysihtml5-0.0.3/bootstrap-wysihtml5-0.0.3.css" rel="stylesheet">  
        <script src="<%=request.getContextPath()%>/resources/x-editable/inputs-ext/wysihtml5/bootstrap-wysihtml5-0.0.3/wysihtml5-0.3.0.min.js"></script>  
        <script src="<%=request.getContextPath()%>/resources/x-editable/inputs-ext/wysihtml5/bootstrap-wysihtml5-0.0.3/bootstrap-wysihtml5-0.0.3.min.js"></script>
        <script src="<%=request.getContextPath()%>/resources/x-editable/inputs-ext/wysihtml5/wysihtml5-0.0.3.js"></script>
		

		<script>
			$.fn.editable.defaults.mode = 'popup';
		
			$(document).ready(function() {
				$('.editable').editable();
			});
		</script>
	</head>
	<body style=" width: 100%;">
		<jsp:include page="navi.jsp">
			<jsp:param name="page" value="home" />
		</jsp:include>

		<c:if test="${plan == null}">
			<div class="w3-panel w3-red">
			    <h3>出错了</h3>
			    <p><c:out value="${error}"/></p>
			</div>
			<a href="<%=request.getContextPath()%>/do/plan/list.html">返回</a>
		</c:if>
		
		<c:if test="${plan != null}">
		<table border="1" style="margin-left: auto;margin-right: auto; width:80%">
			<thead>
				<tr>
					<th style="text-align: center;" colspan="7" align="center"><h2>杭州涂鸦信息技术有限公司</h2></th>
				</tr>
			</thead>
			<tfoot align="center">
				<tr>
					<td colspan="7">
						<div>制表</div>
						<div></div>
						
						<div>审核</div>
						<div></div>
						
						<div>承认</div>
						<div></div>
					</td>
				</tr>
		    	<tr>
		        	<td colspan="7">
		        		<form name="form" method="POST" action="<%=request.getContextPath()%>/do/plan/submitReview.html">
		        			<input type="hidden" name="planId" value="${plan.planId}">
		        			<input type="submit" value="提交审核"/>
		        		</form>
		        	</td>
		      	</tr>
		    </tfoot>
			<tbody>
			<tr>
				<th rowspan = "10">生产资料</th>
				<th>产品名称</th>
				<th>物料编码</th>
				<th>客户模组编码</th>
				<th>产品型号</th>
				<th>信息描述</th>
				<th>订单批量(pcs)</th>
			</tr>
			<tr>
				<td>
					<a href="#" class="editable" id="productName" data-type="text" data-pk="productName" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入产品名称">
						<c:out value="${plan.planItems['productName'].itemValue}"/>
					</a>
				</td>
				<td>
					<a href="#" class="editable" id="materialNo" data-type="text" data-pk="materialNo" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入物料编码">
						<c:out value="${plan.planItems['materialNo'].itemValue}"/>
					</a>
				</td>
				<td>
					<a href="#" class="editable" id="custModelNo" data-type="text" data-pk="custModelNo" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入客户模组编码">
						<c:out value="${plan.planItems['custModelNo'].itemValue}"/>
					</a>
				</td>
				<td>
					<a href="#" class="editable" id="model" data-type="text" data-pk="model" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入产品型号">
						<c:out value="${plan.planItems['model'].itemValue}"/>
					</a>
				</td>
				<td>
					<a href="#" class="editable" id="desc" data-type="text" data-pk="desc" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入信息描述">
						<c:out value="${plan.planItems['desc'].itemValue}"/>
					</a>
				</td>
				<td>
					<a href="#" class="editable" id="orderQuantity" data-type="text" data-pk="orderQuantity" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入订单批量(pcs)">
						<c:out value="${plan.planItems['orderQuantity'].itemValue}"/>
					</a>
				</td>
			</tr>
			<tr>
				<th>类别</th>
				<td colspan = "5"> 
					<a href="#" class="editable" id="category" data-type="text" data-pk="category" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入类别">
						<c:out value="${plan.planItems['category'].itemValue}"/>
					</a>
				</td>
			</tr>
			<tr>
				<th>生产BOM</th>
				<td colspan = "3">
					<a href="#" class="editable" id="bom" data-type="text" data-pk="bom" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入生产BOM">
						<c:out value="${plan.planItems['bom'].itemValue}"/>
					</a>
				</td>
				<th>BOM版本</th>
				<td>
					<a href="#" class="editable" id="bomVer" data-type="text" data-pk="bomVer" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入BOM版本">
						<c:out value="${plan.planItems['bomVer'].itemValue}"/>
					</a>
				</td>
			</tr>
			<tr>
				<th>固件KEY</th>
				<td colspan = "3">
					<a href="#" class="editable" id="firwareKey" data-type="text" data-pk="firwareKey" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入固件KEY">
						<c:out value="${plan.planItems['firwareKey'].itemValue}"/>
					</a>
				</td>
				<th>固件版本</th>
				<td>
					<a href="#" class="editable" id="firwareVer" data-type="text" data-pk="firwareVer" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入固件版本">
						<c:out value="${plan.planItems['firwareVer'].itemValue}"/>
					</a>
				</td>
			</tr>
			<tr>
				<th>固件名称</th>
				<td colspan = "3">
					<a href="#" class="editable" id="firwareName" data-type="text" data-pk="firwareName" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入固件名称">
						<c:out value="${plan.planItems['firwareName'].itemValue}"/>
					</a>
				</td>
				<th>热点名称</th>
				<td >
					<a href="#" class="editable" id="hotspotName" data-type="text" data-pk="hotspotName" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入热点名称">
						<c:out value="${plan.planItems['hotspotName'].itemValue}"/>
					</a>
				</td>
			</tr>
			<tr>
				<th>STM资料包</th>
				<td colspan = "3">
					<a href="#" class="editable" id="stmPackage" data-type="text" data-pk="stmPackage" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入STM资料包">
						<c:out value="${plan.planItems['stmPackage'].itemValue}"/>
					</a>
				</td>
				<th>FLASH烧录软件</th>
				<td >
					<a href="#" class="editable" id="flashSoft" data-type="text" data-pk="flashSoft" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入FLASH烧录软件">
						<c:out value="${plan.planItems['flashSoft'].itemValue}"/>
					</a>
				</td>
			</tr>
			<tr>
				<th>硬件测试工具</th>
				<td colspan = "3">
					<a href="#" class="editable" id="hardwareTestTool" data-type="text" data-pk="hardwareTestTool" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入硬件测试工具">
						<c:out value="${plan.planItems['hardwareTestTool'].itemValue}"/>
					</a>
				</td>
				<th>check软件名称</th>
				<td >
					<a href="#" class="editable" id="checkSoftName" data-type="text" data-pk="checkSoftName" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入check软件名称">
						<c:out value="${plan.planItems['checkSoftName'].itemValue}"/>
					</a>
				</td>
			</tr>
			<tr>
				<th>授权激活码</th>
				<td colspan = "4">
					<a href="#" class="editable" id="authKey" data-type="text" data-pk="authKey" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入授权激活码">
						<c:out value="${plan.planItems['authKey'].itemValue}"/>
					</a>
				</td>
				<td></td>
			</tr
			><tr>
				<th>激活测试软件名称</th>
				<td colspan = "5">
					<a href="#" class="editable" id="authSoftName" data-type="text" data-pk="authSoftName" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入激活测试软件名称">
						<c:out value="${plan.planItems['authSoftName'].itemValue}"/>
					</a>
				</td>
			</tr>
			<tr>
				<th rowspan = "2">绿色产品生产要求</th>
				<th>工艺要求</th>
				<td colspan = "5">
					<a href="#" id="fabrication" data-type="checklist" data-pk="fabrication" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="工艺要求"></a>
					<script>
					$(function() {
						$('#fabrication').editable({
							value : [${plan.planItems['fabrication'].itemValue}],
							source : [ {
								value : 1,
								text : '无铅工艺'
							}]
						});
					});
				</script>
				</td>
			</tr>
			<tr>
				<th>有害物质标准要求</th>
				<td colspan = "5">要求符合《有害物质限用管理标准》(若为ROHS工艺请选项)</td>
			</tr>
			<tr>
				<th>生产性质</th>
				<td colspan = "6">
					<a href="#" id="manufactureType" data-type="checklist" data-pk="manufactureType" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="生产性质"></a>
					<script>
					$(function() {
						$('#manufactureType').editable({
							value : [${plan.planItems['manufactureType'].itemValue}],
							source : [ {
								value : 1,
								text : '试产'
							},  {
								value : 2,
								text : '小批'
							},  {
								value : 3,
								text : '量产'
							}]
						});
					});
				</script>
				</td>
			</tr>
			<tr>
				<th>预计生产日期</th>
				<td colspan = "3">
					<a href="#" class="editable" id="manufactureDate" data-type="date" data-pk="manufactureDate" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入预计生产日期">
						<c:out value="${plan.planItems['manufactureDate'].itemValue}"/>
					</a>
				</td>
				<th>预计交货日期</th>
				<td colspan = "2">
					<a href="#" class="editable" id="completeDate" data-type="date" data-pk="completeDate" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入预计交货日期">
						<c:out value="${plan.planItems['completeDate'].itemValue}"/>
					</a>
				</td>
			</tr>
			<tr>
				<th rowspan = "2">客户要求</th>
				<th>客户订单号</th>
				<th>物料编码</th>
				<th>物料型号</th>
				<th>model号</th>
				<th colspan = "2">批次号</th>
			</tr>
			<tr>
				<td>
					<a href="#" class="editable" id="custOrderNo" data-type="text" data-pk="custOrderNo" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入客户订单号">
						<c:out value="${plan.planItems['custOrderNo'].itemValue}"/>
					</a>
				</td>
				<td>
					<a href="#" class="editable" id="custMaterialNo" data-type="text" data-pk="custMaterialNo" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入物料编码">
						<c:out value="${plan.planItems['custMaterialNo'].itemValue}"/>
					</a>
				</td>
				<td>
					<a href="#" class="editable" id="materialModel" data-type="text" data-pk="materialModel" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入物料型号">
						<c:out value="${plan.planItems['materialModel'].itemValue}"/>
					</a>
				</td>
				<td>
					<a href="#" class="editable" id="modelNo" data-type="text" data-pk="modelNo" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入model号">
						<c:out value="${plan.planItems['modelNo'].itemValue}"/>
					</a>
				</td>
				<td colspan = "2">
					<a href="#" class="editable" id="sequenceNo" data-type="text" data-pk="sequenceNo" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入批次号">
						<c:out value="${plan.planItems['sequenceNo'].itemValue}"/>
					</a>
				</td>
			</tr>
			<tr>
				<th>标签</th>
				<td colspan = "6"></td>
			</tr>
			<tr>
				<th>其他备注</th>
				<td colspan = "6" >
					<div id="comments" data-type="wysihtml5" data-pk="comments">
						<c:out value="${plan.planItems['comments'].itemValue}" escapeXml="false"/>
					</div>
					<script>
					$('#comments').editable({
				        url: '<%=request.getContextPath()%>/do/plan/save.html',
				        title: '其他备注',
				        wysihtml5:{
				        	"font-styles": true, //Font styling, e.g. h1, h2, etc. Default true
				        	"emphasis": true, //Italics, bold, etc. Default true
				        	"lists": true, //(Un)ordered lists, e.g. Bullets, Numbers. Default true
				        	"html": false, //Button which allows you to edit the generated HTML. Default false
				        	"link": false, //Button to insert a link. Default true
				        	"image": false, //Button to insert an image. Default true,
				        	"color": true //Button to change color of font 
				        }
				    });
					</script>
				</td>
			</tr>
			
			</tbody>
		</table>
	</c:if>
	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>
