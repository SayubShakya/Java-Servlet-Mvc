<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>User Profile</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
  <style>
    :root {
      --primary: #4361ee;
      --primary-light: #4895ef;
      --secondary: #3f37c9;
      --dark: #1b263b;
      --light: #f8f9fa;
      --success: #4cc9f0;
      --danger: #f72585;
      --warning: #f8961e;
      --info: #560bad;
      --border-radius: 8px;
      --shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
      --transition: all 0.3s ease;
    }

    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    body {
      font-family: 'Poppins', sans-serif;
      background-color: #f5f7fa;
      color: #333;
      line-height: 1.6;
      display: flex;
      flex-direction: column;
      min-height: 100vh;
    }

    .navbar {
      width: 100%;
      background: linear-gradient(135deg, var(--primary), var(--secondary));
      color: white;
      padding: 1rem 2rem;
      display: flex;
      justify-content: space-between;
      align-items: center;
      box-shadow: var(--shadow);
      position: relative;
      z-index: 10;
    }

    .user-info {
      display: flex;
      align-items: center;
      gap: 10px;
    }

    .user-info i {
      font-size: 1.2rem;
    }

    .container {
      display: flex;
      flex: 1;
    }

    .sidebar {
      width: 260px;
      background: white;
      box-shadow: 2px 0 10px rgba(0, 0, 0, 0.05);
      flex-shrink: 0;
      display: flex;
      flex-direction: column;
      padding: 2rem 0;
      transition: var(--transition);
    }

    .sidebar-header {
      padding: 0 1.5rem 1.5rem;
      border-bottom: 1px solid #eee;
      margin-bottom: 1rem;
    }

    .sidebar h2 {
      color: var(--primary);
      font-size: 1.5rem;
      font-weight: 600;
    }

    .sidebar a {
      padding: 0.8rem 1.5rem;
      color: #555;
      text-decoration: none;
      display: flex;
      align-items: center;
      gap: 12px;
      transition: var(--transition);
      margin: 0.2rem 1rem;
      border-radius: var(--border-radius);
    }

    .sidebar a i {
      width: 24px;
      text-align: center;
    }

    .sidebar a:hover {
      background-color: #f0f4ff;
      color: var(--primary);
      transform: translateX(5px);
    }

    .sidebar a.active {
      background-color: #e6f0ff;
      color: var(--primary);
      font-weight: 500;
    }

    .main {
      flex: 1;
      padding: 2rem;
      background-color: #f5f7fa;
    }

    .card {
      background: white;
      border-radius: var(--border-radius);
      box-shadow: var(--shadow);
      padding: 2rem;
      margin-bottom: 2rem;
    }

    .profile-card {
      max-width: 800px;
      margin: 0 auto;
    }

    .profile-header {
      margin-bottom: 2rem;
      text-align: center;
    }

    .profile-header h1 {
      color: var(--primary);
      font-size: 2rem;
      margin-bottom: 0.5rem;
    }

    .profile-details {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
      gap: 1.5rem;
    }

    .detail-item {
      margin-bottom: 1rem;
    }

    .label {
      font-weight: 600;
      color: var(--dark);
      display: block;
      margin-bottom: 0.3rem;
    }

    .value {
      padding: 0.8rem;
      background-color: var(--light);
      border-radius: var(--border-radius);
      display: block;
    }

    .btn {
      display: inline-block;
      padding: 0.8rem 1.5rem;
      background-color: var(--primary);
      color: white;
      text-decoration: none;
      border-radius: var(--border-radius);
      margin-top: 1.5rem;
      transition: var(--transition);
      border: none;
      cursor: pointer;
      font-size: 1rem;
      font-family: inherit;
    }

    .btn:hover {
      background-color: var(--secondary);
      transform: translateY(-2px);
    }

    .btn-danger {
      background-color: var(--danger);
      margin-left: 1rem;
    }

    .btn-danger:hover {
      background-color: #d11a66;
    }

    .action-buttons {
      display: flex;
      justify-content: center;
      margin-top: 2rem;
      flex-wrap: wrap;
      gap: 1rem;
    }

    @media (max-width: 768px) {
      .sidebar {
        position: fixed;
        top: 0;
        left: -260px;
        height: 100vh;
        z-index: 100;
        background: white;
      }

      .sidebar.active {
        left: 0;
      }

      .container {
        flex-direction: column;
      }

      .main {
        padding: 1rem;
        margin-top: 70px;
      }

      .mobile-menu-btn {
        display: block;
        background: none;
        border: none;
        color: white;
        font-size: 1.5rem;
        cursor: pointer;
      }
      .sidebar a.active {
        background-color: #e6f0ff;
        color: var(--primary);
        font-weight: 500;
      }
      .profile-details {
        grid-template-columns: 1fr;
      }
    }

    @media (min-width: 769px) {
      .mobile-menu-btn {
        display: none;
      }
    }
  </style>
</head>
<body>

<div class="navbar">
  <button class="mobile-menu-btn" onclick="toggleSidebar()">
    <i class="fas fa-bars"></i>
  </button>
  <div class="user-info">
    <i class="fas fa-user-circle"></i>
    <span>${sessionScope.loggedInUser.email}</span>
  </div>
</div>

<div class="container">
  <div class="sidebar" id="sidebar">
    <a href="${pageContext.request.contextPath}/dashboard"
       class="${pageContext.request.requestURI.endsWith('/dashboard.jsp') || pageContext.request.requestURI.endsWith('/dashboard') ? 'active' : ''}">
      <i class="fas fa-tachometer-alt"></i> Dashboard
    </a>
    <a href="${pageContext.request.contextPath}/profile"
       class="${pageContext.request.requestURI.endsWith('/profile') || pageContext.request.requestURI.contains('/profile') ? 'active' : ''}">
      <i class="fas fa-user-circle"></i> Profile
    </a>
    <a href="${pageContext.request.contextPath}/users"
       class="${pageContext.request.requestURI.endsWith('/users') || pageContext.request.requestURI.contains('/users/') ? 'active' : ''}">
      <i class="fas fa-users"></i> Users
    </a>
    <a href="${pageContext.request.contextPath}/logout">
      <i class="fas fa-sign-out-alt"></i> Logout
    </a>
  </div>

  <div class="main">
    <div class="card profile-card">
      <div class="profile-header">
        <h1><i class="fas fa-user-circle"></i> User Profile</h1>
      </div>

      <c:if test="${not empty sessionScope.currentUser}">
        <div class="profile-details">
          <div class="detail-item">
            <span class="label">First Name</span>
            <span class="value">${sessionScope.currentUser.firstName}</span>
          </div>
          <div class="detail-item">
            <span class="label">Last Name</span>
            <span class="value">${sessionScope.currentUser.lastName}</span>
          </div>
          <div class="detail-item">
            <span class="label">Email</span>
            <span class="value">${sessionScope.currentUser.email}</span>
          </div>
          <div class="detail-item">
            <span class="label">Phone Number</span>
            <span class="value">${sessionScope.currentUser.phoneNumber}</span>
          </div>
        </div>

        <div class="action-buttons">
          <a href="<c:url value='/users/update/${sessionScope.currentUser.id}'/>" class="btn">
            <i class="fas fa-edit"></i> Edit Profile
          </a>
        </div>
      </c:if>

      <c:if test="${empty sessionScope.currentUser}">
        <div class="alert">
          <p>No user data found. Please log in.</p>
        </div>
      </c:if>
    </div>
  </div>
</div>

<script>
  function toggleSidebar() {
    document.getElementById('sidebar').classList.toggle('active');
  }
</script>

</body>
</html>