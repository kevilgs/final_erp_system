package operations;

import java.util.List;

import model.UserPojo;

public interface User_Management_Interface {

   public  List<UserPojo> getUserDetails();

    void activateUser(String MailID);

    void deactivateUser(String  MailID);

    void updateUser(UserPojo userPojo);

}