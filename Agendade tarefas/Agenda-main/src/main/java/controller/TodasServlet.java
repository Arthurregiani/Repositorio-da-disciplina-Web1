package controller;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.TarefaDAO;
import dao.UserDAO;
import model.Tarefa;

public class TodasServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public TodasServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String username = (String) session.getAttribute("username");
        List<Tarefa> tarefas = TarefaDAO.getTasksByUsername(username);

        request.setAttribute("tasks", tarefas);

        RequestDispatcher dispatcher = request.getRequestDispatcher("todas.jsp");
        dispatcher.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");

        if (action != null && action.equals("remove")) {
            String taskIdParam = request.getParameter("taskId");
            int tarefaID = Integer.parseInt(taskIdParam);
            TarefaDAO.removeTask(tarefaID);
        } else {
            String titulo = request.getParameter("title");
            String descricao = request.getParameter("description");
            String username = (String) session.getAttribute("username");
            String dataInicio = LocalDate.now().toString();
            int userId = UserDAO.getUserIdByUsername(username);
            Tarefa novaTarefa = new Tarefa(titulo, descricao, dataInicio, null, "incomplete", userId);
            int tarefaID = TarefaDAO.saveTask(novaTarefa);
            novaTarefa.setId(tarefaID);
        }

        response.sendRedirect("TodasServlet");
    }
}
