package operations.regularuser;

import model.RegUserPojo;

public interface RegularUserInterface {
    RegUserPojo getUserById(int userId);
    boolean updateUserDetails(int userId, String name, String email);
}
