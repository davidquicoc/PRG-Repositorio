<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Perfil de Usuario</title>
    </head>
    <body>
        <%
            int idUsuario = (int) session.getAttribute("id_usuario");
            String usuario = (String) session.getAttribute("usuario");
            String rol = (String) session.getAttribute("rol");
            
            
            if (usuario == null) {
                response.sendRedirect("login/login-form.jsp");
            }
        %>
        
        <h2>Datos del usuario</h2>
        <p>ID: <%= idUsuario%></p>
        <p>Usuario: <%= usuario%></p>
        <% if (rol != null) { %>
            <p>Rol: <%= rol %></p>
        <% } else {%>
            <p>Rol: No especificado</p>
        <% } %>
        
        <a href="login/logout.jsp">Cerrar sesión</a>
    </body>
</html>
