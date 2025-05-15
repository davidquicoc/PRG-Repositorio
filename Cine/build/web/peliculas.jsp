<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="programas.ConexionBD"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Peliculas - Cine</title>
        <link rel="stylesheet" href="css/peliculas.css">
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
                    <a href="login/logout.jsp">Cerrar sesión (<%= session.getAttribute("usuario")%>)</a>
                    <%
                        }
                    %>
                </div>
            </header>
            <main>
                <h2>Películas en la Base de Datos</h2>
                <section>
                    <%
                        Connection conexion = ConexionBD.conectar();

                        if (conexion == null) {
                            response.sendRedirect("./error");
                            return;
                        }

                        Statement stmt = conexion.createStatement();
                        ResultSet rs = stmt.executeQuery("SELECT * FROM pelicula ORDER BY titulo");
                    
                        while (rs.next()) {
                    %>
                    <div class="bloque">
                        <div class="bloque-img">
                            <h4 class="año-pelicula"><%=rs.getInt("año")%></h4>
                            <img src="<%=rs.getString("url")%>"
                                 <%
                                     if (rs.getBoolean("estado_pelicula")) {
                                 %>class="image-original"<%
                                 } else {
                                 %>
                                 class="image-color-gray"
                                 <%
                                     }
                                 %>
                                 >
                        </div>
                        <div class="info-pelicula">
                            <h3><%=rs.getString("titulo")%></h3>
                            <p><%=rs.getString("genero")%></p>
                            <div class="extra-info">
                                <span class="cuadrado"><%=rs.getString("clasificacion")%></span>
                                <span class="cuadrado"><%=rs.getInt("duracion")%> min</span>

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
