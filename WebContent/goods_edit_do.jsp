<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="cn.mldn.vo.*"%>
<%@ page import="cn.mldn.util.factory.*"%>
<%@ page import="cn.mldn.service.*"%>
<%@ page import="cn.mldn.service.impl.*"%>
<%@ page import="com.jspsmart.upload.*"%>
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
String msg="---商品编辑失败！";
//要进行封装文件的提取，必须使用SmartUpload提取
SmartUpload smart=new SmartUpload();
smart.initialize(config, request, response);
smart.upload();
//将需要的内容设置到Goods的vo类之中
Goods vo=new Goods();
String gid = smart.getRequest().getParameter("gid");
vo.setGid(Integer.parseInt(gid));
IGoodsService service=ServiceFactory.getInstance(GoodsServiceImpl.class);
vo.setTitle(smart.getRequest().getParameter("title"));		
vo.setPrice(Double.parseDouble(smart.getRequest().getParameter("price")));
vo.setIid(Integer.parseInt(smart.getRequest().getParameter("iid")));
vo.setPhoto(smart.getRequest().getParameter("oldpic"));//接收旧的图片名称
String tids[] = smart.getRequest().getParameterValues("tid");
Set<Integer> allTids = new HashSet<Integer>();
	for(int x=0;x<tids.length;x++){
		allTids.add(Integer.parseInt(tids[x]));
}
vo.setTids(allTids);
if(smart.getFiles().getSize()>0){//有图片上传
	if(!("nophoto.jpg".equals(vo.getPhoto()))){//此时没有图片名称，则应该生成新的图片名称
	if(smart.getFiles().getFile(0).getContentType().contains("image")){
		String fileName=UUID.randomUUID() + "." + smart.getFiles().getFile(0).getFileExt();
		vo.setPhoto(fileName);
		}
	}
}
IGoodsService goodsService=ServiceFactory.getInstance(GoodsServiceImpl.class);
if(goodsService.edit(vo)){//保存成功
	if(smart.getFiles().getSize()>0){//有图片才可以保存
		String filePath=this.getServletContext().getRealPath("/upload/goods/") + vo.getPhoto();
		smart.getFiles().getFile(0).saveAs(filePath);
	}
	msg="---商品编辑成功。";
}
%>
<jsp:include page="/pages/plugins/time_div.jsp">
		<jsp:param value="<%=url%>" name="url"/>
		<jsp:param value="<%=msg%>" name="msg"/>
	</jsp:include>
</body>
</html>