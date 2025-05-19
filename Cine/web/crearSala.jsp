<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="programas.ConexionBD"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Crear sala</title>
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
            
            String insertar = "INSERT INTO sala VALUES ("
                    + "'" + request.getParameter("ID_sala") + "', "
                    + "'" + request.getParameter("nombre") + "', "
                    + Integer.valueOf(request.getParameter("numeroAsientos")) + ", "
                    + Boolean.parseBoolean(request.getParameter("personasConMovilidadReducida")) + ", "
                    + Boolean.parseBoolean(request.getParameter("estado_sala")) + ")";
            
            stmt.execute(insertar);
            conexion.close();
            
            out.println(request.getParameter("nombre") + "  creada.");
        %>
        <a href="gestionar.jsp">Volver</a>
    </body>
</html>
