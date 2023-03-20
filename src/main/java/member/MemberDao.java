package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.Vector;

import board.placeShare.PlaceShareBoardDto;
import mysql.db.DbConnect;
import profile.dogProfile.DogProfileDto;

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
		} finally {
			db.dbClose(rs, pstmt, conn);
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
		} finally {
			db.dbClose(rs, pstmt, conn);
		}
		return num;
	}

	public MemberDto getMemeber(String id) {

		MemberDto dto = new MemberDto();

		Connection conn = db.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = "select * from member where id=?";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				dto.setNickname(rs.getString("nickname"));
				dto.setId(rs.getString("id"));
				dto.setHp(rs.getString("hp"));
				dto.setAddr(rs.getString("addr"));
				dto.setEmail(rs.getString("email"));
				dto.setCreateDay(rs.getTimestamp("create_day"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			db.dbClose(rs, pstmt, conn);
		}
		return dto;
	}

	//hp에 따른 id값 리턴
	public String getId(String hp) {
		String id="";
		Connection conn = db.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = "select id from member where hp=?";

			try {
				pstmt=conn.prepareStatement(sql);
				pstmt.setString(1, hp);
				
				rs=pstmt.executeQuery();
				
				if(rs.next()) {
					id=rs.getString("id");
				}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			db.dbClose(rs, pstmt, conn);
		}
		return id;
		}
	//id에 따른 password값 리턴
		public String getPassword(String id) {
			String password="";
			
			Connection conn = db.getConnection();
			PreparedStatement pstmt = null;
			ResultSet rs = null;

			String sql = "select password from member where id=?";

				try {
					pstmt=conn.prepareStatement(sql);
					pstmt.setString(1, id);
					
					rs=pstmt.executeQuery();
					
					if(rs.next()) {
						password=rs.getString("password");
					}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				db.dbClose(rs, pstmt, conn);
			}
			return password;
			}
		
		// dto받아와서 멤버의 프로필 수정
		public void updateMemberProfile(MemberDto dto) {
			Connection conn = db.getConnection();
			PreparedStatement pstmt = null;

			String sql = "update member set nickname=?, hp=?, email=?,addr=? where id=?";

			try {
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, dto.getNickname());
				pstmt.setString(2, dto.getHp());
				pstmt.setString(3, dto.getEmail());
				pstmt.setString(4, dto.getAddr());
				pstmt.setString(5, dto.getId());
				
				pstmt.execute();
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				db.dbClose(pstmt, conn);
			}
		}
		
		//모든 사용자 dto 리스트 반환
		public List<MemberDto> getAllUserList() {
			List<MemberDto> list = new Vector<>();
			Connection conn = db.getConnection();
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = "select * from member order by num desc";

			try {
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				
				while (rs.next()) {
					MemberDto dto = new MemberDto();
					dto.setNum(rs.getString("num"));
					dto.setNickname(rs.getString("nickname"));
					dto.setId(rs.getString("id"));
					dto.setPassword(rs.getString("password"));
					dto.setHp(rs.getString("hp"));
					dto.setAddr(rs.getString("addr"));
					dto.setEmail(rs.getString("email"));
					dto.setCreateDay(rs.getTimestamp("create_day"));
					dto.setAuth(rs.getInt("auth"));
					list.add(dto);
				}
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				db.dbClose(rs, pstmt, conn);
			}
			return list;
		}
}
