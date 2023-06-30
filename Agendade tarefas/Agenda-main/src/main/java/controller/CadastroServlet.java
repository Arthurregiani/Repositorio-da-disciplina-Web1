package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.UserDAO;
import model.User;
import java.sql.SQLException;

public class CadastroServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public CadastroServlet() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.getWriter().append("Served at: ").append(request.getContextPath());
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("login");
        String email = request.getParameter("email");

        UserDAO userDAO = null;
        try {
            userDAO = new UserDAO();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        if (!userDAO.isUserExists(username, email)) {
            String senha = request.getParameter("password");
            String nome = request.getParameter("name");

            User newUser = new User(username, senha, nome, email);
            userDAO.insertUser(newUser);

            response.sendRedirect("login.jsp");
        } else {
            String errorMessage = "Nome de usuário ou e-mail já está em uso";
            request.setAttribute("errorMessage", errorMessage);
            request.getRequestDispatcher("cadastro.jsp").forward(request, response);
        }
    }
}
