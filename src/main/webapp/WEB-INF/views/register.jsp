<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="https://jakarta.ee/xml/ns/jakartaee/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Register</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f4f4f4;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .register-box {
            background: white;
            padding: 2rem;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            width: 320px;
            text-align: center;
        }
        .register-box img {
            width: 80px;
            height: 80px;
            margin-bottom: 1rem;
        }
        .register-box h2 {
            margin-bottom: 1.2rem;
        }
        .register-box input {
            width: 100%;
            padding: 0.5rem;
            margin: 0.4rem 0;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        .register-box button {
            width: 100%;
            padding: 0.6rem;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
            font-weight: bold;
            cursor: pointer;
        }
        .register-box button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
<form class="register-box" action="register" method="post">
    <img src="data:image/jpeg;base64,${requestScope.qr}">
    <h2>Register</h2>
    <input type="text" name="firstName" placeholder="First Name" required>
    <input type="text" name="lastName" placeholder="Last Name" required>
    <input type="email" name="email" placeholder="Email" required>
    <input type="password" name="password" placeholder="Password" required>
    <input type="text" name="phoneNo" placeholder="Phone Number" required>
    <input type="text" name="totpCode" placeholder="Enter TOTP Code" required>
    <input type="text" hidden name="secretKey" value="${requestScope.secretKey}">
    <button type="submit">Register</button>
</form>
</body>
</html>
