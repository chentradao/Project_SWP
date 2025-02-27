/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;
import entity.Cart;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
/**
 *
 * @author nguye
 */
public class DAOCart extends DBConnection{
    public Cart getCart (int id){
        Cart cart = null;
    String sql = "Select p.ProductID,p.ProductName,pd.ID,pd.IdentityCode,pd.Quantity,pd.Size,pd.Color,pd.Price,pd.Image\n" +
"From Products p join ProductDetail pd on p.ProductID=pd.ProductID\n" +
"Where pd.ID ="+id;
    try {
            ResultSet rs = conn.createStatement().executeQuery(sql);
            if(rs.next()){
                cart = new Cart(rs.getInt("ProductID"), rs.getString("ProductName"), rs.getInt("Quantity"), rs.getInt("ID"), rs.getString("IdentityCode"), rs.getString("Size"), rs.getString("Color"), rs.getInt("Price"), rs.getString("Image"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOCart.class.getName()).log(Level.SEVERE, null, ex);
        }
        return cart;
            }
}
