package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Reg_pojo;

import java.io.IOException;

/**
 * Servlet implementation class Register
 */
@WebServlet("/Register")
public class Register extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		Reg_pojo pojo = new Reg_pojo();
		pojo.setMail(request.getParameter("mail"));
		System.out.println(request.getParameter("mail"));
		pojo.setName(request.getParameter("name"));
		System.out.println(request.getParameter("name"));
		pojo.setPword(request.getParameter("pword"));
		System.out.println(request.getParameter("pword"));
		pojo.setRole(request.getParameter("role"));
		System.out.println(request.getParameter("role"));
		
		String result = pojo.registerUser(pojo);
		System.out.println(result);
		if("Successfully Registered!!".equals(result)) {
			response.sendRedirect("login.jsp");
			
		}else {
			request.getRequestDispatcher("Register.jsp").forward(request, response);
		}
	}

}
