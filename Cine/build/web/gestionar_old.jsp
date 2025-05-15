<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="programas.ConexionBD"%>
<%@page import="programas.ExportarDatos"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Gestionar - Cine</title>
    </head>
    <body>
        <%
            Class.forName("com.mysql.jdbc.Driver");
            Connection conexion = ConexionBD.conectar();

            if (conexion == null) {
                response.sendRedirect("../error/");
                return;
            }

            Statement stmt = conexion.createStatement();
        %>
        <a href="crearPelicula.jsp">Crear película nueva</a>
        <table border="1">
            <tr>
                <th>&nbsp;</th>
                <th>ID</th>
                <th>Título</th>
                <th>Género</th>
                <th>Duración</th>
                <th>Año</th>
                <th>Clasificación</th>
                <th>URL imagen</th>
                <th>Estado</th>
            </tr>
            <%
                ResultSet rsP = stmt.executeQuery("SELECT * FROM pelicula");
                while (rsP.next()) {
            %>
                <tr>
                    <td>
                        <img src="<%=rsP.getString("url")%>" alt="<%=ExportarDatos.exportar(rsP.getString("titulo"))%>" width="100">
                    </td>
                    <td><%=rsP.getString("ID_pelicula")%></td>
                    <td><%=rsP.getString("titulo")%></td>
                    <td><%=rsP.getString("genero")%></td>
                    <td><%=rsP.getInt("duracion")%></td>
                    <td><%=rsP.getInt("año")%></td>
                    <td><%=rsP.getString("clasificacion")%></td>
                    <td><%=(rsP.getBoolean("estado_pelicula") ? "Disponible" : "No disponible")%></td>
            
            <td>
                <form method="get" action="modificarPelicula.jsp">
                    <input type="hidden" name="ID_pelicula" value="<%=rsP.getString("ID_pelicula")%>">
                    <input type="hidden" name="titulo" value="<%=rsP.getString("titulo")%>">
                    <input type="hidden" name="genero" value="<%=rsP.getString("genero")%>">
                    <input type="hidden" name="duracion" value="<%=rsP.getInt("duracion")%>">
                    <input type="hidden" name="año" value="<%=rsP.getInt("año")%>">
                    <input type="hidden" name="clasificacion" value="<%=rsP.getString("clasificacion")%>">
                    <input type="hidden" name="url" value="<%=rsP.getString("url")%>">
                    <input type="hidden" name="estado_pelicula" value="<%=rsP.getString("estado_pelicula")%>">
                    <input type="submit" value="Modificar">
                </form>
                <br>
                <form method="get" action="eliminarPelicula.jsp">
                    <input type="hidden" name="ID_pelicula" value="<%=rsP.getString("ID_pelicula")%>"/>
                    <input type="submit" value="Eliminar">
                </form>
            </td>
        </tr>
            <%
                }
                rsP.close();
            %>
    </table>
    
    <hr>
    
    <a href="crearSala.jsp">Crear sala nueva</a>
        <table border="1">
            <tr>
                <th>ID</th>
                <th>Nombre</th>
                <th>Número de asientos</th>
                <th>plazasMinusvalido</th>
                <th>estado_sala</th>
            </tr>
            <%
                ResultSet rsSa = stmt.executeQuery("SELECT * FROM sala");
                while (rsSa.next()) {
            %>
                <tr>
                    <td><%=rsSa.getString("ID_sala")%></td>
                    <td><%=rsSa.getString("nombre")%></td>
                    <td><%=rsSa.getInt("numeroAsientos")%></td>
                    <td><%=(rsSa.getBoolean("plazasMinusvalido") ? "Si" : "No")%></td>
                    <td><%=(rsSa.getBoolean("estado_pelicula") ? "Disponible" : "No disponible")%></td>
            <td>
                <form method="get" action="modificarSala.jsp">
                    <input type="hidden" name="ID_sala" value="<%=rsSa.getString("ID_sala")%>">
                    <input type="hidden" name="nombre" value="<%=rsSa.getString("nombre")%>">
                    <input type="hidden" name="numeroAsientos" value="<%=rsSa.getInt("numeroAsientos")%>">
                    <input type="hidden" name="plazasMinusvalido" value="<%=rsSa.getString("plazasMinusvalido")%>">
                    <input type="hidden" name="estado_pelicula" value="<%=rsSa.getString("estado_pelicula")%>">
                    <input type="submit" value="Modificar">
                </form>
                <br>
                <form method="get" action="eliminarSala.jsp">
                    <input type="hidden" name="ID_sala" value="<%=rsSa.getString("ID_pelicula")%>"/>
                    <input type="submit" value="Eliminar">
                </form>
            </td>
        </tr>
            <%
                }
                rsSa.close();
            %>
    </table>
    
    
    <hr>
    
    <a href="crearSesion.jsp">Crear sesión nueva</a>
        <table border="1">
            <tr>
                <th>ID</th>
                <th>ID Película</th>
                <th>ID Sala</th>
                <th>Fecha y hora</th>
                <th>&nbsp;</th>
            </tr>
            <%
                ResultSet rsSe = stmt.executeQuery("SELECT * FROM sesion");
                while (rsSe.next()) {
            %>
                <tr>
                    <td><%=rsSe.getString("ID_sesion")%></td>
                    <td><%=rsSe.getString("ID_pelicula")%></td>
                    <td><%=rsSe.getString("ID_sala")%></td>
                    <td><%=rsSe.getString("Fecha_Hora")%></td>
            <td>
                <form method="get" action="modificarSesion.jsp">
                    <input type="hidden" name="ID_sesion" value="<%=rsSe.getString("ID_sesion")%>">
                    <input type="hidden" name="ID_pelicula" value="<%=rsSe.getString("ID_pelicula")%>">
                    <input type="hidden" name="ID_sala" value="<%=rsSe.getString("ID_sala")%>">
                    <input type="hidden" name="Fecha_Hora" value="<%=rsSe.getString("Fecha_Hora")%>">
                    <input type="submit" value="Modificar">
                </form>
                <br>
                <form method="get" action="eliminarSala.jsp">
                    <input type="hidden" name="ID_sesion" value="<%=rsSe.getString("ID_sesion")%>"/>
                    <input type="submit" value="Eliminar">
                </form>
            </td>
        </tr>
            <%
                }
                rsSe.close();
                stmt.close();
                conexion.close();
            %>
    </table>
    
    <hr>
    
    <h3>Exportar datos</h3>
    <%
        String tabla = request.getParameter("tabla");
        if (tabla != null) {
            boolean resultado = ExportarDatos.exportar(tabla);
            if (resultado) {
                %>
                <p>Datos de <%= tabla %> exportados</p>
                <p><a href="files/<%= tabla %>.txt" download>Descargar <%= tabla %></a></p>
                <%
            } else {
            %>
                <p style="color: red;">Error al exportar los datos de <%= tabla%></p>
            <%
            }
        }
    %>
    <ul>
        <li><a href="gestionar.jsp?tabla=pelicula">Exportar películas</a></li>
        <li><a href="gestionar.jsp?tabla=sala">Exportar salas</a></li>
        <li><a href="gestionar.jsp?tabla=sesion">Exportar sesiones</a></li>
    </ul>
</body>
</html>