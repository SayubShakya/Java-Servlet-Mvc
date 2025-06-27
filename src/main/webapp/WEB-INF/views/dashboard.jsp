<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Dashboard</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f4f4f4;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        /* Top Navbar */
        .navbar {
            width: 100%;
            background-color: #1abc9c;
            color: white;
            padding: 15px 20px;
            text-align: right;
            font-size: 16px;
        }

        /* Layout container */
        .container {
            display: flex;
            flex: 1;
        }

        /* Sidebar */
        .sidebar {
            width: 220px;
            background-color: #2c3e50;
            color: #ecf0f1;
            flex-shrink: 0;
            display: flex;
            flex-direction: column;
            padding-top: 20px;
        }

        .sidebar h2 {
            text-align: center;
            margin-bottom: 30px;
        }

        .sidebar a {
            padding: 15px 20px;
            color: #ecf0f1;
            text-decoration: none;
            display: block;
            transition: background 0.3s;
        }

        .sidebar a:hover {
            background-color: #34495e;
        }

        /* Main content */
        .main {
            flex: 1;
            padding: 20px;
        }

        .main h1 {
            margin-bottom: 20px;
        }

        .card {
            background-color: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            margin-bottom: 20px;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .sidebar {
                display: none;
            }

            .container {
                flex-direction: column;
            }

            .main {
                padding: 10px;
            }
        }
    </style>
</head>
<body>

<div class="navbar">
    Hello, ${sessionScope.email}
</div>

<div class="container">
    <div class="sidebar">
        <h2>My Dashboard</h2>
        <a href="#">Dashboard</a>
        <a href="#">Profile</a>
        <a href="#">Settings</a>
        <a href="#">Messages</a>
        <a href="#">Logout</a>
    </div>

    <div class="main">
        <h1>Welcome, User!</h1>
        <div class="card">
            <h2>Overview</h2>
            <p>This is your main dashboard content. Add widgets, charts, or tables here.</p>
        </div>
        <div class="card">
            <h2>Recent Activity</h2>
            <p>Latest updates and activities go here.</p>
        </div>
    </div>
</div>

</body>
</html>
