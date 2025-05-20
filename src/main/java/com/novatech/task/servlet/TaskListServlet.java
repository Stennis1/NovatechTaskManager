package com.novatech.task.servlet;

import com.novatech.task.dao.TaskDAO;
import com.novatech.task.model.Task;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.time.LocalDate;
import java.util.*;
import java.util.stream.Collectors;

@WebServlet("/tasks")
public class TaskListServlet extends HttpServlet {
    private TaskDAO taskDAO;

    @Override
    public void init() throws ServletException {
        taskDAO = new TaskDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String statusFilter = request.getParameter("status");
        String sortOrder = request.getParameter("sortOrder");
        String dueDateFromStr = request.getParameter("dueDateFrom");
        String dueDateToStr = request.getParameter("dueDateTo");

        List<Task> taskList = taskDAO.getAllTasks();

        LocalDate dueDateFrom = null;
        LocalDate dueDateTo = null;

        // For validation messages
        String dateError = null;

        // Validate and parse dates
        try {
            if (dueDateFromStr != null && !dueDateFromStr.isEmpty()) {
                dueDateFrom = LocalDate.parse(dueDateFromStr);
            }
            if (dueDateToStr != null && !dueDateToStr.isEmpty()) {
                dueDateTo = LocalDate.parse(dueDateToStr);
            }

            if (dueDateFrom != null && dueDateTo != null && dueDateFrom.isAfter(dueDateTo)) {
                dateError = "'Due Date From' cannot be after 'Due Date To'.";
            }
        } catch (Exception e) {
            dateError = "Invalid date format. Please use YYYY-MM-DD.";
        }

        // If there's a date error, set the error message and skip filtering
        if (dateError != null) {
            request.setAttribute("dateError", dateError);
        } else {
            // Apply filters only if no error

            // Filter by status
            if (statusFilter != null && !statusFilter.equalsIgnoreCase("All")) {
                taskList = taskList.stream()
                        .filter(task -> statusFilter.equalsIgnoreCase(task.getStatus()))
                        .collect(Collectors.toList());
            }

            // Filter by due date range
            if (dueDateFrom != null) {
                LocalDate finalDueDateFrom = dueDateFrom;
                taskList = taskList.stream()
                        .filter(task -> !task.getDueDate().isBefore(finalDueDateFrom))
                        .collect(Collectors.toList());
            }

            if (dueDateTo != null) {
                LocalDate finalDueDateTo = dueDateTo;
                taskList = taskList.stream()
                        .filter(task -> !task.getDueDate().isAfter(finalDueDateTo))
                        .collect(Collectors.toList());
            }

            // Sort by due date
            if (sortOrder != null) {
                if (sortOrder.equalsIgnoreCase("asc")) {
                    taskList.sort(Comparator.comparing(Task::getDueDate));
                } else if (sortOrder.equalsIgnoreCase("desc")) {
                    taskList.sort(Comparator.comparing(Task::getDueDate).reversed());
                }
            }
        }

        request.setAttribute("taskList", taskList);

        request.getRequestDispatcher("/WEB-INF/views/task-list.jsp").forward(request, response);
    }
}