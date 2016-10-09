<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="cn.mldn.vo.*"%>
<%@ page import="cn.mldn.util.factory.*"%>
<%@ page import="cn.mldn.service.*"%>
<%@ page import="cn.mldn.service.impl.*"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	request.setCharacterEncoding("UTF-8") ;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="<%=basePath%>">
<jsp:include page="/pages/plugins/include_javascript.jsp"/>
<script type="text/javascript" src="js/goods_list.js"></script>
</head>
<body> 
<% 
	int currentPage=1;
	int lineSize=5;
	String column=null;
	String keyWord=null;
	int  allRecorders=0;
	String columnData="商品名称:title";
%>
<% 
	try{
		currentPage=Integer.parseInt(request.getParameter("cp"));
	}catch(Exception e){}
	try{
		lineSize=Integer.parseInt(request.getParameter("ls"));
	}catch(Exception e){}
	column=request.getParameter("col");
	keyWord=request.getParameter("kw");
	if(keyWord==null){
		keyWord="";
	}
%>
<% 
	String url = basePath+"goods_list.jsp";
	String editUrl = basePath+"goods_edit.jsp";
	IGoodsService goodsService=ServiceFactory.getInstance(GoodsServiceImpl.class);
	Map<String,Object> map=goodsService.list(column, keyWord, currentPage, lineSize);
	allRecorders=(Integer)map.get("goodsCount");
	List<Goods> allGoods=(List<Goods>)map.get("allGoods");
	List<Item> allItems=(List<Item>)map.get("allItems");
	Map<Integer,String> itemMap=new HashMap<Integer,String>();
	Iterator<Item> iterItem=allItems.iterator();
	while(iterItem.hasNext()){
		Item item=iterItem.next();
		itemMap.put(item.getIid(),item.getTitle());
	}
	Iterator<Goods> iter=allGoods.iterator();
%>
<jsp:include page="/pages/plugins/split_page_search_plugin.jsp">
	<jsp:param name="url" value="<%=url%>"/> 
	<jsp:param name="allRecorders" value="<%=allRecorders%>"/>
	<jsp:param name="columnData" value="<%=columnData%>"/>
	<jsp:param name="column" value="<%=column%>"/>
	<jsp:param name="keyWord" value="<%=keyWord%>"/>
</jsp:include>

<div>
<table border="1" style="width:100%">
	<tr>
		<td width="5%"><input type="checkbox" id="selall"></td>
		<td width="45%">商品图片</td>
		<td width="20%">商品名称</td>
		<td width="15%">商品分类</td>
		<td width="15%">商品价格</td>
	</tr>
	<% 
		while(iter.hasNext()){
			Goods vo=iter.next();
	%>
	<tr>
		<td><input type="checkbox" id="gid" name="gid" value="<%= vo.getGid()%>:<%= vo.getPhoto()%>"></td>
		<td><img src="upload/goods/<%= vo.getPhoto()%>" style="width:20%"></td>
		<td><a href="<%= editUrl%>?gid=<%= vo.getGid()%>"><%= vo.getTitle()%></a></td>
		<td width="15%"><%= itemMap.get(vo.getIid())%></td>
		<td><%= vo.getPrice()%></td>
	</tr>
	<%
		}
	%>
</table>
</div>

<div><input type="button" value="删除所选商品信息" id="deleteBut"></div>
<jsp:include page="/pages/plugins/split_page_bar_plugin.jsp">
	<jsp:param name="url" value="<%=url%>"/>
	<jsp:param name="currentPage" value="<%=currentPage%>"/>
	<jsp:param name="lineSize" value="<%=lineSize%>"/>
	<jsp:param name="keyWord" value="<%=keyWord%>"/>
	<jsp:param name="column" value="<%=column%>"/>
	<jsp:param name="allRecorders" value="<%=allRecorders%>"/>
</jsp:include>
</body>
</html>