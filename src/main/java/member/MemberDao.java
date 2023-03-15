package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import mysql.db.DbConnect;

public class MemberDao {
	DbConnect db=new DbConnect();
	
	//insert
	public void addMember(MemberDto dto) {
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		
		String sql="insert into member values(null,?,?,?,?,?,?,now(),?)";
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, dto.getNickname());
			pstmt.setString(2, dto.getId());
			pstmt.setString(3, dto.getPassword());
			pstmt.setString(4, dto.getHp());
			pstmt.setString(5, dto.getAddr());
			pstmt.setString(6, dto.getEmail());
			pstmt.setInt(7, dto.getAuth());
			
			pstmt.execute();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.dbClose(pstmt, conn);
		}
	}
	
	//id중복체크
	public int isIdCheck(String id) {
		int isid=0;
		
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		ResultSet rs= null;
		
		String sql="select count(*) from member where id=?";
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs=pstmt.executeQuery();
			if(rs.next()) {//해당 아이디가 존재하면 1, 존재하지 않으면 0 반환
				
				isid=rs.getInt(1);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.dbClose(rs, pstmt, conn);
		}
		
		
		return isid;
	}
	
	//nickname중복체크
	public int isNicknameCheck(String nickname) {
		int isnickname=0;
		
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		ResultSet rs= null;
		
		String sql="select count(*) from member where nickname=?";
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, nickname);
			
			rs=pstmt.executeQuery();
			if(rs.next()) {//해당 닉네임이 존재하면 1, 존재하지 않으면 0 반환
				
				isnickname=rs.getInt(1);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.dbClose(rs, pstmt, conn);
		}
		
		
		return isnickname;
	}
	
	//아이디, 비번 체크
	public boolean isIdPasswordCheck(String id, String password) {
		boolean b=false;
		
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		String sql="select * from member where id=? and password=?";
		
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, password);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				b=true;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.dbClose(rs, pstmt, conn);
			
		}
		
		return b;
	}
	
	//id에 따른 nickname값 return
	public String getNickname(String id) {
		String nickname="";
		
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		String sql="select * from member where id=?";
		
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				nickname=rs.getString("nickname");
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.dbClose(rs, pstmt, conn);
		}
		
		return nickname;
	}
	//id에 따른 auth값 return
	//재승이 영역인데 필요해서 김희수가 추가함.
	public String getAuth(String id) {
		String auth = "0";
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		String sql = "select * from member where id=?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				//auth = rs.getInt("auth");
				auth = rs.getString("auth");
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return auth;
	}
	
	public String getNum(String id) {
		String num = "0";
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		String sql = "select * from member where id=?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				//auth = rs.getInt("auth");
				num = rs.getString("num");
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return num;
	}


}
