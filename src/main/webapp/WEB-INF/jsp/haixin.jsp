<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ taglib prefix="security"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
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

	<form name="form" method="POST" action="<%=request.getContextPath()%>/do/plan/create.html">
	<h3 align="center">生产计划通知书</h3>
	
	<table style="margin-left: auto; margin-right: auto; border: 0px">
		<tr>
			<td style="width:80px">客户名称:</td>
			<td style="width:200px" align="left"><div style="width:200px; text-align:left;  word-break: break-all;"><a href="#" id="customer" data-type="text" data-pk="customer" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入客户名称">
				<c:out value="${plan.customer}"/>
				</a>
				</div>
				<script>
				$('#customer').editable({
						placement: 'bottom'
				});
				</script>
			</td>
			<td style="width:100px">销    售：</td>
			<td style="width:200px" align="left"><div style="width:200px; text-align:left; word-break: break-all;"><a href="#" id="saleType" data-type="checklist" data-pk="saleType" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="选择销售"></a></div> 
				<script>
					$(function() {
						$('#saleType').editable({
							value : [${plan.planItems['saleType'].itemValue}],
							source : [ {
								value : 1,
								text : '内销'
							}, {
								value : 2,
								text : '外销'
							}],
							placement: 'bottom',
							display:function(value, sourceData){
								var html = [], checked = $.fn.editableutils.itemsByValue(value, sourceData);
								if (checked.length) {
							    	$.each(checked, function(i, v) {
							        	html.push($.fn.editableutils.escape(v.text));
							      	});
							      	$(this).html(html.join(', '));
							    } else {
							      	$(this).empty();
							    }
							}
						});
					});
				</script>
			</td>
		</tr>
		<tr>
			<td>文件编号:</td>
			<td><c:out value="${plan.notifyNo}"/></td>
			<td>日    期：</td>
			<td><fmt:formatDate value="${plan.createDate}" pattern="yyyy-MM-dd" /></td>
		</tr>
	</table>
	<br/>
	<table border="1" style="margin-left: auto;margin-right: auto; width:80%">
		<!-- 
		<thead>
			<tr>
				<th colspan="4">生产资料（无请填写/）</th>
			</tr>
		</thead>
		<tfoot align="center">
	      <tr>
	        <td colspan="4"><input type="submit" value="提交审核"/></td>
	      </tr>
	    </tfoot>
	     -->
	    <tbody>
		<tr>
			<td style="width:140px">产品名称 </td>
			<td style="width:200px">产品型号 </td>
			<td style="width:160px">PCB 版本号 </td>
			<td style="width:160px">产品P/N </td>
		</tr>
		<tr>
			<td><a href="#" class="editable" id="productName" data-type="text" data-pk="productName" 
				data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入产品名称">
				<c:out value="${plan.planItems['productName'].itemValue}"/>
			</a></td>
			<td>
				<a href="#" class="editable" id="productModel" data-type="text" data-pk="productModel" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入产品型号">
					<c:out value="${plan.planItems['productModel'].itemValue}"/>
				</a>
			</td>
			<td>
				<a href="#" class="editable" id="pcbVer" data-type="text" data-pk="pcbVer" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入PCB版本号 ">
					<c:out value="${plan.planItems['pcbVer'].itemValue}"/>
				</a>
			</td>
			<td>
				<a href="#" class="editable" id="productPN" data-type="text" data-pk="productPN" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入产品P/N">
					<c:out value="${plan.planItems['productPN'].itemValue}"/>
				</a>
			</td>
			
		</tr>
		<tr>
			<td>类别</td>
			<td colspan="3"><a href="#" id="category" data-type="checklist" data-pk="category" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入类别"></a>
				<script>
					$(function() {
						$('#category').editable({
							value : [${plan.planItems['category'].itemValue}],
							source : [ {
								value : 1,
								text : 'SMT'
							}, {
								value : 2,
								text : '插件'
							}, {
								value : 3,
								text : '组装'
							}, {
								value : 4,
								text : '其他'
							}],
							display:function(value, sourceData){
								var html = [], checked = $.fn.editableutils.itemsByValue(value, sourceData);
								if (checked.length) {
							    	$.each(checked, function(i, v) {
							        	html.push($.fn.editableutils.escape(v.text));
							      	});
							      	$(this).html(html.join(', '));
							    } else {
							      	$(this).empty();
							    }
							}
						});
					});
				</script>
			</td>
			
		</tr>
		<tr>
			<td>贴片BOM</td>
			<td colspan="3">
				<a href="#" id="bom" data-type="textarea" data-pk="bom" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入产品P/N"><c:out value="${plan.planItems['bom'].itemValue}"/></a>
			<script>
				$(function(){
				    $('#bom').editable({
				        url: '<%=request.getContextPath()%>/do/plan/save.html',
				        title: '贴片BOM',
				        rows: 2
				    });
				});
				</script>
			</td>
			
		</tr>
		<tr>
			<td>SMT资料包</td>
			<td colspan="3"><a href="#" id="smtDocPackage" data-type="textarea" data-pk="smtDocPackage" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入产品P/N"><c:out value="${plan.planItems['smtDocPackage'].itemValue}"/></a>
			<script>
				$(function(){
				    $('#smtDocPackage').editable({
				    	url: '<%=request.getContextPath()%>/do/plan/save.html',
				        title: 'SMT资料包',
				        rows: 5
				    });
				});
				</script>
			</td>
		</tr>
		<tr>
			<td>软件版本号</td>
			<td colspan="3"><a href="#" id="softwareVer" data-type="textarea" data-pk="softwareVer" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="软件版本号"><c:out value="${plan.planItems['softwareVer'].itemValue}"/></a>
			<script>
				$(function(){
				    $('#softwareVer').editable({
				    	url: '<%=request.getContextPath()%>/do/plan/save.html',
				        title: '软件版本号',
				        rows: 5
				    });
				});
				</script>
			</td>
		</tr>
		<tr>
			<td>下载软件名</td>
			<td colspan="3"><a href="#" id="downloadSoft" data-type="textarea" data-pk="downloadSoft" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="下载软件名"><c:out value="${plan.planItems['downloadSoft'].itemValue}"/></a>
			<script>
				$(function(){
				    $('#downloadSoft').editable({
				    	url: '<%=request.getContextPath()%>/do/plan/save.html',
				        title: '下载软件名',
				        rows: 5
				    });
				});
				</script>
			</td>
		</tr>
		<tr>
			<td>烧录软件校验和</td>
			<td colspan="3"><a href="#" id="softChecksum" data-type="textarea" data-pk="softChecksum" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="烧录软件校验和"><c:out value="${plan.planItems['softChecksum'].itemValue }"/></a>
			<script>
				$(function(){
				    $('#softChecksum').editable({
				    	url: '<%=request.getContextPath()%>/do/plan/save.html',
				        title: '烧录软件校验和',
				        rows: 5
				    });
				});
				</script>
			</td>
		</tr>
		<tr>
			<td>测试流程要求</td>
			<td colspan="3">
				<div id="flowReq" data-type="wysihtml5" data-pk="flowReq">
						<c:out value="${plan.planItems['flowReq'].itemValue}" escapeXml="false"/>
					</div>
					<script>
					$('#flowReq').editable({
				        url: '<%=request.getContextPath()%>/do/plan/save.html',
				        title: '测试流程要求',
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
		<tr>
			<td>测试工具版本</td>
			<td colspan="3"><a href="#" id="testToolVer" data-type="textarea" data-pk="testToolVer" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="测试工具版本"><c:out value="${plan.planItems['testToolVer'].itemValue }"/></a>
			<script>
				$(function(){
				    $('#testToolVer').editable({
				    	url: '<%=request.getContextPath()%>/do/plan/save.html',
				        title: '测试工具版本',
				        rows: 5
				    });
				});
				</script>
			</td>
		</tr>
		<tr>
			<td>烧录器件编码</td>
			<td colspan="3"><a href="#" id="qijianCode" data-type="textarea" data-pk="qijianCode" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="烧录器件编码"><c:out value="${plan.planItems['qijianCode'].itemValue }"/></a>
			<script>
				$(function(){
				    $('#qijianCode').editable({
				    	url: '<%=request.getContextPath()%>/do/plan/save.html',
				        title: '烧录器件编码',
				        rows: 5
				    });
				});
				</script>
			</td>
		</tr>
		<tr>
			<td>LCM</td>
			<td><a href="#" id="lcm" data-type="textarea" data-pk="lcm" 
				data-url="<%=request.getContextPath()%>/do/plan/save.html" 
				data-title="LCM"><c:out value="${plan.planItems['lcm'].itemValue }"/></a>
			<script>
				$(function(){
				    $('#lcm').editable({
				    	url: '<%=request.getContextPath()%>/do/plan/save.html',
				        title: 'LCM',
				        rows: 5
				    });
				});
				</script>
			</td>
			
			<td>摄像头</td>
			<td ><a href="#" id="camera" data-type="textarea" data-pk="camera" 
				data-url="<%=request.getContextPath()%>/do/plan/save.html" 
				data-title="摄像头"><c:out value="${plan.planItems['camera'].itemValue }"/></a>
			<script>
				$(function(){
				    $('#camera').editable({
				    	url: '<%=request.getContextPath()%>/do/plan/save.html',
				        title: '摄像头',
				        rows: 5
				    });
				});
				</script>
			</td>
			
			<td>主副板配套信息</td>
			<td ><a href="#" id="zhufubanpeitao" data-type="textarea" data-pk="zhufubanpeitao" 
				data-url="<%=request.getContextPath()%>/do/plan/save.html" 
				data-title="主副板配套信息"><c:out value="${plan.planItems['zhufubanpeitao'].itemValue }"/></a>
			<script>
				$(function(){
				    $('#zhufubanpeitao').editable({
				    	url: '<%=request.getContextPath()%>/do/plan/save.html',
				        rows: 5
				    });
				});
				</script>
			</td>
		</tr>
		
		<tr>
			<td>测试频段</td>
			<td>
			</td>
		</tr>
		<tr>
			<td>绿色产品生产要求（必选）</td>
			<td>工艺要求：<div style="width:200px; text-align:left; word-break: break-all;"><a href="#" id="fabrication" data-type="checklist" data-pk="fabrication" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="工艺要求"></a></div> 
				<script>
					$(function() {
						$('#fabrication').editable({
							value : [${plan.planItems['fabrication'].itemValue}],
							source : [ {
								value : 1,
								text : '无铅工艺'
							}, {
								value : 2,
								text : '有铅工艺'
							}, {
								value : 3,
								text : 'ROHS工艺'
							}, {
								value : 4,
								text : '无卤工艺'
							}, {
								value : 5,
								text : '其他要求'
							}],
							placement: 'bottom',
							display:function(value, sourceData){
								var html = [], checked = $.fn.editableutils.itemsByValue(value, sourceData);
								if (checked.length) {
							    	$.each(checked, function(i, v) {
							        	html.push($.fn.editableutils.escape(v.text));
							      	});
							      	$(this).html(html.join(', '));
							    } else {
							      	$(this).empty();
							    }
							}
						});
					});
				</script></td>
		</tr>
		
		<tr>
			<td>生产性质（必选）</td>
			<td><div style="width:200px; text-align:left; word-break: break-all;"><a href="#" id="manufactureType" data-type="checklist" data-pk="manufactureType" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="生产性质"></a></div> 
				<script>
					$(function() {
						$('#manufactureType').editable({
							value : [${plan.planItems['manufactureType'].itemValue}],
							source : [ {
								value : 1,
								text : '量产'
							}, {
								value : 2,
								text : '试产'
							}, {
								value : 3,
								text : '返工'
							}],
							placement: 'bottom',
							display:function(value, sourceData){
								var html = [], checked = $.fn.editableutils.itemsByValue(value, sourceData);
								if (checked.length) {
							    	$.each(checked, function(i, v) {
							        	html.push($.fn.editableutils.escape(v.text));
							      	});
							      	$(this).html(html.join(', '));
							    } else {
							      	$(this).empty();
							    }
							}
						});
					});
				</script></td>
		</tr>
		<tr>
			<td>委托加工放</td>
			<td>订单批量</td>
			<td>要求出货量</td>
			<td>预计生产日期</td>
			<td>预计交货日期</td>
		</tr>
		<tr>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
		</tr>
		</tbody>
	</table>

	<table style="border-top-width: 0px;　border-right-width: 1px;　border-bottom-width: 1px;　border-left-width: 1px; margin-left: auto;margin-right: auto; width:80%; border-collapse: collapse">
	<tbody>
		<tr>
			<td rowspan="3">客户确认</td>
			<td rowspan="3">标记</td>
			<td>主板S/N：</td>
			<td></td>
			<td>MAC地址：</td>
		</tr>
		<tr>
			<td>IMEI：</td>
			<td></td>
			<td>MEID：</td>
		</tr>
		<tr>
			<td>蓝牙地址：</td>
			<td></td>
			<td></td>
		</tr>
		</tbody>
	</table>
		
	</form>
	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>