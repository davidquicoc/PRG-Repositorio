<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="programas.ConexionBD"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Crear película</title>
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
            
            String consultaIDPelicula = "SELECT * FROM pelicula WHERE ID_pelicula='"
                    + request.getParameter("ID_pelicula") + "'";

            ResultSet IDsPeliculas = stmt.executeQuery(consultaIDPelicula);
            //IDsPeliculas.last();

            if (IDsPeliculas.getRow() != 0) {
                out.println("Ya existe una película con el ID "
                        + request.getParameter("ID_pelicula") + ".");
            } else {

                String insertar = "INSERT INTO pelicula VALUES ("
                        + "'" + request.getParameter("ID_pelicula") + "', "
                        + "'" + request.getParameter("titulo") + "', "
                        + "'" + request.getParameter("genero") + "', "
                        + Integer.valueOf(request.getParameter("duracion")) + ", "
                        + Integer.valueOf(request.getParameter("año")) + ", "
                        + "'" + request.getParameter("clasificacion") + "', "
                        + "'" + request.getParameter("url") + "', "
                        + request.getParameter("estado_pelicula") + ")";

                stmt.execute(insertar);
                conexion.close();

                out.println("Película " + request.getParameter("titulo") + " creada.");
            }
            conexion.close();
        %>
        <a href="gestionar.jsp">Volver</a>
    </body>
</html>
