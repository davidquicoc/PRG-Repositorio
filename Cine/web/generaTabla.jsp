<%@page import="java.io.IOException"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.Catch"%>
<%@page import="java.io.FileReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.BufferedWriter"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <table>
        <%
            String tabla = request.getParameter("tablanom");
            try {
                BufferedReader br = new BufferedReader(new FileReader(tabla));
                
                String linea = "";
                while (linea != null) {
                    linea = br.readLine();
                    
                    out.print("<tr><td>"<%=a%>"</td></tr>");
                    
                    if (linea == null) {
                        break;
                    }
                }
                
            } catch (IOException e) {
                System.err.println(e.getMessage());
            }
        %>
        </table>
    </body>
</html>
