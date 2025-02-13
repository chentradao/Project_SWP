/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;
import java.sql.DriverManager;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.PreparedStatement;
import java.util.logging.Level;
import java.util.logging.Logger;

//import com.sun.jdi.connect.spi.Connection;
/**
 *
 * @author nguye
 */
public class DBConnection {
    public Connection conn = null;
    public DBConnection(String URL, String userName, String password){
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
//        call connection
              conn =  DriverManager.getConnection(URL, userName, password);
              System.out.println("connected");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e){
            e.printStackTrace();
        }
//        URL: String connection: Server, DB, socket
//        userName, password: account of SQL Server   

//        call Driver  
    }

    public DBConnection() {
       this("jdbc:sqlserver://localhost:1433;databaseName=SWP", "sa", "123456");
    }
    public ResultSet getData(String sql){
        ResultSet rs=null;
        try {
            Statement state = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,
                    ResultSet.CONCUR_UPDATABLE);
            rs=state.executeQuery(sql);
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return rs;
    }
    
    public static void main(String[] args) {
        new DBConnection();
    }
    
}
