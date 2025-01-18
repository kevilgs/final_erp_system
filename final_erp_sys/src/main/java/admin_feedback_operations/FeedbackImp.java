package admin_feedback_operations;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import db.GetConnection;
import model.FeedbackPojo;

public class FeedbackImp implements Feedback {

  public List<FeedbackPojo> getAllFeedback() {
    List<FeedbackPojo> feedbackList = new ArrayList<>();

    try (Connection connection = GetConnection.getConnection()) {
      if (connection == null) {
        System.out.println("Database connection failed!");
        return feedbackList;
      }

      String sql = "SELECT * FROM demo_erp.feedback";
      try (PreparedStatement preparedStatement = connection.prepareStatement(sql);
          ResultSet resultSet = preparedStatement.executeQuery()) {

        while (resultSet.next()) {
          FeedbackPojo feedback = new FeedbackPojo();
          feedback.setCustomerId(resultSet.getInt("CustomerID"));
          feedback.setComments(resultSet.getString("Comments"));
          feedback.setRatings(resultSet.getInt("Ratings"));
          feedback.setTimestamp(resultSet.getString("Timestamp"));
          feedbackList.add(feedback);
        }
      }
    } catch (SQLException e) {
      System.out.println("Error fetching feedback: " + e.getMessage());
      e.printStackTrace();
    }

    return feedbackList;
  }
}
