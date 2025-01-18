package login_operations;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import db.GetConnection;
import model.Login_pojo;

public class Login_op_implement implements Login {

	@Override
	public String loginuser(Login_pojo pojo) {

		String result = null;
		CallableStatement callableStatement;

		try {
			callableStatement = GetConnection.getConnection().prepareCall("SELECT demo_erp.Authentication(?,?)");
			callableStatement.setString(1, pojo.getPname());
			callableStatement.setString(2, pojo.getPword());

			ResultSet rs = callableStatement.executeQuery();

			if (rs.next()) {

				result = rs.getString(1);

			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("errorrr");
		}

		return result;
	}

	@Override
	public String adminuser(Login_pojo pojo) {
		String result = null;
		CallableStatement callableStatement;

		try {
			callableStatement = GetConnection.getConnection().prepareCall("SELECT demo_erp.AdminAuthentication(?,?)");
			callableStatement.setString(1, pojo.getPname());
			callableStatement.setString(2, pojo.getPword());

			ResultSet rs = callableStatement.executeQuery();

			if (rs.next()) {

				result = rs.getString(1);

			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("errorrr");
		}

		return result;
	}

}
