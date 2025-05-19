<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="programas.ConexionBD"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>9
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Crear sesión</title>
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
                        
            String idSesion = request.getParameter("ID_sesion");
            String idPelicula = request.getParameter("ID_pelicula");
            String idSala = request.getParameter("ID_sala");
            String fechaHora = request.getParameter("Fecha_Hora");
            
            //  Verificar si la película existe y su estado sea TRUE
            PreparedStatement psPeli = conexion.prepareStatement(
                    "SELECT 1 FROM pelicula WHERE ID_pelicula = ? AND estado_pelicula = TRUE");
            psPeli.setString(1, idPelicula);
            ResultSet rsPeli = psPeli.executeQuery();
            
            //  Verificar si la sala existe y su estado sea TRUE
            PreparedStatement psSala = conexion.prepareStatement(
                    "SELECT 1 FROM sala WHERE ID_sala = ? AND estado_sala = TRUE");
            psSala.setString(1, idSala);
            ResultSet rsSala = psSala.executeQuery();
            
            //  Si ambas comprobaciones son verdaderos, se crea la sesión
            if (rsPeli.next() && rsSala.next()) {
                PreparedStatement psInsert = conexion.prepareStatement(
                "INSERT INTO sesion (ID_sesion, ID_pelicula, ID_sala, Fecha_Hora) VALUES (?, ?, ?, ?)");
                psInsert.setString(1, idSesion);
                psInsert.setString(2, idPelicula);
                psInsert.setString(3, idSala);
                psInsert.setString(4, fechaHora);
                
                //  Ejecutar la inserción
                psInsert.executeUpdate();
                
                out.println("Sesión " + idSesion + " creada.");
            } else {
                
                out.println("Error: Película o sala inactiva o inexistetne.");
            }
            
            conexion.close();
            
        %>
        <a href="gestionar.jsp">Volver</a>
    </body>
</html>
