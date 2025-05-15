/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package programas;

import java.sql.DriverManager;
import java.sql.Connection;
import java.sql.SQLException;

public class ConexionBD {
    
    public static Connection conectar() {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            return DriverManager.getConnection("jdbc:mysql://localhost:3306/cine","root","root");
        } catch(ClassNotFoundException | SQLException e) {
            System.err.println("Error en la conexión de la BBDD cine.");
            return null;
        }
    }
    
}
