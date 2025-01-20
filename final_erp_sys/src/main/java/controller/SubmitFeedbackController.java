package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.UserFeedbackPojo;
import operations.feedback.Feedback_Implementation;
import operations.feedback.Feedback_Interface;

@WebServlet("/SubmitFeedback")
public class SubmitFeedbackController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final Feedback_Interface feedbackInterface = new Feedback_Implementation();
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        int productId = Integer.parseInt(request.getParameter("productId"));
        int customerId = 1; // Replace with actual logged-in customer ID
        String comments = request.getParameter("comments");
        int rating = Integer.parseInt(request.getParameter("rating"));
        
        UserFeedbackPojo feedback = new UserFeedbackPojo();
        feedback.setProductId(productId);
        feedback.setCustomerId(customerId);
        feedback.setComments(comments);
        feedback.setRatings(rating);
        
        boolean success = feedbackInterface.submitFeedback(feedback);
        
        if (success) {
            response.sendRedirect("Feedback?message=success");
        } else {
            response.sendRedirect("Feedback?error=true");
        }
    }
}