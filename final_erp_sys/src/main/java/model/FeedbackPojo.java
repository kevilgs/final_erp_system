package model;

import java.util.List;

import admin_feedback_operations.FeedbackImp;

public class FeedbackPojo {
    // Private fields
    private int customerId;
    private String comments;
    private int ratings;
    private String timestamp;
    
    // Getters and setters
    public int getCustomerId() {
        return customerId;
    }
    
    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }
    
    public String getComments() {
        return comments;
    }
    
    public void setComments(String comments) {
        this.comments = comments;
    }
    
    public int getRatings() {
        return ratings;
    }
    
    public void setRatings(int ratings) {
        this.ratings = ratings;
    }
    
    public String getTimestamp() {
        return timestamp;
    }
    
    public void setTimestamp(String timestamp) {
        this.timestamp = timestamp;
    }
    
    public static List<FeedbackPojo > getAllFeedbackFromDatabase() {
        FeedbackImp feedbackImpl = new FeedbackImp(); // Create instance inside the method
        return feedbackImpl.getAllFeedback();
    }
}