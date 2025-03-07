package entity;

public class FeedbackStats {

    private int oneStar;
    private int twoStar;
    private int threeStar;
    private int fourStar;
    private int fiveStar;
    private double averageStars;
    private int totalReviews;

    public FeedbackStats() {
    }

    public FeedbackStats(int oneStar, int twoStar, int threeStar, int fourStar, int fiveStar, double averageStars) {
        this.oneStar = oneStar;
        this.twoStar = twoStar;
        this.threeStar = threeStar;
        this.fourStar = fourStar;
        this.fiveStar = fiveStar;
        this.averageStars = averageStars;
        this.totalReviews = oneStar + twoStar + threeStar + fourStar + fiveStar;
    }

    public int getOneStar() {
        return oneStar;
    }

    public void setOneStar(int oneStar) {
        this.oneStar = oneStar;
        updateTotalReviews();
    }

    public int getTwoStar() {
        return twoStar;
    }

    public void setTwoStar(int twoStar) {
        this.twoStar = twoStar;
        updateTotalReviews();
    }

    public int getThreeStar() {
        return threeStar;
    }

    public void setThreeStar(int threeStar) {
        this.threeStar = threeStar;
        updateTotalReviews();
    }

    public int getFourStar() {
        return fourStar;
    }

    public void setFourStar(int fourStar) {
        this.fourStar = fourStar;
        updateTotalReviews();
    }

    public int getFiveStar() {
        return fiveStar;
    }

    public void setFiveStar(int fiveStar) {
        this.fiveStar = fiveStar;
        updateTotalReviews();
    }

    public double getAverageStars() {
        return averageStars;
    }

    public void setAverageStars(double averageStars) {
        this.averageStars = averageStars;
    }

    public int getTotalReviews() {
        return totalReviews;
    }

    private void updateTotalReviews() {
        this.totalReviews = oneStar + twoStar + threeStar + fourStar + fiveStar;
    }

    public void setTotalReviews(int totalReviews) {
        this.totalReviews = totalReviews;
    }

}
