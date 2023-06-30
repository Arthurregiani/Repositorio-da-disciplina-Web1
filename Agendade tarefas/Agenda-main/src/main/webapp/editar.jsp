<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.Tarefa" %>
<!DOCTYPE html>
<html>
<head>
    <title>Agenda de tarefas</title>
    <link rel="stylesheet" type="text/css" href="editar.css">
</head>
<body>
    <nav id="navigation">
        <div class="wrapper">
            <a class="nome">
                <%=request.getSession().getAttribute("username")%>
            </a>

            <div class="menu">
                <ul>
                    <li><a href="#" alt="TodasServlet">Todas</a></li>
                    <li><a href="#" alt="AbertasServlet">Abertas</a></li>
                    <li><a href="#" alt="CompletasServlet">Finalizadas</a></li>
                </ul>
            </div>
        </div>
    </nav>
    <h1>Agenda de tarefas</h1>

    <%
    Tarefa task = (Tarefa) request.getAttribute("task");
    %>
    <div id="yena">
        <form action="EditarServlet" method="POST">
            <input type="hidden" name="taskId" value="<%= task.getId() %>" />
            <div class="form-group">
                <label for="title">Tarefa</label>
                <input type="text" id="title" name="title" value="<%= task.getTitle() %>" required />
            </div>
            <div class="form-group">
                <label for="description">Descrição</label>
                <textarea id="description" name="description" required><%= task.getDescription() %></textarea>
            </div>
            <div class="form-group">
                <label for="creationDate">Data de inicio</label>
                <input type="date" id="completionDate" name="creationDate" value="<%= task.getCreationDate() %>" required />
            </div>
            <div class="form-group">
                <label for="completionDate">Data de finalização</label>
                <input type="date" id="completionDate" name="completionDate" value="<%= task.getCompletionDate() %>" />
            </div>
            <div class="form-group">
                <button type="submit">Salvar alterações</button>
                <a id="cancel" href="TodasServlet">Cancelar</a>
            </div>
        </form>
    </div>
</body>
</html>
