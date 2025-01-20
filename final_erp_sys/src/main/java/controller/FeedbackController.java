package controller;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.SalesPojo;
import operations.feedback.Feedback_Implementation;
import operations.feedback.Feedback_Interface;

@WebServlet("/Feedback")
public class FeedbackController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final Feedback_Interface feedbackInterface = new Feedback_Implementation();
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        int customerId = 1; // Replace with actual logged-in customer ID
        
        List<SalesPojo> purchasedProducts = feedbackInterface.getPurchasedProducts(customerId);
        request.setAttribute("purchasedProducts", purchasedProducts);
        
        request.getRequestDispatcher("RegUserFeedback.jsp").forward(request, response);
    }
}
