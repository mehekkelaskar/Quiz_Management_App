<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.util.List" %>
<%@ page import="org.bson.Document" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<% List<Document> s=(List<Document>)request.getAttribute("students"); %>
<%for(Document d:s)  {
	      
	    
%>
<p><%= d.get("email")%></p>
<%
                }
            
        %>
</body>
</html>