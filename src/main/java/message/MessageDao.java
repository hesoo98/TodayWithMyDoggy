package message;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import board.qna.QnaBoardDto;
import mysql.db.DbConnect;

public class MessageDao {
	
	DbConnect db=new DbConnect();
	
	//insert
	public void insertMessage(MessageDto dto) {
		
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		
		String sql="insert into message(sender, board_num, content, writeday) values(?,?,?,now())";
		
		try {
			pstmt=conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getSender());
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

}
