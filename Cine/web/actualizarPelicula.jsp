<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="programas.ConexionBD"%>
<%@page import="programas.ActualizarSesiones"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Actualizar película</title>
    </head>
    <body>
        <%
            Connection conexion = ConexionBD.conectar();
            
            if (conexion == null) {
                response.sendRedirect("./error");
                return;
            }
            
            Statement stmt = conexion.createStatement();
            
            request.setCharacterEncoding("UTF-8");
            
            String actualizar = "UPDATE pelicula SET " + 
                    "titulo = '" + request.getParameter("titulo") + "', " + 
                    "genero = '" + request.getParameter("genero") + "', " +
                    "duracion = " + Integer.valueOf(request.getParameter("duracion")) + ", " + 
                    "año = " + Integer.valueOf(request.getParameter("año")) + ", " + 
                    "clasificacion = '" + request.getParameter("clasificacion") + "', " + 
                    "url = '" + request.getParameter("url") + "', " + 
                    "estado_pelicula = " + Boolean.parseBoolean(request.getParameter("estado_pelicula")) + " " + 
                    "WHERE ID_pelicula = '" + request.getParameter("ID_pelicula") + "'";
            
            stmt.execute(actualizar);
            
            ActualizarSesiones.actualizar(conexion);
            
            conexion.close();
            
            out.println("Película actualizada.");
        %>
        <a href="gestionar.jsp">Volver</a>
    </body>
</html>
