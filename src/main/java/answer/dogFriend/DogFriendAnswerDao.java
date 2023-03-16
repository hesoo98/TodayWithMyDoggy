package answer.dogFriend;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import mysql.db.DbConnect;

public class DogFriendAnswerDao {
	
	DbConnect db=new DbConnect();
	
	//insert
	public void insertAnswer(DogFriendAnswerDto dto) {
		
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		
		String sql="insert into dog_friend_answer value(null,?,?,?,now())";
		
		try {
			pstmt=conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getBoardNum());
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
	public List<DogFriendAnswerDto> showAnswers(String board_num){
		
		List<DogFriendAnswerDto> list=new ArrayList<DogFriendAnswerDto>();
		
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		String sql="select * from dog_friend_answer where board_num=? order by idx desc";
		
		try {
			pstmt=conn.prepareStatement(sql);
			
			pstmt.setString(1, board_num);
			
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				DogFriendAnswerDto dto=new DogFriendAnswerDto();
				
				dto.setIdx(rs.getString("idx"));
				dto.setId(rs.getString("id"));
				dto.setBoardNum(rs.getString("board_num"));
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
	
	//delete
	public void deleteAnswer(String idx) {
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		
		String sql="delete from dog_friend_answer where idx=?";
		
		try {
			pstmt=conn.prepareStatement(sql);
			
			pstmt.setString(1, idx);
			
			pstmt.execute();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.dbClose(pstmt, conn);
		}
		
				
	}
}