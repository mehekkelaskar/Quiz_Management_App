<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Admin Dashboard - Quiz App</title>
  <style>
    * {
      box-sizing: border-box;
      margin: 0;
      padding: 0;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }

    html, body {
      height: 100%;
      background-color: #f5f7fa;
    }

    /* Profile Icon */
    .profile-icon {
      position: fixed;
      top: 20px;
      left: 20px;
      cursor: pointer;
      z-index: 3;
      background: #4e73df;
      width: 50px;
      height: 50px;
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      box-shadow: 0 4px 8px rgba(0,0,0,0.1);
      transition: all 0.3s ease;
    }

    .profile-icon:hover {
      transform: scale(1.05);
      box-shadow: 0 6px 12px rgba(0,0,0,0.15);
    }

    .profile-icon img {
      width: 30px;
      height: 30px;
      border-radius: 50%;
      filter: brightness(0) invert(1);
    }

    /* Sidebar */
    .sidebar {
      position: fixed;
      top: 0;
      left: -250px;
      width: 250px;
      height: 100vh;
      background: linear-gradient(180deg, #4e73df 0%, #224abe 100%);
      color: white;
      padding-top: 80px;
      transition: left 0.3s ease-in-out;
      z-index: 2;
      box-shadow: 5px 0 15px rgba(0,0,0,0.1);
    }

    .sidebar.active {
      left: 0;
    }

    .sidebar-item {
      width: 90%;
      margin: 5px auto;
      border-radius: 5px;
      overflow: hidden;
    }

    .sidebar-btn {
      display: flex;
      align-items: center;
      justify-content: space-between;
      width: 100%;
      padding: 12px 20px;
      border: none;
      background: transparent;
      color: white;
      text-align: left;
      cursor: pointer;
      font-size: 15px;
      transition: all 0.3s ease;
    }

    .sidebar-btn:hover {
      background-color: rgba(255,255,255,0.1);
    }

    .sidebar-btn i.chevron {
      transition: transform 0.3s ease;
      font-size: 12px;
    }

    .sidebar-btn.active i.chevron {
      transform: rotate(90deg);
    }

    .dropdown-menu {
      max-height: 0;
      overflow: hidden;
      transition: max-height 0.3s ease-out;
      background-color: rgba(0,0,0,0.1);
      border-radius: 0 0 5px 5px;
    }

    .dropdown-menu.active {
      max-height: 200px;
    }

    .dropdown-menu a {
      display: block;
      padding: 10px 20px 10px 30px;
      color: white;
      text-decoration: none;
      font-size: 14px;
      transition: all 0.2s ease;
    }

    .dropdown-menu a:hover {
      background-color: rgba(255,255,255,0.1);
      padding-left: 35px;
    }

    /* Overlay */
    .overlay {
      display: none;
      position: fixed;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background-color: rgba(0, 0, 0, 0.5);
      z-index: 1;
      backdrop-filter: blur(3px);
    }

    .overlay.active {
      display: block;
    }

    .main-content {
     padding-top:80px;
      transition: margin-left 0.3s ease-in-out;
      margin-left: 0;
      min-height: 100vh;
    }

    .main-content.shifted {
      margin-left: 250px;
    }

    .topbar {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 35px;
      padding: 20px 40px;

      background: white;
      border-radius: 10px;
      box-shadow: 0 2px 10px rgba(0,0,0,0.05);
    }

    .topbar h1 {
      color: #4e73df;
      font-size: 28px;
      font-weight: 600;
    }

    .topbar p {
      color: #6c757d;
      font-size: 16px;
      background: #f8f9fa;
      padding: 8px 15px;
      border-radius: 20px;
    }

    .summary-cards {
      display: flex;
      gap: 25px;
      margin-top: 20px;
      flex-wrap: wrap;
    }

    .card {
      flex: 1;
      min-width: 200px;
      background-color: white;
      padding: 25px;
      border-radius: 10px;
      box-shadow: 0 4px 6px rgba(0,0,0,0.05);
      text-align: center;
      transition: transform 0.3s ease, box-shadow 0.3s ease;
      border-left: 4px solid #4e73df;
    }

    .card:hover {
      transform: translateY(-5px);
      box-shadow: 0 10px 15px rgba(0,0,0,0.1);
    }

    .card h2 {
      margin: 0;
      color: #4e73df;
      font-size: 36px;
      font-weight: 700;
      margin-bottom: 5px;
    }

    .card p {
      color: #6c757d;
      font-size: 16px;
      margin: 0;
    }

    @media (max-width: 768px) {
      .summary-cards {
        flex-direction: column;
      }
      
      .main-content.shifted {
        margin-left: 0;
      }
      
      .sidebar.active + .overlay {
        display: none;
      }
    }
  </style>
  <!-- Font Awesome for icons -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>

  <!-- Profile Icon -->
  <div class="profile-icon" onclick="toggleSidebar()">
    <img src="https://cdn-icons-png.flaticon.com/512/3135/3135715.png" alt="Profile">
  </div>

  <!-- Sidebar -->
  <div class="sidebar" id="sidebar">
   
    
    <div class="sidebar-item">
      <button class="sidebar-btn" onclick="toggleDropdown(this)">
        <span><i class="fas fa-users"></i> Students</span>
        <i class="fas fa-chevron-right chevron"></i>
      </button>
      <div class="dropdown-menu">
        <a href="fetchStudents"><i class="fas fa-list"></i> All Students</a>
         <a href="studentsPerformance"><i class="fas fa-chart-pie"></i> Performance</a>
      </div>
    </div>
    
    
    <div class="sidebar-item">
      <button class="sidebar-btn" onclick="toggleDropdown(this)">
        <span><i class="fas fa-chalkboard-teacher"></i> Teachers</span>
        <i class="fas fa-chevron-right chevron"></i>
      </button>
      <div class="dropdown-menu">
        <a href="fetchAllTeacher"><i class="fas fa-list"></i> All Teachers</a>
        <a href="addFac"><i class="fas fa-user-plus"></i> Add Teacher</a>
        <a href="removeFac"><i class="fas fa-tasks"></i> Remove Teacher</a>
      </div>
    </div>
    <form action="logout">
    <div class="sidebar-item">
      <button class="sidebar-btn">
        <span><i class="fas fa-sign-out-alt"></i> Logout</span>
      </button>
    </div>
    </form>
  </div>

  <!-- Optional overlay for sidebar click-out -->
  <div class="overlay" id="overlay" onclick="toggleSidebar()"></div>

  <!-- Main Content -->
  <div class="main-content" id="main">
    <div class="topbar">
      <h1>Admin Dashboard</h1>
      <p>Welcome, Admin</p>
    </div>

  
   
    <div class="summary-cards">
      <div class="card">
    <h2>${studentCount}</h2>
    <p>Registered Students</p>
</div>
<div class="card">
    <h2>${teacherCount}</h2>
    <p>Registered Teachers</p>
</div>


      
      <div class="card">
        <h2>45</h2>
        <p>Active Quizzes</p>
      </div>
      
    </div>
  </div>

  <!-- JavaScript -->
  <script>
    function toggleSidebar() {
      const sidebar = document.getElementById("sidebar");
      const overlay = document.getElementById("overlay");
      const main = document.getElementById("main");

      sidebar.classList.toggle("active");
      overlay.classList.toggle("active");
      main.classList.toggle("shifted");
    }

    function toggleDropdown(button) {
      // Get the dropdown menu associated with this button
      const dropdown = button.parentElement.querySelector('.dropdown-menu');
      
      // Close all other dropdowns first
      document.querySelectorAll('.dropdown-menu').forEach(menu => {
        if (menu !== dropdown) {
          menu.classList.remove('active');
          // Also remove active class from their buttons
          menu.closest('.sidebar-item').querySelector('.sidebar-btn').classList.remove('active');
        }
      });
      
      // Toggle the clicked one
      button.classList.toggle('active');
      dropdown.classList.toggle('active');
    }
  </script>

</body>
</html>