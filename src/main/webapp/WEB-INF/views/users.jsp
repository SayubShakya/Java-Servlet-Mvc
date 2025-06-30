<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Users List</title>
    <style>
        table {
            border-collapse: collapse;
            width: 100%;
            max-width: 900px;
            margin: 20px auto;
        }
        th, td {
            padding: 8px 12px;
            border: 1px solid #ccc;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
        tbody tr:hover {
            background-color: #f9f9f9;
        }
        .action-btn {
            margin-right: 8px;
            text-decoration: none;
            color: blue;
        }
        .delete-btn {
            color: red;
        }
    </style>
</head>
<body>

<h2 style="text-align:center;">Users List</h2>

<c:if test="${empty users}">
    <p style="text-align:center;">No users found.</p>
</c:if>

<c:if test="${not empty users}">
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
                    <a class="action-btn" href="edit-user?id=${user.id}">Edit</a>
                    <a class="action-btn delete-btn" href="delete-user?id=${user.id}" onclick="return confirm('Are you sure you want to delete this user?');">Delete</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</c:if>

</body>
</html>
