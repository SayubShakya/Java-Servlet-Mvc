<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
  <title>Update User</title>
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
      display: flex;
      justify-content: center;
      align-items: center;
    }

    .form-container {
      background: white;
      border-radius: var(--border-radius);
      box-shadow: var(--shadow);
      padding: 2.5rem;
      max-width: 600px;
      width: 100%;
    }

    .form-header {
      text-align: center;
      margin-bottom: 2rem;
    }

    .form-header h2 {
      color: var(--primary);
      font-size: 1.8rem;
      margin-bottom: 0.5rem;
    }

    .form-group {
      margin-bottom: 1.5rem;
    }

    label {
      display: block;
      margin-bottom: 0.5rem;
      font-weight: 500;
      color: #555;
    }

    input[type="text"],
    input[type="email"],
    input[type="password"] {
      width: 100%;
      padding: 0.8rem 1rem;
      border: 1px solid #ddd;
      border-radius: var(--border-radius);
      font-family: inherit;
      font-size: 1rem;
      transition: all 0.3s ease;
    }

    input[type="text"]:focus,
    input[type="email"]:focus,
    input[type="password"]:focus {
      border-color: var(--primary);
      outline: none;
      box-shadow: 0 0 0 3px rgba(67, 97, 238, 0.2);
    }

    .btn {
      background-color: var(--primary);
      color: white;
      padding: 0.8rem 1.5rem;
      border: none;
      border-radius: var(--border-radius);
      font-family: inherit;
      font-size: 1rem;
      font-weight: 500;
      cursor: pointer;
      transition: all 0.3s ease;
      width: 100%;
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 8px;
    }

    .btn:hover {
      background-color: #3a56d4;
      transform: translateY(-2px);
    }

    .message {
      padding: 1rem;
      border-radius: var(--border-radius);
      margin-bottom: 1.5rem;
      display: flex;
      align-items: center;
      gap: 10px;
    }

    .success {
      background-color: rgba(76, 201, 240, 0.1);
      color: #0e7c86;
      border-left: 4px solid var(--success);
    }

    .back-link {
      display: inline-flex;
      align-items: center;
      gap: 6px;
      color: var(--primary);
      text-decoration: none;
      margin-top: 1.5rem;
      font-weight: 500;
      transition: all 0.3s ease;
    }

    .back-link:hover {
      color: #3a56d4;
      transform: translateX(-3px);
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
      .sidebar a.active {
        background-color: #e6f0ff;
        color: var(--primary);
        font-weight: 500;
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
       class="${pageContext.request.requestURI.endsWith('/profile') ? 'active' : ''}">
      <i class="fas fa-user-circle"></i> Profile
    </a>
    <a href="${pageContext.request.contextPath}/users"
       class="${pageContext.request.requestURI.endsWith('/users') ? 'active' : ''}">
      <i class="fas fa-users"></i> Users
    </a>
    <a href="${pageContext.request.contextPath}/logout">
      <i class="fas fa-sign-out-alt"></i> Logout
    </a>
  </div>

  <div class="main">
    <div class="form-container">
      <div class="form-header">
        <h2><i class="fas fa-user-edit"></i> Update User</h2>
      </div>

      <c:if test="${not empty successMessage}">
        <div class="message success">
          <i class="fas fa-check-circle"></i> ${successMessage}
        </div>
      </c:if>

      <form action="${pageContext.request.contextPath}/users/update/${user.id}" method="post">
        <div class="form-group">
          <label for="firstName">First Name</label>
          <input type="text" id="firstName" name="firstName" value="${user.firstName}" required>
        </div>

        <div class="form-group">
          <label for="lastName">Last Name</label>
          <input type="text" id="lastName" name="lastName" value="${user.lastName}" required>
        </div>

        <div class="form-group">
          <label for="email">Email</label>
          <input type="email" id="email" name="email" value="${user.email}" required>
        </div>

        <div class="form-group">
          <label for="phoneNumber">Phone Number</label>
          <input type="text" id="phoneNumber" name="phoneNumber" value="${user.phoneNumber}">
        </div>

        <button type="submit" class="btn">
          <i class="fas fa-save"></i> Update User
        </button>

        <a href="${pageContext.request.contextPath}/users" class="back-link">
          <i class="fas fa-arrow-left"></i> Back to Users List
        </a>
      </form>
    </div>
  </div>
</div>

<script>
  function toggleSidebar() {
    const sidebar = document.getElementById('sidebar');
    sidebar.classList.toggle('active');
  }
</script>

</body>
</html>