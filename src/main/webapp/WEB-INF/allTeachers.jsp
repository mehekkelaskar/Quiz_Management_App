<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="org.bson.Document" %>
<%@ page import="java.util.List" %>
<html>
<head>
    <title>All Teachers</title>
</head>
<body>
    <h2>List of Teachers</h2>

    <%
        List<Document> teachers = (List<Document>) request.getAttribute("teachers");
    %>

    <table border="1">
        <tr>
            <th>Name</th>
            <th>Email</th>
        </tr>

        <%
            if (teachers != null) {
                for (Document teacher : teachers) {
        %>
                    <tr>
                        <td><%= teacher.get("name") %></td>
                        <td><%= teacher.get("email") %></td>
                    </tr>
        <%
                }
            }
        %>
    </table>
</body>
</html>
