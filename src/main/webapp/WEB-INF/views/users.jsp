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
            --danger: #f72585;
            --border-radius: 8px;
            --shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f5f7fa;
            padding: 2rem;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
        }

        .header h2 {
            color: #333;
            font-size: 1.8rem;
            font-weight: 600;
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
        }

        .delete-btn:hover {
            background-color: rgba(247, 37, 133, 0.2);
        }

        .empty-state {
            text-align: center;
            padding: 3rem;
            color: #777;
        }

        .empty-state i {
            font-size: 2.5rem;
            margin-bottom: 1rem;
            color: #ccc;
        }

        .action-buttons {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 1rem;
        }

        .dashboard-btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 0.7rem 1.3rem;
            background-color: #6c757d;
            color: white;
            text-decoration: none;
            border-radius: var(--border-radius);
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .dashboard-btn:hover {
            background-color: #5a6268;
            transform: translateY(-2px);
            box-shadow: var(--shadow);
        }
    </style>
</head>
<body>
<div class="container">
    <div class="header">
        <h2><i class="fas fa-users"></i> Users Management</h2>
        <a href="${pageContext.request.contextPath}/users/new" class="add-user-btn">
            <i class="fas fa-plus"></i> Add New User
        </a>
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
                            <a class="action-btn edit-btn" href="${pageContext.request.contextPath}/users/update/${user.id}">
                                <i class="fas fa-edit"></i> Edit
                            </a>
                            <a class="action-btn delete-btn" href="${pageContext.request.contextPath}/users/delete/${user.id}">
                                <i class="fas fa-trash-alt"></i> Delete
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
</body>
</html>