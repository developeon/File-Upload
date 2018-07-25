<%@page import="java.util.Enumeration"%>
<%@ page import="file.FileDAO"%>
<%@ page import="java.io.File"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JSP 파일 업로드</title>
</head>
<body>
	<%
		String directory = application.getRealPath("/upload/");
	int maxSize = 1024 * 1024 * 100; //100MB
	String encoding = "UTF-8";
	
	MultipartRequest multipartRequest = new MultipartRequest(request, directory, maxSize, encoding, new DefaultFileRenamePolicy());
	//사용자가 전송한 파일정보(request)를 토대로 upload 폴더안에 maxsize만큼만 UTF-8인코딩 적용해서 실제 파일업로드를 수행할 수 있도록 함.
	
	Enumeration fileNames = multipartRequest.getFileNames();
	while(fileNames.hasMoreElements()){
		String parameter = (String)fileNames.nextElement();
		String fileName = multipartRequest.getOriginalFileName(parameter);
		String fileRealName = multipartRequest.getFilesystemName(parameter);
		
		if(fileName == null) continue;
		
		new FileDAO().upload(fileName, fileRealName);
		out.write("파일명 : " + fileName + "<br>");	
		out.write("실제 파일명 : " + fileRealName + "<br>");
	}
	%>
</body>
</html>