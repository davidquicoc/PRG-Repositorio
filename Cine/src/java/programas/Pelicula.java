/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package programas;

/**
 *
 * @author user
 */
public class Pelicula {
    private String ID_pelicula;
    private String titulo;
    private String genero;
    private int duracion;
    private int año;
    private String url;
    private boolean estado_pelicula;
    
    public Pelicula() {}
    
    public Pelicula(String ID_pelicula, String titulo, String genero, int duracion, int año, String url, boolean estado_pelicula) {
        this.ID_pelicula = ID_pelicula;
        this.titulo = titulo;
        this.genero = genero;
        this.duracion = duracion;
        this.año = año;
        this.url = url;
        this.estado_pelicula = estado_pelicula;
    }
    
    public String getID_pelicula() {
        return ID_pelicula;
    }

    public void setID_pelicula(String ID_pelicula) {
        this.ID_pelicula = ID_pelicula;
    }

    public String getTitulo() {
        return titulo;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    public String getGenero() {
        return genero;
    }

    public void setGenero(String genero) {
        this.genero = genero;
    }

    public int getDuracion() {
        return duracion;
    }

    public void setDuracion(int duracion) {
        this.duracion = duracion;
    }

    public int getAño() {
        return año;
    }

    public void setAño(int año) {
        this.año = año;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public boolean isEstado_pelicula() {
        return estado_pelicula;
    }

    public void setEstado_pelicula(boolean estado_pelicula) {
        this.estado_pelicula = estado_pelicula;
    }
    
}
