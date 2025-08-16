<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form action="/generateQuestions" method="post">
    <label for="prompt">Enter Your Prompt:</label><br>
    <textarea id="prompt" name="prompt" rows="5" cols="50" required></textarea><br><br>
    <input type="submit" value="Generate">
</form>

</body>
</html>