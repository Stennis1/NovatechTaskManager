<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>NovaTech Task Manager</title>
    <style>
        /* Reset and base styles */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #f0f4f8, #d9e2ec);
            color: #102a43;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        header {
            background-color: #243b53;
            padding: 20px 0;
            text-align: center;
            color: #ffffff;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        header h1 {
            font-size: 2.5em;
            letter-spacing: 1px;
        }

        main {
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 40px 20px;
        }

        .card {
            background-color: #ffffff;
            padding: 30px 40px;
            border-radius: 12px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            max-width: 500px;
            width: 100%;
            text-align: center;
        }

        .card h2 {
            margin-bottom: 20px;
            font-size: 1.8em;
            color: #243b53;
        }

        .nav-links {
            display: flex;
            flex-direction: column;
            gap: 15px;
            margin-top: 20px;
        }

        .nav-links a {
            text-decoration: none;
            background-color: #3e4c59;
            color: #ffffff;
            padding: 12px 20px;
            border-radius: 8px;
            font-size: 1em;
            transition: background-color 0.3s ease;
        }

        .nav-links a:hover {
            background-color: #52606d;
        }

        footer {
            background-color: #f0f4f8;
            text-align: center;
            padding: 15px 0;
            font-size: 0.9em;
            color: #627d98;
        }

        @media (max-width: 600px) {
            .card {
                padding: 20px;
            }

            .nav-links a {
                font-size: 0.95em;
                padding: 10px 16px;
            }
        }
    </style>
</head>
<body>
<header>
    <h1>NovaTech Task Manager</h1>
</header>
<main>
    <div class="card">
        <h2>Welcome to Your Task Management Dashboard</h2>
        <p>Efficiently manage your tasks with ease and clarity.</p>
        <div class="nav-links">
            <a href="tasks">📋 View All Tasks</a>
            <a href="add-task">➕ Add New Task</a>
            <!-- Future enhancements -->
            <!-- <a href="filter-tasks">🔍 Filter Tasks</a>
            <a href="sort-tasks">🔃 Sort Tasks</a> -->
        </div>
    </div>
</main>
<footer>
    &copy; 2025 NovaTech. All rights reserved.
</footer>
</body>
</html>
