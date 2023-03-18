package board.placeShare;

import java.sql.Timestamp;

public class PlaceShareBoardDto {
	private String num;
	private String id;
	private String subject;
	private String content;
	private String photoName;
	private Timestamp writeday;
	private int readCount;
	private int likes;
	private String placeLa;
	private String placeMa;
	
	public String getNum() {
		return num;
	}
	public void setNum(String num) {
		this.num = num;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getPhotoName() {
		return photoName;
	}
	public void setPhotoName(String photoName) {
		this.photoName = photoName;
	}
	public Timestamp getWriteday() {
		return writeday;
	}
	public void setWriteday(Timestamp writeday) {
		this.writeday = writeday;
	}
	public int getReadCount() {
		return readCount;
	}
	public void setReadCount(int readCount) {
		this.readCount = readCount;
	}
	public int getLikes() {
		return likes;
	}
	public void setLikes(int likes) {
		this.likes = likes;
	}
	public String getPlaceLa() {
		return placeLa;
	}
	public void setPlaceLa(String placeLa) {
		this.placeLa = placeLa;
	}
	public String getPlaceMa() {
		return placeMa;
	}
	public void setPlaceMa(String placeMa) {
		this.placeMa = placeMa;
	}
}
