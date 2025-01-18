package admin_dashboard;

import model.Admin_Dashoboard_Pojo;

public interface Admin_Dashboard_Operations {
	
	String getsalestrendata(Admin_Dashoboard_Pojo pojo);
	String getdemandforecastdata(Admin_Dashoboard_Pojo pojo);
	String getabclassificationdata(Admin_Dashoboard_Pojo pojo);
	String getinvenotoryratio(Admin_Dashoboard_Pojo pojo);
	String getproductprfotability(Admin_Dashoboard_Pojo pojo);

}
