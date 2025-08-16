<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="org.bson.Document" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Attempt Test</title>
</head>
<body>

    <h2>Test: <%= request.getAttribute("testName") %></h2>
    <h3>Time Remaining: <span id="timer"></span></h3>

    <form id="testForm" action="submitTest" method="post">
        <input type="hidden" name="testName" value="<%= request.getAttribute("testName") %>">
        <input type="hidden" id="cheatingFlag" name="cheatingFlag" value="false">

        <%
            List<Document> questions = (List<Document>) request.getAttribute("questions");
            if (questions != null) {
                for (int i = 0; i < questions.size(); i++) {
                    Document q = questions.get(i);
                    String questionText = q.getString("questionText");
                    List<String> options = (List<String>) q.get("options");
        %>
                    <div style="margin-bottom: 20px;">
                        <b>Q<%= (i+1) %>: <%= questionText %></b><br>
                        <%
                            char optionLabel = 'A';
                            for (String option : options) {
                        %>
                            <input type="radio" name="q<%= i %>" value="<%= optionLabel %>" required> <%= option %><br>
                        <%
                                optionLabel++;
                            }
                        %>
                    </div>
        <%
                }
            } else {
        %>
            <p>No questions found.</p>
        <%
            }
        %>

        <button type="submit">Submit Test</button>
    </form>

<script>
    let duration = <%= request.getAttribute("duration") %> * 60; // convert minutes to seconds

    function startTimer() {
        let timerDisplay = document.getElementById('timer');
        let interval = setInterval(function() {
            let minutes = Math.floor(duration / 60);
            let seconds = duration % 60;

            timerDisplay.innerHTML = 
                (minutes < 10 ? "0" + minutes : minutes) + ":" + 
                (seconds < 10 ? "0" + seconds : seconds);

            if (duration <= 0) {
                clearInterval(interval);
                forceSubmit("Time is up! Submitting the test.", false);  // Not cheating
            }

            duration--;
        }, 1000);
    }

   

    window.onload = startTimer;
</script>

</body>
</html>
