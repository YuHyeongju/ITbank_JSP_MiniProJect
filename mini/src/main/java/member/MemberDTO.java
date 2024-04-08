package member;

//	�̸�          ��?       ����            
//	----------- -------- ------------- 
//	USERID      NOT NULL VARCHAR2(200) 
//	USERPW      NOT NULL VARCHAR2(300) 
//	NICKNAME    NOT NULL VARCHAR2(300) 
//	GENDER               VARCHAR2(50)  
//	PROFILE_IMG          VARCHAR2(500) 

public class MemberDTO {
	private String userid;
	private String userpw;
	private String nickname;
	private String email;
	private String gender;
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	private String profile_img;
	
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getUserpw() {
		return userpw;
	}
	public void setUserpw(String userpw) {
		this.userpw = userpw;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getProfile_img() {
		return profile_img;
	}
	public void setProfile_img(String profile_img) {
		this.profile_img = profile_img;
	}
	
}
