/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import java.util.Date;
import java.util.Vector;


/**
 *
 * @author nguye
 */
public class Order {
    private int OrderID;
    private Integer CustomerID;
    private String CustomerName;
    private Date OrderDate;
    private Date ShippedDate;
    private int ShippingFee;
    private int TotalCost;
    private String Email;
    private String Phone;
    private String ShipAddress;
    private int Discount;
    private String CancelNotification;
    private String Note;
    private String PaymentMethod;
    private int OrderStatus;
    private Vector<OrderDetail> orderDetail;

    public Order(Integer CustomerID, String CustomerName, Date OrderDate, Date ShippedDate, int ShippingFee, int TotalCost, String Email, String Phone, String ShipAddress, int Discount, String Note, String CancelNotification, String PaymentMethod, int OrderStatus) {
        this.CustomerID = CustomerID;
        this.CustomerName = CustomerName;
        this.OrderDate = OrderDate;
        this.ShippedDate = ShippedDate;
        this.ShippingFee = ShippingFee;
        this.TotalCost = TotalCost;
        this.Email = Email;
        this.Phone = Phone;
        this.ShipAddress = ShipAddress;
        this.Discount = Discount;
        this.Note = Note;
        this.CancelNotification = CancelNotification;
        this.PaymentMethod = PaymentMethod;
        this.OrderStatus = OrderStatus;
    }


    public Order(Integer OrderID, int CustomerID, String CustomerName, Date OrderDate, Date ShippedDate, int ShippingFee, int TotalCost, String Email, String Phone, String ShipAddress, int Discount, String CancelNotification, String Note, String PaymentMethod, int OrderStatus) {
        this.OrderID = OrderID;
        this.CustomerID = CustomerID;
        this.CustomerName = CustomerName;
        this.OrderDate = OrderDate;
        this.ShippedDate = ShippedDate;
        this.ShippingFee = ShippingFee;
        this.TotalCost = TotalCost;
        this.Email = Email;
        this.Phone = Phone;
        this.ShipAddress = ShipAddress;
        this.Discount = Discount;
        this.CancelNotification = CancelNotification;
        this.Note = Note;
        this.PaymentMethod = PaymentMethod;
        this.OrderStatus = OrderStatus;
    }

    public Vector<OrderDetail> getOrderDetail() {
        return orderDetail;
    }

    public void setOrderDetail(Vector<OrderDetail> orderDetail) {
        this.orderDetail = orderDetail;
    }

    public String getPaymentMethod() {
        return PaymentMethod;
    }

    public void setPaymentMethod(String PaymentMethod) {
        this.PaymentMethod = PaymentMethod;
    }

    public String getEmail() {
        return Email;
    }

    public void setEmail(String Email) {
        this.Email = Email;
    }

    

    public int getOrderID() {
        return OrderID;
    }

    public void setOrderID(int OrderID) {
        this.OrderID = OrderID;
    }

    public Integer getCustomerID() {
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

    public int getOrderStatus() {
        return OrderStatus;
    }

    public void setOrderStatus(int OrderStatus) {
        this.OrderStatus = OrderStatus;
    }

    public int getShippingFee() {
        return ShippingFee;
    }

    public void setShippingFee(int ShippingFee) {
        this.ShippingFee = ShippingFee;
    }

    public int getDiscount() {
        return Discount;
    }

    public void setDiscount(int Discount) {
        this.Discount = Discount;
    }

    public String getCancelNotification() {
        return CancelNotification;
    }

    public void setCancelNotification(String CancelNotification) {
        this.CancelNotification = CancelNotification;
    }

    public String getNote() {
        return Note;
    }

    public void setNote(String Note) {
        this.Note = Note;
    }
      
}
