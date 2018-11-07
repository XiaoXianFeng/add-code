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
						<h3 align="center">生产工单</h3>
		<table border="1" style="margin-left: auto;margin-right: auto; width:80%">	
			<tfoot align="center">
					<tr>
						<td colspan="8">
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
			        	<td colspan="8">
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
				<td style="width:80px">客户名称:</td>
				<td colspan="2" style="width:200px" align="left"><div style="width:200px; text-align:left;  word-break: break-all;"><a href="#" id="customer" data-type="text" data-pk="customer" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入客户名称">
					<c:out value="${plan.customer}"/>
					</a>
					</div>
					<script>
					$('#customer').editable({
							placement: 'bottom'
					});
					</script>
				</td>
				<td style="width:100px">销售性质：</td>
				<td colspan="4" style="width:200px" align="left"><div style="width:200px; text-align:left; word-break: break-all;"><a href="#" id="saleType" data-type="checklist" data-pk="saleType" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="选择销售"></a></div> 
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
				<td>订单编号:</td>
				<td colspan="2"><c:out value="${plan.notifyNo}"/></td>
				<td>工    厂：</td>
				<td colspan="4">
					<a href="#" class="editable" id="factory" data-type="text" data-pk="factory" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入工厂">
						<c:out value="${plan.planItems['factory'].itemValue}"/>
					</a>
				</td>
			</tr>
			<tr>
				<td>工单编号:</td>
				<td colspan="2"><c:out value="${plan.notifyNo}"/></td>
				<td>日    期：</td>
				<td colspan="4"><fmt:formatDate value="${plan.createDate}" pattern="yyyy-MM-dd" /></td>
			</tr>
			<tr>
				<td rowspan = "12" width=10%px>生产资料</td>
				<td width=10%px>产品名称</td>
				<td width=20%px>产品型号</td>
				<td width=20%px>产品描述</td>
				<td width=10%px>PCBA版本号</td>
				<td width=5%px>客户编码</td>
				<td width=10%px>古北编码</td>
				<td width=15%px>备注</td>
			</tr>
			<tr>
				<td>
					<a href="#" class="editable" id="productName" data-type="text" data-pk="productName" 
					data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入产品名称">
					<c:out value="${plan.planItems['productName'].itemValue}"/>
					</a>
				</td>
				<td>
					<a href="#" class="editable" id="productModel" data-type="text" data-pk="productModel" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入产品型号">
						<c:out value="${plan.planItems['productModel'].itemValue}"/>
					</a>
				</td>
				<td>
					<a href="#" class="editable" id="product_description" data-type="text" data-pk="product_description" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入产品描述">
						<c:out value="${plan.planItems['product_description'].itemValue}"/>
					</a>
				</td>
				<td>
					<a href="#" class="editable" id="pcbVer" data-type="text" data-pk="pcbVer" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入PCB版本号 ">
						<c:out value="${plan.planItems['pcbVer'].itemValue}"/>
					</a>
				</td>
				<td>
					<a href="#" class="editable" id="customer_code" data-type="text" data-pk="customer_code" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入客户编码 ">
						<c:out value="${plan.planItems['customer_code'].itemValue}"/>
					</a>
				</td>
				<td>
					<a href="#" class="editable" id="gubei_code" data-type="text" data-pk="gubei_code" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入古北编码 ">
						<c:out value="${plan.planItems['gubei_code'].itemValue}"/>
					</a>
				</td>
				<td>
					<a href="#" class="editable" id="comment" data-type="text" data-pk="comment" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入备注">
						<c:out value="${plan.planItems['comment'].itemValue}"/>
					</a>
				</td>
			</tr>
			<tr>
				<td>类别</td>
				<td colspan="6"><a href="#" id="category" data-type="checklist" data-pk="category" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入类别"></a>
					<script>
						$(function(){
							$('#category').editable({
								value : [${plan.planItems['category'].itemValue}],
								source : [ {
									value : 1,
									text : '整机'
								}, {
									value : 2,
									text : 'PCBA'
								}, {
									value : 3,
									text : '模块'
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
				<td colspan = "4">
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
				<td rowspan = "5">项目经理</td>
				<td rowspan = "5">
					<a href="#" id="custel" data-type="textarea" data-pk="custel" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入项目经理信息"><c:out value="${plan.planItems['custel'].itemValue}"/></a>
				<script>
					$(function(){
					    $('#custel').editable({
					        url: '<%=request.getContextPath()%>/do/plan/save.html',
					        title: '项目经理信息',
					        rows: 2
					    });
					});
					</script>
				</td>
			</tr>
			<tr>
				<td>组装BOM</td>
				<td colspan = "4">
					<a href="#" id="zuzhuang_bom" data-type="textarea" data-pk="zuzhuang_bom" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入组装bom"><c:out value="${plan.planItems['zuzhuang_bom'].itemValue}"/></a>
				<script>
					$(function(){
					    $('#zuzhuang_bom').editable({
					        url: '<%=request.getContextPath()%>/do/plan/save.html',
					        title: '组装BOM',
					        rows: 2
					    });
					});
					</script>
				</td>
			</tr>
			<tr>
				<td>包装BOM</td>
				<td colspan = "4">
					<a href="#" id="baozhuang_bom" data-type="textarea" data-pk="baozhuang_bom" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入包装bom"><c:out value="${plan.planItems['baozhuang_bom'].itemValue}"/></a>
				<script>
					$(function(){
					    $('#baozhuang_bom').editable({
					        url: '<%=request.getContextPath()%>/do/plan/save.html',
					        title: '包装BOM',
					        rows: 2
					    });
					});
					</script>
				</td>
			</tr>
			<tr>
				<td>SMT资料包</td>
				<td colspan = "4"><a href="#" id="smtDocPackage" data-type="textarea" data-pk="smtDocPackage" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入产品P/N"><c:out value="${plan.planItems['smtDocPackage'].itemValue}"/></a>
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
				<td>银网文件</td>
				<td colspan = "4">
					<a href="#" id="yinwang_file" data-type="textarea" data-pk="yinwang_file" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入银网文件"><c:out value="${plan.planItems['yinwang_file'].itemValue}"/></a>
				<script>
					$(function(){
					    $('#yinwang_file').editable({
					        url: '<%=request.getContextPath()%>/do/plan/save.html',
					        title: '银网文件',
					        rows: 2
					    });
					});
					</script>
				</td>
			</tr>
			<tr>
				<td>芯片预烧录文件</td>
				<td colspan = "4">
					<a href="#" id="chipdebug_file" data-type="textarea" data-pk="chipdebug_file" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入芯片预烧录文件"><c:out value="${plan.planItems['chipdebug_file'].itemValue}"/></a>
				<script>
					$(function(){
					    $('#chipdebug_file').editable({
					        url: '<%=request.getContextPath()%>/do/plan/save.html',
					        title: '芯片预烧录文件',
					        rows: 2
					    });
					});
					</script>
				</td>
				<td rowspan = "4">测试部</td>
				<td rowspan = "4">
					<a href="#" id="test_part" data-type="textarea" data-pk="test_part" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入测试部信息"><c:out value="${plan.planItems['test_part'].itemValue}"/></a>
				<script>
					$(function(){
					    $('#test_part').editable({
					        url: '<%=request.getContextPath()%>/do/plan/save.html',
					        title: '测试部信息',
					        rows: 2
					    });
					});
					</script>
				</td>
			</tr>
			<tr>
				<td>固件烧录信息</td>
				<td colspan = "4">
					<a href="#" id="gujiandebug_message" data-type="textarea" data-pk="gujiandebug_message" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入固件烧录信息"><c:out value="${plan.planItems['gujiandebug_message'].itemValue}"/></a>
				<script>
					$(function(){
					    $('#gujiandebug_message').editable({
					        url: '<%=request.getContextPath()%>/do/plan/save.html',
					        title: '固件烧录信息',
					        rows: 2
					    });
					});
					</script>
				</td>
			</tr>
			<tr>
				<td>MAC列表获取</td>
				<td colspan = "4">
					<a href="#" id="maclist_message" data-type="textarea" data-pk="maclist_message" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入MAC列表获取"><c:out value="${plan.planItems['maclist_message'].itemValue}"/></a>
				<script>
					$(function(){
					    $('#maclist_message').editable({
					        url: '<%=request.getContextPath()%>/do/plan/save.html',
					        title: 'MAC列表获取',
					        rows: 2
					    });
					});
					</script>
				</td>
			</tr>
			<tr>
				<td>烧录,测试工具</td>
				<td colspan = "4">
					<a href="#" id="burn_test_tool" data-type="textarea" data-pk="burn_test_tool" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入烧录，测试工具"><c:out value="${plan.planItems['burn_test_tool'].itemValue}"/></a>
				<script>
					$(function(){
					    $('#burn_test_tool').editable({
					        url: '<%=request.getContextPath()%>/do/plan/save.html',
					        title: '烧录，测试工具',
					        rows: 2
					    });
					});
					</script>
				</td>
			</tr>
			<tr>
				<td rowspan = "2">绿色产品生产要求(必选)</td>
				<td colspan = "7">工艺要求：<div style="width:200px; text-align:left; word-break: break-all;"><a href="#" id="fabrication" data-type="checklist" data-pk="fabrication" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="工艺要求"></a></div> 
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
				<td colspan = "7">有害物质标准要求:<div style="width:200px; text-align:left; word-break: break-all;"><a href="#" id="fabrication1" data-type="checklist" data-pk="fabrication1" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="有害物质标准要求"></a></div> 
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
				<td>生产性质（必选）</td>
				<td colspan = "7"><div style="width:200px; text-align:left; word-break: break-all;"><a href="#" id="manufactureType" data-type="checklist" data-pk="manufactureType" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="生产性质"></a></div> 
				<script>
					$(function() {
						$('#manufactureType').editable({
							value : [${plan.planItems['manufactureType'].itemValue}],
							source : [ {
								value : 1,
								text : '量产'
							}, {
								value : 2,
								text : '试产（小批量设计验证）'
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
                <td>委托加工方</td>
                <td>订单批量</td>
                <td>分批投产数量</td>
                <td colspan = "2">预计生产日期</td>
                <td colspan = "2">预计交货日期</td>
				<td>备注</td>
            </tr>
			<tr>
				<td>
				<a href="#" class="editable" id="producer" data-type="text" data-pk="producter" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入委托加工方">
					<c:out value="${plan.planItems['producer'].itemValue}"/>
				</a>
				</td>
				<td>
					<a href="#" class="editable" id="dingdan_total" data-type="text" data-pk="dingdan_total" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入订单批量">
						<c:out value="${plan.planItems['dingdan_total'].itemValue}"/>
					</a>
				</td>
				<td>
					<a href="#" class="editable" id="fenpi_total" data-type="text" data-pk="fenpi_total" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入分批投产数量">
						<c:out value="${plan.planItems['fenpi_total'].itemValue}"/>
					</a>
				</td>
				<td colspan = "2">
					<a href="#" class="editable" id="manufactureDate" data-type="date" data-pk="manufactureDate" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入预计生产日期">
						<c:out value="${plan.planItems['manufactureDate'].itemValue}"/>
					</a>
				</td>
				<td colspan = "2">
					<a href="#" class="editable" id="completeDate" data-type="date" data-pk="completeDate" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入预计交货日期">
						<c:out value="${plan.planItems['completeDate'].itemValue}"/>
					</a>
				</td>
				<td>
					<a href="#" class="editable" id="comment_1" data-type="text" data-pk="comment_1" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入备注">
						<c:out value="${plan.planItems['comment_1'].itemValue}"/>
					</a>
				</td>
			</tr>
			<tr>
				<td>备注</td>
				<td colspan = "7" >
					<div id="comments_2" data-type="wysihtml5" data-pk="comments_2">
						<c:out value="${plan.planItems['comments_2'].itemValue}" escapeXml="false"/>
					</div>
					<script>
					$('#comments_2').editable({
				        url: '<%=request.getContextPath()%>/do/plan/save.html',
				        title: '备注',
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
				<td rowspan = "4">客户确认</td>
				<td rowspan = "2">标记</td>
				<td>主板S/N</td>
				<td colspan = "3">
					<a href="#" class="editable" id="zhuban_sn" data-type="text" data-pk="zhuban_sn" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入主板S/N">
						<c:out value="${plan.planItems['zhuban_sn'].itemValue}"/>
					</a>
				</td>
				<td>生产部</td>
				<td>
					<a href="#" class="editable" id="product_part" data-type="text" data-pk="product_part" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入生产部信息">
						<c:out value="${plan.planItems['product_part'].itemValue}"/>
					</a>
				</td>
			</tr>
			<tr>
				<td>IMEI</td>
				<td colspan = "3">
					<a href="#" class="editable" id="imei" data-type="text" data-pk="imei" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入IMEI">
						<c:out value="${plan.planItems['imei'].itemValue}"/>
					</a>
				</td>
				<td>质量部</td>
				<td>
					<a href="#" class="editable" id="quality_part" data-type="text" data-pk="quality_part" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入测试部信息">
						<c:out value="${plan.planItems['quality_part'].itemValue}"/>
					</a>
				</td>
			</tr>
			<tr>
				<td>物料齐套时间</td>
				<td>
					<a href="#" class="editable" id="wuliao_completeDate" data-type="date" data-pk="wuliao_completeDate" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入物料齐套时间">
						<c:out value="${plan.planItems['wuliao_completeDate'].itemValue}"/>
					</a>
				</td>
				<td colspan = "3"></td>
				<td>物流部</td>
				<td>
					<a href="#" class="editable" id="logistics_part" data-type="text" data-pk="logistics_part" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入物流部信息">
						<c:out value="${plan.planItems['logistics_part'].itemValue}"/>
					</a>
				</td>
			</tr>
			<tr>
				<td>客户型号</td>
				<td>
					<a href="#" class="editable" id="customerModel" data-type="text" data-pk="customerModel" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入客户型号">
						<c:out value="${plan.planItems['customerModel'].itemValue}"/>
					</a>
				</td>
				<td colspan = "3"></td>
				<td>产品经理</td>
				<td>
					<a href="#" class="editable" id="productmanager_part" data-type="text" data-pk="productmanager_part" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入产品经理信息">
						<c:out value="${plan.planItems['productmanager_part'].itemValue}"/>
					</a>
				</td>
			</tr>
			<tr>
				<td colspan = "2" rowspan = "3">委托加工确认</td>
				<td>生产日期</td>
				<td colspan = "3">
					<a href="#" class="editable" id="product_Date" data-type="date" data-pk="product_Date" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入生产日期">
						<c:out value="${plan.planItems['product_Date'].itemValue}"/>
					</a>
				</td>
				<td rowspan = "3">签名</td>
				<td rowspan = "3">
					<a href="#" class="editable" id="signature" data-type="text" data-pk="signature" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入签名">
						<c:out value="${plan.planItems['signature'].itemValue}"/>
					</a>
				</td>
			</tr>
			<tr>
				<td>交货日期</td>
				<td colspan = "3">
					<a href="#" class="editable" id="jiaohuo_Date" data-type="date" data-pk="jiaohuo_Date" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入交货日期">
						<c:out value="${plan.planItems['jiaohuo_Date'].itemValue}"/>
					</a>
				</td>
			</tr>
			<tr>
				<td>资料签收</td>
				<td colspan = "3">
					<a href="#" class="editable" id="ziliao_qinashou" data-type="text" data-pk="ziliao_qinashou" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入资料签收">
						<c:out value="${plan.planItems['ziliao_qinashou'].itemValue}"/>
					</a>
				</td>
			</tr>
		</tbody>
	</table>
	<table style="border-top-width: 0px;　border-right-width: 1px;　border-bottom-width: 1px;　border-left-width: 1px; margin-left: auto;margin-right: auto; width:80%; border-collapse: collapse">
	</table>	
	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>
