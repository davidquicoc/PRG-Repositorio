<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Iniciar sesión</title>
    </head>
    <body>
        <%
            if (session.getAttribute("usuario") != null) {
                response.sendRedirect("../index.jsp");
            }
        %>
        <div>
            <h2>Iniciar sesión</h2>
            
            <%  if (session.getAttribute("error") != null) { %>
                    <p style="color: red;"><%= session.getAttribute("error") %></p>
            <%  
                    session.removeAttribute("error");
                }
            %>
            
            <form action="login.jsp" method="POST">
                <label for="usuario">Usuario</label>
                <input type="text" name="usuario" id="usuario" placeholder="Usuario" required><br>
                <label for="contrasena">Contraseña</label>
                <input type="password" name="contrasena" id="contrasena" placeholder="Contraseña"><br>
                <input type="submit" value="Acceder"><br>
                <a href="../index.jsp">Volver a la página de inicio</a>
            </form>
        </div>
    </body>
</html>
