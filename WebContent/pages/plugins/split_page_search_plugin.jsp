<%@ page pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8") ;
%>
<%--
<jsp:include page="split_page_search_plugin.jsp">
	<jsp:param name="url" value="<%=url%>"/>
	<jsp:param name="allRecorders" value="<%=allRecorders%>"/>
	<jsp:param name="columnData" value="<%=columnData%>"/>
	<jsp:param name="column" value="<%=column%>"/>
	<jsp:param name="keyWord" value="<%=keyWord%>"/>
</jsp:include>
--%>
<%
	String url = request.getParameter("url") ;
	String allRecorders = request.getParameter("allRecorders") ;
	String columnData = request.getParameter("columnData") ;
	String column = request.getParameter("column") ;
	String keyWord = request.getParameter("keyWord") ;
%>
<div id="searchDiv">
	<form action="<%=url%>" method="post">
<%		// 现在columnData变量有内容
		if (!(columnData == null || "".equals(columnData))) {
			String result [] = columnData.split("\\|") ;	// 拆分
%>
			<select id="col" name="col">
<%
				for (int x = 0 ; x < result.length ; x ++) {
					String temp [] = result[x].split(":") ;
%>
					<option value="<%=temp[1]%>" <%=temp[1].equals(column) ? "selected" : ""%>><%=temp[0]%></option>
<%
				}
%>
			</select>
<%  
		}
%>
		<input type="text" name="kw" id="kw" placeholder="请输入检索关键字" value="<%=keyWord == null ? "" : keyWord%>">
		<input type="submit" value="检索">
		<div>本次查询一共返回有“<%=allRecorders%>”行记录！</div>
	</form>
</div>