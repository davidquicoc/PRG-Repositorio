package programas;

public class DescripcionImagen {
    
    public static String generarDescripcion(String titulo) {
        
        String[] split = titulo.split(" ");
        String descrp = "";
        for (String s : split) {
            descrp += s.toLowerCase();
        }
        return descrp;
    }
    
}
