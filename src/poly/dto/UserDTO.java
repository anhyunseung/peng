package poly.dto;

public class UserDTO {

   private String user_no; // 
   private String user_id; // 
   private String user_name; // 
   private String email1; // 
   private String email2; // 
   private String tel_1; // 
   private String tel_2; // 
   private String tel_3; // 
   private String birthday;
   private String password;
   

   public String getUser_no() {
      return user_no;
   }

   public void setUser_no(String user_no) {
      this.user_no = user_no;
   }

   public String getUser_id() {
      return user_id;
   }

   public void setUser_id(String user_id) {
      this.user_id = user_id;
   }

   public String getUser_name() {
      return user_name;
   }

   public void setUser_name(String user_name) {
      this.user_name = user_name;
   }
   
   public String getPassword() {
	   return password;
   }
   public void setPassword(String password) {
	   this.password = password;
   }
   public String getEmail1() {
	   return email1;
   }
   public void setEmail1(String email1) {
	   this.email1 = email1;
   }
   public String getEmail2() {
	   return email2;
   }
   public void setEmail2(String email2) {
	   this.email2 = email2;
   }
   public String getTel_1() {
	   return tel_1;
   }
   public void setTel_1(String tel_1) {
	   this.tel_1 = tel_1;
   }
   public String getTel_2() {
	   return tel_2;
   }
   public void setTel_2(String tel_2) {
	   this.tel_2 = tel_2;
   }
   public String getTel_3() {
	   return tel_3;
   }
   public void setTel_3(String tel_3) {
	   this.tel_3 = tel_3;
   }
   public String getBirthday() {
	   return birthday;
   }
   public void setBirthday(String birthday) {
	   this.birthday = birthday;
   }
}