package profile.dogProfile;

public class DogProfileDto {
	private String idx;
	private String memberNum;
	private String name;
	private String gender;
	private String dogSize;
	private String birthday;
	private String photo;
	private int mainDog;
	
	public int getMainDog() {
		return mainDog;
	}
	public void setMainDog(int mainDog) {
		this.mainDog = mainDog;
	}
	public String getIdx() {
		return idx;
	}
	public void setIdx(String idx) {
		this.idx = idx;
	}
	public String getMemberNum() {
		return memberNum;
	}
	public void setMemberNum(String memberNum) {
		this.memberNum = memberNum;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getDogSize() {
		return dogSize;
	}
	public void setDogSize(String dogSize) {
		this.dogSize = dogSize;
	}
	public String getBirthday() {
		return birthday;
	}
	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}
	public String getPhoto() {
		return photo;
	}
	public void setPhoto(String photo) {
		this.photo = photo;
	}
}
