<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Quiz Landing Page</title>
  <style>
    * {
      box-sizing
      : border-box;
      margin: 0;
      padding: 0;
    }

    body {
      font-family: 'Segoe UI', sans-serif;
      background-image: url('https://static.vecteezy.com/system/resources/previews/014/499/595/original/minimalist-background-blue-pastel-line-abstract-free-vector.jpg');
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
    }

    .container {
      max-width: 1000px;
      width: 100%;
      background: white;
      box-shadow: 0 0 20px rgba(0,0,0,0.1);
      border-radius: 20px;
      padding: 90px;
      display: flex;
      justify-content: space-between;
      align-items: center;
      border:lightgray solid 5px;
    }

    nav {
      position: absolute;
      top: 20px;
      right: 40px;
    }

    nav a {
      margin: 0 12px;
      text-decoration: none;
      color: #333;
      font-weight: 500;
    }

    nav a.active {
      color: #f5a623;
      font-weight: bold;
    }

    .left {
      flex: 1;
    }

    .left h1 {
      font-size: 2.5rem;
      color: #2d2d2d;
    }

    .left span {
      color: #f5a623;
    }

    .left p {
      margin-top: 10px;
      color: #666;
    }

    .left button {
      margin-top: 20px;
      padding: 12px 20px;
      border: none;
      background-color: #2d2dff;
      color: white;
      border-radius: 25px;
      font-size: 1rem;
      cursor: pointer;
    }

    .right {
      flex: 1;
      display: flex;
      justify-content: center;
    }

    .right img {
      width: 100%;
   
      max-width: 700px;
    }
  </style>
</head>
<body>

  <nav>
    <a href="#" class="active">Home</a>
  <a href="login">Login</a>
  </nav>

  <div class="container">
    <div class="left">
      <h1>Create a Free <br><span>Quiz Now</span></h1>
      <p>The versatile platform for students to upgrade their skills.<br>
         Typeform makes asking easy & answering refreshing.</p>
         <form action="login">
           <button>Let's start !</button>
         </form>
    
    </div>
    <div class="right">
      <img src="https://cdn.dribbble.com/userupload/27365913/file/original-2cd0dd3ca4dff1b8fec6e873dc421b4b.png?format=webp&resize=400x300&vertical=center">
    </div>
  </div>

</body>
</html>
