<%@page import="java.util.Calendar"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="programas.ConexionBD"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Calendario</title>
        <link rel="stylesheet" type="text/css" href="css/calendario.css">
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
                <%
                    Calendar calendario = Calendar.getInstance();
                    int año = calendario.get(Calendar.YEAR);
                    int mes = calendario.get(Calendar.MONTH) + 1;
                    calendario.set(Calendar.DAY_OF_MONTH, 1);

                    calendario.set(Calendar.YEAR, año);
                    calendario.set(Calendar.MONTH, mes - 1);
                    calendario.set(Calendar.DAY_OF_MONTH, 1);

                    int primerDiaSemana = calendario.get(Calendar.DAY_OF_WEEK);

                    primerDiaSemana = (primerDiaSemana == Calendar.SUNDAY) ? 6 : primerDiaSemana - 2;

                    int diasEnMes = calendario.getActualMaximum(Calendar.DAY_OF_MONTH);

                    Connection conexion = ConexionBD.conectar();
                    Map<Integer, Integer> sesionesPorDia = new HashMap<>();

                    if (conexion != null) {
                        Statement stmt = conexion.createStatement();
                        String query = "SELECT DAY(Fecha_Hora) AS dia, COUNT(*) AS num_sesiones FROM sesion "
                                + "WHERE MONTH(Fecha_Hora) = " + mes + " AND YEAR(Fecha_Hora) = " + año
                                + " GROUP BY dia ORDER BY dia";
                        ResultSet rs = stmt.executeQuery(query);

                        while (rs.next()) {
                            sesionesPorDia.put(rs.getInt("dia"), rs.getInt("num_sesiones"));
                        }

                        rs.close();
                        stmt.close();
                        conexion.close();
                    }

                %>
                <h2>Calendario - <%= mes%> / <%= año%></h2>
                <table>
                    <caption>Sesiones - <%=mes%> / <%=año%></caption>
                    <thead>
                        <tr>
                            <th>Lunes</th>
                            <th>Martes</th>
                            <th>Miércoles</th>
                            <th>Jueves</th>
                            <th>Viernes</th>
                            <th>Sábado</th>
                            <th>Domingo</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <%
                                for (int i = 0; i < primerDiaSemana; i++) {
                            %>

                            <td>
                                <div class="td-container">
                                    <div class="div-parafo">
                                        <p>&nbsp;</p>
                                    </div>
                                </div>
                            </td>
                            <%
                                }

                                for (int dia = 1; dia <= diasEnMes; dia++) {
                                    int sesiones = 0;

                                    if (sesionesPorDia.containsKey(dia)) {
                                        sesiones = sesionesPorDia.get(dia);
                                    }
                            %>

                            <td>
                                <div class="td-container">
                                    <div class="div-parrafo">
                                        <p><%=dia%></p>
                                    </div>
                                    <div class="section-container">
                                        <%
                                            if (sesiones >= 1) {
                                                for (int i = 0; i < sesiones; i++) {
                                        %>
                                        <div class="session-circle">&nbsp;</div>
                                        <%
                                                }
                                            }
                                        %>
                                    </div>
                                </div>
                            </td>

                            <%
                                if ((dia + primerDiaSemana) % 7 == 0) {
                            %>
                        <tr></tr>
                        <%
                                }
                            }
                        %>
                        </tr>
                    </tbody>
                    <tfoot>
                        <tr>
                            <td colspan="7">
                                <div class="foot-container">
                                    <div class="session-circle">&nbsp;</div>
                                    <h3>Nº sesiones</h3>
                                </div>
                            </td>
                        </tr>
                    </tfoot>
                </table>
            </main>
        </div>
    </body>
</html>