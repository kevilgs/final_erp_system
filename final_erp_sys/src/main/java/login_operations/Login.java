package login_operations;

import model.Login_pojo;

public interface Login {

	String loginuser(Login_pojo pojo);

	String adminuser(Login_pojo pojo);

}
