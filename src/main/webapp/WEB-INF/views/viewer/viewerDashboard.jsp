<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Viewer Dashboard</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        /* Same CSS as Admin Dashboard */
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

        .welcome-card {
            background: linear-gradient(135deg, var(--primary-light), var(--primary));
            color: white;
            text-align: center;
            padding: 3rem 2rem;
        }

        .welcome-card h1 {
            font-size: 2.5rem;
            margin-bottom: 1rem;
            font-weight: 600;
        }

        .welcome-card p {
            font-size: 1.1rem;
            opacity: 0.9;
            max-width: 600px;
            margin: 0 auto;
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
        <span>${user.email}</span>
    </div>
</div>

<div class="container">
    <div class="sidebar" id="sidebar">
        <a href="${pageContext.request.contextPath}/dashboard"
           class="${pageContext.request.requestURI.endsWith('/dashboard') ? 'active' : ''}">
            <i class="fas fa-tachometer-alt"></i> Dashboard
        </a>
        <a href="${pageContext.request.contextPath}/profile"
           class="${pageContext.request.requestURI.contains('/profile') ? 'active' : ''}">
            <i class="fas fa-user-circle"></i> Profile
        </a>
        <a href="${pageContext.request.contextPath}/logout">
            <i class="fas fa-sign-out-alt"></i> Logout
        </a>
    </div>

    <div class="main">
        <div class="card welcome-card">
            <h1>Welcome to Viewer Dashboard</h1>
            <p>View reports and analytics from this control panel</p>
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