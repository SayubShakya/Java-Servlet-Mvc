<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>User Deleted</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            padding: 50px;
        }
        .message {
            color: red;
            font-size: 20px;
            margin-bottom: 20px;
        }
        .user-details {
            display: inline-block;
            text-align: left;
            border: 1px solid #ccc;
            padding: 20px;
            border-radius: 8px;
        }
        .user-details p {
            margin: 8px 0;
        }
        a {
            color: blue;
            text-decoration: none;
        }
        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<div class="message">User has been successfully deleted.</div>

<div class="user-details">
    <p><strong>First Name:</strong> ${user.firstName}</p>
    <p><strong>Last Name:</strong> ${user.lastName}</p>
    <p><strong>Email:</strong> ${user.email}</p>
    <p><strong>Phone Number:</strong> ${user.phoneNumber}</p>
</div>

<br><br>
<a href="${pageContext.request.contextPath}/users">Back to Users List</a>

</body>
</html>
