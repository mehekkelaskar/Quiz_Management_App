<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="org.bson.Document" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Available Tests</title>
</head>
<body>
    <h2>Available Tests</h2>
    <ul>
        <%
            List<Document> tests = (List<Document>) request.getAttribute("tests");
            if (tests != null && !tests.isEmpty()) {
                for (Document test : tests) {
                    String testName = test.getString("testName");
        %>
                    <li><a href="startTest?testName=<%= testName %>"><%= testName %></a></li>
        <%
                }
            } else {
        %>
                <li>No Tests Available</li>
        <%
            }
        %>
    </ul>
</body>
</html>
