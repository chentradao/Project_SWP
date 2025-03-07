package model;

import entity.Slider;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DAOSlider extends DBConnection {

    public int insertSlider(Slider slider) {
        String sql = "INSERT INTO Slider (SliderTitle, ImageURL, StartDate, EndDate, SliderAuthor, SliderStatus) VALUES (?, ?, ?, ?, ?, ?)";
        try ( PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, slider.getSliderTitle());
            ps.setString(2, slider.getImageURL());
            ps.setDate(3, new Date(slider.getStartDate().getTime()));
            ps.setDate(4, new Date(slider.getEndDate().getTime()));
            ps.setInt(5, slider.getSliderAuthor());
            ps.setShort(6, (short) slider.getSliderStatus());
            return ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Error inserting slider", e);
        }
    }

    public List<Slider> getAllSliders() {
        List<Slider> list = new ArrayList<>();
        String sql = "SELECT * FROM Slider";
        try ( PreparedStatement ps = conn.prepareStatement(sql);  ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new Slider(
                        rs.getInt("SliderID"),
                        rs.getString("SliderTitle"),
                        rs.getString("ImageURL"),
                        rs.getDate("StartDate"),
                        rs.getDate("EndDate"),
                        rs.getInt("SliderAuthor"),
                        rs.getShort("SliderStatus")
                ));
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error retrieving sliders", e);
        }
        return list;
    }

    public int updateSlider(Slider slider) {
        StringBuilder sql = new StringBuilder("UPDATE Slider SET SliderTitle=?, StartDate=?, EndDate=?, SliderAuthor=?, SliderStatus=?");
        if (slider.getImageURL() != null && !slider.getImageURL().isEmpty()) {
            sql.append(", ImageURL=?");
        }
        sql.append(" WHERE SliderID=?");

        try ( PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            int index = 1;
            ps.setString(index++, slider.getSliderTitle());
            ps.setDate(index++, new Date(slider.getStartDate().getTime()));
            ps.setDate(index++, new Date(slider.getEndDate().getTime()));
            ps.setInt(index++, slider.getSliderAuthor());
            ps.setShort(index++, (short) slider.getSliderStatus());

            if (slider.getImageURL() != null && !slider.getImageURL().isEmpty()) {
                ps.setString(index++, slider.getImageURL());
            }

            ps.setInt(index, slider.getSliderID());
            return ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Error updating slider", e);
        }
    }

    public int deleteSlider(int sliderID) {
        String sql = "DELETE FROM Slider WHERE SliderID = ?";
        try ( PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, sliderID);
            return ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Error deleting slider", e);
        }
    }

    public Slider getSliderById(int sliderID) {
        String sql = "SELECT * FROM Slider WHERE SliderID = ?";
        try ( PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, sliderID);
            try ( ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Slider(
                            rs.getInt("SliderID"),
                            rs.getString("SliderTitle"),
                            rs.getString("ImageURL"),
                            rs.getDate("StartDate"),
                            rs.getDate("EndDate"),
                            rs.getInt("SliderAuthor"),
                            rs.getShort("SliderStatus")
                    );
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error retrieving slider by ID", e);
        }
        return null;
    }

}
