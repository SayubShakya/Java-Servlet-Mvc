<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
  <title>Update User</title>
  <style>
    .form-container {
      max-width: 500px;
      margin: 20px auto;
      padding: 20px;
      border: 1px solid #ddd;
      border-radius: 5px;
    }
    .form-group {
      margin-bottom: 15px;
    }
    label {
      display: block;
      margin-bottom: 5px;
      font-weight: bold;
    }
    input[type="text"],
    input[type="email"],
    input[type="password"] {
      width: 100%;
      padding: 8px;
      border: 1px solid #ddd;
      border-radius: 4px;
      box-sizing: border-box;
    }
    .btn {
      background-color: #4CAF50;
      color: white;
      padding: 10px 15px;
      border: none;
      border-radius: 4px;
      cursor: pointer;
    }
    .btn:hover {
      background-color: #45a049;
    }
    .message {
      margin: 15px 0;
      padding: 10px;
      border-radius: 4px;
    }
    .success {
      background-color: #dff0d8;
      color: #3c763d;
    }
  </style>
</head>
<body>
<div class="form-container">
  <h2>Update User</h2>

  <c:if test="${not empty successMessage}">
    <div class="message success">
        ${successMessage}
    </div>
  </c:if>

  <form action="${pageContext.request.contextPath}/users/update/${user.id}" method="post">
    <div class="form-group">
      <label for="firstName">First Name:</label>
      <input type="text" id="firstName" name="firstName" value="${user.firstName}" required>
    </div>

    <div class="form-group">
      <label for="lastName">Last Name:</label>
      <input type="text" id="lastName" name="lastName" value="${user.lastName}" required>
    </div>

    <div class="form-group">
      <label for="email">Email:</label>
      <input type="email" id="email" name="email" value="${user.email}" required>
    </div>

    <div class="form-group">
      <label for="phoneNumber">Phone Number:</label>
      <input type="text" id="phoneNumber" name="phoneNumber" value="${user.phoneNumber}">
    </div>

    <button type="submit" class="btn">Update User</button>

    <br><br>
    <a href="${pageContext.request.contextPath}/users">Back to Users List</a>
  </form>
</div>
</body>
</html>