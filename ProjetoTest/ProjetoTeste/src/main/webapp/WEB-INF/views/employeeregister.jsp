<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<h1>Registro de Novo Empregado</h1>
  <form action="<%= request.getContextPath() %>/register" method="post">
   <table style="with: 80%">
    <tr>
     <td>Primeiro Nome</td>
     <td><input type="text" name="firstName" /></td>
    </tr>
    <tr>
     <td>Sobrenome</td>
     <td><input type="text" name="lastName" /></td>
    </tr>
    <tr>
     <td>Usuário</td>
     <td><input type="text" name="username" /></td>
    </tr>
    <tr>
     <td>Senha</td>
     <td><input type="password" name="password" /></td>
    </tr>
    <tr>
     <td>Endereço</td>
     <td><input type="text" name="address" /></td>
    </tr>
    <tr>
     <td>Contato</td>
     <td><input type="text" name="contact" /></td>
    </tr>
   </table>
   <input type="submit" value="Submit" />
  </form>

</body>
</html>