<%--
  Created by IntelliJ IDEA.
  User: stennis
  Date: 5/19/25
  Time: 8:08 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.novatech.model.Task" %>
<%@ page import="java.util.List" %>
<html>
<head>
    <title>Task Management</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 40px;
        }

        h1 {
            color: #333;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        table, th, td {
            border: 1px solid #ccc;
        }

        th, td {
            padding: 10px;
            text-align: left;
        }

        a.button {
            display: inline-block;
            padding: 8px 16px;
            margin-top: 20px;
            background-color: #28a745;
            color: white;
            text-decoration: none;
            border-radius: 4px;
        }

        a.button:hover {
            background-color: #218838;
        }

        .btn-action {
            color: white;
            padding: 4px 8px;
            border-radius: 4px;
            text-decoration: none;
        }

        .edit-btn {
            background-color: #007bff;
        }

        .delete-btn {
            background-color: #dc3545;
        }

        .edit-btn:hover {
            background-color: #0056b3;
        }

        .delete-btn:hover {
            background-color: #c82333;
        }
    </style>
</head>
<body>

<h1>Task List</h1>

<a href="add-task.jsp" class="button">+ Add New Task</a>

<%
    List<Task> taskList = (List<Task>) request.getAttribute("taskList");
    if (taskList == null || taskList.isEmpty()) {
%>
<p>No tasks available.</p>
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
            <a href="delete-task?id=<%= task.getId() %>" class="btn-action delete-btn"
               onclick="return confirm('Are you sure you want to delete this task?');">Delete</a>
        </td>
    </tr>
    <td>
        <a href="edit-task?id=${task.id}">Edit</a> |
        <a href="delete-task?id=${task.id}" onclick="return confirm('Are you sure you want to delete this task?');">Delete</a>
    </td>

    <% } %>
    </tbody>
</table>
<% } %>

</body>
</html>
