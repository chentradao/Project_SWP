/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

/**
 *
 * @author admin
 */
public class SalesData {
    String year_Month;
    int total;

    public SalesData() {
    }

    public SalesData(String year_Month, int total) {
        this.year_Month = year_Month;
        this.total = total;
    }

    public String getYear_Month() {
        return year_Month;
    }

    public void setYear_Month(String year_Month) {
        this.year_Month = year_Month;
    }

    public int getTotal() {
        return total;
    }

    public void setTotal(int total) {
        this.total = total;
    }
    
    
    
}
