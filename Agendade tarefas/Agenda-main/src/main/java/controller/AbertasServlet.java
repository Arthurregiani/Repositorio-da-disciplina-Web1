package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.TarefaDAO;
import model.Tarefa;

public class AbertasServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public AbertasServlet() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = (String) request.getSession().getAttribute("username");
        List<Tarefa> tarefasAbertas = TarefaDAO.getInProgressTasksByUsername(username);

        request.setAttribute("inProgressTasks", tarefasAbertas);
        request.getRequestDispatcher("abertas.jsp").forward(request, response);

        for (Tarefa tarefa : tarefasAbertas) {
            System.out.println(tarefa.getTitle());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
