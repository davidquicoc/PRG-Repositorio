<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="programas.ConexionBD"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Modificar sesión</title>
        <link rel="stylesheet" href="css/formulario.css">
    </head>
    <body>
        <%
            Connection conexion = ConexionBD.conectar();

            if (conexion == null) {
                response.sendRedirect("./error");
                return;
            }

            String idSesion = request.getParameter("ID_sesion");
            Statement stmt = conexion.createStatement();
            ResultSet rsSesion = stmt.executeQuery("SELECT * FROM sesion WHERE ID_sesion = '" + idSesion + "'");

            if (!rsSesion.next()) {
                out.println("Sesión no encontrada");
                rsSesion.close();
                stmt.close();
                conexion.close();
                return;
            }
            
            String idPeliculaActual = rsSesion.getString("ID_pelicula");
            String idSalaActual = rsSesion.getString("ID_sala");
            String fechaHora = rsSesion.getTimestamp("Fecha_Hora").toLocalDateTime().toString();
            
            rsSesion.close();
            stmt.close();
        %>

        <form method="post" action="actualizarSesion.jsp">
            <h1>Edición de sesión</h1>

            <label for="ID_sesion">ID de la sesión: </label>
            <input type="text" id="ID_sesion" name="ID_sesion" value="<%= idSesion%>" readonly>

            <br>

            <label for="ID_peliculaSe">Película ID Ref</label>
            <select name="ID_pelicula" id="ID_peliculaSe">
                <%
                    Statement stmtPeliculas = conexion.createStatement();
                    ResultSet rsPeliculas = stmtPeliculas.executeQuery("SELECT ID_pelicula, titulo FROM pelicula WHERE estado_pelicula = TRUE");
                    while (rsPeliculas.next()) {
                        String idPeli = rsPeliculas.getString("ID_pelicula");
                        String titulo = rsPeliculas.getString("titulo");
                        String selected = idPeli.equals(idPeliculaActual) ? "selected" : "";
                %>
                <option value="<%=idPeli%>" <=% selected%><%=titulo%></option>
                <%
                    }
                    rsPeliculas.close();
                    stmtPeliculas.close();
                %>
            </select>
            <br>

            <label for="ID_salaSe">Sala ID Ref</label>
            <select name="ID_sala" id="ID_salaSe">
                <%
                    Statement stmtSalas = conexion.createStatement();
                    ResultSet rsSalas = stmtSalas.executeQuery("SELECT ID_sala, nombre FROM sala WHERE estado_sala = TRUE");
                    while (rsSalas.next()) {
                        String idSala = rsSalas.getString("ID_sala");
                        String nombre = rsSalas.getString("nombre");
                        String selected = idSala.equals(idSalaActual) ? "selected" : "";
                %>
                <option value="<%=idSala%>" <=% selected%><%=nombre%></option>
                <%
                    }
                %>
            </select>
            <br>

            <label for="Fecha_Hora">Fecha y hora</label>
            <input class="fecha" type="datetime-local" id="Fecha_Hora" name="Fecha_Hora" value="<%= fechaHora.replace(" ", "T")%>" required>

            <br>

            <input type="submit" value="Enviar">
            <a class="enlace" href="gestionar.jsp">Cancelar</a>
        </form>
        <%
            conexion.close();
        %>
    </body>
</html>
