package profile.dogProfile;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.Vector;

import mysql.db.DbConnect;

public class DogProfileDao {
	DbConnect db = new DbConnect();

	// 대표가 아닌 일반강아지 insert
	public void insertDogProfile(DogProfileDto dto) {
		Connection conn = db.getConnection();
		PreparedStatement pstmt = null;

		String sql = "insert into dog_profile (member_num,name,gender,dog_size,birthday,photo,main_dog)values(?,?,?,?,?,?,0)";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getMemberNum());
			pstmt.setString(2, dto.getName());
			pstmt.setString(3, dto.getGender());
			pstmt.setString(4, dto.getDogSize());
			pstmt.setString(5, dto.getBirthday());
			pstmt.setString(6, dto.getPhoto());
			pstmt.execute();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			db.dbClose(pstmt, conn);
		}
	}

	// 모든 사용자들의 반려견 총 개수 구하기
	public int getTotalDogCount() {
		int n = 0;
		Connection conn = db.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select count(*) from dog_profile";

		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

			if (rs.next())
				n = rs.getInt(1);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			db.dbClose(rs, pstmt, conn);
		}
		return n;
	}

	// 나의 모든 강아지들 리스트 반환
	public List<DogProfileDto> getMyDogList(String num) {
		List<DogProfileDto> list = new Vector<>();
		Connection conn = db.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select * from dog_profile where member_num = ? order by idx";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, num);

			rs = pstmt.executeQuery();

			while (rs.next()) {

				DogProfileDto dto = new DogProfileDto();

				dto.setIdx(rs.getString("idx"));
				dto.setMemberNum(rs.getString("member_num"));
				dto.setName(rs.getString("name"));
				dto.setGender(rs.getString("gender"));
				dto.setDogSize(rs.getString("dog_size"));
				dto.setBirthday(rs.getString("birthday"));
				dto.setPhoto(rs.getString("photo"));
				dto.setMainDog(rs.getInt("main_dog"));

				list.add(dto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			db.dbClose(rs, pstmt, conn);
		}
		return list;
	}

	// 다른 게시판에서 멍멍이 불러오기
	public DogProfileDto getPetInfo(String num) {

		DogProfileDto dto = new DogProfileDto();

		Connection conn = db.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = "select * from dog_profile where member_num=?";

		try {
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, num);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				dto.setIdx(rs.getString("idx"));
				dto.setMemberNum(rs.getString("member_num"));
				dto.setName(rs.getString("name"));
				dto.setGender(rs.getString("gender"));
				dto.setDogSize(rs.getString("dog_size"));
				dto.setBirthday(rs.getString("birthday"));
				dto.setPhoto(rs.getString("photo"));
				dto.setMainDog(rs.getInt("main_dog"));
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.dbClose(rs, pstmt, conn);
		}

		return dto;

	}

	// 나의 강아지들 중 대표가 아닌 강아지들 리스트 반환
	public List<DogProfileDto> getMyNotMainDogList(String num) {
		List<DogProfileDto> list = new Vector<>();
		Connection conn = db.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select * from dog_profile where member_num = ? and main_dog = 0 order by idx";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, num);

			rs = pstmt.executeQuery();

			while (rs.next()) {

				DogProfileDto dto = new DogProfileDto();

				dto.setIdx(rs.getString("idx"));
				dto.setMemberNum(rs.getString("member_num"));
				dto.setName(rs.getString("name"));
				dto.setGender(rs.getString("gender"));
				dto.setDogSize(rs.getString("dog_size"));
				dto.setBirthday(rs.getString("birthday"));
				dto.setPhoto(rs.getString("photo"));
				dto.setMainDog(rs.getInt("main_dog"));

				list.add(dto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			db.dbClose(rs, pstmt, conn);
		}
		return list;
	}
	
	//대표 강아지 추가. 일반강아지아님.
	public void insertMainDogProfile(DogProfileDto dto) {
		Connection conn = db.getConnection();
		PreparedStatement pstmt = null;

		String sql = "insert into dog_profile (member_num,name,gender,dog_size,birthday,photo,main_dog)values(?,?,?,?,?,?,1)";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getMemberNum());
			pstmt.setString(2, dto.getName());
			pstmt.setString(3, dto.getGender());
			pstmt.setString(4, dto.getDogSize());
			pstmt.setString(5, dto.getBirthday());
			pstmt.setString(6, dto.getPhoto());
			pstmt.execute();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			db.dbClose(pstmt, conn);
		}
	}
	
	//idx값 가져와서 대표강아지로 만들기
	public void selectMainDog(String idx) {
		Connection conn = db.getConnection();
		PreparedStatement pstmt = null;
		String sql = "update dog_profile set main_dog=1 where idx=?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, idx);
			pstmt.execute();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			db.dbClose(pstmt, conn);
		}
	}
	
	// 나의 강아지들 중 대표 강아지 dto 반환
	public DogProfileDto getMyMainDog(String num) {
		DogProfileDto dto = new DogProfileDto();
		Connection conn = db.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select * from dog_profile where member_num = ? and main_dog = 1";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, num);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				dto.setIdx(rs.getString("idx"));
				dto.setMemberNum(rs.getString("member_num"));
				dto.setName(rs.getString("name"));
				dto.setGender(rs.getString("gender"));
				dto.setDogSize(rs.getString("dog_size"));
				dto.setBirthday(rs.getString("birthday"));
				dto.setPhoto(rs.getString("photo"));
				dto.setMainDog(rs.getInt("main_dog"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			db.dbClose(rs, pstmt, conn);
		}
		return dto;
	}
	
	//나의 모든 강아지들 일반 강아지로 바꿈
	public void allChangeNomalDog(String num) {
		Connection conn = db.getConnection();
		PreparedStatement pstmt = null;
		String sql = "update dog_profile set main_dog=0 where member_num=?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, num);
			pstmt.execute();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			db.dbClose(pstmt, conn);
		}
	}
}
