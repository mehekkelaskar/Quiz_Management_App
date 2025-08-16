<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, org.bson.Document"  %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Performance Summary</title>
    <style>
        table { width: 80%; border-collapse: collapse; margin: 20px auto; }
        th, td { padding: 12px; border: 1px solid #ddd; text-align: center; }
        th { background-color: #2E86C1; color: white; }
        .improved { color: green; font-weight: bold; }
        .declined { color: red; font-weight: bold; }
        .nochange { color: orange; font-weight: bold; }
    </style>
</head>
<body>

<h2 style="text-align:center;">Your Performance Summary</h2>
<table border="1" cellpadding="10">
    <tr>
        <th>Test Name</th>
        <th>Score</th>
        <th>Total</th>
        <th>Date</th>
        <th>Improvement (%)</th>
    </tr>
    <%
        List<Map<String, Object>> performanceData = (List<Map<String, Object>>) request.getAttribute("performanceData");
        if (performanceData != null && !performanceData.isEmpty()) {
            for (Map<String, Object> row : performanceData) {
    %>
                <tr>
                    <td><%= row.get("testName") %></td>
                    <td><%= row.get("score") %></td>
                    <td><%= row.get("total") %></td>
                    <td><%= row.get("timestamp") %></td>
                    <td><%= row.get("improvement") %></td>
                </tr>
    <%
            }
        } else {
    %>
        <tr><td colspan="5">No Test Results Found</td></tr>
    <%
        }
    %>
</table>


</body>
</html>
