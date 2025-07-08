<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f4f4f4;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
            padding: 1rem;
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
            width: 300px;
            height: 300px;
            margin-bottom: 1rem;
        }
        .register-box h2 {
            margin-bottom: 1.2rem;
            color: #333;
        }
        .register-box label {
            display: block;
            text-align: left;
            margin: 0.5rem 0 0.2rem;
            font-weight: bold;
            color: #555;
        }
        .register-box input, .register-box select {
            width: 100%;
            padding: 0.5rem;
            margin-bottom: 0.8rem;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
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
            margin-top: 1rem;
            font-size: 1rem;
        }
        .register-box button:hover {
            background-color: #45a049;
        }
        .error-message {
            color: red;
            margin-bottom: 1rem;
            padding: 0.5rem;
            background: #ffeeee;
            border-radius: 4px;
        }
        @media (max-width: 480px) {
            .register-box {
                width: 90%;
                padding: 1rem;
            }
            .register-box img {
                width: 200px;
                height: 200px;
            }
        }
    </style>
</head>
<body>
<form class="register-box" action="register" method="post">
    <img src="data:image/jpeg;base64,${requestScope.qr}" alt="QR Code">
    <h2>Register</h2>

    <c:if test="${not empty errorMessage}">
        <div class="error-message">
                ${errorMessage}
        </div>
    </c:if>

    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">

    <label for="firstName">First Name</label>
    <input type="text" id="firstName" name="firstName" placeholder="First Name" required>

    <label for="lastName">Last Name</label>
    <input type="text" id="lastName" name="lastName" placeholder="Last Name" required>

    <label for="email">Email</label>
    <input type="email" id="email" name="email" placeholder="Email" required>

    <label for="password">Password</label>
    <input type="password" id="password" name="password" placeholder="Password" required autocomplete="new-password">

    <label for="phoneNo">Phone Number</label>
    <input type="tel" id="phoneNo" name="phoneNo" placeholder="Phone Number" required pattern="[0-9]{10,15}">

    <label for="roleId">Role</label>
    <select id="roleId" name="roleId" required>
        <option value="">Select Role</option>
        <c:forEach items="${requestScope.roles}" var="role">
            <option value="${role.id}">${role.name}</option>
        </c:forEach>
    </select>

    <label for="totpCode">TOTP Code</label>
    <input type="text" id="totpCode" name="totpCode" placeholder="Enter 6-digit TOTP Code" required pattern="[0-9]{6}" title="6-digit code">

    <input type="hidden" name="secretKey" value="${requestScope.secretKey}">

    <button type="submit">Register</button>
</form>
</body>
</html>