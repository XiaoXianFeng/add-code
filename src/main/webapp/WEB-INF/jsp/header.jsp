<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<header>
    <table style="width: 100%">
        <tr>
            <td style="width:110px;"><img style="width: 103px; height:47px; border:0px;" src="<%=request.getContextPath()%>/resources/logo.jpg"/></td>
            <td vertical-align="bottom" align="left">System</td>
            <td></td>
            <td align="right"><span><a href="<%=request.getContextPath()%>/logout">Password</a></span>
                <span><a href="<%=request.getContextPath()%>/logout">Logout</a></span></td>
        </tr>
    </table>

</header>