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
            --danger: #f72585;
            --border-radius: 8px;
            --shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f5f7fa;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 20px;
            margin: 0;
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
    </style>
</head>
<body>
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
</body>
</html>