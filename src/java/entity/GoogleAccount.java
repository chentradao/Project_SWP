package entity;

/**
 * Represents a Google Account with various attributes returned from the Google API.
 */
public class GoogleAccount {
    // Các thuộc tính của tài khoản Google
    private String id;                // ID của tài khoản Google
    private String email;             // Địa chỉ email của tài khoản
    private String name;              // Tên đầy đủ của người dùng
    private String firstName;         // Tên đầu tiên của người dùng
    private String givenName;         // Tên được cấp (có thể giống tên đầu tiên)
    private String familyName;        // Họ của người dùng
    private String picture;           // URL đến hình ảnh đại diện
    private boolean verifiedEmail;    // Trạng thái email đã được xác minh

    // Constructor để khởi tạo đối tượng GoogleAccount
    public GoogleAccount(String id, String email, String name, String firstName, String givenName, String familyName, String picture, boolean verifiedEmail) {
        this.id = id;
        this.email = email;
        this.name = name;
        this.firstName = firstName;
        this.givenName = givenName;
        this.familyName = familyName;
        this.picture = picture;
        this.verifiedEmail = verifiedEmail;
    }

    // Getter và Setter cho các thuộc tính
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getGivenName() {
        return givenName;
    }

    public void setGivenName(String givenName) {
        this.givenName = givenName;
    }

    public String getFamilyName() {
        return familyName;
    }

    public void setFamilyName(String familyName) {
        this.familyName = familyName;
    }

    public String getPicture() {
        return picture;
    }

    public void setPicture(String picture) {
        this.picture = picture;
    }

    public boolean isVerifiedEmail() {
        return verifiedEmail;
    }

    public void setVerifiedEmail(boolean verifiedEmail) {
        this.verifiedEmail = verifiedEmail;
    }

    /**
     * Phương thức để lấy tên hiển thị cho người dùng.
     * Nếu tên không tồn tại, sẽ trả về địa chỉ email.
     * @return Tên hiển thị (hoặc email nếu tên không tồn tại)
     */
    public String getDisplayname() { // Đổi tên phương thức
        return (name != null && !name.isEmpty()) ? name : email; // Trả về tên nếu có, nếu không thì trả về email
    }

    public void setDisplayname(String displayname) { // Thêm phương thức setter
        this.name = displayname; // Nếu bạn muốn set tên hiển thị vào thuộc tính name
    }

    @Override
    public String toString() {
        return "GoogleAccount{" +
                "id='" + id + '\'' +
                ", email='" + email + '\'' +
                ", name='" + name + '\'' +
                ", firstName='" + firstName + '\'' +
                ", givenName='" + givenName + '\'' +
                ", familyName='" + familyName + '\'' +
                ", picture='" + picture + '\'' +
                ", verifiedEmail=" + verifiedEmail +
                '}';
    }
}
