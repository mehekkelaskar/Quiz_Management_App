<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Student Login</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <style>
    * {
      box-sizing: border-box;
      margin: 0;
      padding: 0;
      font-family: 'Segoe UI', sans-serif;
    }

    body {
      background-color: #a0c1f7;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
    }

    .container {
      width: 90%;
      max-width: 900px;
      background-color: #ffffff;
      border-radius: 20px;
      display: flex;
      overflow: hidden;
      box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
    }

    .left-side {
      background-color: white;
      flex: 1;
      display: flex;
      justify-content: center;
      align-items: center;
      padding: 40px;
    }

    .left-side img {
      max-width: 100%;
      height: auto;
    }

    .right-side {
      flex: 1;
      padding: 40px;
    }

    .right-side h2 {
      color: #1a3f9c;
      margin-bottom: 10px;
    }

    .right-side p {
      font-size: 14px;
      margin-bottom: 25px;
      color: #555;
    }

    .form-group {
      margin-bottom: 15px;
    }

    .form-group input {
      width: 100%;
      padding: 35px 20px;
      border-radius: 8px;
      border: 1px solid #ccc;
      font-size: 1rem;
    }

    .form-group input:focus {
      outline: none;
      border-color: #2d5be3;
    }

    .login-btn {
      background-color: #2d5be3;
      color: white;
      padding: 12px;
      border: none;
      width: 100%;
      border-radius: 8px;
      font-size: 1rem;
      cursor: pointer;
      margin-top: 10px;
      transition: background 0.3s ease;
    }

    .login-btn:hover {
      background-color: #1a3f9c;
    }

    .small-text {
      font-size: 12px;
      color: #555;
      margin: 10px 0;
    }

    .social-login {
      display: flex;
      justify-content: space-between;
      margin-top: 15px;
    }

    .social-btn {
      display: flex;
      align-items: center;
      gap: 8px;
      background-color: #f1f1f1;
      padding: 10px 20px;
      border-radius: 8px;
      cursor: pointer;
      border: 1px solid #ccc;
      font-size: 0.9rem;
    }

    .social-btn img {
      width: 20px;
    }

    .signup-link {
      margin-top: 20px;
      font-size: 14px;
      text-align: center;
    }

    .signup-link a {
      color: #2d5be3;
      text-decoration: none;
      font-weight: bold;
    }

    @media (max-width: 768px) {
      .container {
        flex-direction: column;
      }

      .left-side {
        display: none;
      }

      .right-side {
        padding: 30px 20px;
      }
    }
  </style>
</head>
<body>
  <div class="container">
    <!-- Left Section -->
    <div class="left-side">
      <img src="https://static.vecteezy.com/system/resources/previews/006/584/649/original/illustration-graphic-cartoon-character-of-home-study-free-vector.jpg" alt="Student Illustration" />
      <!-- Replace the image URL with any illustration -->
    </div>

    <!-- Right Section -->
    <div class="right-side">
      <h2>User Login</h2>
      
<form action="otpVerification" method="post">
      <div class="form-group">
        <input type="text" placeholder="Enter the received otp" name="otp" required>
      </div>
       <label><input type="checkbox" name="remember" /> Remember Me</label>

      <button class="login-btn">Login In</button>

      </form>

      
    </div>
  </div>
</body>
</html>
