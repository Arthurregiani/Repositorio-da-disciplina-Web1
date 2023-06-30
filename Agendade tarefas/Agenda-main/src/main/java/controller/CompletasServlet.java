package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.TarefaDAO;
import model.Tarefa;

public class CompletasServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public CompletasServlet() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = (String) request.getSession().getAttribute("username");
        List<Tarefa> tarefasCompletas = TarefaDAO.getCompletedTasksByUsername(username);

        request.setAttribute("completedTasks", tarefasCompletas);
        request.getRequestDispatcher("completas.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
