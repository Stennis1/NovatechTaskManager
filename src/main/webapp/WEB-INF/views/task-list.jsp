<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.novatech.task.model.Task" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Task List</title>

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
            --table-header-bg: #e9ecef;
            --table-row-even: #fdfdfd;
            --table-row-odd: #f7f7f7;
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
            max-width: 900px;
            margin: 40px auto;
            background-color: var(--bg-white);
            border-radius: var(--border-radius);
            box-shadow: 0 4px 8px rgba(0,0,0,0.05);
            padding: 30px;
        }

        .top-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            gap: 10px;
        }

        .top-bar h2 {
            font-size: 1.8rem;
            color: var(--secondary-color);
            margin: 0;
        }

        .btn-add {
            background-color: var(--primary-color);
            color: var(--bg-white);
            border: none;
            padding: 10px 18px;
            border-radius: var(--border-radius);
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: background-color var(--transition-fast);
            text-decoration: none;
        }
        .btn-add:hover {
            background-color: var(--secondary-color);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }

        thead th {
            background-color: var(--table-header-bg);
            padding: 12px;
            text-align: left;
            font-weight: 600;
            border-bottom: 2px solid #dee2e6;
        }

        tbody tr:nth-child(even) {
            background-color: var(--table-row-even);
        }
        tbody tr:nth-child(odd) {
            background-color: var(--table-row-odd);
        }
        tbody tr:hover {
            background-color: #e2e6ea;
        }

        td {
            padding: 12px;
            border-bottom: 1px solid #dee2e6;
            vertical-align: middle;
        }

        .btn-action {
            color: var(--bg-white);
            padding: 6px 12px;
            border-radius: var(--border-radius);
            text-decoration: none;
            font-size: 0.9rem;
            margin-right: 5px;
            transition: background-color var(--transition-fast);
            border: none;
            cursor: pointer;
        }

        .edit-btn {
            background-color: var(--accent-color);
        }
        .edit-btn:hover {
            background-color: #e0a443;
        }

        .delete-btn {
            background-color: var(--danger-color);
        }
        .delete-btn:hover {
            background-color: #c9302c;
        }

        .delete-form {
            display: inline;
        }

        .no-tasks {
            text-align: center;
            padding: 30px 0;
            font-size: 1.1rem;
            color: #6c757d;
        }

        footer {
            text-align: center;
            padding: 15px 0;
            font-size: 0.9rem;
            color: #6c757d;
            background-color: var(--bg-white);
            border-top: 1px solid #eaeaea;
        }

        @media (max-width: 768px) {
            .top-bar {
                flex-direction: column;
                gap: 15px;
            }
            thead th, td {
                font-size: 0.9rem;
                padding: 10px;
            }
            .btn-add {
                width: 100%;
                text-align: center;
            }
        }
    </style>
</head>
<body>
<header>
    <h1>NovaTech Task Manager</h1>
</header>

<div class="container">
    <div class="top-bar">
        <h2>Task List</h2>
        <a href="add-task" class="btn-add">+ Add New Task</a>
    </div>

    <form method="get" action="tasks" class="filter-bar" style="margin-bottom: 20px; display: flex; gap: 20px; align-items: center; flex-wrap: wrap;">
        <label>
            <strong>Status:</strong>
            <select name="status" style="padding: 8px; border-radius: 6px; border: 1px solid #ccc;">
                <option value="All" <%= "All".equals(request.getParameter("status")) ? "selected" : "" %>>All</option>
                <option value="Pending" <%= "Pending".equals(request.getParameter("status")) ? "selected" : "" %>>Pending</option>
                <option value="Completed" <%= "Completed".equals(request.getParameter("status")) ? "selected" : "" %>>Completed</option>
            </select>
        </label>

        <label>
            <strong>Sort by Due Date:</strong>
            <select name="sortOrder" style="padding: 8px; border-radius: 6px; border: 1px solid #ccc;">
                <option value="asc" <%= "asc".equals(request.getParameter("sortOrder")) ? "selected" : "" %>>Ascending</option>
                <option value="desc" <%= "desc".equals(request.getParameter("sortOrder")) ? "selected" : "" %>>Descending</option>
            </select>
        </label>

        <label>
            <strong>Due Date From:</strong>
            <input type="date" name="dueDateFrom"
                   value="<%= request.getParameter("dueDateFrom") != null ? request.getParameter("dueDateFrom") : "" %>"
                   style="padding: 8px; border-radius: 6px; border: 1px solid #ccc;" />
        </label>

        <label>
            <strong>Due Date To:</strong>
            <input type="date" name="dueDateTo"
                   value="<%= request.getParameter("dueDateTo") != null ? request.getParameter("dueDateTo") : "" %>"
                   style="padding: 8px; border-radius: 6px; border: 1px solid #ccc;" />
        </label>

        <label>
            <strong>Search:</strong>
            <input type="text" name="keyword" placeholder="Search tasks..."
                   value="<%= request.getParameter("keyword") != null ? request.getParameter("keyword") : "" %>"
                   style="padding: 8px; border-radius: 6px; border: 1px solid #ccc;" />
        </label>

        <input type="submit" value="Apply Filters" style="padding: 8px 16px; background-color: var(--primary-color); color: white; border: none; border-radius: 6px; cursor: pointer;" />
        <a href="tasks" style="padding: 8px 16px; background-color: gray; color: white; border-radius: 6px; text-decoration: none;">Clear Filters</a>
    </form>

    <%
        List<Task> taskList = (List<Task>) request.getAttribute("taskList");
        if (taskList == null || taskList.isEmpty()) {
    %>
    <div class="no-tasks">No tasks available.</div>
    <%
    } else {
    %>
    <table>
        <thead>
        <tr>
            <th>Title</th>
            <th>Description</th>
            <th>Due Date</th>
            <th>Status</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <% for (Task task : taskList) { %>
        <tr>
            <td><%= task.getTitle() %></td>
            <td><%= task.getDescription() %></td>
            <td><%= task.getDueDate() %></td>
            <td><%= task.getStatus() %></td>
            <td>
                <a href="edit-task?id=<%= task.getId() %>" class="btn-action edit-btn">Edit</a>

                <form action="delete-task" method="post" class="delete-form"
                      onsubmit="return confirm('Are you sure you want to delete this task?');">
                    <input type="hidden" name="id" value="<%= task.getId() %>" />
                    <button type="submit" class="btn-action delete-btn">Delete</button>
                </form>
            </td>
        </tr>
        <% } %>
        </tbody>
    </table>
    <% } %>
</div>

<footer>
    &copy; 2025 NovaTech Solutions
</footer>
</body>
</html>
