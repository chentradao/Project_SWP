/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import java.math.BigDecimal;

/**
 *
 * @author admin
 */
public class RevenueSummary1 {

    private BigDecimal totalRevenue;
    private int totalSold;
    private int totalStock;

    public RevenueSummary1() {
    }

    public RevenueSummary1(BigDecimal totalRevenue, int totalSold, int totalStock) {
        this.totalRevenue = totalRevenue;
        this.totalSold = totalSold;
        this.totalStock = totalStock;
    }   
    
    public BigDecimal getTotalRevenue() {
        return totalRevenue;
    }

    public void setTotalRevenue(BigDecimal totalRevenue) {
        this.totalRevenue = totalRevenue;
    }

    public int getTotalSold() {
        return totalSold;
    }

    public void setTotalSold(int totalSold) {
        this.totalSold = totalSold;
    }

    public int getTotalStock() {
        return totalStock;
    }

    public void setTotalStock(int totalStock) {
        this.totalStock = totalStock;
    }
}
