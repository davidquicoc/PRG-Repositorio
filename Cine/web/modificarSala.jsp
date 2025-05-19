<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="programas.ConexionBD"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Modificar sala</title>
        <link rel="stylesheet" href="css/formulario.css">
    </head>
    <body>
        <%
            Connection conexion = ConexionBD.conectar();

            if (conexion == null) {
                response.sendRedirect("./error");
                return;
            }

            conexion.close();
        %>

        <form method="post" action="actualizarSala.jsp">
            <h1>Edición de salas</h1>

            <label for="ID_sala">ID de la sala: </label>
            <input type="text" id="ID_sala" name="ID_sala" value="<%= request.getParameter("ID_sala")%>" readonly>

            <br>

            <label for="nombre">Nombre: </label>
            <input type="text" id="nombre" name="nombre" value="<%= request.getParameter("nombre")%>">

            <br>

            <label for="numeroAsientos">Número de asientos: </label>
            <input type="number" id="numeroAsientos" name="numeroAsientos" value="<%= request.getParameter("numeroAsientos")%>">

            <br>
            
            <p class="textopregunta">¿Hay lugares para personas con movilidad reducida?</p>
            <div>
                <label for="p1">Si&nbsp;&nbsp;<input type="radio" id="p1" name="personasConMovilidadReducida" value="true" <%= request.getParameter("personasConMovilidadReducida").equals("true") ? "checked" : ""%>></label>            
            <label for="p2">No&nbsp;&nbsp;<input type="radio" id="p2" name="personasConMovilidadReducida" value="false" <%= !request.getParameter("personasConMovilidadReducida").equals("false") ? "checked" : ""%>></label>
            </div>
            
            
            <br>

            <label for="estSa1">Alta&nbsp;&nbsp;<input type="radio" id="estSa1" name="estado_sala" value="true" <%= request.getParameter("estado_sala").equals("true") ? "checked" : ""%>></label>

            <br>
            
            <label for="estSa2">Baja&nbsp;&nbsp;<input type="radio" id="estSa2" name="estado_sala" value="false" <%= !request.getParameter("estado_sala").equals("false") ? "checked" : ""%>></label>

            <br>

            <input type="submit" value="Enviar">
            <a class="enlace" href="gestionar.jsp">Cancelar</a>
        </form>

    </body>
</html>
