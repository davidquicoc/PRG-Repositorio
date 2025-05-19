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
        <title>Eliminar sesión</title>
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
            
            String eliminar = "DELETE FROM sesion WHERE ID_sesion = '" + request.getParameter("ID_sesion") + "'";
            
            //  Ejecuta la eliminación de registros y verifica si hubo cambios
            int filasAfectadas = stmt.executeUpdate(eliminar);
            
            conexion.close();
            
            ActualizarSesiones.actualizar(conexion);
            
            //  Si cumple la condición, significa que se han eliminado
            if (filasAfectadas > 0) {
                out.println("Sesión eliminada.");
            } else {
                out.println("No se encontró ninguna sesión con ese ID.");
            }
        %>
        <a href="gestionar.jsp">Volver</a>
    </body>
</html>
