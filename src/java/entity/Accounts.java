/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import java.util.Date;

/**
 *
 * @author Admin
 */
public class Accounts {

    private int AccountID;
    private String UserName;
    private String Password;
    private String FullName;
    private String Gender;
    private String Phone;
    private String Email;
    private String Address;
    private String Role;
    private String Image;
    private String GoogleID;
    private Date CreateDate;
    private int OrderQuality;
    private int TotalSpending;
    private int AccountStatus;

    public Accounts() {
    }

    public Accounts(int AccountID, String UserName, String Password, String FullName, String Gender, String Phone, String Email, String Address, String Role, String Image, String GoogleID, Date CreateDate, int OrderQuality, int TotalSpending, int AccountStatus) {
        this.AccountID = AccountID;
        this.UserName = UserName;
        this.Password = Password;
        this.FullName = FullName;
        this.Gender = Gender;
        this.Phone = Phone;
        this.Email = Email;
        this.Address = Address;
        this.Role = Role;
        this.Image = Image;
        this.GoogleID = GoogleID;
        this.CreateDate = CreateDate;
        this.OrderQuality = OrderQuality;
        this.TotalSpending = TotalSpending;
        this.AccountStatus = AccountStatus;
    }

    public int getAccountID() {
        return AccountID;
    }

    public void setAccountID(int AccountID) {
        this.AccountID = AccountID;
    }

    public String getUserName() {
        return UserName;
    }

    public void setUserName(String UserName) {
        this.UserName = UserName;
    }

    public String getPassword() {
        return Password;
    }

    public void setPassword(String Password) {
        this.Password = Password;
    }

    public String getFullName() {
        return FullName;
    }

    public void setFullName(String FullName) {
        this.FullName = FullName;
    }

    public String getGender() {
        return Gender;
    }

    public void setGender(String Gender) {
        this.Gender = Gender;
    }

    public String getPhone() {
        return Phone;
    }

    public void setPhone(String Phone) {
        this.Phone = Phone;
    }

    public String getEmail() {
        return Email;
    }

    public void setEmail(String Email) {
        this.Email = Email;
    }

    public String getAddress() {
        return Address;
    }

    public void setAddress(String Address) {
        this.Address = Address;
    }

    public String getRole() {
        return Role;
    }

    public void setRole(String Role) {
        this.Role = Role;
    }

    public String getImage() {
        return Image;
    }

    public void setImage(String Image) {
        this.Image = Image;
    }

    public String getGoogleID() {
        return GoogleID;
    }

    public void setGoogleID(String GoogleID) {
        this.GoogleID = GoogleID;
    }

    public Date getCreateDate() {
        return CreateDate;
    }

    public void setCreateDate(Date CreateDate) {
        this.CreateDate = CreateDate;
    }

    public int getOrderQuality() {
        return OrderQuality;
    }

    public void setOrderQuality(int OrderQuality) {
        this.OrderQuality = OrderQuality;
    }

    public int getTotalSpending() {
        return TotalSpending;
    }

    public void setTotalSpending(int TotalSpending) {
        this.TotalSpending = TotalSpending;
    }

    public int getAccountStatus() {
        return AccountStatus;
    }

    public void setAccountStatus(int AccountStatus) {
        this.AccountStatus = AccountStatus;
    }

    /**
     *
     * @return
     */
    @Override
    public String toString() {
        return "Accounts{"
                + "AccountID=" + AccountID
                + ", UserName='" + UserName + '\''
                + ", Password='" + Password + '\''
                + ", FullName='" + FullName + '\''
                + ", Gender='" + Gender + '\''
                + ", Phone='" + Phone + '\''
                + ", Email='" + Email + '\''
                + ", Address='" + Address + '\''
                + ", Role=" + Role + '\''
                + ", Image='" + Image + '\''
                + ", GoogleID='" + GoogleID + '\''
                + ", CreateDate=" + CreateDate + '\''
                + ", OrderQuality=" + OrderQuality + '\''
                + ", TotalSpending=" + TotalSpending + '\''
                + ", AccountStatus=" + AccountStatus
                + '}';
    }

}