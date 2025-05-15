/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package programas;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.io.File;
import java.util.List;

/**
 *
 * @author user
 */
public class PeliculasUtils {
    
    public static List<Pelicula> cargarJSONPeliculas(String fichero) {
        ObjectMapper mapper = new ObjectMapper();
        try {
            return mapper.readValue(new File(fichero), new TypeReference<List<Pelicula>() {});
        } catch (IOException e) {
            return null;
        }
    }
    
    public static Pelicula cargarJSONUnaPelicula(String fichero) {
        ObjectMapper mapper = new ObjectMapper();
        try {
            return mapper.readValue(new File(fichero), Pelicula.class);
        } catch (IOException e) {
            return null;
        }
    }
    
}
