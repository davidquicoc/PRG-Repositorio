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
        <title>Eliminar sala</title>
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
            
            String eliminar = "DELETE FROM sala WHERE ID_sala = '" + request.getParameter("ID_sala") + "'";
            
            stmt.execute(eliminar);
            
            ActualizarSesiones.actualizar(conexion);
            
            conexion.close();
            
            out.println("Sala eliminada.");
        %>
        <a href="gestionar.jsp">Volver</a>
    </body>
</html>
