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
        <title>JSP Page</title>
    </head>
    <body>
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
                String query = "SELECT DAY(Fecha_Hora) AS dia, COUNT(*) AS num_sesiones FROM sesion " +
                               "WHERE MONTH(Fecha_Hora) = " + mes + " AND YEAR(Fecha_Hora) = " + año +
                               " GROUP BY dia ORDER BY dia";
                ResultSet rs = stmt.executeQuery(query);
                
                while (rs.next()) {
                    sesionesPorDia.put(rs.getInt("dia"), rs.getInt("num_sesiones"));
                }
                
                rs.close();
                stmt.close();
                conexion.close();
            } 
            
        %>
        <h2>Calendario - <%= mes %> / <%= año %></h2>
        <table style="border-collapse: collapse;" border="1">
            <tr>
                <th>Lunes</th>
                <th>Martes</th>
                <th>Miércoles</th>
                <th>Jueves</th>
                <th>Viernes</th>
                <th>Sábado</th>
                <th>Domingo</th>
            </tr>
            <tr>
                <%
                    for (int i = 0; i < primerDiaSemana; i++) {
                        out.print("<td></td>");
                    }
                    
                    for (int dia = 1; dia <= diasEnMes; dia++) {
                        int sesiones = 0;
                        
                        if (sesionesPorDia.containsKey(dia)) {
                            sesiones = sesionesPorDia.get(dia);
                        }
                        
                        out.print("<td>" + dia + "<br><small>" + sesiones + " sesiones</small></td>");
                        if ((dia + primerDiaSemana) % 7 == 0) {
                            out.print("</tr><tr>");
                        }
                    }
                %>
            </tr>
        </table>
    </body>
</html>
