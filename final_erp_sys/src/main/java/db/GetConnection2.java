package db;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
public class GetConnection2 {
    public static Connection getConnection() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection("jdbc:mysql://localhost:3306/demo_erp", "root", "1234");
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            return null;
        }
    }
}