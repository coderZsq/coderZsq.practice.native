package pop.compare;

import java.util.ArrayList;
import java.util.List;

public class UserFileFormatter {
    public void format(String userFile, String formattedUserFile) {
        // Open files...
        String userText = null;
        List users = new ArrayList<>();
        while (true) { // read until file is empty
            // read from file into userText...
            User user = User.praseFrom(userText);
            users.add(user);

            if (true) break;
        }
        // sort users by age...
        for (int i = 0; i < users.size(); ++i) {
            User user = null;
            String formattedUserText = user.formatToText();
            // write to new file...
        }
        // close files...
    }
}
