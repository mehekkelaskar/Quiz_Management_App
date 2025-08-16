<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Test Result</title>
</head>
<body>

    <h2>Test Submitted Successfully!</h2>

    <p>Total Questions: <%= request.getAttribute("totalQuestions") %></p>
    <p>Correct Answers: <%= request.getAttribute("correctCount") %></p>
    <p>Incorrect Answers: <%= request.getAttribute("incorrectCount") %></p>
    <p>Unattempted Questions: <%= request.getAttribute("unattemptedCount") %></p>
    <h3>Your Score: <%= request.getAttribute("score") %> / <%= request.getAttribute("totalQuestions") %></h3>

</body>
</html>
