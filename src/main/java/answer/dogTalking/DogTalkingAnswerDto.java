package answer.dogTalking;

import java.sql.Timestamp;

public class DogTalkingAnswerDto {

	private String idx;
	private String boardnum;
	private String id;
	private String content;
	private Timestamp writeday;
	
	public String getIdx() {
		return idx;
	}
	public void setIdx(String idx) {
		this.idx = idx;
	}
	public String getBoardnum() {
		return boardnum;
	}
	public void setBoardnum(String boardnum) {
		this.boardnum = boardnum;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Timestamp getWriteday() {
		return writeday;
	}
	public void setWriteday(Timestamp writeday) {
		this.writeday = writeday;
	}
	
	
}
