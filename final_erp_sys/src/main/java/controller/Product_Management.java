package controller;

import java.io.IOException;
import java.sql.Date;
import java.util.List;

import admin_product_operations.Product_Implementation;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import model.Product_Pojo;

@WebServlet("/ProductController")
public class Product_Management extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Product_Implementation productDao = new Product_Implementation();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	String action = "list";
         action = request.getParameter("action");
//        System.out.println(action);
        if (action == null) {
            action = "list"; // Default action
        }

        try {
            switch (action) {
                case "new":
                    // Just set a flag to show the form in JSP
                    request.setAttribute("formAction", "add");
                    request.setAttribute("product", new Product_Pojo()); // Empty product for form
                    forwardToJsp(request, response);
                    break;
                case "edit":
                    int id = Integer.parseInt(request.getParameter("id"));
                    Product_Pojo existingProduct = productDao.getProductById(id);
                    request.setAttribute("product", existingProduct);
                    request.setAttribute("formAction", "update");
                    forwardToJsp(request, response);
                    break;
                case "delete":
                    deleteProduct(request, response);
                    break;
                default:
                	System.out.println("Action: " + action);

                    listProducts(request, response);
                    break;
            }
        } catch (Exception ex) {
            throw new ServletException(ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        System.out.println("Received action: " + action);

        try {
            switch (action) {
                case "add":
                	System.out.println("Add action is : ");
                    addProduct(request, response);
                    break;
                case "update":
                	System.out.println("Action is : "+action);
                    updateProduct(request, response);
                    break;
                default:
                    response.sendRedirect("ProductController?action=list");
                    break;
            }
        } catch (Exception ex) {
            throw new ServletException(ex);
        }
    }


    private void listProducts(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Product_Pojo> productList = productDao.getAllProducts();
//        System.out.println("Number of products: " + productList.size());
//        System.out.println(productDao.getAllProducts());
        request.setAttribute("productList", productList);
        forwardToJsp(request, response);
    }

    
    private void addProduct(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        // Retrieve form data from the request
        String name = request.getParameter("name");
        String category = request.getParameter("category");
        double cost = Double.parseDouble(request.getParameter("cost"));
        double sellingPrice = Double.parseDouble(request.getParameter("sellingPrice"));
        int stock = Integer.parseInt(request.getParameter("stock"));
        int reorderLevel = Integer.parseInt(request.getParameter("reorderLevel"));
        String supplierInfo = request.getParameter("supplierInfo");  // supplierInfo as a plain string
        Date expiryDate = Date.valueOf(request.getParameter("expiryDate"));

        // Create a JSON string for supplierInfo
        String supplierJson = "{\"Supplier\":\"" + supplierInfo + "\"}";

        // Create a new Product_Pojo instance and set its fields
        Product_Pojo product = new Product_Pojo();
        product.setP_Name(name);
        product.setP_Category(category);
        product.setP_Cost(cost);
        product.setP_SellingPrice(sellingPrice);
        product.setP_Stock(stock);
        product.setP_ReorderLevel(reorderLevel);
        product.setP_SupplierInfo(supplierJson);  // Set the JSON formatted supplierInfo
        product.setP_ExpiryDate(expiryDate);

        // Use Product_Implementation to save the product to the database
        productDao.addProduct(product);

        // After adding the product, redirect to the product list page
        response.sendRedirect("ProductController?action=list");
    }


    private void updateProduct(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Product_Pojo product = new Product_Pojo();
        product.setId(id);
        product.setP_Name(request.getParameter("name"));
        product.setP_Category(request.getParameter("category"));
        product.setP_Cost(Double.parseDouble(request.getParameter("cost")));
        product.setP_SellingPrice(Double.parseDouble(request.getParameter("sellingPrice")));
        product.setP_Stock(Integer.parseInt(request.getParameter("stock")));
        product.setP_ReorderLevel(Integer.parseInt(request.getParameter("reorderLevel")));

        // Construct the JSON manually
        String supplierInfoValue = request.getParameter("supplierInfo");
        String supplierJson = "{\"Supplier\":\"" + supplierInfoValue + "\"}";
        
        product.setP_SupplierInfo(supplierJson); // Store the JSON string

        product.setP_ExpiryDate(java.sql.Date.valueOf(request.getParameter("expiryDate")));

        productDao.updateProduct(product);
        response.sendRedirect("ProductController?action=list");
    }


    private void deleteProduct(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        productDao.deleteProduct(id);
        response.sendRedirect("ProductController?action=list");
    }

    private void forwardToJsp(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("product_management.jsp");  // Your single JSP page
        dispatcher.forward(request, response);
    }
}