<%@page import="java.io.ObjectInputStream.GetField"%>
<%@page import="com.jspsmart.upload.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="cn.mldn.vo.*"%>
<%@ page import="cn.mldn.service.*"%>
<%@ page import="cn.mldn.service.impl.*"%>
<%@ page import="cn.mldn.util.factory.*"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	request.setCharacterEncoding("UTF-8") ;	// 只要是JSP页面就必须存在此程序代码
	String url=basePath + "goods_add.jsp";
%>
<html>
<head>
	<base href="<%=basePath%>">
	<title>JSP + Oracle实战开发</title>
	<script type="text/javascript" src="js/util.js"></script>
	<link rel="stylesheet" type="text/css" href="css/mldn.css">
	<link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
<% 
	String msg="--添加商品失败！";
	SmartUpload smart=new SmartUpload();
	smart.initialize(config, request, response);
	smart.upload();
	IGoodsService service=ServiceFactory.getInstance(GoodsServiceImpl.class);
	Goods vo=new Goods();
	vo.setTitle(smart.getRequest().getParameter("title"));
	vo.setPrice(Double.parseDouble(smart.getRequest().getParameter("price")));
	vo.setIid(Integer.parseInt(smart.getRequest().getParameter("iid")));
	String tids[]=smart.getRequest().getParameterValues("tid");
	Set<Integer> allTids=new HashSet<Integer>();
		for(int x=0;x<tids.length;x++){
			allTids.add(Integer.parseInt(tids[x]));
		}
	vo.setTids(allTids);
	if(smart.getFiles().getSize()>0){
		if(smart.getFiles().getFile(0).getContentType().contains("image")){
			String fileName=UUID.randomUUID() + "." + smart.getFiles().getFile(0).getFileExt();
			vo.setPhoto(fileName);
		}
	}else{
		vo.setPhoto("nophoto.jpg");
	}
	IGoodsService goodsService=ServiceFactory.getInstance(GoodsServiceImpl.class);
	if(goodsService.add(vo)){
		if(smart.getFiles().getSize()>0){
			String filePath=this.getServletContext().getRealPath("/upload/goods/") + vo.getPhoto();
			smart.getFiles().getFile(0).saveAs(filePath);
		}
		msg="--商品添加成功。";
	}
%>
	<jsp:include page="/pages/plugins/time_div.jsp">
		<jsp:param value="<%= url%>" name="url"/>
		<jsp:param value="<%= msg%>" name="msg"/>
	</jsp:include>
</body>
</html>

