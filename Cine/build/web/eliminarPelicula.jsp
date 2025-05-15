<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="programas.ConexionBD"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
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
            
            String eliminar = "DELETE FROM pelicula WHERE ID_pelicula = '" + request.getParameter("ID_pelicula") + "'";
            
            stmt.execute(eliminar);
            conexion.close();
            
            out.println("Película eliminada.");
        %>
        <a href="gestionar.jsp">Volver</a>
    </body>
</html>
