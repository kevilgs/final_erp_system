package db;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
public class GetConnection2 {
	public static Connection getConnection() {
	    try {
	        Class.forName("com.mysql.jdbc.Driver");
	        Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/demo_erp", "root", "1234");
	        System.out.println("Database connected successfully.");
	        return connection;
	    } catch (ClassNotFoundException | SQLException e) {
	        e.printStackTrace();
	        System.out.println("Database connection failed.");
	        return null;
	    }
	}

}