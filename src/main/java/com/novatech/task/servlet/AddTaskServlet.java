package com.novatech.task.servlet;

import com.novatech.task.dao.TaskDAO;
import com.novatech.task.model.Task;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.time.LocalDate;

@WebServlet("/add-task")
public class AddTaskServlet extends HttpServlet {
    private TaskDAO taskDAO;

    @Override
    public void init() throws ServletException {
        taskDAO = new TaskDAO();
    }

    @Override
    protected  void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/add-task.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Read form data
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        LocalDate dueDate = LocalDate.parse(request.getParameter("dueDate"));
        String status = request.getParameter("status");

        Task task = new Task();
        task.setTitle(title);
        task.setDescription(description);
        task.setDueDate(dueDate);
        task.setStatus(status);

        taskDAO.insertTask(task);

        response.sendRedirect("tasks");
    }
}
