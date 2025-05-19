<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="programas.ConexionBD"%>
<%@page import="programas.DescripcionImagen"%>
<%@page import="programas.ActualizarSesiones"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Peliculas - Cine</title>
        <link rel="stylesheet" type="text/css" href="css/peliculas.css">
    </head>
    <body>
        <div class="contenedor">
            <header>
                <div class="header-logo">
                    <a href="#">
                        <h2>LOGO</h2>
                    </a>
                </div>
                <nav class="header-nav">
                    <ul>
                        <li><a href="index.jsp">Inicio</a></li>
                        <li><a href="peliculas.jsp">Películas</a></li>
                        <li><a href="calendario.jsp">Calendario</a></li>
                            <%
                                if (session.getAttribute("usuario") != null) {
                            %>
                        <li><a href="gestionar.jsp">Gestionar</a></li>
                            <%
                                }
                            %>
                    </ul>
                </nav>
                <div class="header-user">
                    <%
                        if (session.getAttribute("usuario") == null) {
                    %>
                    <a href="login/">Iniciar sesión</a>
                    <%
                    } else {
                    %>
                    <a href="user-profile.jsp"><%= session.getAttribute("usuario")%></a>
                    <%
                        }
                    %>
                </div>
            </header>
            <main>
                <div class="encabezado">
                    <h2>Todas las películas</h2>
                <hr>
                <hr>
                </div>
                <section>
                    <%
                        Connection conexion = ConexionBD.conectar();

                        if (conexion == null) {
                            response.sendRedirect("./error");
                            return;
                        }
                        
                        ActualizarSesiones.actualizar(conexion);
                        
                        Statement stmt = conexion.createStatement();
                        ResultSet rs = stmt.executeQuery("SELECT * FROM pelicula ORDER BY titulo");
                    
                        while (rs.next()) {
                        String altImg = DescripcionImagen.generarDescripcion(rs.getString("url"));
                    %>
                    <div class="peliculas">
                        <div
                            <%
                                if (rs.getBoolean("estado_pelicula")) {
                            %>
                                class="pelicula"
                            <%
                                } else {
                            %>
                                class="pelicula-baja"
                            <%
                                }
                            %>
                            >
                            <div class="pelicula-header">
                                <h4 class="año-pelicula"><%= rs.getInt("año") %></h4>
                                <img src="<%= rs.getString("url") %>" alt="<%= altImg %>" class="image"/>
                            </div>
                            <h3><%= rs.getString("titulo") %></h3>
                            <p>Género: <%= rs.getString("genero") %></p>
                            <div class="extra-info">
                                <span class="clasificacion"><%= rs.getString("clasificacion") %></span>
                                <span class="duracion"><%= rs.getInt("duracion") %> min</span>
                            </div>
                        </div>
                    </div>
                    <%
                        }
                        conexion.close();
                    %>
                </section>
            </main>
        </div>
    </body>
</html>