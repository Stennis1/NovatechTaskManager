package com.novatech.servlet;

import com.novatech.dao.TaskDAO;
import com.novatech.model.Task;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

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

        List<Task> taskList = taskDAO.getAllTasks();
        request.setAttribute("taskList", taskList);

        request.getRequestDispatcher("/WEB-INF/views/task-list.jsp").forward(request, response);
    }
}
