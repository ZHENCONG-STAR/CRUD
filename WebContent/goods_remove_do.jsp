<%@page import="cn.mldn.dao.impl.GoodsDAOImpl"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
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
</head>
<body> 
<% 
	String url=basePath + "goods_list.jsp";
	String ids=request.getParameter("ids");
	String result[]=ids.split("\\|");
	Set<Integer> gids=new HashSet<Integer>();
	Set<String> photos=new HashSet<String>();
	for(int x=0;x<result.length;x++){
		String temp[]=result[x].split(":");
		photos.add(temp[1]);
		gids.add(Integer.parseInt(temp[0]));
	}
	String msg="--删除商品失败！";
	IGoodsService goodsService=ServiceFactory.getInstance(GoodsServiceImpl.class);
	if(goodsService.remove(gids)){
		Iterator<String> iter=photos.iterator();
		while(iter.hasNext()){
			String fileName=iter.next();
			if(!("nophoto.jpg".equals(fileName))){
				String filePath=this.getServletContext().getRealPath("/upload/goods/") + fileName;
				File file=new File(filePath);
				if(file.exists()){
					file.delete();
				}
			}
		}
		msg="--商品删除成功。";
	}
%>
<jsp:include page="/pages/plugins/time_div.jsp">
	<jsp:param name="url" value="<%=url%>"/>
	<jsp:param name="msg" value="<%=msg%>"/>
</jsp:include>
</body>
</html>