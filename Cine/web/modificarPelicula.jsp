<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="programas.ConexionBD"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Modificar película</title>
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

        <form method="post" action="actualizarPelicula.jsp">
            <h1>Edición de películas</h1>
            <label for="ID_pelicula">ID de la película: </label>
            <input type="text" id="ID_pelicula" name="ID_pelicula" value="<%= request.getParameter("ID_pelicula")%>" readonly>

            <br>

            <label for="titulo">Título: </label>
            <input type="text" id="titulo" name="titulo" value="<%= request.getParameter("titulo")%>">

            <br>

            <label for="genero">Género: </label>
            <input type="text" id="genero" name="genero" value="<%= request.getParameter("genero")%>">

            <br>

            <label for="duracion">Duración: </label>
            <input type="number" id="duracion" name="duracion" value="<%= request.getParameter("duracion")%>">

            <br>

            <label for="año">Año: </label>
            <input type="number" id="año" name="año" value="<%= request.getParameter("año")%>">

            <br>

            <label for="clasificacion">Clasificación: </label>
            <select name="clasificacion" id="clasificacion">
                <option value="G" <%= request.getParameter("clasificacion").equals("G") ? "selected" : ""%>>G - Para todas las edades</option>
                <option value="PG" <%= request.getParameter("clasificacion").equals("PG") ? "selected" : ""%>>PG - Supervisión sugerida</option>
                <option value="PG-13" <%= request.getParameter("clasificacion").equals("PG-13") ? "selected" : ""%>>PG-13 - +13</option>
                <option value="R" <%= request.getParameter("clasificacion").equals("R") ? "selected" : ""%>>R - +17 con supervisión</option>
                <option value="NC-17" <%= request.getParameter("clasificacion").equals("NC-17") ? "selected" : ""%>>NC-17 - Solo adultos</option>
            </select>

            <br>

            <label for="url">URL de la imagen: </label>
            <input type="url" id="url" name="url" placeholder="https://pics.filmaffinity.com/..." value="<%= request.getParameter("url")%>">

            <br>

            <label for="est1">Alta&nbsp;&nbsp;<input type="radio" id="est1" name="estado_pelicula" value="true" <%= request.getParameter("estado_pelicula").equals("true") ? "checked" : ""%>></label>

            <br>
            <label for="est2">Baja&nbsp;&nbsp;<input type="radio" id="est2" name="estado_pelicula" value="false" <%= !request.getParameter("estado_pelicula").equals("false") ? "checked" : ""%>></label>
            

            <br>
            <input type="submit" value="Enviar">
            <a class="enlace" href="gestionar.jsp">Cancelar</a>

        </form>

    </body>
</html>