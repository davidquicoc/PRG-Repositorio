<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="programas.ConexionBD"%>
<%@page import="programas.ExportarDatos"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Gestionar</title>
        <link rel="stylesheet" type="text/css" href="css/gestionar.css">
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
                <h2>Gestión de películas</h2>
                <section class="pelicula">
                    <div class="div-pelicula">
                        <form method="post" action="crearPelicula.jsp">
                            <div>
                                <label for="ID_pelicula">ID</label>
                                <input type="text" size="4" id="ID_pelicula" name="ID_pelicula" placeholder="P####" required>
                            </div>
                            <div>
                                <label for="titulo">Título</label>
                                <input type="text" id="titulo" name="titulo" required>
                            </div>
                            <div>
                                <label for="genero">Genero</label>
                                <input type="text" size="7" id="genero" name="genero" required>
                            </div>
                            <div>
                                <label for="duracion">Duración</label>
                                <input type="number" id="duracion" name="duracion" min="0" required>
                            </div>
                            <div>
                                <label for="año">Año</label>
                                <input type="number" id="año" name="año" required>
                            </div>
                            <div>
                                <label for="clasificacion">Clasificación</label>
                                <select id="clasificacion" name="clasificacion" required>
                                    <option value="G">G - Para todas las edades</option>
                                    <option value="PG">PG - Supervisión sugerida</option>
                                    <option value="PG-13">PG-13 - +13</option>
                                    <option value="R">R - +17 con supervisión</option>
                                    <option value="NC-17">NC-17 - Solo adultos</option>
                                </select>
                            </div>
                            <div>
                                <label for="url">URL</label>
                                <input type="url" id="url" name="url" placeholder="https://pics.filmaffinity.com/..." required>
                            </div>
                            <div>
                                <p>Estado</p>
                                <p><input type="radio" id="est1" name="estado_pelicula" value="true" checked required>&nbsp;<label for="est1">Alta</label></p>
                                <p><input type="radio" id="est2" name="estado_pelicula" value="false">&nbsp;<label for="est2">Baja</label></p> 
                            </div>
                            <div>
                                <input type="submit" value="Agregar">
                            </div>
                        </form>
                    </div>
                    <div class="bloques-pelicula">
                        <%
                            ResultSet rsP = stmt.executeQuery("SELECT * FROM pelicula ORDER BY ID_pelicula");
                            while (rsP.next()) {
                        %>
                        <div class="bloque-pelicula">
                            <div class="pelicula-contenedor">
                                <div class="pelicula-imagen">
                                    <img src="<%=rsP.getString("url")%>" alt="<%=ExportarDatos.exportar(rsP.getString("titulo"))%>" width="100">
                                </div>
                                <div class="pelicula-info">
                                    <p><b>ID:</b>&nbsp;<span class="datosP"><%=rsP.getString("ID_pelicula")%></span></p>
                                    <p><b>Título:</b>&nbsp;<span class="datosP"><%=rsP.getString("titulo")%></span></p>
                                    <p><b>Género:</b>&nbsp;<span class="datosP"><%=rsP.getString("genero")%></span></p>
                                    <p><b>Duración:</b>&nbsp;<span class="datosP"><%=rsP.getInt("duracion")%></span></p>
                                    <p><b>Año:</b>&nbsp;<span class="datosP"><%=rsP.getInt("año")%></span></p>
                                    <p><b>Clasificación:</b>&nbsp;<span class="datosP"><%=rsP.getString("clasificacion")%></span></p>
                                    <p><b>URL:</b>&nbsp;<span class="datosP"><%=rsP.getString("url")%></span></p>
                                    <p><b>Estado:</b>&nbsp;<span class="datosP"><%=(rsP.getBoolean("estado_pelicula") ? "Disponible" : "No disponible")%></span></p>
                                </div>
                            </div>
                            <div class="pelicula-botones">
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
                                <form method="get" action="eliminarPelicula.jsp">
                                    <input type="hidden" name="ID_pelicula" value="<%=rsP.getString("ID_pelicula")%>">
                                    <input type="submit" value="Eliminar">
                                </form>
                            </div>
                        </div>
                        <%
                            }
                            rsP.close();
                        %>
                    </div>
                </section>
                <section class="salas">
                    <h2>Salas guardadas</h2>
                    <div class="bloque-crear-sala">
                        <form method="post" action="crearSala.jsp">
                            <div>
                                <label for="ID_sala">ID</label>
                                <input type="text" size="4" id="ID_sala" name="ID_sala" placeholder="SA###" required>
                            </div>
                            <div>
                                <label for="nombre">Nombre</label>
                                <input type="text" id="nombre" name="nombre" required>
                            </div>
                            <div>
                                <label for="numeroAsientos">Nº Asiento</label>
                                <input type="number" id="numeroAsientos" name="numeroAsientos" required>
                            </div>
                            <div>
                                <p>P. Minusválido</p>
                                <p><input type="radio" id="p1" name="personasConMovilidadReducida" value="true" checked required>&nbsp;<label for="p1">Si</label></p>
                                <p><input type="radio" id="p2" name="personasConMovilidadReducida" value="false">&nbsp;<label for="p2">No</label></p> 
                            </div>
                            <div>
                                <p>Estado</p>
                                <p><input type="radio" id="estSa1" name="estado_sala" value="true" checked required>&nbsp;<label for="estSa1">Si</label></p>
                                <p><input type="radio" id="estSa2" name="estado_sala" value="false">&nbsp;<label for="estSa2">No</label></p> 
                            </div>
                            <div>
                                <input type="submit" value="Agregar">
                            </div>
                        </form>
                    </div>
                    <%
                        ResultSet rsSa = stmt.executeQuery("SELECT * FROM sala");
                        while (rsSa.next()) {
                    %>
                    <div class="info-sala">
                        <div class="sala-bloque">
                            <p><b><%=rsSa.getString("ID_sala")%></b>&nbsp;|&nbsp;<b><%=rsSa.getString("nombre")%></b> - Capacidad: <%=rsSa.getInt("numeroAsientos")%>&nbsp;|&nbsp;
                                <%
                                    if (rsSa.getBoolean("personasConMovilidadReducida")) {
                                        out.print("✔♿");
                                    } else {
                                        out.print("Sin plazas para personas con movilidad reducida.");
                                    }
                                %>
                                &nbsp;
                                |&nbsp;Estado: <%=(rsSa.getBoolean("estado_sala") ? "Disponible" : "No disponible")%>
                            </p>
                        </div>
                        <div class="sala-button">
                            <form method="get" action="modificarSala.jsp">
                                <input type="hidden" name="ID_sala" value="<%=rsSa.getString("ID_sala")%>">
                                <input type="hidden" name="nombre" value="<%=rsSa.getString("nombre")%>">
                                <input type="hidden" name="numeroAsientos" value="<%=rsSa.getInt("numeroAsientos")%>">
                                <input type="hidden" name="personasConMovilidadReducida" value="<%=rsSa.getString("personasConMovilidadReducida")%>">
                                <input type="hidden" name="estado_sala" value="<%=rsSa.getString("estado_sala")%>">
                                <input type="submit" value="Modificar">
                            </form>
                            <form method="get" action="eliminarSala.jsp">
                                <input type="hidden" name="ID_sala" value="<%=rsSa.getString("ID_sala")%>">
                                <input type="submit" value="Eliminar">
                            </form>
                        </div>
                    </div>
                    <%
                        }
                        rsSa.close();
                    %>
                </section>
                <section class="sesiones">
                    <h2>Gestión de sesiones</h2>
                    <div class="crearSesion">
                        <form method="post" action="crearSesion.jsp">
                            <div>
                                <label for="ID_sesion">ID</label>
                                <input type="text" size="4" id="ID_sesion" name="ID_sesion" placeholder="SE###">
                            </div>
                            <div>
                                <label for="ID_peliculaSe">Película ID Ref</label>
                                <select id="ID_peliculaSe" name="ID_pelicula" required>
                                    <%
                                        PreparedStatement psPeliculas = conexion.prepareStatement("SELECT ID_pelicula, titulo FROM pelicula WHERE estado_pelicula = TRUE");
                                        ResultSet rsPSelect = psPeliculas.executeQuery();
                                        while (rsPSelect.next()) {
                                    %>
                                    <option value="<%=rsPSelect.getString("ID_pelicula")%>"><%=rsPSelect.getString("titulo")%></option>
                                    <%
                                        }
                                        rsPSelect.close();
                                        psPeliculas.close();
                                    %>
                                </select>
                            </div>
                            <div>
                                <label for="ID_salaSe">Sala ID Ref</label>
                                <select id="ID_salaSe" name="ID_sala" required>
                                    <%
                                        PreparedStatement psSalas = conexion.prepareStatement("SELECT ID_sala, nombre FROM sala WHERE estado_sala = TRUE");
                                        ResultSet rsSaSelect = psSalas.executeQuery();
                                        while (rsSaSelect.next()) {
                                    %>
                                    <option value="<%=rsSaSelect.getString("ID_sala")%>"><%=rsSaSelect.getString("nombre")%></option>
                                    <%
                                        }
                                        rsSaSelect.close();
                                        psSalas.close();
                                    %>
                                </select>
                            </div>
                            <div>
                                <label for="Fecha_Hora">Fecha y hora</label>
                                <input type="datetime-local" id="Fecha_Hora" name="Fecha_Hora" required>
                            </div>
                            <div>
                                <input type="submit" value="Enviar">
                            </div>
                        </form>
                    </div>
                    <%
                        ResultSet rsSe = stmt.executeQuery("SELECT * FROM sesion");
                        while (rsSe.next()) {
                            String idPelicula = rsSe.getString("ID_pelicula");
                            String idSala = rsSe.getString("ID_sala");

                            Statement stmtP = conexion.createStatement();
                            Statement stmtS = conexion.createStatement();

                            ResultSet rsPelicula = stmtP.executeQuery("SELECT estado_pelicula FROM pelicula WHERE ID_pelicula = '" + idPelicula + "' AND estado_pelicula = 1");
                            ResultSet rsSala = stmtS.executeQuery("SELECT estado_sala FROM sala WHERE ID_sala = '" + idSala + "' AND estado_sala = 1");
                            if (rsPelicula.next() && rsSala.next()) {
                    %>
                    <div class="bloqueSesiones">
                        <div class="bloqueSesion">
                            <p><b>ID:&nbsp;</b><%=rsSe.getString("ID_sesion")%></p>
                            <p><b>Película:&nbsp;</b><%=rsSe.getString("ID_pelicula")%></p>
                            <p><b>Sala:&nbsp;</b><%=rsSe.getString("ID_sala")%></p>
                            <p><b>Fecha y hora&nbsp;</b><%=rsSe.getTimestamp("Fecha_Hora")%></p>
                        </div>
                        <div class="sesion-boton">
                            <form method="get" action="modificarSesion.jsp">
                                <input type="hidden" name="ID_sesion" value="<%=rsSe.getString("ID_sesion")%>">
                                <input type="hidden" name="ID_pelicula" value="<%=rsSe.getString("ID_pelicula")%>">
                                <input type="hidden" name="ID_sala" value="<%=rsSe.getString("ID_sala")%>">
                                <input type="hidden" name="Fecha_Hora" value="<%=rsSe.getString("Fecha_Hora")%>">
                                <input type="submit" value="Modificar">
                            </form>
                            <form method="get" action="eliminarSesion.jsp">
                                <input type="hidden" name="ID_sesion" value="<%=rsSe.getString("ID_sesion")%>"/>
                                <input type="submit" value="Eliminar">
                            </form>
                        </div>
                    </div>
                    <%
                            }
                            rsPelicula.close();
                            rsSala.close();
                        }
                        rsSe.close();
                    %>
                </section>
                <section class="importar-peliculas">
                    <h3>Exportar datos</h3>
                    <%
                        String tabla = request.getParameter("tabla");
                        if (tabla != null) {
                            boolean resultado = ExportarDatos.exportar(tabla);
                            if (resultado) {
                    %>
                    <p>Datos de <%= tabla%> exportados</p>
                    <p><a href="files/<%= tabla%>.txt" download>Descargar <%= tabla%></a></p>
                    <form method="get" action="files/<%=tabla%>.html">
                        <input type="text" name="tablanom" value="<%=tabla%>.txt" readonly>
                        <input type="submit" value="Visitar <%=tabla%>">
                    </form>
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

                    <br>
                    <div>
                        <div>
                            <form method="get" action="importarPeliculas">
                                <input type="file" required accept=".json">
                                &nbsp;
                                <input type="submit">
                            </form>
                        </div>
                        <div>
                            <a href="files/plantilla.json" download>Descargar plantilla .json</a>
                        </div>
                    </div>
                </section>
                <section>
                    <form action="importarPeliculas.jsp" method="post" enctype="multipart/form-data">
                        <label for="archivoPeliculas">Importar películas (.txt):</label>
                        <input type="file" name="archivoPeliculas" accept=".txt" required>
                        <input type="submit" value="Importar">
                    </form>
                </section>
            </main>
        </div>
    </body>
</html>