<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Add New Task</title>

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600&display=swap" rel="stylesheet" />

    <style>
        :root {
            --primary-color: #4b6cb7;
            --secondary-color: #182848;
            --accent-color: #f0ad4e;
            --danger-color: #d9534f;
            --bg-light: #f8f9fa;
            --bg-white: #ffffff;
            --text-dark: #2c3e50;
            --border-radius: 8px;
            --transition-fast: 0.2s ease-in-out;
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: 'Inter', sans-serif;
        }

        body {
            background-color: var(--bg-light);
            color: var(--text-dark);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        header {
            background: var(--secondary-color);
            color: var(--bg-white);
            padding: 20px;
            text-align: center;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        header h1 {
            font-weight: 600;
            letter-spacing: 1px;
        }

        .container {
            flex: 1;
            max-width: 600px;
            margin: 40px auto;
            background-color: var(--bg-white);
            border-radius: var(--border-radius);
            box-shadow: 0 4px 8px rgba(0,0,0,0.05);
            padding: 30px;
        }

        h2 {
            font-size: 1.8rem;
            margin-bottom: 20px;
            color: var(--secondary-color);
            text-align: center;
        }

        form {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }

        label {
            font-weight: 500;
            margin-bottom: 5px;
        }

        input[type="text"],
        input[type="date"],
        textarea,
        select {
            padding: 10px 12px;
            border: 1px solid #ced4da;
            border-radius: var(--border-radius);
            font-size: 1rem;
            color: var(--text-dark);
            transition: border-color var(--transition-fast);
        }

        input:focus,
        textarea:focus,
        select:focus {
            outline: none;
            border-color: var(--primary-color);
        }

        textarea {
            resize: vertical;
            min-height: 100px;
        }

        .btn-primary {
            background-color: var(--primary-color);
            color: var(--bg-white);
            border: none;
            padding: 12px;
            border-radius: var(--border-radius);
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: background-color var(--transition-fast);
        }
        .btn-primary:hover {
            background-color: var(--secondary-color);
        }

        .back-link {
            display: inline-block;
            margin-top: 20px;
            color: var(--accent-color);
            text-decoration: none;
            font-size: 0.95rem;
            transition: color var(--transition-fast);
        }
        .back-link:hover {
            color: var(--primary-color);
        }

        footer {
            text-align: center;
            padding: 15px 0;
            font-size: 0.9rem;
            color: #6c757d;
            background-color: var(--bg-white);
            border-top: 1px solid #eaeaea;
        }
    </style>
</head>
<body>
<header>
    <h1>NovaTech Task Manager</h1>
</header>

<div class="container">
    <h2>Add New Task</h2>
    <form action="add-task" method="post">
        <div>
            <label for="title">Title</label>
            <input type="text" id="title" name="title" placeholder="Enter task title" required />
        </div>

        <div>
            <label for="description">Description</label>
            <textarea id="description" name="description" placeholder="Describe your task…" required></textarea>
        </div>

        <div>
            <label for="dueDate">Due Date</label>
            <input type="date" id="dueDate" name="dueDate" required />
        </div>

        <div>
            <label for="status">Status</label>
            <select id="status" name="status" required>
                <option value="Pending" selected>Pending</option>
                <option value="Completed">Completed</option>
            </select>
        </div>

        <button type="submit" class="btn-primary">Create Task</button>
    </form>

    <a href="tasks" class="back-link">← Back to Task List</a>
</div>

<footer>
    &copy; 2025 NovaTech Solutions
</footer>
</body>
</html>
