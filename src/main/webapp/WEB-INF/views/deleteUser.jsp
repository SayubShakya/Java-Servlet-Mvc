<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>User Deleted</title>
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

        .card {
            background: white;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow);
            padding: 2.5rem;
            max-width: 500px;
            width: 100%;
            text-align: center;
        }

        .icon {
            font-size: 3rem;
            color: var(--danger);
            margin-bottom: 1rem;
        }

        .title {
            font-size: 1.5rem;
            font-weight: 600;
            margin-bottom: 1.5rem;
            color: var(--danger);
        }

        .user-details {
            text-align: left;
            background: #f9f9f9;
            padding: 1.5rem;
            border-radius: var(--border-radius);
            margin: 1.5rem 0;
        }

        .user-details p {
            margin: 0.8rem 0;
            display: flex;
        }

        .user-details strong {
            min-width: 120px;
            display: inline-block;
            color: #555;
        }

        .back-btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 0.6rem 1.2rem;
            background-color: var(--primary);
            color: white;
            text-decoration: none;
            border-radius: var(--border-radius);
            transition: all 0.3s ease;
            margin-top: 1rem;
        }

        .back-btn:hover {
            background-color: #3a56d4;
            transform: translateY(-2px);
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
        <span>${sessionScope.email}</span>
    </div>
</div>

<div class="container">
    <div class="sidebar" id="sidebar">
        <div class="sidebar-header">
            <h2><i class="fas fa-tachometer-alt"></i> Dashboard</h2>
        </div>
        <a href="users">
            <i class="fas fa-users"></i> Users
        </a>
        <a href="logout">
            <i class="fas fa-sign-out-alt"></i> Logout
        </a>
    </div>

    <div class="main">
        <div class="card">
            <div class="icon">
                <i class="fas fa-trash-alt"></i>
            </div>
            <h1 class="title">User Deleted Successfully</h1>

            <div class="user-details">
                <p><strong>First Name:</strong> ${user.firstName}</p>
                <p><strong>Last Name:</strong> ${user.lastName}</p>
                <p><strong>Email:</strong> ${user.email}</p>
                <p><strong>Phone Number:</strong> ${user.phoneNumber}</p>
            </div>

            <a href="${pageContext.request.contextPath}/users" class="back-btn">
                <i class="fas fa-arrow-left"></i> Back to Users List
            </a>
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