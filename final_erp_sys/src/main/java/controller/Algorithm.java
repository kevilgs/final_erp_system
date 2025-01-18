package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Algorithm_Pojo;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonElement;
import com.google.gson.JsonParser;

import java.io.IOException;

/**
 * Servlet implementation class Algorithm
 */
@WebServlet("/Algorithm")
public class Algorithm extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
    private String formatJson(String json) {
        try {
            Gson gson = new GsonBuilder().setPrettyPrinting().create();
            JsonElement jsonElement = JsonParser.parseString(json);
            return gson.toJson(jsonElement);
        } catch (Exception e) {
            return json;
        }
    }
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String algorithm = request.getParameter("algorithm");
		Algorithm_Pojo pojo = new Algorithm_Pojo();

		  
		
		try {
		    if ("salesTrend".equals(algorithm)) {
		        String sales = pojo.getsalestrendata(pojo);
		        request.setAttribute("salestrend", formatJson(sales));
		    } else if ("profit".equals(algorithm)) {
		        String profit = pojo.getproductprofitability(pojo);
		        request.setAttribute("profitanalysis", formatJson(profit));
		    }
		    else if ("abc".equals(algorithm)){
		        String abc = pojo.getabclassificationdata(pojo);
		        request.setAttribute("abc", formatJson(abc));
		    }
		    else if ("turnover".equals(algorithm)){
		        String turnover = pojo.getinventoryratio(pojo);
		        request.setAttribute("turnover", formatJson(turnover));
		    }
		    else if ("demandForecast".equals(algorithm)){
		        String demandForecast = pojo.getdemandforecastdata(pojo);
		        request.setAttribute("demandForecast", formatJson(demandForecast));
		    }
		    else if (algorithm != null){
		        request.setAttribute("errorMessage", "Invalid algorithm selected");
		    }

		    request.getRequestDispatcher("algorithm_monitoring.jsp").forward(request, response);

		} catch (Exception e) {
		    e.printStackTrace();
		    request.setAttribute("errorMessage", "An error occurred: " + e.getMessage());
		    request.getRequestDispatcher("/algorithm_monitoring.jsp").forward(request, response);
		}
}}

		


