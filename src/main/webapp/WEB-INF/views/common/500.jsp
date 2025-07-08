<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>500 - Server Error</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            background-color: #f8f8f8;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            color: #333;
        }

        .error-container {
            text-align: center;
            padding: 2rem;
            background-color: #fff;
            border-radius: 12px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
            max-width: 500px;
        }

        .error-container h1 {
            font-size: 5rem;
            margin: 0;
            color: #dc3545;
        }

        .error-container h2 {
            margin: 0.5rem 0;
            font-size: 1.8rem;
        }

        .error-container p {
            font-size: 1rem;
            color: #666;
            margin: 1rem 0 2rem;
        }

        .error-container a {
            text-decoration: none;
            background-color: #007BFF;
            color: white;
            padding: 0.6rem 1.2rem;
            border-radius: 6px;
            transition: background-color 0.3s;
        }

        .error-container a:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
<div class="error-container">
    <h1>500</h1>
    <h2>Internal Server Error</h2>
    <p>Something went wrong on our end.<br>Please try again later.</p>
    <a href="/">Back to Home</a>
</div>
</body>
</html>
