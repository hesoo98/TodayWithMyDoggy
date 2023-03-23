package answer.placeShare;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.List;
import java.util.Vector;

import board.placeShare.PlaceShareBoardDto;
import mysql.db.DbConnect;

public class PlaceShareAnswerDao {

	DbConnect db = new DbConnect();
	
	//총 댓글 수
	public int getTotalAnswerCount(String boardnum) {
		int cnt = 0;
		
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		String sql="select count(*) from place_share_answer where board_num=?";
		
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, boardnum);
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				cnt = rs.getInt(1);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.dbClose(rs, pstmt, conn);
		}
		return cnt;
	}
	
	public void insertAnswer(PlaceShareAnswerDto dto) {
		Connection conn = db.getConnection();
		PreparedStatement pstmt = null;
		
		String sql = "insert into place_share_answer(board_num,id,content,writeday) values(?,?,?,now())";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getBoardNum());
			pstmt.setString(2, dto.getId());
			pstmt.setString(3, dto.getContent());
			pstmt.execute();
		} catch (SQLException e) {
			System.out.println("INSERT ERROR: " + e.getMessage());
		} finally {
			db.dbClose(pstmt, conn);
		}
	}
	
	//댓글 수정
	public void updateAnswer(PlaceShareAnswerDto dto) {
		Connection conn = db.getConnection();
		PreparedStatement pstmt = null;
		
		String sql = "update place_share_answer set content=? where idx=?";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getContent());
			pstmt.setString(2, dto.getIdx());
			pstmt.execute();
		} catch (SQLException e) {
			System.out.println("UPDATE ERROR: " + e.getMessage());
		} finally {
			db.dbClose(pstmt, conn);
		}
	}
	
	//댓글 목록 불러오기
	public List<PlaceShareAnswerDto> getAllAnswers(String boardnum) {
		List<PlaceShareAnswerDto> list = new Vector<>();
		Connection conn = db.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = "select * from place_share_answer where board_num=?";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, boardnum);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				PlaceShareAnswerDto dto = new PlaceShareAnswerDto();
				dto.setIdx(rs.getString("idx"));
				dto.setBoardNum(rs.getString("board_num"));
				dto.setId(rs.getString("id"));
				dto.setContent(rs.getString("content"));
				dto.setWriteday(rs.getTimestamp("writeday"));
				list.add(dto);
			}
		} catch (SQLException e) {
			System.out.println("getList ERROR: " + e.getMessage());
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
		
		String sql="delete from place_share_answer where idx=?";
		
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
	public PlaceShareAnswerDto getData(String idx) {

		PlaceShareAnswerDto dto = new PlaceShareAnswerDto();

		Connection conn = db.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = "select * from place_share_answer where idx=?";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, idx);

			rs = pstmt.executeQuery();

			while (rs.next()) {

				dto.setIdx(rs.getString("idx"));
				dto.setBoardNum(rs.getString("board_num"));
				dto.setId(rs.getString("id"));
				dto.setContent(rs.getString("content"));
				dto.setWriteday(rs.getTimestamp("writeday"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			db.dbClose(rs, pstmt, conn);
		}
		return dto;
	}
}
