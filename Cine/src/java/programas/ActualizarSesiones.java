package programas;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class ActualizarSesiones {
    
    public static void actualizar(Connection conexion) {
        try {
            String sql1 = """
                            DELETE FROM sesion 
                            WHERE ID_pelicula NOT IN (SELECT ID_pelicula FROM pelicula WHERE estado_pelicula = TRUE)
                         """;
            //  Usar PreparedStatement para ejecutar consultas SQL
            PreparedStatement ps1 = conexion.prepareStatement(sql1);
            ps1.executeUpdate();
            ps1.close();
            
            String sql2 = """
                            DELETE FROM sesion 
                            WHERE ID_sala NOT IN (SELECT ID_sala FROM sala WHERE estado_sala = TRUE)
                          """;
            PreparedStatement ps2 = conexion.prepareStatement(sql2);
            ps2.executeUpdate();
            ps2.close();
        } catch (Exception e) {
            System.out.println(e);
        } 
   }
    
}
