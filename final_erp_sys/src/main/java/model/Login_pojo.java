package model;

import login_operations.Login_op_implement;

public class Login_pojo {
	
	private String pname;
	private String pword;
	private String role;
	public String getPname() {
		return pname;
	}
	public void setPname(String pname) {
		this.pname = pname;
	}
	public String getPword() {
		return pword;
	}
	public void setPword(String pword) {
		this.pword = pword;
	}
	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
	}

	public String loginuser(Login_pojo pojo) {
		 Login_op_implement login_op_implement = new Login_op_implement();
		 try {
			return login_op_implement.loginuser(pojo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return "Error during Authetication";
		}
	}


	public String adminuser(Login_pojo pojo) {
		 Login_op_implement login_op_implement = new Login_op_implement();
		 try {
			return login_op_implement.adminuser(pojo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return "Error during Authetication";
		}
	}
	}
