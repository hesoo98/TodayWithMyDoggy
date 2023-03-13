package board.notification;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import mysql.db.DbConnect;

public class NotificationDao {
	DbConnect db = new DbConnect();
	
	//공지사항 insert
	public void insertNotification(NotificationDto dto) {
		Connection conn = db.getConnection();
		PreparedStatement pstmt = null;

		String sql = "insert into notification_board (title,content,writeday) values (?,?,now())";
		
		try {
			pstmt = conn.prepareStatement(sql);
			//pstmt.setString(1, dto.getNum());
			pstmt.setString(1, dto.getTitle());
			pstmt.setString(2, dto.getContent());
			
			pstmt.execute();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.dbClose(pstmt, conn);
		}
	}
	
	// 공지사항 전체목록 출력 메서드
		public List<NotificationDto> getAllNotifications() {
			Connection conn = db.getConnection();
			List<NotificationDto> list = new ArrayList<>();
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = "select * from notification_board order by num";

			try {
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();

				while (rs.next()) {
					NotificationDto dto = new NotificationDto();
					dto.setNum(rs.getString("num"));
					dto.setTitle(rs.getString("title"));
					dto.setContent(rs.getString("content"));
					dto.setWriteday(rs.getTimestamp("writeday"));
					list.add(dto);
				}
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				db.dbClose(rs, pstmt, conn);
			}
			return list;
		}
		
		// num에 대한 하나의 공지dto조회
		public NotificationDto getData(String num) {
			NotificationDto dto = new NotificationDto();

			Connection conn = db.getConnection();
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = "select * from notification_board where num = ?";

			try {
				pstmt = conn.prepareStatement(sql);

				pstmt.setString(1, num);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					dto.setNum(rs.getString("num"));
					dto.setTitle(rs.getString("title"));
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

		// 공지사항 수정
		public void updateNotification(NotificationDto dto) {
			Connection conn = db.getConnection();
			PreparedStatement pstmt = null;

			String sql = "update notification_board set title=?, content=? where num=?";

			try {
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, dto.getTitle());
				pstmt.setString(2, dto.getContent());
				pstmt.setString(3, dto.getNum());
				pstmt.execute();
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				db.dbClose(pstmt, conn);
			}
		}
}
