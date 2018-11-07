<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="security"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@page contentType="text/html;charset=utf-8" pageEncoding="UTF-8"%>

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
		
		<style>
			th {
				font-weight:normal;}
		</style>
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
		
		<c:if test="${plan != null}">
		<c:if test="${not empty plan.message }">
			<div class="w3-panel w3-yellow">
			    <p><c:out value="${plan.message}"/></p>
			</div>
		</c:if>
				<table border="1" style="margin-left: auto;margin-right: auto; width:80%">
			<thead>
				<tr>
					<th style="text-align: center;" colspan="10" align="center"><h3>上海盛本智能科技有限公司</h3></th>
				</tr>
			</thead>
			<tfoot align="center">
				<tr>
					<td colspan="10">
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
		        	<td colspan="10">
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
			<tr>
				<th colspan = "8" rowspan = "3">
					<a href="#" id="product_book" data-type="textarea" data-pk="product_book" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入通知书信息"><c:out value="${plan.planItems['product_book'].itemValue}"/></a>
					<script>
					$(function(){
					    $('#product_book').editable({
					        url: '<%=request.getContextPath()%>/do/plan/save.html',
					        title: '通知书',
					        rows: 2
					    });
					});
					</script>
				</th>
				<td colspan = "2">表单编号:
					<a href="#" id="list_number" data-type="textarea" data-pk="list_number" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入表单编号"><c:out value="${plan.planItems['list_number'].itemValue}"/></a>
					<script>
					$(function(){
					    $('#list_number').editable({
					        url: '<%=request.getContextPath()%>/do/plan/save.html',
					        title: '表单编号',
					        rows: 2
					    });
					});
					</script>
				</td>
			</tr>
			<tr>
				<td colspan = "2">版本号:
					<a href="#" class="editable" id="version_number" data-type="text" data-pk="version_number" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入版本号">
						<c:out value="${plan.planItems['version_number'].itemValue}"/>
					</a>
				</td>
			</tr>
			<tr>
				<td colspan = "2">编号:
					<a href="#" class="editable" id="edit_number" data-type="text" data-pk="edit_number" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入编号">
						<c:out value="${plan.planItems['edit_number'].itemValue}"/>
					</a>
				</td>
			</tr>
			<tr>
				<th rowspan = "2" width=10%px>订单信息</th>
				<th width=10%px>客户</th>
				<td colspan = "4" width=40%px>
					<a href="#" class="editable" id="cus_name" data-type="text" data-pk="cus_name" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入客户">
						<c:out value="${plan.planItems['cus_name'].itemValue}"/>
					</a>				
				</td>
				<th width=10%px>产品型号</th>
				<td colspan = "3" width=30%px>
					<a href="#" class="editable" id="productModel" data-type="text" data-pk="productModel" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入产品型号">
						<c:out value="${plan.planItems['productModel'].itemValue}"/>
					</a>
				</td>
			</tr>
			<tr>
				<th>生产性质</th>
				<td colspan = "4">
						<div style="width:200px; text-align:left; word-break: break-all;"><a href="#" id="manufactureType" data-type="checklist" data-placement="auto" data-pk="manufactureType" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="生产性质"></a></div> 
					<script>
						$(function() {
							$('#manufactureType').editable({
								value : [${plan.planItems['manufactureType'].itemValue}],
								source : [ {
									value : 1,
									text : '试产'
								}, {
									value : 2,
									text : '小批'
								}, {
									value : 3,
									text : '量产'
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
				<th>订单数量</th>
				<td colspan = "3">
					<a href="#" class="editable" id="dingdan_total" data-type="text" data-pk="dingdan_total" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入订单批量">
						<c:out value="${plan.planItems['dingdan_total'].itemValue}"/>
					</a>
				</td>
			</tr>
			<tr>
				<th rowspan = "3">工单信息</th>
				<th>产品信息</th>
				<th>生产单号</th>
				<td colspan = "2"><a href="#" id="product_list_number" data-type="textarea" data-pk="product_list_number" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入生产单号"><c:out value="${plan.planItems['product_list_number'].itemValue}"/></a>
					<script>
					$(function(){
					    $('#product_list_number').editable({
					        url: '<%=request.getContextPath()%>/do/plan/save.html',
					        title: '生产单号',
					        rows: 2
					    });
					});
					</script>
				</td>
				<th>成品料号</th>
				<td colspan = "2"><a href="#" id="chengpin_number" data-type="textarea" data-pk="chengpin_number" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入成品料号"><c:out value="${plan.planItems['chengpin_number'].itemValue}"/></a>
					<script>
					$(function(){
					    $('#chengpin_number').editable({
					        url: '<%=request.getContextPath()%>/do/plan/save.html',
					        title: '成品料号',
					        rows: 2
					    });
					});
					</script>
				</td>
				<th>整机颜色</th>
				<td>
					<a href="#" class="editable" id="" data-type="text" data-pk="machine_colour" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入整机颜色">
						<c:out value="${plan.planItems['machine_colour'].itemValue}"/>
					</a>
				</td>
			</tr>
			<tr>
				<th>生产类别</th>
				<td colspan = "8" style=center><a href="#" id="category" data-type="checklist" data-placement="auto" data-pk="category" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入生产类别"></a>
				<script>
					$(function() {
						$('#category').editable({
							value : [${plan.planItems['category'].itemValue}],
							source : [ {
								value : 1,
								text : '核心板PCBA'
							}, {
								value : 2,
								text : '主板PCBA'
							}, {
								value : 3,
								text : '副板'
							}, {
								value : 4,
								text : '机头'
							}, {
								value : 5,
								text : '底座'
							}, {
								value : 6,
								text : '包装'
							}, {
								value : 7,
								text : '返工'
							}, {
								value : 8,
								text : '升级出货'
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
				<th>是否走系统</th>
				<td colspan = "4">
						<div style="width:200px; text-align:left; word-break: break-all;"><a href="#" id="choose_yn_sys" data-type="checklist" data-pk="choose_yn_sys" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="是否走系统"></a></div> 
					<script>
						$(function() {
							$('#choose_yn_sys').editable({
								value : [${plan.planItems['choose_yn_sys'].itemValue}],
								source : [ {
									value : 1,
									text : '是'
								},{
									value : 2,
									text : '否'
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
				<th>即时出货</th>
				<td colspan = "3">
						<div style="width:200px; text-align:left; word-break: break-all;"><a href="#" id="choose_yn_chuhuo" data-type="checklist" data-pk="choose_yn_chuhuo" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="是否及时出货"></a></div> 
					<script>
						$(function() {
							$('#choose_yn_chuhuo').editable({
								value : [${plan.planItems['choose_yn_chuhuo'].itemValue}],
								source : [ {
									value : 1,
									text : '是'
								},{
									value : 2,
									text : '否'
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
				<th rowspan = "15">生产资料信息</th>
				<th>核心板bom</th>
				<td colspan = "8">
					<a href="#" id="hexin_bom" data-type="textarea" data-pk="hexin_bom" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入核心板bom"><c:out value="${plan.planItems['hexin_bom'].itemValue}"/></a>
				<script>
					$(function(){
					    $('#hexin_bom').editable({
					        url: '<%=request.getContextPath()%>/do/plan/save.html',
					        title: '核心板BOM',
					        rows: 2
					    });
					});
					</script>
				</td>
			</tr>
			<tr>
				<td>主板BOM</td>
				<td colspan = "8">
					<a href="#" id="zhuban_bom" data-type="textarea" data-pk="zhuban_bom" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入主板bom"><c:out value="${plan.planItems['zhuban_bom'].itemValue}"/></a>
				<script>
					$(function(){
					    $('#zhuban_bom').editable({
					        url: '<%=request.getContextPath()%>/do/plan/save.html',
					        title: '主板BOM',
					        rows: 2
					    });
					});
					</script>
				</td>
			</tr>
			<tr>
				<td>副板BOM</td>
				<td colspan = "8">
					<a href="#" id="fuban_bom" data-type="textarea" data-pk="fuban_bom" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入副板bom"><c:out value="${plan.planItems['fuban_bom'].itemValue}"/></a>
				<script>
					$(function(){
					    $('#fuban_bom').editable({
					        url: '<%=request.getContextPath()%>/do/plan/save.html',
					        title: '副板BOM',
					        rows: 2
					    });
					});
					</script>
				</td>
			</tr>
			<tr>
				<td>SMT资料包</td>
				<td colspan = "8"><a href="#" id="smtDocPackage" data-type="textarea" data-pk="smtDocPackage" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入产品P/N"><c:out value="${plan.planItems['smtDocPackage'].itemValue}"/></a>
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
				<td>组装BOM</td>
				<td colspan = "8">
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
				<th>配置BOM</th>
				<td colspan = "8">
					<a href="#" id="config_bom" data-type="textarea" data-pk="config_bom" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入配置bom"><c:out value="${plan.planItems['config_bom'].itemValue}"/></a>
				<script>
					$(function(){
					    $('#config_bom').editable({
					        url: '<%=request.getContextPath()%>/do/plan/save.html',
					        title: '配置BOM',
					        rows: 2
					    });
					});
					</script>
				</td>
			</tr>
			<tr>
				<td>包装BOM</td>
				<td colspan = "8">
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
				<th>工艺文件</th>
				<td colspan = "8">
					<a href="#" id="art_file" data-type="textarea" data-pk="art_file" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入工艺文件"><c:out value="${plan.planItems['art_file'].itemValue}"/></a>
				<script>
					$(function(){
					    $('#art_file').editable({
					        url: '<%=request.getContextPath()%>/do/plan/save.html',
					        title: '工艺文件',
					        rows: 2
					    });
					});
					</script>
				</td>
			</tr>
			<tr>
				<th>组包装SOP</th>
				<td colspan = "8">
					<a href="#" id="zubaozhuang_sop" data-type="textarea" data-pk="zubaozhuang_sop" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入组包装SOP"><c:out value="${plan.planItems['zubaozhuang_sop'].itemValue}"/></a>
				<script>
					$(function(){
					    $('#zubaozhuang_sop').editable({
					        url: '<%=request.getContextPath()%>/do/plan/save.html',
					        title: '组包装SOP',
					        rows: 2
					    });
					});
					</script>
				</td>
			</tr>
			<tr>
				<th>标签打印包</th>
				<td colspan = "8">
					<a href="#" id="biaoqianprts_package" data-type="textarea" data-pk="biaoqianprts_package" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入标签打印包"><c:out value="${plan.planItems['biaoqianprts_package'].itemValue}"/></a>
				<script>
					$(function(){
					    $('#biaoqianprts_package').editable({
					        url: '<%=request.getContextPath()%>/do/plan/save.html',
					        title: '标签打印包',
					        rows: 2
					    });
					});
					</script>
				</td>
			</tr>
			<tr>
				<th rowspan = "5">软件版本</th>
				<th>平台版本</th>
				<td colspan = "7">
					<a href="#" class="editable" id="pingtai_Ver" data-type="text" data-pk="pingtai_Ver" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入平台版本 ">
						<c:out value="${plan.planItems['pingtai_Ver'].itemValue}"/>
					</a>
				</td>
			</tr>
			<tr>
				<th>AP版本</th>
				<td colspan = "7">
					<a href="#" class="editable" id="ap_Ver" data-type="text" data-pk="ap_Ver" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入AP版本 ">
						<c:out value="${plan.planItems['ap_Ver'].itemValue}"/>
					</a>
				</td>
			</tr>
			<tr>
				<th>模块版本</th>
				<td colspan = "7">
					<a href="#" class="editable" id="module_Ver" data-type="text" data-pk="module_Ver" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入模块版本 ">
						<c:out value="${plan.planItems['module_Ver'].itemValue}"/>
					</a>
				</td>
			</tr>
			<tr>
				<th>读取版本号</th>
				<td colspan = "7">
					<a href="#" class="editable" id="rw_Ver" data-type="text" data-pk="rw_Ver" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入读取版本号 ">
						<c:out value="${plan.planItems['rw_Ver'].itemValue}"/>
					</a>
				</td>
			</tr>
			<tr>
				<th>QCN/PRI</th>
				<td colspan = "7">
					<a href="#" class="editable" id="qcn_pri_Ver" data-type="text" data-pk="qcn_pri_Ver" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入QCN/PRI ">
						<c:out value="${plan.planItems['qcn_pri_Ver'].itemValue}"/>
					</a>
				</td>
			</tr>
			<tr>
				<th>注意事项(返工流程)</th>
				<td colspan = "9" >
					<div id="comments_2" data-type="wysihtml5" data-pk="comments_2">
						<c:out value="${plan.planItems['comments_2'].itemValue}" escapeXml="false"/>
					</div>
					<script>
					$('#comments_2').editable({
				        url: '<%=request.getContextPath()%>/do/plan/save.html',
				        title: '注意事项',
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
				<th rowspan = "8">配置信息</th>
				<th rowspan = "6">频段</th>
				<td>GSM</td>
				<td colspan = "7">
					<a href="#" class="editable" id="gsm_number" data-type="text" data-pk="gsm_number" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入GSM频段">
						<c:out value="${plan.planItems['gsm_number'].itemValue}"/>
					</a>
				</td>
			</tr>
			<tr>
				<td>CDMA</td>
				<td colspan = "7">
					<a href="#" class="editable" id="cdma_number" data-type="text" data-pk="cdma_number" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入CDMA频段">
						<c:out value="${plan.planItems['cdma_number'].itemValue}"/>
					</a>
				</td>
			</tr>
			<tr>
				<td>WCDMA</td>
				<td colspan = "7">
					<a href="#" class="editable" id="wcdma_number" data-type="text" data-pk="wcdma_number" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入WCDMA频段">
						<c:out value="${plan.planItems['wcdma_number'].itemValue}"/>
					</a>
				</td>
			</tr>
			<tr>
				<td>TD-SCDMA</td>
				<td colspan = "7">
					<a href="#" class="editable" id="tdscdma_number" data-type="text" data-pk="tdscdma_number" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入TDSCDMA频段">
						<c:out value="${plan.planItems['tdscdma_number'].itemValue}"/>
					</a>
				</td>
			</tr>
			<tr>
				<td rowspan = "2">LTE-FDD</td>
				<td colspan = "7">
					<a href="#" class="editable" id="tdd-lte_number" data-type="text" data-pk="tdd-lte_number" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入TDD-LTE频段">
						<c:out value="${plan.planItems['tdd-lte_number'].itemValue}"/>
					</a>
				</td>
			</tr>
			<tr>
				<td colspan = "7">
					<a href="#" class="editable" id="fdd-lte_number" data-type="text" data-pk="fdd-lte_number" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入FDD-LTE频段">
						<c:out value="${plan.planItems['fdd-lte_number'].itemValue}"/>
					</a>
				</td>
			</tr>
			<tr>
				<th>主板配置码</th>
				<td colspan = "4">
					<a href="#" class="editable" id="zhuban_configcode" data-type="text" data-pk="zhuban_configcode" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入主板配置码">
						<c:out value="${plan.planItems['zhuban_configcode'].itemValue}"/>
					</a>
				</td>
				<th>成品配置</th>
				<td colspan = "3">
					<a href="#" class="editable" id="producted_config" data-type="text" data-pk="producted_config" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入成品配置">
						<c:out value="${plan.planItems['producted_config'].itemValue}"/>
					</a>
				</td>
			</tr>
			<tr>
				<th>灌装SN密匙</th>
				<td colspan = "4">
						<div style="width:200px; text-align:left; word-break: break-all;"><a href="#" id="sn_code" data-type="checklist" data-pk="sn_code" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="灌装SN密匙"></a></div> 
					<script>
						$(function() {
							$('#sn_code').editable({
								value : [${plan.planItems['sn_code'].itemValue}],
								source : [ {
									value : 1,
									text : '是'
								},{
									value : 2,
									text : '否'
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
				<th>灌装客户密匙</th>
				<td colspan = "4">
						<div style="width:200px; text-align:left; word-break: break-all;"><a href="#" id="customer_code" data-type="checklist" data-pk="customer_code" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="灌装客户密匙"></a></div> 
					<script>
						$(function() {
							$('#customer_code').editable({
								value : [${plan.planItems['customer_code'].itemValue}],
								source : [ {
									value : 1,
									text : '是'
								},{
									value : 2,
									text : '否'
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
				<th rowspan = "3">号段信息</th>
				<td>BT号段</td>
				<td colspan = "3">
					<a href="#" class="editable" id="bt_num" data-type="text" data-pk="bt_num" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入BT号段">
						<c:out value="${plan.planItems['bt_num'].itemValue}"/>
					</a>
				</td>
				<td>WIFI号段</td>
				<td colspan = "4">
					<a href="#" class="editable" id="wifi_num" data-type="text" data-pk="wifi_num" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入WIFI号段">
						<c:out value="${plan.planItems['wifi_num'].itemValue}"/>
					</a>
				</td>
			</tr>
			<tr>
				<td>MEID号段</td>
				<td colspan = "3">
					<a href="#" class="editable" id="meid_num" data-type="text" data-pk="meid_num" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入MEID号段">
						<c:out value="${plan.planItems['meid_num'].itemValue}"/>
					</a>
				</td>
					<td>IMEI号段</td>
				<td colspan = "4">
					<a href="#" class="editable" id="imei_num" data-type="text" data-pk="imei_num" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入IMEI号段">
						<c:out value="${plan.planItems['imei_num'].itemValue}"/>
					</a>
				</td>
			</tr>
			<tr>
				<td>PSN/KSN</td>
				<td colspan = "3">
					<a href="#" class="editable" id="psn_ksn" data-type="text" data-pk="psn_ksn" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入PSN/KSN">
						<c:out value="${plan.planItems['psn_ksn'].itemValue}"/>
					</a>
				</td>
					<td>DSN/TUSN</td>
				<td colspan = "4">
					<a href="#" class="editable" id="dsn_tusn" data-type="text" data-pk="dsn_tusn" data-url="<%=request.getContextPath()%>/do/plan/save.html" data-title="输入IMEI号段">
						<c:out value="${plan.planItems['dsn_tusn'].itemValue}"/>
					</a>
				</td>
			</tr>
			<tr>
				<th>工单确认</th>
				<td colspan = "3">PM:</td>
				<td colspan = "3">SPM:</td>
				<td colspan = "3">PMC:</td>
			</tr>
		</tbody>
		</table>
	</c:if>
	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>
