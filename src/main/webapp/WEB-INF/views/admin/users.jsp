<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Users List</title>
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
            flex-direction: column;
            align-items: center;
        }

        .header {
            display: flex;
            flex-direction: column;
            align-items: center;
            margin-bottom: 2rem;
            width: 100%;
            text-align: center;
        }

        .header h2 {
            color: #333;
            font-size: 1.8rem;
            font-weight: 600;
            margin-bottom: 1rem;
        }

        .add-user-btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 0.7rem 1.3rem;
            background-color: var(--primary);
            color: white;
            text-decoration: none;
            border-radius: var(--border-radius);
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .add-user-btn:hover {
            background-color: #3a56d4;
            transform: translateY(-2px);
            box-shadow: var(--shadow);
        }

        .table-container {
            background: white;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow);
            overflow: hidden;
            margin-bottom: 1.5rem;
            width: 100%;
            max-width: 1200px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            padding: 1rem 1.5rem;
            text-align: left;
        }

        th {
            background-color: #f8f9fa;
            font-weight: 600;
            color: #555;
            text-transform: uppercase;
            font-size: 0.8rem;
            letter-spacing: 0.5px;
        }

        tr:not(:last-child) {
            border-bottom: 1px solid #eee;
        }

        tr:hover {
            background-color: #f8f9fa;
        }

        .action-btn {
            display: inline-flex;
            align-items: center;
            gap: 5px;
            padding: 0.4rem 0.8rem;
            border-radius: 4px;
            text-decoration: none;
            font-size: 0.9rem;
            transition: all 0.3s ease;
        }
        .edit-btn {
            background-color: rgba(67, 97, 238, 0.1);
            color: var(--primary);
        }
        .edit-btn:hover {
            background-color: rgba(67, 97, 238, 0.2);
        }
        .delete-btn {
            background-color: rgba(247, 37, 133, 0.1);
            color: var(--danger);
            border: none;
            background: none;
            cursor: pointer;
            padding: 0.4rem 0.8rem;
            font-size: 0.9rem;
            border-radius: 4px;
            display: inline-flex;
            align-items: center;
            gap: 5px;
            transition: all 0.3s ease;
        }
        .delete-btn:hover {
            background-color: rgba(247, 37, 133, 0.2);
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
           class="${pageContext.request.requestURI.endsWith('/dashboard.jsp') || pageContext.request.requestURI.endsWith('/dashboard') ? 'active' : ''}">
            <i class="fas fa-tachometer-alt"></i> Dashboard
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
        <div class="header">
            <h2><i class="fas fa-users"></i> Users Management</h2>
        </div>

        <c:if test="${empty users}">
            <div class="table-container empty-state">
                <i class="fas fa-user-slash"></i>
                <h3>No Users Found</h3>
                <p>There are currently no users in the system.</p>
            </div>
        </c:if>

        <c:if test="${not empty users}">
            <div class="table-container">
                <table>
                    <thead>
                    <tr>
                        <th>First Name</th>
                        <th>Last Name</th>
                        <th>Phone Number</th>
                        <th>Email</th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="user" items="${users}">
                        <tr>
                            <td>${user.firstName}</td>
                            <td>${user.lastName}</td>
                            <td>${user.phoneNumber}</td>
                            <td>${user.email}</td>
                            <td>
                                <a class="action-btn edit-btn" href="${pageContext.request.contextPath}/users/edit/${user.id}">
                                    <i class="fas fa-edit"></i> Edit
                                </a>
                                <a class="action-btn edit-btn" href="/users/delete/${user.id}">
                                    <i class="fas fa-edit"></i> Delete
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:if>

        <div class="action-buttons">
            <a href="${pageContext.request.contextPath}/dashboard" class="dashboard-btn">
                <i class="fas fa-arrow-left"></i> Back to Dashboard
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