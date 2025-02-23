/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import java.util.Date;

/**
 *
 * @author admin
 */
public class Order {

    int CustomerID, TotalCost, OrderStatus;
    String CustomerName, ShipAddress, ShipCity, Phone;
    Date OrderDate, ShippedDate;

    public Order() {
    }

    public Order(int CustomerID, int TotalCost, int OrderStatus, String CustomerName, String ShipAddress, String ShipCity, String Phone, Date OrderDate, Date ShippedDate) {
        this.CustomerID = CustomerID;
        this.TotalCost = TotalCost;
        this.OrderStatus = OrderStatus;
        this.CustomerName = CustomerName;
        this.ShipAddress = ShipAddress;
        this.ShipCity = ShipCity;
        this.Phone = Phone;
        this.OrderDate = OrderDate;
        this.ShippedDate = ShippedDate;
    }

    public int getCustomerID() {
        return CustomerID;
    }

    public void setCustomerID(int CustomerID) {
        this.CustomerID = CustomerID;
    }

    public int getTotalCost() {
        return TotalCost;
    }

    public void setTotalCost(int TotalCost) {
        this.TotalCost = TotalCost;
    }

    public int getOrderStatus() {
        return OrderStatus;
    }

    public void setOrderStatus(int OrderStatus) {
        this.OrderStatus = OrderStatus;
    }

    public String getCustomerName() {
        return CustomerName;
    }

    public void setCustomerName(String CustomerName) {
        this.CustomerName = CustomerName;
    }

    public String getShipAddress() {
        return ShipAddress;
    }

    public void setShipAddress(String ShipAddress) {
        this.ShipAddress = ShipAddress;
    }

    public String getShipCity() {
        return ShipCity;
    }

    public void setShipCity(String ShipCity) {
        this.ShipCity = ShipCity;
    }

    public String getPhone() {
        return Phone;
    }

    public void setPhone(String Phone) {
        this.Phone = Phone;
    }

    public Date getOrderDate() {
        return OrderDate;
    }

    public void setOrderDate(Date OrderDate) {
        this.OrderDate = OrderDate;
    }

    public Date getShippedDate() {
        return ShippedDate;
    }

    public void setShippedDate(Date ShippedDate) {
        this.ShippedDate = ShippedDate;
    }

    
}
