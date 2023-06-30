<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
    <link rel="stylesheet" type="text/css" href="login.css">
</head>
<body>
    <h1>Minha Agenda</h1>

    <div class="container">
        <form method="post" action="LoginServlet" class="form">
            <h2 class="title">Acessar a Agenda</h2>

            <div class="input-group">
                <label for="username">Usuário</label>
                <input type="text" id="username" name="username" class="input" required>
            </div>

            <div class="input-group">
                <label for="password">Senha</label>
                <input type="password" id="password" name="password" class="input" required>
            </div>

            <button type="submit" class="submit">Entrar</button>

            <div class="error-message">
                <% if (request.getAttribute("errorMessage") != null) { %>
                    <%= request.getAttribute("errorMessage") %>
                <% } %>
            </div>
        </form>
    </div>

</body>
</html>
