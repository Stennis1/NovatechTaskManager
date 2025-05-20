package com.novatech.task.dao;

import com.novatech.task.model.Task;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TaskDAO {

    private final String URL = "jdbc:postgresql://localhost:5432/task_db";
    private final String USER = "stennis";
    private final String PASSWORD = "stennis12345";

    public TaskDAO() {
        try {
            Class.forName("org.postgresql.Driver");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    protected Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }

    public void insertTask(Task task) {
        String sql = "INSERT INTO task (title, description, due_date, status) VALUES (?, ?, ?, ?)";

        try (Connection connection = getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {

            stmt.setString(1, task.getTitle());
            stmt.setString(2, task.getDescription());
            stmt.setDate(3, Date.valueOf(task.getDueDate()));
            stmt.setString(4, task.getStatus());  // Fixed index

            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Task> getAllTasks() {
        List<Task> tasks = new ArrayList<>();
        String sql = "SELECT * FROM task ORDER BY due_date ASC";

        try (Connection connection = getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Task task = new Task();
                task.setId(rs.getInt("id"));
                task.setTitle(rs.getString("title"));
                task.setDescription(rs.getString("description"));
                task.setDueDate(rs.getDate("due_date").toLocalDate());
                task.setStatus(rs.getString("status"));

                tasks.add(task);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return tasks;
    }

    public Task getTaskById(int id) {
        Task task = null;
        String sql = "SELECT * FROM task WHERE id = ?"; // Fixed missing *

        try (Connection connection = getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                task = new Task();
                task.setId(rs.getInt("id"));
                task.setTitle(rs.getString("title"));
                task.setDescription(rs.getString("description"));
                task.setDueDate(rs.getDate("due_date").toLocalDate());
                task.setStatus(rs.getString("status"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return task;
    }

    public void updateTask(Task task) {
        String sql = "UPDATE task SET title = ?, description = ?, due_date = ?, status = ? WHERE id = ?";

        try (Connection connection = getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {

            stmt.setString(1, task.getTitle());
            stmt.setString(2, task.getDescription());
            stmt.setDate(3, Date.valueOf(task.getDueDate()));
            stmt.setString(4, task.getStatus());
            stmt.setInt(5, task.getId());

            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteTask(int id) {
        String sql = "DELETE FROM task WHERE id = ?";

        try (Connection connection = getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {

            stmt.setInt(1, id);
            stmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Task> getFilteredTasks(String statusFilter, String sortOrder) {
        List<Task> tasks = new ArrayList<>();

        StringBuilder sql = new StringBuilder("SELECT * FROM task");

        List<Object> parameters = new ArrayList<>();

        // Build WHERE clause if filtering
        if (statusFilter != null && !statusFilter.equalsIgnoreCase("All")) {
            sql.append(" WHERE status = ?");
            parameters.add(statusFilter);
        }

        // Append ORDER BY clause if sorting
        if (sortOrder != null) {
            if (sortOrder.equalsIgnoreCase("asc")) {
                sql.append(" ORDER BY due_date ASC");
            } else if (sortOrder.equalsIgnoreCase("desc")) {
                sql.append(" ORDER BY due_date DESC");
            }
        } else {
            sql.append(" ORDER BY due_date ASC"); // default sort
        }

        try (Connection connection = getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql.toString())) {

            // Bind parameters
            for (int i = 0; i < parameters.size(); i++) {
                stmt.setObject(i + 1, parameters.get(i));
            }

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Task task = new Task();
                task.setId(rs.getInt("id"));
                task.setTitle(rs.getString("title"));
                task.setDescription(rs.getString("description"));
                task.setDueDate(rs.getDate("due_date").toLocalDate());
                task.setStatus(rs.getString("status"));

                tasks.add(task);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return tasks;
    }

}
