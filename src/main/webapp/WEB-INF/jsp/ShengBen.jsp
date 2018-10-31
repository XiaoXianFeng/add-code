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
			<table border="1">
			<tr>
				<th colspan  = "10">上海盛本智能科技有限公司</th>
			</tr>
			<tr>
				<th colspan = "8" rowspan = "3">QR300 P4_PCBA生产通知书</th>
				<td colspan = "2">表单编号:QR-QSP-017-10</td>
			</tr>
			<tr>
				<td colspan = "2">版本号:A/1</td>
			</tr>
			<tr>
				<td colspan = "2">编号:201809291511</td>
			</tr>
			<tr>
				<th rowspan = "2">订单信息</th>
				<th>客户</th>
				<td colspan = "4"></td>
				<th>产品型号</th>
				<td colspan = "3">QR300</td>
			</tr>
			<tr>
				<th>生产性质</th>
				<td>试产</td>
				<td colspan = "2">小批</td>
				<td>量产</td>
				<th>订单数量</th>
				<td colspan = "3">1500</td>
			</tr>
			<tr>
				<th rowspan = "3">工单信息</th>
				<th>产品信息</th>
				<th>生产单号</th>
				<td colspan = "2">5101-QR3000927005</td>
				<th>成品料号</th>
				<td colspan = "2">6005071601</td>
				<th>整机颜色</th>
				<td>N/A</td>
			</tr>
			<tr>
				<th>生产类别</th>
				<td>核心板PCBA</td>
				<td>主板PCBA</td>
				<td>副板</td>
				<td>机头</td>
				<td>底座</td>
				<td>包装</td>
				<td>返工</td>
				<td>升级出货</td>
			</tr>
			<tr>
				<th>是否走系统</th>
				<td colspan = "2">是</td>
				<td colspan = "2">否</td>
				<th>即时出货</th>
				<td colspan = "2">是</td>
				<td>否</td>
			</tr>
			<tr>
				<th rowspan = "15">生产资料信息</th>
				<th>核心板bom</th>
				<td colspan = "8">N/A</td>
			</tr>
				<th>主板bom</th>
				<td colspan = "8">QR300_MAIN_P4_V1.2_20180921(20180914)</td>
			</tr>
			<tr>
				<th>副板bom</th>
				<td colspan = "8">N/A</td>
			</tr>
			<tr>
				<th>STM资料包</th>
				<td colspan = "8">QR300_BFZJ1800540_MAIN_P4_SMT_20180925.rar</td>
			</tr>
			<tr>
				<th>组装BOM</th>
				<td colspan = "8">N/A</td>
			</tr>
			<tr>
				<th>配置BOM</th>
				<td colspan = "8">N/A</td>
			</tr>
			<tr>
				<th>包装BOM</th>
				<td colspan = "8">N/A</td>
			</tr>
			<tr>
				<th>工艺文件</th>
				<td colspan = "8">QR300 CIT测试需求及流程 (for非及时出货) -20180830.xls</td>
			</tr>
			<tr>
				<th>组包装SOP</th>
				<td colspan = "8">N/A</td>
			</tr>
			<tr>
				<th>标签打印包</th>
				<td colspan = "8">N/A</td>
			</tr>
			<tr>
				<th rowspan = "5">软件版本</th>
				<th>平台版本</th>
				<td colspan = "7">/QR/AC35_Tool/PA_V1.9.7/MercuryPlat_V1.9.7.7z</td>
			</tr>
			<tr>
				<th>AP版本</th>
				<td colspan = "7">/QR/QR300/STM/QR300_SMT_APP_V2.09.7705_K_20180830_sec.rar</td>
			</tr>
			<tr>
				<th>模块版本</th>
				<td colspan = "7">/POS/pos/MH1902/QR100/BOOTLOADER/001_Signed/MH1920_BL_20180223.hex.sig.zip </hr>
				/POS/pos/MH1902/QR300/SMT/V9.39.864/MH1902FW_QR300_DEBUG_MB01_V9.39.864_180914.bin.7z</td>
			</tr>
			<tr>
				<th>读取版本号</th>
				<td colspan = "7"></td>
			</tr>
			<tr>
				<th>QCN/PRI</th>
				<td colspan = "7"></td>
			</tr>
			<tr>
				<th>注意事项(返工流程)</th>
				<td colspan = "9"></td>
			</tr>
			<tr>
				<th rowspan = "8">配置信息</th>
				<th rowspan = "6">频段</th>
				<td>GSM</td>
				<td>850</td>
				<td>900</td>
				<td>1800</td>
				<td>1900</td>
				<td></td>
				<td></td>
				<td></td>
			</tr>
			<tr>
				<td>CDMA</td>
				<td>800</td>
				<td>1900</td>
				<td>AWS</td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>
			<tr>
				<td>WCDMA</td>
				<td>850</td>
				<td>900</td>
				<td>1900</td>
				<td>2100</td>
				<td></td>
				<td></td>
				<td></td>
			</tr>
			<tr>
				<td>TD-SCDMA</td>
				<td>B34</td>
				<td>B39</td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>
			<tr>
				<td rowspan = "2">LTE-FDD</td>
				<td>B38</td>
				<td>B39</td>
				<td>B40</td>
				<td>B41</td>
				<td></td>
				<td></td>
				<td></td>
			</tr>
			<tr>
				<td>B1</td>
				<td>B2</td>
				<td>B3</td>
				<td>B5</td>
				<td>B7</td>
				<td>B8</td>
				<td>B9</td>
			</tr>
			<tr>
				<th>主板配置码</th>
				<td colspan = "4">5</td>
				<th>成品配置</th>
				<td colspan = "3">N/A</td>
			</tr>
			<tr>
				<th>灌装SN密匙</th>
				<td colspan = "2">是</td>
				<td colspan = "2">否</td>
				<th>灌装客户密匙</th>
				<td colspan = "2">是</td>
				<td>否</td>
			</tr>
			<tr>
				<th rowspan = "3">号段信息</th>
				<th>BT号段</th>
				<td colspan = "3">N/A</td>
				<th>WIFI号段</th>
				<td colspan = "4">N/A</td>
			</tr>
			<tr>
				<th>MEID号段</th>
				<td colspan = "3">N/A</td>
				<th>IMEI号段</th>
				<td colspan = "4">N/A</td>
			</tr>
				<th>PSN/KSN</th>
				<td colspan = "3">NQR3B05</td>
				<th>DSN/TUSN</th>
				<td colspan = "4">N/A
			</td>
			<tr>
				<th>工单确认</th>
				<td colspan = "3">PM:</td>
				<td colspan = "3">SPM:</td>
				<td colspan = "3">PMC:</td>
			</tr>
		</table>
		<table>
			<tr>
			<th>制表日</th>
			<td>2018年8月23日</td>
			<th>制表：</th>
			<td></td>
			</tr>
		</table>
		</c:if>
	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>
