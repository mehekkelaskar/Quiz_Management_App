<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Add Teacher</title>
  <style>
    body {
      font-family: 'Segoe UI', system-ui, sans-serif;
      background: #f8f9fa;
      margin: 0;
      padding: 20px;
      display: flex;
      justify-content: center;
      align-items: center;
      min-height: 100vh;
    }
    
    .form-container {
      background: white;
      border-radius: 8px;
      box-shadow: 0 2px 10px rgba(0,0,0,0.1);
      width: 100%;
      max-width: 400px;
      padding: 30px;
    }
    
    h2 {
      margin: 0 0 20px 0;
      color: #2c3e50;
      font-size: 1.5rem;
    }
    
    .form-group {
      margin-bottom: 20px;
    }
    
    label {
      display: block;
      margin-bottom: 6px;
      font-weight: 500;
      color: #495057;
    }
    
    input {
      width: 100%;
      padding: 10px;
      border: 1px solid #ddd;
      border-radius: 4px;
      font-size: 16px;
    }
    
    input:focus {
      outline: none;
      border-color: #3498db;
    }
    
    button {
      background: #3498db;
      color: white;
      border: none;
      padding: 12px;
      width: 100%;
      border-radius: 4px;
      font-size: 16px;
      cursor: pointer;
      margin-top: 10px;
    }
    
    button:hover {
      background: #2980b9;
    }
  </style>
</head>
<body>
  <div class="form-container">
    <h2>Add New Teacher</h2>
    <form id="teacherForm " action="removingFac" method="post">
      <div class="form-group">
        <label for="teacherEmail">Email</label>
        <input type="email" id="teacherEmail" name="email" required>
      </div>
      <button type="submit">Add Teacher</button>
    </form>
  </div>

 
</body>
</html>