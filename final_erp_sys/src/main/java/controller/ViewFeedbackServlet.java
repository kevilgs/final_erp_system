package controller;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.UserFeedbackPojo;
import operations.viewfeedback.FeedbackInterface;
import operations.viewfeedback.FeedbackImplementation;

@WebServlet("/ViewFeedbacks")
public class ViewFeedbackServlet extends HttpServlet {
    private final FeedbackInterface feedbackService = new FeedbackImplementation();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // For demo purposes, using customerId = 1
        int customerId = 1;
        
        List<UserFeedbackPojo> feedbacks = feedbackService.getFeedbacksByCustomerId(customerId);
        request.setAttribute("feedbacks", feedbacks);
        request.getRequestDispatcher("viewFeedback.jsp").forward(request, response);
    }
}