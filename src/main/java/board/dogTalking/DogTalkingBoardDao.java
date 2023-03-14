package board.dogTalking;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import mysql.db.DbConnect;

public class DogTalkingBoardDao {

	DbConnect db=new DbConnect();
	
	//insert
	public void insertBoard(DogTalkingBoardDto dto) {
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;

		String sql="insert into dog_talking_board(nickname,subject,photo,content,writeday) values(?,?,?,?,now())";
		
		try {
			pstmt=conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getNickname());
			pstmt.setString(2, dto.getSubject());
			pstmt.setString(3, dto.getPhoto());
			pstmt.setString(4, dto.getContent());
			
			pstmt.execute();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.dbClose(pstmt, conn);
		}
		
	}
	
	//전체개수 (0개의 글이 있습니다.)
		public int getTotalCount() {
			int n=0;
			
			Connection conn=db.getConnection();
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			
			String sql="select count(*) from dog_talking_board";
			
			try {
				pstmt=conn.prepareStatement(sql);
				rs=pstmt.executeQuery();
				
				if(rs.next()) {
					n=rs.getInt(1);
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally {
				db.dbClose(rs, pstmt, conn);
			}
			
			return n;
		}
		
	
	//read
	//페이지에서 필요한만큼만 리턴 (for paging)
	public List<DogTalkingBoardDto> getList(int start,int perpage){
		List<DogTalkingBoardDto> list=new ArrayList<DogTalkingBoardDto>();
		
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		String sql="select * from dog_talking_board order by num desc limit ?,?";
		
		try {
			pstmt=conn.prepareStatement(sql);
			
			pstmt.setInt(1, start);
			pstmt.setInt(2, perpage);
			
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				DogTalkingBoardDto dto=new DogTalkingBoardDto();
				
				dto.setNum(rs.getString("num"));
				dto.setNickname(rs.getString("nickname"));
				dto.setSubject(rs.getString("subject"));
				dto.setPhoto(rs.getString("photo"));
				dto.setContent(rs.getString("content"));
				dto.setWriteday(rs.getTimestamp("writeday"));
				dto.setReadCount(rs.getInt("readcount"));
				dto.setLikes(rs.getInt("likes"));
				
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
	
	//getdata for detailpage
	public DogTalkingBoardDto getData(String num) {
		
		DogTalkingBoardDto dto=new DogTalkingBoardDto();
		
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		String sql="select * from dog_talking_board where num=?";
		
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, num);
			
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				
				dto.setNum(rs.getString("num"));
				dto.setNickname(rs.getString("nickname"));
				dto.setSubject(rs.getString("subject"));
				dto.setPhoto(rs.getString("photo"));
				dto.setContent(rs.getString("content"));
				dto.setWriteday(rs.getTimestamp("writeday"));
				dto.setReadCount(rs.getInt("readcount"));
				dto.setLikes(rs.getInt("likes"));
				
			}
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.dbClose(rs, pstmt, conn);
		}
		
		return dto;
	}
	
	//delete
	public void deleteBoard(String num) {
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		
		String sql="delete from dog_talking_board where num=?";
		
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, num);
			
			pstmt.execute();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.dbClose(pstmt, conn);
		}
		
		
	}
	
	//좋아요
	public void updateLikes(String num) {
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		
		String sql="update dog_talking_board set likes=likes+1 where num=?";
		
		try {
			pstmt=conn.prepareStatement(sql);
			
			pstmt.setString(1, num);
			pstmt.execute();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.dbClose(pstmt, conn);
		}	
		
	}
		
}
