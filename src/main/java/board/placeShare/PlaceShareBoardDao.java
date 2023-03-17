package board.placeShare;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.Vector;

import board.dogTalking.DogTalkingBoardDto;
import mysql.db.DbConnect;

public class PlaceShareBoardDao {

	DbConnect db = new DbConnect();

	public void insertBoard(PlaceShareBoardDto dto) {
		Connection conn = db.getConnection();
		PreparedStatement pstmt = null;

		String sql = "insert into place_share_board(id,subject,content,photo_name,title_photo_name,writeday) values(?,?,?,?,?,now())";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getSubject());
			pstmt.setString(3, dto.getContent());
			pstmt.setString(4, dto.getPhotoName());
			pstmt.setString(5, dto.getTitlePhotoName());
			pstmt.execute();
		} catch (SQLException e) {
			System.out.println("INSERT ERROR: " + e.getMessage());
		} finally {
			db.dbClose(pstmt, conn);
		}
	}

	public int getTotalCount() {
		int cnt = 0;
		return cnt;
	}

	public List<PlaceShareBoardDto> getBoardList() {
		List<PlaceShareBoardDto> list = new Vector<>();
		Connection conn = db.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = "select * from place_share_board order by num desc";

		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				PlaceShareBoardDto dto = new PlaceShareBoardDto();
				dto.setNum(rs.getString("num"));
				dto.setId(rs.getString("id"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setPhotoName(rs.getString("photo_name"));
				dto.setWriteday(rs.getTimestamp("writeday"));
				dto.setReadCount(rs.getInt("read_count"));
				dto.setLikes(rs.getInt("likes"));
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

	public PlaceShareBoardDto getData(String num) {

		PlaceShareBoardDto dto = new PlaceShareBoardDto();

		Connection conn = db.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = "select * from place_share_board where num=?";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, num);

			rs = pstmt.executeQuery();

			while (rs.next()) {

				dto.setNum(rs.getString("num"));
				dto.setId(rs.getString("id"));
				dto.setSubject(rs.getString("subject"));
				dto.setPhotoName(rs.getString("photo_name"));
				dto.setContent(rs.getString("content"));
				dto.setWriteday(rs.getTimestamp("writeday"));
				dto.setReadCount(rs.getInt("read_count"));
				dto.setLikes(rs.getInt("likes"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			db.dbClose(rs, pstmt, conn);
		}
		return dto;
	}
}
