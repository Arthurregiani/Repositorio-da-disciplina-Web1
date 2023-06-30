<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Tarefa" %>

<!DOCTYPE html>
<html>
<head>
    <title>Agenda de tarefas</title>
    <link rel="stylesheet" type="text/css" href="completas.css">
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
                    <li><a href="AbertasServlet" alt="Open">Abertas</a></li>
                    <li><a href="#" alt="Completed">Completas</a></li>
                </ul>
            </div>
        </div>
    </nav>
    <h1>Agenda de tarefas</h1>

	<%
	List<?> tasks = (List<?>) request.getAttribute("completedTasks");
	%>
    <div id="checklist" style="margin-top: <%=tasks.size() * 85%>px;">
        <%
        if (tasks == null || tasks.isEmpty()) {
        %>
		    <p class="empty-tasks">Não há tarefas completas.</p>
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
		                                <strong>Title: <%= taskItem.getTitle() %></strong>
		                            </label>
		                            <br>
		                            <p class="description">Description: <%= taskItem.getDescription() %></p>
		                            <div class="meta">
		                                <p>Gerado: <%= taskItem.getCreationDate() %> </p>
		                            </div>
		                            <% if (taskItem.getCompletionDate() != null) { %>
		                                <p>Finalizado: <%= taskItem.getCompletionDate() %> </p>
		                            <% } %>
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

        <!-- Adicione o formulário para adicionar novas tarefas -->
        <form class="add-task" action="adicionar-tarefa.jsp" method="POST">
    <div>
        <input type="text" name="name" id="task" placeholder="Nome da tarefa" required>
    </div>
    <div>
        <input type="text" name="description" id="description" placeholder="Descrição da tarefa">
    </div>
    <button type="submit">Adicionar Tarefa</button>
</form>
    </div>
</body>
</html>
