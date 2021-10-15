package pop;

public class User {
    private String name;
    private int age;
    private String gender;

    public User(String name, int age, String gender) {
        this.name = name;
        this.age = age;
        this.gender = gender;
    }

    public static User praseFrom(String userInfoText) { // 将text(“小王&28&男”)解析成类User
        return null;
    }

    public String formatToText() { // 将类User格式化成文本（"小王\t28\t男"）
        return null;
    }
}
