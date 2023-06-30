package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.RequestDispatcher;

import dao.TarefaDAO;
import model.Tarefa;


public class EditarServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public EditarServlet() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String taskIdParam = request.getParameter("taskId");
        int tarefaID = Integer.parseInt(taskIdParam);
        System.out.println(tarefaID);

        Tarefa task = TarefaDAO.getTaskById(tarefaID);

        System.out.println(task.getCreationDate());
        request.setAttribute("task", task);

        RequestDispatcher dispatcher = request.getRequestDispatcher("editar.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String taskIdParam = request.getParameter("taskId");
        int tarefaID = Integer.parseInt(taskIdParam);

        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String creationDate = request.getParameter("creationDate");
        String completionDate = request.getParameter("completionDate");

        Tarefa tarefa = TarefaDAO.getTaskById(tarefaID);
        if (completionDate.isEmpty()) {
            completionDate = null;
        } else {
            tarefa.setStatus("completed");
        }
        tarefa.setTitle(title);
        tarefa.setDescription(description);
        tarefa.setCreationDate(creationDate);
        tarefa.setCompletionDate(completionDate);

        TarefaDAO.updateTask(tarefa);

        response.sendRedirect("TodasServlet");
    }
}
