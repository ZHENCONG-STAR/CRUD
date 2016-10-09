<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="cn.mldn.vo.*" %>
<%@ page import="cn.mldn.util.factory.*" %>
<%@ page import="cn.mldn.service.*" %>
<%@ page import="cn.mldn.service.impl.*" %>
<%@page import="com.jspsmart.upload.*"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String addUrl=basePath + "goods_add_do.jsp";
%>
<html>
<head>
	<title>商品信息管理</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="js/util.js"></script>
<link rel="stylesheet" type="text/css" href="css/mldn.css">
<link rel="stylesheet" type="text/css" href="css/style.css">

</head>
<body> 
<% 
	IGoodsService service=ServiceFactory.getInstance(GoodsServiceImpl.class);
	Map<String,Object> map=service.addPre();
	List<Item> allItems=(List<Item>)map.get("allItems");
	List<Tag> allTags=(List<Tag>)map.get("allTags");
	Iterator<Item> iterItem=allItems.iterator();
	Iterator<Tag> iterTag=allTags.iterator();
%>
<form action="<%= addUrl%>" method="post" enctype="multipart/form-data">
	<table border="1" style="width:100%;">
		<tr>
			<td colspan="2">添加商品信息</td>
		</tr>
		<tr>
			<td>商品名称</td>
			<td><input type="text" id="gid" name="gid"></td>
		</tr>
		<tr>
			<td>商品分类</td>
			<td>
				<select id="iid" name="iid">
				<% 
					while(iterItem.hasNext()){
					Item item=iterItem.next();
				%>
				<option value="<%= item.getIid()%>"><%= item.getTitle()%></option>
				<%
					}
				%>
				</select>
			</td>
		</tr>
		<tr>
			<td>商品价格</td>
			<td><input type="text" id="price" name="price"></td>
		</tr>
		<tr>
			<td>商品图片</td>
			<td><input type="file" id="photo" name="photo"></td>
		</tr>
		<tr>
			<td>商品标签</td>
			<td>
				<% 
					while(iterTag.hasNext()){
					Tag tag=iterTag.next();
				%>
				<input type="checkbox" id="tid" name="tid" value="<%= tag.getTid()%>"><%= tag.getTitle() %>
				<%
					}
				%>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<input type="submit" value="增加">
				<input type="reset" value="重置">
			</td>
		</tr>
	</table>
</form>
</body>
</html>
