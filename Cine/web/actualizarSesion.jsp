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
        <title>Actualizar sesión</title>
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
            
            String actualizar = "UPDATE sesion SET " + 
                    "ID_pelicula = '" + request.getParameter("ID_pelicula") + "', " + 
                    "ID_sala = '" + request.getParameter("ID_sala") + "', " +
                    "Fecha_Hora = '" + request.getParameter("Fecha_Hora") + "' " + 
                    "WHERE ID_sesion = '" + request.getParameter("ID_sesion") + "'";
            
            int filas = stmt.executeUpdate(actualizar);
            
            if (filas > 0) {
                out.println("Sesión actualizada.");
            } else {
                out.println("Error al actualizar");
            }
            
            ActualizarSesiones.actualizar(conexion);
            
            conexion.close();
        %>
        <a href="gestionar.jsp">Volver</a>
    </body>
</html>
