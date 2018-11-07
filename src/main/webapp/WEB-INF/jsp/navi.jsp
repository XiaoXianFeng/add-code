<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<ul id="navi" class="navi-ul">
  <li class="navi-li"><a class="<%="home".equals(request.getParameter("page")) ? "active" : "" %>" href="<%=request.getContextPath()%>/do/plan/list.html">生产计划</a></li>
  <li class="navi-li"><a class="<%="template".equals(request.getParameter("page")) ? "active" : "" %>" href="<%=request.getContextPath()%>/do/template/">模板设置</a></li>
  <li class="navi-li"><a class="<%="setting".equals(request.getParameter("page")) ? "active" : "" %>" href="<%=request.getContextPath()%>/do/user/users.html">用户设置</a></li>
  <li class="navi-li" style="float:right"><a href="<%=request.getContextPath()%>/logout">退出</a></li>
</ul>
<br/>
