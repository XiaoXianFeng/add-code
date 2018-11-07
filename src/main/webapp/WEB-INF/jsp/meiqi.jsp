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
					<h3 align="center">生产计划通知书</h3>
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
			<td >客户名称:</td>
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
			<td colspan="2" style="width:200px" align="left"><div style="width:200px; text-align:left; word-break: break-all;"><a href="#" id="saleType" data-type="checklist" data-pk="saleType" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="选择销售"></a></div> 
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
			<td colspan="2"><fmt:formatDate value="${plan.createDate}" pattern="yyyy-MM-dd" /></td>
		</tr>
		<tr>
			<td rowspan = "11" width=10%px>生产资料</td>
			<td width=15%px>产品名称 </td>
			<td width=25%px>产品型号 </td>
			<td width=25%px>PCB 版本号 </td>
			<td width=25%px>产品P/N </td>
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
							source : [{
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
							display : function(value, sourceData){
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
			<td colspan="2">
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
			<td rowspan ="8">
				<a href="#" id="custel" data-type="textarea" data-pk="custel" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入客户信息"><c:out value="${plan.planItems['custel'].itemValue}"/></a>
			<script>
				$(function(){
				    $('#custel').editable({
				        url: '<%=request.getContextPath()%>/do/plan/save.html',
				        title: '客户信息',
				        rows: 2
				    });
				});
				</script>
			</td>
		</tr>
		<tr>
			<td>SMT资料包</td>
			<td colspan="2"><a href="#" id="smtDocPackage" data-type="textarea" data-pk="smtDocPackage" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入产品P/N"><c:out value="${plan.planItems['smtDocPackage'].itemValue}"/></a>
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
			<td>软件版本</td>
			<td colspan="2"><a href="#" id="softwareVer" data-type="textarea" data-pk="softwareVer" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入软件版本"><c:out value="${plan.planItems['softwareVer'].itemValue}"/></a>
			<script>
				$(function(){
				    $('#softwareVer').editable({
				    	url: '<%=request.getContextPath()%>/do/plan/save.html',
				        title: '软件版本',
				        rows: 5
				    });
				});
				</script>
			</td>
		</tr>
		<tr>
			<td>校验和</td>
			<td colspan="2"><a href="#" id="softChecksum" data-type="textarea" data-pk="softChecksum" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入校验和"><c:out value="${plan.planItems['softChecksum'].itemValue }"/></a>
			<script>
				$(function(){
				    $('#softChecksum').editable({
				    	url: '<%=request.getContextPath()%>/do/plan/save.html',
				        title: '校验和',
				        rows: 5
				    });
				});
				</script>
			</td>
		</tr>
		<tr>
			<td>烧录器件编码</td>
			<td colspan="2"><a href="#" id="qijianCode" data-type="textarea" data-pk="qijianCode" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入烧录器件编码"><c:out value="${plan.planItems['qijianCode'].itemValue }"/></a>
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
			<td>条码标签规格</td>
			<td colspan="2"><a href="#" id="biaoqianstyle" data-type="textarea" data-pk="biaoqianstyle" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入条码标签规格"><c:out value="${plan.planItems['biaoqianstyle'].itemValue }"/></a>
			<script>
				$(function(){
				    $('#biaoqianstyle').editable({
				    	url: '<%=request.getContextPath()%>/do/plan/save.html',
				        title: '条码标签规格',
				        rows: 5
				    });
				});
				</script>
			</td>
		</tr>
		<tr>
			<td>插件要求</td>
			<td colspan="2"><a href="#" id="chajian_request" data-type="textarea" data-pk="chajian_request" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入插件要求"><c:out value="${plan.planItems['chajian_request'].itemValue }"/></a>
			<script>
				$(function(){
				    $('#chajian_request').editable({
				    	url: '<%=request.getContextPath()%>/do/plan/save.html',
				        title: '插件要求',
				        rows: 5
				    });
				});
				</script>
			</td>
		</tr>
		<tr>
			<td>测试要求</td>
			<td colspan="2"><a href="#" id="test_request" data-type="textarea" data-pk="test_request" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入测试要求"><c:out value="${plan.planItems['test_request'].itemValue }"/></a>
			<script>
				$(function(){
				    $('#test_request').editable({
				    	url: '<%=request.getContextPath()%>/do/plan/save.html',
				        title: '测试要求',
				        rows: 5
				    });
				});
				</script>
			</td>
		</tr>
		<tr>
			<td>绿色产品生产要求（必选）</td>
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
			<td>委托加工方</td>
			<td>订单批量</td>
			<td>分批投产数量</td>
			<td>预计生产日期</td>
			<td>预计交货日期</td>
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
			<td>
				<a href="#" class="editable" id="manufactureDate" data-type="date" data-pk="manufactureDate" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入预计生产日期">
					<c:out value="${plan.planItems['manufactureDate'].itemValue}"/>
				</a>
			</td>
			<td>
				<a href="#" class="editable" id="completeDate" data-type="date" data-pk="completeDate" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入预计交货日期">
					<c:out value="${plan.planItems['completeDate'].itemValue}"/>
				</a>
			</td>
		</tr>
		<tr>
				<td rowspan = "3">客户确认（标记）</td>
				<td>主板S/N</td>
				<td>
					<a href="#" class="editable" id="zhuban_sn" data-type="text" data-pk="zhuban_sn" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入主板S/N">
						<c:out value="${plan.planItems['zhuban_sn'].itemValue}"/>
					</a>
				</td>
				<td>MAC地址</td>
				<td>
					<a href="#" class="editable" id="mac_address" data-type="text" data-pk="mac_address" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入MAC地址">
						<c:out value="${plan.planItems['mac_address'].itemValue}"/>
					</a>
				</td>
		</tr>
		<tr>
				<td>IMEI</td>
				<td>
					<a href="#" class="editable" id="imei" data-type="text" data-pk="imei" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入IMEI">
						<c:out value="${plan.planItems['imei'].itemValue}"/>
					</a>
				</td>
				<td>MEID</td>
				<td>
					<a href="#" class="editable" id="meid" data-type="text" data-pk="meid" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入MEID">
						<c:out value="${plan.planItems['meid'].itemValue}"/>
					</a>
				</td>
		</tr>
		<tr>
				<td>蓝牙地址</td>
				<td style=" word-wrap: break-word; word-break: normal;">
					<a href="#" class="editable" id="bluetooth_address" data-type="text" data-pk="bluetooth_address" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入蓝牙地址">
						<c:out value="${plan.planItems['bluetooth_address'].itemValue}"/>
					</a>
				</td>
				<td></td>
				<td></td>
		</tr>
		<tr>
				<td>备注</td>
				<td colspan = "4" >
					<div id="comments" data-type="wysihtml5" data-pk="comments">
						<c:out value="${plan.planItems['comments'].itemValue}" escapeXml="false"/>
					</div>
					<script>
					$('#comments').editable({
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
		</tbody>
	</table>
	<table style="border-top-width: 0px;　border-right-width: 1px;　border-bottom-width: 1px;　border-left-width: 1px; margin-left: auto;margin-right: auto; width:80%; border-collapse: collapse">
	</table>	
	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>