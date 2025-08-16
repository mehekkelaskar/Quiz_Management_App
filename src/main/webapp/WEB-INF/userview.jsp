<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="org.bson.Document" %>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Dashboard</title>
    <style>
        body { margin: 0; font-family: Arial, sans-serif; }
        .sidebar { position: fixed; top: 0; left: -250px; width: 250px; height: 100%; background-color: #34495e; color: white; padding-top: 60px; transition: 0.3s; z-index: 1000; }
        .sidebar.active { left: 0; }
        .sidebar a { display: block; padding: 15px 25px; color: white; text-decoration: none; font-size: 1.2em; }
        .sidebar a:hover { background-color: rgba(255,255,255,0.1); }
        .overlay { position: fixed; top: 0; left: 0; width: 100%; height: 100%; background-color: rgba(0,0,0,0.5); z-index: 999; display: none; }
        .overlay.active { display: block; }
        .hamburger { position: fixed; top: 20px; left: 20px; font-size: 1em; color: white; background-color: #4e73df; border: none; padding: 10px 15px; cursor: pointer; border-radius: 5px; z-index: 1001; }
        .topbar { padding: 20px; font-size: 1.5em; text-align: center; background-color: #f8f9fa; box-shadow: 0 2px 5px rgba(0,0,0,0.1); }
        
        .main-content {
            display: flex;
            margin-top: 80px;
            padding: 20px;
            gap: 20px;
        }
        
        .greeting-block {
            flex: 2;
            background-color: #e9ecef;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        
        .greeting-block h1 {
            font-size: 2.5em;
            margin-bottom: 20px;
            color: #333;
        }
        
        .greeting-block p {
            font-size: 1.2em;
            line-height: 1.6;
            color: #555;
        }
		  .greeting-block {
            flex: 2;
            background-color: #e9ecef;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            transition: transform 0.3s;
        }
        
        .greeting-block:hover {
            transform: translateY(-5px);
        }
        
        
        .stats-block {
            flex: 1;
            display: flex;
            flex-direction: column;
            gap: 20px;
        }
        
        .stat-card {
            background-color: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            text-align: center;
            transition: transform 0.3s;
        }
        
        .stat-card:hover {
            transform: translateY(-5px);
        }
        
        .stat-card a {
            text-decoration: none;
            color: inherit;
            display: block;
            height: 100%;
        }
        
        .stat-card h3 {
            font-size: 1.5em;
            margin-bottom: 10px;
        }
        
        .stat-card p {
            font-size: 1.1em;
            color: #666;
        }
        
        #total-tests {
            background-color: #d4edda;
            color: #155724;
        }
        
        #attendance {
            background-color: #cce5ff;
            color: #004085;
        }
        
        #performance {
            background-color: #fff3cd;
            color: #856404;
        }
    </style>
</head>
<body>

    <div class="sidebar" id="sidebar">
        <a href="totalQuiz">Quiz Board</a>
        <a href="logout">Logout</a>
    </div>

    <div class="overlay" id="overlay" onclick="toggleSidebar()"></div>

    <button class="hamburger" onclick="toggleSidebar()">&#9776;</button>

    <div class="topbar">User Dashboard</div>

    <div class="main-content">
        <div class="greeting-block">
            <h1>Hello,${username}!</h1>
            <p>Prepare yourself.<br>
            Stay calm. Stay focused.<br>
            This is your time to challenge your knowledge.<br>
            Every question is a step towards improvement.<br>
            Give your best without rushing.<br>
            Your journey to success begins here.</p>
        </div>
        
        <div class="stats-block">
            <div class="stat-card" id="total-tests">
                <a href="getTotalTests">
                
                    <h3>Total Tests</h3>
                    <p>${total_count}</p>
                </a>
            </div>
            
            <div class="stat-card" id="attendance">
                <a href="#">
                    <h3>Attendance</h3>
                    <p>100%</p>
                </a>
            </div>
            
            <div class="stat-card" id="performance">
                <a href="performance">
                    <h3>Performance</h3>
                    <p>Track your progress and scores</p>
                </a>
            </div>
        </div>
    </div>

    <script>
        function toggleSidebar() {
            document.getElementById('sidebar').classList.toggle('active');
            document.getElementById('overlay').classList.toggle('active');
        }
    </script>

</body>
</html>