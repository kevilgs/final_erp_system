package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.CartItem;
import model.ProductPojo;
import operations.addtocart.Cart_Implementation;
import operations.addtocart.Cart_Interface;

@WebServlet("/AddToCart")
public class AddToCartController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final Cart_Interface cartInterface = new Cart_Implementation();
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        
        int productId = Integer.parseInt(request.getParameter("productId"));
        int quantity = 1; // Default quantity
        
        // Get current cart or create new one
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
        }
        
        // Check stock availability
        if (!cartInterface.checkStockAvailability(productId, quantity)) {
            response.sendRedirect("HomePage?error=outofstock");
            return;
        }
        
        // Get product details
        ProductPojo product = cartInterface.getProductById(productId);
        if (product != null) {
            // Check if product already in cart
            boolean found = false;
            for (CartItem item : cart) {
                if (item.getProduct().getId() == productId) {
                    item.setQuantity(item.getQuantity() + quantity);
                    found = true;
                    break;
                }
            }
            
            if (!found) {
                cart.add(new CartItem(product, quantity));
            }
            
            session.setAttribute("cart", cart);
            session.setAttribute("cartCount", cart.size());
            
            // Redirect back to previous page
            String category = request.getParameter("currentCategory");
            if (category != null && !category.isEmpty()) {
                response.sendRedirect("HomePage?Category=" + category);
            } else {
                response.sendRedirect("HomePage");
            }
        }
    }
}
