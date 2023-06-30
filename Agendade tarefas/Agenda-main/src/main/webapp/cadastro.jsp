<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Cadastro</title>
    <link rel="stylesheet" type="text/css" href="cadastro.css">
</head>
<body>
    <h1>Agenda de Tarefas</h1>
    
    <div class="container">
    
        <form action="CadastroServlet" method="post" class="form">
        
            <h2 class="title">Cadastro</h2>
            
            <p class="message">Faça o cadastro para acessar nossos serviços.</p>
            <p class="message">Preencha os dados a seguir para realizar o cadastro:</p>
            
            
            <div class="input-group">
                <label for="name">Nome</label>
                <input type="text" id="name" name="name" class="input" required>
            </div>


            <div class="input-group">
                <label for="email">E-mail</label>
                <input type="email" id="email" name="email" class="input" required>
            </div>



            <div class="input-group">
                <label for="login">Nome de usuário</label>
                <input type="text" id="login" name="login" class="input" required>
            </div>



            <div class="input-group">
                <label for="password">Senha</label>
                <input type="password" id="password" name="password" class="input" required>
            </div>



	    <button type="submit" value="Register" class="submit">Cadastrar</button>
	    <p class="signin">Fazer <a href="login.jsp">login</a> </p>
	    
	    
	    
	    <div id="errorMessage" class="error-message">
            <% String errorMessage = (String) request.getAttribute("errorMessage");
               if (errorMessage != null && !errorMessage.isEmpty()) {
                   out.println(errorMessage);
               }
            %>
        </div>
        
        
	</form>
	
</body>

</html>