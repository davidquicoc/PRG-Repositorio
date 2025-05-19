package programas;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.sql.*;

public class ExportarDatos {

    public static boolean exportar(String tabla) {

        if (!tabla.equals("pelicula")
                && !tabla.equals("sala")
                && !tabla.equals("sesion")) {
            return false;
        }

        Connection conexion = ConexionBD.conectar();

        if (conexion == null) {
            return false;
        }
        
        String rutaFichero = System.getProperty("user.dir") + "/NetBeansProjects/Cine/web/files/";
        File directorio = new File(rutaFichero);
        
        if (!directorio.exists()) {
            directorio.mkdirs();
        }
        
        File fichero = new File(directorio, tabla + ".txt");
        String query = "SELECT * FROM " + tabla;
        
        File htmlF = new File(directorio, tabla + ".html");
            
        
        try {
            //  HTML
            BufferedWriter bwH = new BufferedWriter(new FileWriter(htmlF));
            bwH.write("<!DOCTYPE html>");
            
            //  SQL
            Statement stmt = conexion.createStatement();
            ResultSet rs = stmt.executeQuery(query);
            BufferedWriter bw = new BufferedWriter(new FileWriter(fichero));

            switch (tabla) {
                case "pelicula":
                    //bw.write("ID_pelicula | titulo | genero | duracion | año | clasificacion | url | estado_pelicula");
                    bw.newLine();
                    while (rs.next()) {
                        bw.write(rs.getString("ID_pelicula") + " | "
                                + rs.getString("titulo") + " | "
                                + rs.getString("genero") + " | "
                                + rs.getInt("duracion") + " | "
                                + rs.getInt("año") + " | "
                                + rs.getString("clasificacion") + " | "
                                + rs.getString("url") + " | "
                                + rs.getBoolean("estado_pelicula"));
                        bw.newLine();
                    }
                    break;
                case "sala":
                    //bw.write("ID_sala | nombre | numeroAsientos | plazasMinusvalido | estado_sala");
                    bw.newLine();
                    while (rs.next()) {
                        bw.write(rs.getString("ID_sala") + " | "
                                + rs.getString("nombre") + " | "
                                + rs.getInt("numeroAsientos") + " | "
                                + rs.getBoolean("plazasMinusvalido") + " | "
                                + rs.getBoolean("estado_sala"));
                        bw.newLine();
                    }
                    break;
                case "sesion":
                    //bw.write("ID_sesion | ID_pelicula | ID_sala | Fecha_Hora");
                    bw.newLine();
                    while (rs.next()) {
                        bw.write(rs.getString("ID_sesion") + " | "
                                + rs.getString("ID_pelicula") + " | "
                                + rs.getString("ID_sala") + " | "
                                + rs.getTimestamp("Fecha_Hora"));
                        bw.newLine();
                    }
                    break;
                default:
                    return false;
                    
            }
            
            bwH.close();
            
            bw.close();
            
            return true;

        } catch (IOException | SQLException e) {
            System.err.println(e.getMessage());
            return false;
        }

    }

}
