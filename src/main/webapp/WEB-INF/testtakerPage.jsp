<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Test Taker Dashboard</title>
    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
        }

        /* Sidebar */
        .sidebar {
            position: fixed;
            top: 0;
            left: -250px;
            width: 250px;
            height: 100%;
            background-color: #34495e;
            color: white;
            padding-top: 60px;
            transition: 0.3s;
            z-index: 1000;
        }

        .sidebar.active {
            left: 0;
        }

        .sidebar a {
            display: block;
            padding: 15px 25px;
            color: white;
            text-decoration: none;
            font-size: 1.2em;
        }

        .sidebar a:hover {
            background-color: rgba(255,255,255,0.1);
        }

        /* Overlay */
        .overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.5);
            z-index: 999;
            display: none;
        }

        .overlay.active {
            display: block;
        }

        /* Hamburger Button */
        .hamburger {
            position: fixed;
            top: 20px;
            left: 20px;
            font-size: 1em;
            color: white;
            background-color: #4e73df;
            border: none;
            padding: 10px 15px;
            cursor: pointer;
            border-radius: 5px;
            z-index: 1001;
        }

        .topbar {
            padding: 20px;
            font-size: 2em;
            background-color: #4e73df;
            color: white;
            text-align: center;
        }

        .container {
            display: flex;
            justify-content: space-between;
            padding: 40px;
            gap: 30px;
        }

        .welcome-block {
            flex: 1.5;
            background-color: #F9EBEA;
            padding: 30px;
            border-radius: 15px;
            font-size: 1.5em;
            color: #6E2C00;
            display: flex;
            flex-direction: column;
            justify-content: center;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }

        .stats-blocks {
            flex: 1;
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        .stat-card {
            background-color: white;
            border-left: 5px solid #4e73df;
            padding: 20px;
            border-radius: 10px;
            font-size: 1.2em;
            display: flex;
            align-items: center;
            justify-content: space-between;
            box-shadow: 0 4px 8px rgba(0,0,0,0.05);
        }

        .give-test-btn {
            background-color: #28a745;
            color: white;
            padding: 15px 20px;
            text-align: center;
            border-radius: 10px;
            font-size: 1.2em;
            cursor: pointer;
            transition: background 0.3s;
        }

        .give-test-btn:hover {
            background-color: #218838;
        }

    </style>
</head>
<body>

    <!-- Sidebar -->
    <div class="sidebar" id="sidebar">
        <a href="#">Dashboard</a>
        <a href="#">My Profile</a>
        <a href="#">My Tests</a>
        <a href="logout">Logout</a>
    </div>

    <!-- Overlay -->
    <div class="overlay" id="overlay" onclick="toggleSidebar()"></div>

    <!-- Hamburger Button -->
    <button class="hamburger" onclick="toggleSidebar()">&#9776;</button>

    <!-- Topbar -->
    <div class="topbar">Test Taker Dashboard</div>

    <!-- Main Content -->
    <div class="container">
        <!-- Left Big Block -->
        <div class="welcome-block">
            <p>Hello, John Doe!</p>
            <p>Prepare yourself and stay focused.</p>
            <p>Your next test is waiting for you.</p>
        </div>

        <!-- Right Small Blocks -->
        <div class="stats-blocks">
            <div class="stat-card">
                <span>&#128337; Ongoing Tests</span>
                <span>3</span>
            </div>
            <div class="stat-card">
                <span>&#128202; Total Tests</span>
                <span>10</span>
            </div>
            <form action="uploadTest">
            <button class="give-test-btn">
                &#9989; Give Test
            </button>
            </form>
        </div>
    </div>

    <!-- Sidebar Toggle Script -->
    <script>
        function toggleSidebar() {
            document.getElementById('sidebar').classList.toggle('active');
            document.getElementById('overlay').classList.toggle('active');
        }
    </script>

</body>
</html>
