package model;

import reg_operations.Reg_op_implement;

public class Reg_pojo {
	
	private String mail;
	private String name;
	private String pword;
	private String role;
	public String getMail() {
		return mail;
	}
	public void setMail(String mail) {
		this.mail = mail;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
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

	public String registerUser(Reg_pojo pojo) {
		
		Reg_op_implement implement = new Reg_op_implement();
		try {
			return implement.registerUser(pojo);
		} catch (Exception e) {
			
			return "Error During Registration";
		}
		
	}
}
