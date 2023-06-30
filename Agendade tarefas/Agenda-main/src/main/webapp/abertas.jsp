<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Tarefa" %>

<!DOCTYPE html>
<html>
<head>
    <title>Sua lista de tarefas</title>
       <link rel="stylesheet" type="text/css" href="abertas.css">
</head>
<body>
    <nav id="navigation">
        <div class="wrapper">
            <a class="nome">
                <%=request.getSession().getAttribute("username")%>
            </a>

            <div class="menu">
                <ul>
                    <li><a href="TodasServlet" alt="All">Todas</a></li>
                    <li><a href="#" alt="Open">Abertas</a></li>
                    <li><a href="CompletasServlet" alt="Completed">Completas</a></li>
                </ul>
            </div>
        </div>
    </nav>
    <h1>Agenda de tarefas</h1>

    <%
    List<?> tasks = (List<?>) request.getAttribute("inProgressTasks");
    %>
    <div id="checklist">
        <%
        if (tasks == null || tasks.isEmpty()) {
        %>
            <p class="empty-tasks">Não há tarefas abertas.</p>
        <%
        } else {
        %>
            <table>
                <%
                for (Object task : tasks) {
                %>
                    <%
                    Tarefa taskItem = (Tarefa) task;
                    %>
                    <tr>
                        <td>
                            <div class="task-item">
                                <div class="task-content">
                                    <input type="checkbox" id="task<%= tasks.indexOf(task) %>" <% if (taskItem.getStatus().equals("completed")) { out.print("checked"); } %>>
                                    <label for="task<%= tasks.indexOf(task) %>">
                                        <strong>Título: <%= taskItem.getTitle() %></strong>
                                    </label>
                                    <br>
                                    <p class="description">Descrição: <%= taskItem.getDescription() %></p>
                                    <div class="meta">
                                        <p>Criada em: <%= taskItem.getCreationDate() %> </p>
                                    </div>
                                    <% if (taskItem.getCompletionDate() != null) { %>
                                        <p>Finalizado: <%= taskItem.getCompletionDate() %> </p>
                                    <% } %>
                                </div>
                                <div class="task-actions">
                                    <form action="TodasServlet" method="POST">
                                        <input type="hidden" name="taskId" value="<%= taskItem.getId()%>">
                                        <input type="hidden" name="action" value="remove">
                                        <button class="remove-button" type="submit">REMOVER</button>
                                    </form>
                                    <form action="EditarServlet" method="GET">
                                        <input type="hidden" name="taskId" value="<%= taskItem.getId()%>">
                                        <button class="edit-button" type="submit">Gerenciar tarefa</button>
                                    </form>
                                </div>
                            </div>
                        </td>
                    </tr>
                <% } %>
            </table>
        <% } %>

        <div class="add-task">
            <form action="TodasServlet" method="POST" >
                <input type="text" name="title" placeholder="Tarefa" required>
                <br>
                <input type="text" name="description" placeholder="Descrição" required>
                <br>
                <button type="submit">Criar Tarefa</button>
            </form>
        </div>
    </div>
</body>
</html>
