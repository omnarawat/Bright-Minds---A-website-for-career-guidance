<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Role Already Selected</title>
    <style>
        body {
            margin: 0;
            min-height: 100vh;
            display: grid;
            place-items: center;
            font-family: Arial, Helvetica, sans-serif;
            background: #f4f7fb;
            color: #172033;
        }

        .message {
            width: min(460px, calc(100% - 32px));
            padding: 28px;
            border: 1px solid #d9e2ec;
            border-radius: 8px;
            background: #ffffff;
            text-align: center;
            box-shadow: 0 18px 42px rgba(23, 32, 51, 0.09);
        }

        h1 {
            margin: 0 0 10px;
            font-size: 1.45rem;
        }

        p {
            margin: 0 0 18px;
            color: #637083;
            line-height: 1.5;
        }

        a {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            min-height: 40px;
            padding: 0 14px;
            border-radius: 8px;
            background: #0f766e;
            color: #ffffff;
            font-weight: 700;
            text-decoration: none;
        }
    </style>
</head>
<body>
    <main class="message">
        <h1>This email already has a role</h1>
        <p>The same email cannot be used as both Student and Mentor. Please login with a different email for a different role.</p>
        <a href="Logout">Use Different Email</a>
    </main>
</body>
</html>
