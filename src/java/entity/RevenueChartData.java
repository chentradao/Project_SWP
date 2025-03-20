/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import java.util.List;

/**
 *
 * @author admin
 */
public class RevenueChartData {
    private List<String> labels;
    private List<Double> data;

    public List<String> getLabels() { return labels; }
    public void setLabels(List<String> labels) { this.labels = labels; }
    public List<Double> getData() { return data; }
    public void setData(List<Double> data) { this.data = data; }
}
