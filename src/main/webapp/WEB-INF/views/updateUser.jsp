
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
  <title>Update User</title>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
  <style>
    :root {
      --primary: #4361ee;
      --success: #4cc9f0;
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

    .form-container {
      background: white;
      border-radius: var(--border-radius);
      box-shadow: var(--shadow);
      padding: 2.5rem;
      max-width: 600px;
      width: 100%;
    }

    .form-header {
      text-align: center;
      margin-bottom: 2rem;
    }

    .form-header h2 {
      color: var(--primary);
      font-size: 1.8rem;
      margin-bottom: 0.5rem;
    }

    .form-group {
      margin-bottom: 1.5rem;
    }

    label {
      display: block;
      margin-bottom: 0.5rem;
      font-weight: 500;
      color: #555;
    }

    input[type="text"],
    input[type="email"],
    input[type="password"] {
      width: 100%;
      padding: 0.8rem 1rem;
      border: 1px solid #ddd;
      border-radius: var(--border-radius);
      font-family: inherit;
      font-size: 1rem;
      transition: all 0.3s ease;
    }

    input[type="text"]:focus,
    input[type="email"]:focus,
    input[type="password"]:focus {
      border-color: var(--primary);
      outline: none;
      box-shadow: 0 0 0 3px rgba(67, 97, 238, 0.2);
    }

    .btn {
      background-color: var(--primary);
      color: white;
      padding: 0.8rem 1.5rem;
      border: none;
      border-radius: var(--border-radius);
      font-family: inherit;
      font-size: 1rem;
      font-weight: 500;
      cursor: pointer;
      transition: all 0.3s ease;
      width: 100%;
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 8px;
    }

    .btn:hover {
      background-color: #3a56d4;
      transform: translateY(-2px);
    }

    .message {
      padding: 1rem;
      border-radius: var(--border-radius);
      margin-bottom: 1.5rem;
      display: flex;
      align-items: center;
      gap: 10px;
    }

    .success {
      background-color: rgba(76, 201, 240, 0.1);
      color: #0e7c86;
      border-left: 4px solid var(--success);
    }

    .back-link {
      display: inline-flex;
      align-items: center;
      gap: 6px;
      color: var(--primary);
      text-decoration: none;
      margin-top: 1.5rem;
      font-weight: 500;
      transition: all 0.3s ease;
    }

    .back-link:hover {
      color: #3a56d4;
      transform: translateX(-3px);
    }
  </style>
</head>
<body>
<div class="form-container">
  <div class="form-header">
    <h2><i class="fas fa-user-edit"></i> Update User</h2>
  </div>

  <c:if test="${not empty successMessage}">
    <div class="message success">
      <i class="fas fa-check-circle"></i> ${successMessage}
    </div>
  </c:if>

  <form action="${pageContext.request.contextPath}/users/update/${user.id}" method="post">
    <div class="form-group">
      <label for="firstName">First Name</label>
      <input type="text" id="firstName" name="firstName" value="${user.firstName}" required>
    </div>

    <div class="form-group">
      <label for="lastName">Last Name</label>
      <input type="text" id="lastName" name="lastName" value="${user.lastName}" required>
    </div>

    <div class="form-group">
      <label for="email">Email</label>
      <input type="email" id="email" name="email" value="${user.email}" required>
    </div>

    <div class="form-group">
      <label for="phoneNumber">Phone Number</label>
      <input type="text" id="phoneNumber" name="phoneNumber" value="${user.phoneNumber}">
    </div>

    <button type="submit" class="btn">
      <i class="fas fa-save"></i> Update User
    </button>

    <a href="${pageContext.request.contextPath}/users" class="back-link">
      <i class="fas fa-arrow-left"></i> Back to Users List
    </a>
  </form>
</div>
</body>
</html>
