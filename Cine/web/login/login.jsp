<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="programas.ConexionBD"%>
<%
    String usuario = request.getParameter("usuario");
    String contrase�a = request.getParameter("contrasena");
    
    Connection conexion = ConexionBD.conectar();
    if (conexion != null) {
        Statement stmt = conexion.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT * FROM usuarios WHERE username = '" + usuario + "' AND password = '" + contrase�a + "'");
       
        if (rs.next()) {
            session.setAttribute("usuario", rs.getString("username"));
            
            response.sendRedirect("../index.jsp");
        } else {
            session.setAttribute("error", "Usuario o contrase�a incorrectos.");
            response.sendRedirect("index.jsp");
        }
        
        rs.close();
        stmt.close();
        conexion.close();
        
    } else {
        session.setAttribute("error", "Error de conexi�n con la base de datos.");
        response.sendRedirect("index.jsp");
    }
%>