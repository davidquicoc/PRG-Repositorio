<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="programas.ConexionBD"%>
<%@page import="programas.DescripcionImagen"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="css/style.css">
    </head>
    <body>

        <%
            Connection conexion = ConexionBD.conectar();

            if (conexion == null) {
                response.sendRedirect("./error");
                return;
            }

            Statement stmt = conexion.createStatement();
            ResultSet rsSesions = stmt.executeQuery("SELECT * FROM sesion ORDER BY Fecha_Hora");
        %>

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
                <div>
                    <h3>Últimos</h3>
                    <p>Disfruta, no se que poner</p>
                    <!-- Sesiones más recientes -->
                </div>
                <section>
                    <p>Películas disponibles</p>
                    <%
                        ResultSet rsPeliculas = stmt.executeQuery("SELECT * FROM pelicula LIMIT 7");
                        while (rsPeliculas.next()) {
                            String altImg = DescripcionImagen.generarDescripcion(rsPeliculas.getString("url"));
                    %>
                    <div style="border: 2px solid black;">
                        <img src="<%=rsPeliculas.getString("url")%>" alt="<%=altImg%>"/>
                        <div style="border: 4px solid yellowgreen;">
                            <h3>TITULO</h3>
                            <p>Año<br>Genero<br>Duración</p>
                        </div>
                    </div>
                    <%
                        }
                    %>
                    <a href="peliculas.jsp">Ver todas las películas</a>
                </section>
                <footer>
                    <img alt="logo">
                    <hr>
                    <ul>
                        <li><a href="Acerca.html">Acerca de</a></li>
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
                    <p>Copyright</p>
                </footer>
            </main>
        </div>
    </body>
</html>
