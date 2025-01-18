package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Login_pojo;

import java.io.IOException;

/**
 * Servlet implementation class Login
 */
@WebServlet("/Login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String role = request.getParameter("role");
		
		Login_pojo login_pojo = new Login_pojo();
		login_pojo.setPname(request.getParameter("pname"));
		login_pojo.setPword(request.getParameter("ppass"));
	
		
		if("Admin".equals(role)) {
			String result= login_pojo.adminuser(login_pojo);
			System.out.println(result);
			if ("Authentication Successful!".equals(result)) {
				
				response.sendRedirect("Admin_Dashboard");
				
			}else {
				request.getRequestDispatcher("login.jsp").forward(request, response);
			}
			
		}else if("Regular".equals(role)) {
			String result= login_pojo.loginuser(login_pojo);
			System.out.println(result);
			
			if ("Authentication Successful!".equals(result) ) {
				
				response.sendRedirect("browse.jsp");
				
			}else {
				request.getRequestDispatcher("login.jsp").forward(request, response);
			}
		}
		
		
		
		
		
		

}}
