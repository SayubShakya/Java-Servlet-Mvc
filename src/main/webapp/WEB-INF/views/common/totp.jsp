<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>OTP Verification</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
            background: #f0f0f0;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .otp-container {
            background: #fff;
            padding: 2rem 2.5rem;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
            width: 350px;
            text-align: center;
        }

        .otp-container h2 {
            color: #333;
            margin-bottom: 1.5rem;
        }

        .otp-boxes {
            display: flex;
            justify-content: space-between;
            gap: 0.5rem;
        }

        .otp-boxes input {
            width: 2.5rem;
            height: 2.5rem;
            text-align: center;
            font-size: 1.2rem;
            border: 1px solid #ccc;
            border-radius: 6px;
        }

        .otp-boxes input:focus {
            border-color: #007BFF;
            outline: none;
            box-shadow: 0 0 3px #007BFF;
        }

        .verify-btn {
            margin-top: 1.5rem;
            width: 100%;
            padding: 0.7rem;
            background-color: #007BFF;
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 1rem;
            cursor: pointer;
        }

        .verify-btn:hover {
            background-color: #0056b3;
        }

        .note {
            margin-top: 1rem;
            font-size: 0.9rem;
            color: #777;
        }
    </style>
</head>
<body>
<div class="otp-container">
    <h2>Enter OTP</h2>
    <form action="/totp" method="post" onsubmit="return gatherOTP()">
        <div class="otp-boxes">
            <input type="text" maxlength="1" oninput="moveNext(this, 'otp2')" id="otp1" required>
            <input type="text" maxlength="1" oninput="moveNext(this, 'otp3')" id="otp2" required>
            <input type="text" maxlength="1" oninput="moveNext(this, 'otp4')" id="otp3" required>
            <input type="text" maxlength="1" oninput="moveNext(this, 'otp5')" id="otp4" required>
            <input type="text" maxlength="1" oninput="moveNext(this, 'otp6')" id="otp5" required>
            <input type="text" maxlength="1" id="otp6" required>
        </div>
        <input type="hidden" name="totp" id="otp" />
        <input type="hidden" name="email" value="${sessionScope.email}" />
        <button type="submit" class="verify-btn">Verify</button>
    </form>
    <div class="note">
        Didn’t get the code? <a href="resendOtp">Resend</a>
    </div>
</div>

<script>
    // Autofocus on first input
    window.onload = function () {
        document.getElementById("otp1").focus();
    };

    // Move to next box if input filled, or back if backspace pressed on empty
    const inputs = document.querySelectorAll('.otp-boxes input');
    inputs.forEach((input, index) => {
        input.addEventListener('input', () => {
            if (input.value.length === 1 && index < inputs.length - 1) {
                inputs[index + 1].focus();
            }
        });

        input.addEventListener('keydown', (e) => {
            if (e.key === 'Backspace') {
                if (input.value === '' && index > 0) {
                    inputs[index - 1].focus();
                    inputs[index - 1].value = '';
                }
            }
        });
    });

    function gatherOTP() {
        const otp = Array.from(inputs).map(input => input.value).join('');
        document.getElementById("otp").value = otp;
        return true;
    }
</script>
</body>
</html>
