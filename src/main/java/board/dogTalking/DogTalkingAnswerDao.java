package board.dogTalking;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import mysql.db.DbConnect;

public class DogTalkingAnswerDao {

	DbConnect db=new DbConnect();
	
	//insert
	public void insertAnswer(DogTalkingAnswerDto dto) {
		
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		
		String sql="insert into dog_talking_answer value(null,?,?,?,now())";
		
		try {
			pstmt=conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getBoardnum());
			pstmt.setString(2, dto.getNickname());
			pstmt.setString(3, dto.getContent());
			
			pstmt.execute();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.dbClose(pstmt, conn);
		}
	}
	
	//select
	public List<DogTalkingAnswerDto> showAnswers(String board_num){
		
		List<DogTalkingAnswerDto> list=new ArrayList<DogTalkingAnswerDto>();
		
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		String sql="select * from dog_talking_answer where board_num=? order by idx desc";
		
		try {
			pstmt=conn.prepareStatement(sql);
			
			pstmt.setString(1, board_num);
			
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				DogTalkingAnswerDto dto=new DogTalkingAnswerDto();
				
				dto.setIdx(rs.getString("idx"));
				dto.setNickname(rs.getString("nickname"));
				dto.setBoardnum(rs.getString("boardnum"));
				dto.setContent(rs.getString("content"));
				dto.setWriteday(rs.getTimestamp("writeday"));
				
				list.add(dto);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.dbClose(rs, pstmt, conn);
		}
		
		
		return list;
	}
}
