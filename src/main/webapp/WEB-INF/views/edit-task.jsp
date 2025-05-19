<%--
  Created by IntelliJ IDEA.
  User: stennis
  Date: 5/19/25
  Time: 9:29 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.novatech.model.Task" %>
<%
    Task task = (Task) request.getAttribute("task");
    if (task == null) {
%>
<p>Task not found.</p>
<%
        return;
    }
%>
<html>
<head>
    <title>Edit Task</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 40px;
        }

        h1 {
            color: #333;
        }

        form {
            width: 400px;
        }

        label {
            display: block;
            margin-top: 10px;
        }

        input[type="text"], input[type="date"], textarea, select {
            width: 100%;
            padding: 8px;
            margin-top: 5px;
            box-sizing: border-box;
        }

        button {
            margin-top: 20px;
            padding: 8px 16px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        button:hover {
            background-color: #0056b3;
        }

        a {
            display: inline-block;
            margin-top: 15px;
            text-decoration: none;
            color: #007bff;
        }

        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<h1>Edit Task</h1>

<form action="edit-task" method="post">
    <input type="hidden" name="id" value="<%= task.getId() %>" />

    <label>Title:</label>
    <input type="text" name="title" value="<%= task.getTitle() %>" required>

    <label>Description:</label>
    <textarea name="description" rows="4" required><%= task.getDescription() %></textarea>

    <label>Due Date:</label>
    <input type="date" name="dueDate" value="<%= task.getDueDate() %>" required>

    <label>Status:</label>
    <select name="status" required>
        <option value="Pending" <%= task.getStatus().equals("Pending") ? "selected" : "" %>>Pending</option>
        <option value="Completed" <%= task.getStatus().equals("Completed") ? "selected" : "" %>>Completed</option>
    </select>

    <button type="submit">Update Task</button>
</form>

<a href="tasks">← Back to Task List</a>

</body>
</html>

