package operations.viewfeedback;

import java.util.List;
import model.UserFeedbackPojo;

public interface FeedbackInterface {
    List<UserFeedbackPojo> getFeedbacksByCustomerId(int customerId);
}