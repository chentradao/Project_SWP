/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import java.util.Date;


/**
 *
 * @author nguye
 */
public class Order {
    private int OrderID;
    private int CustomerID;
    private String CustomerName;
    private Date OrderDate;
    private Date ShippedDate;
    private int TotalCost;
    private String Phone;
    private String ShipAddress;
    private String ShipCity;
    private int OrderStatus;

    public Order(int OrderID, int CustomerID, String CustomerName, Date OrderDate, Date ShippedDate, int TotalCost, String Phone, String ShipAddress, String ShipCity, int OrderStatus) {
        this.OrderID = OrderID;
        this.CustomerID = CustomerID;
        this.CustomerName = CustomerName;
        this.OrderDate = OrderDate;
        this.ShippedDate = ShippedDate;
        this.TotalCost = TotalCost;
        this.Phone = Phone;
        this.ShipAddress = ShipAddress;
        this.ShipCity = ShipCity;
        this.OrderStatus = OrderStatus;
    }

    public int getOrderID() {
        return OrderID;
    }

    public void setOrderID(int OrderID) {
        this.OrderID = OrderID;
    }

    public int getCustomerID() {
        return CustomerID;
    }

    public void setCustomerID(int CustomerID) {
        this.CustomerID = CustomerID;
    }

    public String getCustomerName() {
        return CustomerName;
    }

    public void setCustomerName(String CustomerName) {
        this.CustomerName = CustomerName;
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

    public int getTotalCost() {
        return TotalCost;
    }

    public void setTotalCost(int TotalCost) {
        this.TotalCost = TotalCost;
    }

    public String getPhone() {
        return Phone;
    }

    public void setPhone(String Phone) {
        this.Phone = Phone;
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

    public int getOrderStatus() {
        return OrderStatus;
    }

    public void setOrderStatus(int OrderStatus) {
        this.OrderStatus = OrderStatus;
    }

    @Override
    public String toString() {
        return "Order{" + "OrderID=" + OrderID + ", CustomerID=" + CustomerID + ", CustomerName=" + CustomerName + ", OrderDate=" + OrderDate + ", ShippedDate=" + ShippedDate + ", TotalCost=" + TotalCost + ", Phone=" + Phone + ", ShipAddress=" + ShipAddress + ", ShipCity=" + ShipCity + ", OrderStatus=" + OrderStatus + '}';
    }
    
    
}
