<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="org.bson.Document" %>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Student Performance</title>
    <style>
        table {
            width: 80%;
            margin: auto;
            border-collapse: collapse;
            margin-top: 50px;
        }
        th, td {
            padding: 12px;
            border: 1px solid #ccc;
            text-align: center;
        }
        th {
            background-color: #4e73df;
            color: white;
        }
    </style>
</head>
<body>

    <h1 style="text-align:center;">All Students Performance</h1>

    <table>
        <tr>
            <th>Email</th>
            <th>Test Name</th>
            <th>Score</th>
            <th>Total Marks</th>
            <th>Date</th>
        </tr>
        <c:forEach var="result" items="${testResults}">
            <tr>
                <td>${result.email}</td>
                <td>${result.testName}</td>
                <td>${result.score}</td>
                <td>${result.total}</td>
                <td>${result.timestamp}</td>
            </tr>
        </c:forEach>
    </table>

</body>
</html>
