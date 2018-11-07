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
	<!--  
		<style>
			td1 {
				border= "0"}
		</style>
	-->
	<body style=" width: 100%;">
		<jsp:include page="navi.jsp">
			<jsp:param name="page" value="home" />
		</jsp:include>

		<c:if test="${plan == null or not empty error}">
			<div class="w3-panel w3-red">
			    <h3>出错了</h3>
			    <p><c:out value="${error}"/></p>
			</div>
			<c:if test="${plan == null}">
			<a href="<%=request.getContextPath()%>/do/plan/list.html">返回</a>
			</c:if>
		</c:if>
		
		<c:if test="${plan != null}"></c:if>
		<c:if test="${not empty plan.message }">
			<div class="w3-panel w3-yellow">
			    <p><c:out value="${plan.message}"/></p>
			</div>
		</c:if>
					<h3 align="center">生产任务-加工说明</h3>
	<table border="1" style="margin-left: auto;margin-right: auto; width:80%">	
		<tfoot align="center">
				<tr>
					<td colspan="7">
						<table style="border:0; width:100%; height:100%">
							<tr>
								<th style="width:80px">制表</th>
								<td style="width:160px">${plan.creator.username}</td>
								<th style="width:80px">审核</th>
								<td style="width:160px">
									<c:if test="${plan.reviewStatus == 'REJECTED'  or plan.reviewStatus == 'APPROVED'}">
									<div class="stamp stamp-${plan.reviewStatus}">
										<span><fmt:formatDate value="${plan.reviewDate}" pattern="yyyy-MM-dd" /></span>
										<span><c:out value="${plan.reviewer.userDispName}"></c:out></span>
									</div>
									</c:if>
								</td>
								<th style="width:80px">承认</th>
								<td style="width:160px">
									<c:if test="${plan.approveStatus == 'REJECTED'  or plan.approveStatus == 'APPROVED'}">
									<div class="stamp stamp-${plan.approveStatus}">
										<span><fmt:formatDate value="${plan.reviewDate}" pattern="yyyy-MM-dd" /></span>
										<span><c:out value="${plan.approver.userDispName}"></c:out></span>
									</div>
									</c:if>
								</td>
								<td></td>
							</tr>
						</table>
					</td>
				</tr>
		    	<tr>
		        	<td colspan="7">
		        		<c:if test="${plan.status == 'CREATING' }">
		        		<form name="form" method="POST" action="<%=request.getContextPath()%>/do/plan/submitReview.html">
		        			<input type="hidden" name="planId" value="${plan.planId}">
		        			<input type="submit" value="提交审核"/>
		        		</form>
		        		</c:if>
		        		
		        		<c:if test="${plan.status == 'REVIEWING' }">
		        		<form name="form" method="POST" action="<%=request.getContextPath()%>/do/plan/review.html">
		        			<input type="hidden" name="planId" value="${plan.planId}">
		        			<input type="submit" name="action" value="发回修改"/>
		        			<input type="submit" name="action" value="通过审核"/>
		        		</form>
		        		</c:if>
		        		
		        		<c:if test="${plan.status == 'APPROVING' }">
		        		<form name="form" method="POST" action="<%=request.getContextPath()%>/do/plan/approve.html">
		        			<input type="hidden" name="planId" value="${plan.planId}">
		        			<input type="submit" name="action" value="发回修改"/>
		        			<input type="submit" name="action" value="承认"/>
		        		</form>
		        		</c:if>
		        		<c:if test="${plan.status == 'APPROVED' }">
		        		
		        		</c:if>
		        	</td>
		      	</tr>
		    </tfoot>
		    <tbody>
		<tr>
			<td >加工单位:</td>
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
			<td></td>
			<td>文件编号:</td>
			<td><c:out value="${plan.notifyNo}"/></td>
		</tr>
		<tr>
			<td>生产性质（必选）</td>
			<td colspan = "4"><div style="width:200px; text-align:left; word-break: break-all;"><a href="#" id="manufactureType" data-type="checklist" data-pk="manufactureType" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="生产性质"></a></div> 
				<script>
					$(function() {
						$('#manufactureType').editable({
							value : [${plan.planItems['manufactureType'].itemValue}],
							source : [ {
								value : 1,
								text : '量产'
							}, {
								value : 2,
								text : '试产(小批量设计验证)'
							}, {
								value : 3,
								text : '软件升级'
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
			<td rowspan = "13" width=10%px>生产资料</td>
			<td width=15%px>工单号</td>
			<td width=25%px>产品型号 </td>
			<td width=25%px>PCB 版本号 </td>
			<td width=25%px>订单数量</td>
		</tr>
		<tr>
			<td><a href="#" class="editable" id="list_number" data-type="text" data-pk="list_number" 
				data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入工单号">
				<c:out value="${plan.planItems['list_number'].itemValue}"/>
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
				<a href="#" class="editable" id="product_num" data-type="text" data-pk="product_num" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入订单数量">
					<c:out value="${plan.planItems['product_num'].itemValue}"/>
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
							source : [{
								value : 1,
								text : '整机'
							},  {
								value : 2,
								text : 'PCBA'
							},  {
								value : 3,
								text : '机头'
							}, {
								value : 4,
								text : '其他'
							}, {
								value : 5,
								text : '模块'
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
			<td>组装包装BOM</td>
			<td colspan="3">
				<a href="#" id="zuzbaoz_bom" data-type="textarea" data-pk="zuzbaoz_bom" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入组装包装BOM"><c:out value="${plan.planItems['zuzbaoz_bom'].itemValue}"/></a>
			<script>
				$(function(){
				    $('#zuzbaoz_bom').editable({
				        url: '<%=request.getContextPath()%>/do/plan/save.html',
				        title: '组装包装BOM',
				        rows: 2
				    });
				});
				</script>
			</td>
		</tr>
		<tr>
			<td>生产程序</td>
			<td colspan="3">
				<a href="#" id="product_program" data-type="textarea" data-pk="product_program" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入生产程序"><c:out value="${plan.planItems['product_program'].itemValue}"/></a>
			<script>
				$(function(){
				    $('#product_program').editable({
				        url: '<%=request.getContextPath()%>/do/plan/save.html',
				        title: '生产程序',
				        rows: 2
				    });
				});
				</script>
			</td>
		</tr>
		<tr>
			<td>软件版本号</td>
			<td colspan="3"><a href="#" id="softwareVer" data-type="textarea" data-pk="softwareVer" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入软件版本号"><c:out value="${plan.planItems['softwareVer'].itemValue}"/></a>
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
			<td>MAC地址范围</td>
			<td colspan="3"><a href="#" id="mac_address" data-type="textarea" data-pk="mac_address" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入MAC地址范围"><c:out value="${plan.planItems['mac_address'].itemValue }"/></a>
			<script>
				$(function(){
				    $('#mac_address').editable({
				    	url: '<%=request.getContextPath()%>/do/plan/save.html',
				        title: 'MAC地址范围',
				        rows: 5
				    });
				});
				</script>
			</td>
		</tr>
		<tr>
			<td>BOMPID烧写</td>
			<td colspan="3"><a href="#" id="bompid_debug" data-type="textarea" data-pk="bompid_debug" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入BOMPID烧写"><c:out value="${plan.planItems['bompid_debug'].itemValue }"/></a>
			<script>
				$(function(){
				    $('#bompid_debug').editable({
				    	url: '<%=request.getContextPath()%>/do/plan/save.html',
				        title: 'BOMPID烧写',
				        rows: 5
				    });
				});
				</script>
			</td>
		</tr>
		<tr>
			<td>HWID</td>
			<td colspan="3"><a href="#" id="hwid_message" data-type="textarea" data-pk="hwid_message" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入HWID"><c:out value="${plan.planItems['hwid_message'].itemValue }"/></a>
			<script>
				$(function(){
				    $('#hwid_message').editable({
				    	url: '<%=request.getContextPath()%>/do/plan/save.html',
				        title: 'HWID',
				        rows: 5
				    });
				});
				</script>
			</td>
		</tr>
		<tr>
			<td>需求工装，文件</td>
			<td colspan="3"><a href="#" id="gongzhuang_file" data-type="textarea" data-pk="gongzhuang_file" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入需求工装，文件"><c:out value="${plan.planItems['gongzhuang_file'].itemValue }"/></a>
			<script>
				$(function(){
				    $('#gongzhuang_file').editable({
				    	url: '<%=request.getContextPath()%>/do/plan/save.html',
				        title: '需求工装，文件',
				        rows: 5
				    });
				});
				</script>
			</td>
		</tr>
		<tr>
			<td>需求工具</td>
			<td colspan="3"><a href="#" id="test_tool" data-type="textarea" data-pk="test_tool" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入需求工具"><c:out value="${plan.planItems['test_tool'].itemValue }"/></a>
			<script>
				$(function(){
				    $('#test_tool').editable({
				    	url: '<%=request.getContextPath()%>/do/plan/save.html',
				        title: '需求工具',
				        rows: 5
				    });
				});
				</script>
			</td>
		</tr>
		<tr>
			<td rowspan = "2">绿色产品生产要求(必选)</td>
			<td colspan = "4">工艺要求：<div style="width:200px; text-align:left; word-break: break-all;"><a href="#" id="fabrication" data-type="checklist" data-pk="fabrication" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="工艺要求"></a></div> 
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
			<td colspan = "4">有害物质标准要求:<div style="width:200px; text-align:left; word-break: break-all;"><a href="#" id="fabrication1" data-type="checklist" data-pk="fabrication1" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="有害物质标准要求"></a></div> 
			<script>
				$(function() {
					$('#fabrication1').editable({
						value : [${plan.planItems['fabrication1'].itemValue}],
						source : [ {
							value : 1,
							text : '要求符合《有害物质限用管理标准》; (若为ROHS工艺请选项)'
						}, {
							value : 2,
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
			</script>
			</td>
		</tr>
		<tr>
				<td>特殊加工要求说明:</td>
				<td colspan = "4" >
					<div id="comments" data-type="wysihtml5" data-pk="comments">
						<c:out value="${plan.planItems['comments'].itemValue}" escapeXml="false"/>
					</div>
					<script>
					$('#comments').editable({
				        url: '<%=request.getContextPath()%>/do/plan/save.html',
				        title: '特殊加工要求说明',
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
	<table style="border-top-width: 0px;　border-right-width: 1px;　border-bottom-width: 1px;　border-left-width: 1px; margin-left: auto;margin-right: auto; width:80%; border-collapse: collapse">
	</table>	
	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>