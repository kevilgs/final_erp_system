package reg_operations;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import db.GetConnection;
import model.Reg_pojo;

public class Reg_op_implement implements Register {

	@Override
	public String registerUser(Reg_pojo pojo) {
		
		String result=null;
		
		try {
			CallableStatement callableStatement = GetConnection.getConnection().prepareCall("SELECT demo_erp.Registration(?,?,?,?)");
			callableStatement.setString(1, pojo.getMail());
			callableStatement.setString(2, pojo.getName());
			callableStatement.setString(3, pojo.getPword());
			callableStatement.setString(4, pojo.getRole());
			
			ResultSet rs = callableStatement.executeQuery();
			
			if(rs.next()) {
				
				 result = rs.getString(1);
				
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return result;
	}
		
	
	

}
