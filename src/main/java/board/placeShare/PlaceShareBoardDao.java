package board.placeShare;

import java.sql.Connection; 
import java.sql.PreparedStatement;
import java.sql.SQLException;

import mysql.db.DbConnect;

public class PlaceShareBoardDao {
	
	DbConnect db = new DbConnect();
	
	public void insertBoard(PlaceShareBoardDto dto) {
		Connection conn = db.getConnection();
		PreparedStatement pstmt = null;
		
		String sql = "insert into place_share_board values(?,?,?,?,?,now())";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getNickname());
			pstmt.setString(2, dto.getSubject());
			pstmt.setString(3, dto.getContent());
			pstmt.setString(4, dto.getPhotoName());
			pstmt.setString(5, dto.getTitlePhotoName());
			pstmt.execute();
		} catch (SQLException e) {
			System.out.println("INSERT ERROR: e.getMessage()");
		} finally {
			db.dbClose(pstmt, conn);
		}
	}
}
