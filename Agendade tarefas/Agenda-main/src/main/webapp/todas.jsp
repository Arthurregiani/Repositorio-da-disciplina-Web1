<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Tarefa" %>
<!DOCTYPE html>
<html>
<head>
    <title>Lista de tarefas</title>
    <link rel="stylesheet" type="text/css" href="todas.css">
</head>
<body>
    <nav id="navigation">
        <div class="wrapper">
            <a class="username">
                <%=request.getSession().getAttribute("username")%>
            </a>

            <div class="menu">
                <ul>
                    <li><a href="#" alt="All">Todas</a></li>
                    <li><a href="AbertasServlet" alt="Open">Abertas</a></li>
                    <li><a href="CompletasServlet" alt="Completed">Completas</a></li>
                </ul>
            </div>
        </div>
    </nav>
    <h1>Agenda de tarefas</h1>

    <div class="clear-fix"><br></div>

    <%
    List<?> tasks = (List<?>) request.getAttribute("tasks");
    %>

    <div id="checklist" style="margin-top: <%=tasks.size() * 30%>px;">
        <%
        if (request.getAttribute("tasks") == null || ((List<?>) request.getAttribute("tasks")).isEmpty()) {
        %>
            <p class="empty-tasks">Não há nenhuma tarefa.</p>
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
                                        <strong>Tarefa: <%= taskItem.getTitle() %></strong>
                                    </label>
                                    <br>
                                    <p class="description">Descrição: <%= taskItem.getDescription() %></p>
                                    <div class="meta">
                                        <p>Gerado: <%= taskItem.getCreationDate() %> </p>
                                        <% if (taskItem.getCompletionDate() != null) { %>
                                            <p>Finalizado: <%= taskItem.getCompletionDate() %> </p>
                                        <% } %>
                                    </div>
                                </div>
                                <div class="task-actions">
                                    <form action="TodasServlet" method="POST" style="display: inline;">
                                        <input type="hidden" name="taskId" value="<%= taskItem.getId()%>">
                                        <input type="hidden" name="action" value="remove">
                                        <button class="remove-button" type="submit">Deletar</button>
                                    </form>
                                    <form action="EditarServlet" method="GET" style="display: inline;">
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
    <div class="group">
        <form action="SairServlet" method="POST" style="display: inline;">
            <button class="button type1" type="submit">
                <span class="btn-txt">Sair</span>
            </button>
        </form>
    </div>
</body>
</html>

