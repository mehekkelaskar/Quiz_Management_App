<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
    <title>Upload Test Questions</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            padding: 20px;
        }

        input[type="text"], input[type="number"] {
            width: 50%;
            padding: 8px;
            margin-bottom: 15px;
        }

        button {
            padding: 10px 20px;
            font-size: 16px;
            margin-top: 15px;
        }

        .question-block {
            border: 1px solid #ccc;
            padding: 15px;
            margin-bottom: 20px;
        }
    </style>
    <script>
        function addQuestionBlock() {
            const container = document.getElementById('questionContainer');

            const block = document.createElement('div');
            block.className = 'question-block';
            block.innerHTML = `
                <label><b>Question:</b></label><br>
                <input type="text" name="questionText" required><br><br>

                <label><b>Option A:</b></label><br>
                <input type="text" name="optionA" required><br><br>

                <label><b>Option B:</b></label><br>
                <input type="text" name="optionB" required><br><br>

                <label><b>Option C:</b></label><br>
                <input type="text" name="optionC" required><br><br>

                <label><b>Option D:</b></label><br>
                <input type="text" name="optionD" required><br><br>

                <label><b>Correct Answer (A/B/C/D):</b></label><br>
                <input type="text" name="correctAnswer" required><br>
            `;
            container.appendChild(block);
        }
    </script>
</head>
<body>

    <h2>Create New Test</h2>

 <form action="submitQuestions" method="post">
    <label><b>Test Name:</b></label><br>
    <input type="text" name="testName" required><br>

    <label><b>Exam Duration (in minutes):</b></label><br>
    <input type="number" name="duration" min="1" required><br><br>

    <label><b>Expiry Date:</b></label><br>
    <input type="date" name="expiryDate" required><br><br>

    <h3>Questions</h3>
    <div id="questionContainer">
        <!-- Question blocks go here -->
    </div>

    <button type="button" onclick="addQuestionBlock()">Add Question</button><br><br>

    <button type="submit">Submit Test</button>
</form>

    <script>
        window.onload = addQuestionBlock;
    </script>

</body>
</html>
