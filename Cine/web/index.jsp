<%@page import="programas.ExportarDatos"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="programas.ConexionBD"%>
<%@page import="programas.DescripcionImagen"%>
<%@page import="programas.ExportarSesion"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Inicio</title>
        <link rel="stylesheet" type="text/css" href="css/style.css">
    </head>
    <body>

        <%
            Connection conexion = ConexionBD.conectar();

            if (conexion == null) {
                response.sendRedirect("./error");
                return;
            }

            Statement stmt = conexion.createStatement();
            ResultSet rsPeliculas = stmt.executeQuery("SELECT * FROM pelicula LIMIT 8");

            Statement stmtSe = conexion.createStatement();

            String sqlSesiones = "SELECT se.ID_sesion, se.Fecha_Hora, "
                    + "p.ID_pelicula, p.titulo, p.url, p.duracion, p.clasificacion, "
                    + "sa.nombre AS nombre_sala, sa.personasConMovilidadReducida, sa.numeroAsientos, "
                    + "se.Fecha_Hora "
                    + "FROM sesion se "
                    + "JOIN pelicula p ON se.ID_pelicula = p.ID_pelicula "
                    + "JOIN sala sa ON se.ID_sala = sa.ID_sala "
                    + "ORDER BY se.Fecha_Hora ASC";
            ;
            ResultSet rsSesiones = stmtSe.executeQuery(sqlSesiones);
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
                    <a href="user-profile.jsp"><%= session.getAttribute("usuario")%></a>
                    <%
                        }
                    %>
                </div>
            </header>
            <main>
                <div>
                    <h3>Últimos</h3>
                </div>
                <section>
                    <p>Sesiones recientes</p>
                    <%
                        String idSesion = request.getParameter("sesion");
                        if (idSesion != null) {
                            boolean resultado = ExportarSesion.exportar(idSesion, conexion);
                            if (resultado) {
                    %>
                    <p>Datos de sesion <%= idSesion%> exportados</p>
                    <p><a href="files/sesion_<%= idSesion%>.dat" download>Descargar sesión <%=idSesion%></a></p>
                    <br>
                    <%
                    } else {
                    %>
                    <p style="color: red;">Error al exportar los datos de la sesión <%= idSesion%></p>
                    <%
                            }
                        }
                    %>
                    <div class="sesiones">
                        <%
                            while (rsSesiones.next()) {
                                String urlP = rsSesiones.getString("url");
                                int duracion = rsSesiones.getInt("duracion");
                                String clasificacion = rsSesiones.getString("clasificacion");
                                String nombreSala = rsSesiones.getString("nombre_sala");
                                boolean movilidadReducida = rsSesiones.getBoolean("personasConMovilidadReducida");
                                String fechaHora = rsSesiones.getString("Fecha_Hora");
                                String idSesionActual = rsSesiones.getString("ID_sesion");

                                String iconoAccesibilidad = movilidadReducida ? "✔️♿" : "❌♿";
                        %>
                        <div class="sesion">
                            <div>
                                <img src="<%=urlP%>" alt="<%=DescripcionImagen.generarDescripcion(urlP)%>">
                            </div>
                            <div class="info">
                                <h3 class="fecha">Hora: <%=fechaHora%></h3>
                                <h4 class="sala">Sala: <%=nombreSala%></h4>
                                <p><%= iconoAccesibilidad%></p>
                                <div>
                                    <p class="duracion"><%=duracion%> min</p>
                                    <p class="clasificacion"><%=clasificacion%></p>
                                </div>
                            </div>
                        </div>
                        <%
                            }
                        %>
                    </div>

                    <br>
                </section>
                <section>
                    <p>Películas disponibles</p>
                    <div class="peliculas">
                        <%
                            while (rsPeliculas.next()) {
                                String altImg = DescripcionImagen.generarDescripcion(rsPeliculas.getString("url"));
                        %>
                        <div class="pelicula">
                            <div class="pelicula-header">
                                <h4 class="año-pelicula"><%= rsPeliculas.getInt("año")%></h4>
                                <img src="<%= rsPeliculas.getString("url")%>" alt="<%= altImg%>" class="image"/>
                            </div>
                            <h3><%= rsPeliculas.getString("titulo")%></h3>
                            <p>Género: <%= rsPeliculas.getString("genero")%></p>
                            <div class="extra-info">
                                <span class="clasificacion"><%= rsPeliculas.getString("clasificacion")%></span>
                                <span class="duracion"><%= rsPeliculas.getInt("duracion")%> min</span>
                            </div>
                        </div>
                        <%
                            }
                        %>
                    </div>
                    <a href="peliculas.jsp">Ver todas las películas</a>
                </section>
                <footer>
                    <img alt="logo">
                    <hr>
                    <ul>
                        <li><a href="acerca.html">Acerca de</a></li>
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