/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import java.util.Date;

/**
 *
 * @author Administrator
 */

import java.util.Date;

public class Slider {
    private int sliderID;
    private String sliderTitle;
    private String imageURL;
    private Date startDate;
    private Date endDate;
    private int sliderAuthor;
    private int sliderStatus;

    public Slider() {
    }

    public Slider(int sliderID, String sliderTitle, String imageURL, Date startDate, Date endDate, int  sliderAuthor, int  sliderStatus) {
        this.sliderID = sliderID;
        this.sliderTitle = sliderTitle;
        this.imageURL = imageURL;
        this.startDate = startDate;
        this.endDate = endDate;
        this.sliderAuthor = sliderAuthor;
        this.sliderStatus = sliderStatus;
    }

    public int getSliderID() {
        return sliderID;
    }

    public void setSliderID(int sliderID) {
        this.sliderID = sliderID;
    }

    public String getSliderTitle() {
        return sliderTitle;
    }

    public void setSliderTitle(String sliderTitle) {
        this.sliderTitle = sliderTitle;
    }

    public String getImageURL() {
        return imageURL;
    }

    public void setImageURL(String imageURL) {
        this.imageURL = imageURL;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public int  getSliderAuthor() {
        return sliderAuthor;
    }

    public void setSliderAuthor(int  sliderAuthor) {
        this.sliderAuthor = sliderAuthor;
    }

    public int  getSliderStatus() {
        return sliderStatus;
    }

    public void setSliderStatus(int  sliderStatus) {
        this.sliderStatus = sliderStatus;
    }

    @Override
    public String toString() {
        return "Slider{" +
                "sliderID=" + sliderID +
                ", sliderTitle='" + sliderTitle + '\'' +
                ", imageURL='" + imageURL + '\'' +
                ", startDate=" + startDate +
                ", endDate=" + endDate +
                ", sliderAuthor='" + sliderAuthor + '\'' +
                ", sliderStatus='" + sliderStatus + '\'' +
                '}';
    }
}
