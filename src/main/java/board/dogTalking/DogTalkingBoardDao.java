package board.dogTalking;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import mysql.db.DbConnect;

public class DogTalkingBoardDao {

    DbConnect db = new DbConnect();

    //insert
    public void insertBoard(DogTalkingBoardDto dto) {
        Connection conn = db.getConnection();
        PreparedStatement pstmt = null;
        String sql = "insert into dog_talking_board(id,photo,content,writeday) values(?,?,?,now())";

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, dto.getId());
            pstmt.setString(2, dto.getPhoto());
            pstmt.setString(3, dto.getContent());
            pstmt.execute();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.dbClose(pstmt, conn);
        }
    }

    //전체개수 (0개의 글이 있습니다.)
    public int getTotalCount() {
        int n = 0;

        Connection conn = db.getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        String sql = "select count(*) from dog_talking_board";

        try {
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                n = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.dbClose(rs, pstmt, conn);
        }
        return n;
    }

    //페이지
    public List<DogTalkingBoardDto> getList(int start, int perpage) {
        List<DogTalkingBoardDto> list = new ArrayList<DogTalkingBoardDto>();

        Connection conn = db.getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        String sql = "select * from dog_talking_board order by num desc limit ?,?";

        try {
            pstmt = conn.prepareStatement(sql);

            pstmt.setInt(1, start);
            pstmt.setInt(2, perpage);

            rs = pstmt.executeQuery();

            while (rs.next()) {
                DogTalkingBoardDto dto = new DogTalkingBoardDto();

                dto.setNum(rs.getString("num"));
                dto.setId(rs.getString("id"));
                dto.setPhoto(rs.getString("photo"));
                dto.setContent(rs.getString("content"));
                dto.setWriteday(rs.getTimestamp("writeday"));
                dto.setReadCount(rs.getInt("readcount"));
                dto.setLikes(rs.getInt("likes"));

                list.add(dto);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.dbClose(rs, pstmt, conn);
        }

        return list;

    }

    //rank list
    public List<DogTalkingBoardDto> getRankList() {
        List<DogTalkingBoardDto> list = new ArrayList<DogTalkingBoardDto>();

        Connection conn = db.getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        String sql = "select * from dog_talking_board "
                + "where date_format(writeday,\"%Y-%m-%d\")>=date_add(curdate(),interval -7 day) and "
                + "date_format(writeday,\"%Y-%m-%d\")<=curdate() order by likes desc limit 0,4";

        try {
            pstmt = conn.prepareStatement(sql);

            rs = pstmt.executeQuery();

            while (rs.next()) {
                DogTalkingBoardDto dto = new DogTalkingBoardDto();

                dto.setNum(rs.getString("num"));
                dto.setId(rs.getString("id"));
                dto.setPhoto(rs.getString("photo"));
                dto.setContent(rs.getString("content"));
                dto.setWriteday(rs.getTimestamp("writeday"));
                dto.setReadCount(rs.getInt("readcount"));
                dto.setLikes(rs.getInt("likes"));

                list.add(dto);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.dbClose(rs, pstmt, conn);
        }
        return list;
    }

    //getdata for detailpage
    public DogTalkingBoardDto getData(String num) {

        DogTalkingBoardDto dto = new DogTalkingBoardDto();

        Connection conn = db.getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        String sql = "select * from dog_talking_board where num=?";

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, num);

            rs = pstmt.executeQuery();

            while (rs.next()) {
                dto.setNum(rs.getString("num"));
                dto.setId(rs.getString("id"));
                dto.setPhoto(rs.getString("photo"));
                dto.setContent(rs.getString("content"));
                dto.setWriteday(rs.getTimestamp("writeday"));
                dto.setReadCount(rs.getInt("readcount"));
                dto.setLikes(rs.getInt("likes"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.dbClose(rs, pstmt, conn);
        }
        return dto;
    }

    //delete
    public void deleteBoard(String num) {
        Connection conn = db.getConnection();
        PreparedStatement pstmt = null;

        String sql = "delete from dog_talking_board where num=?";

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

    public void updateLikes(String num) {
        Connection conn = db.getConnection();
        PreparedStatement pstmt = null;
        String sql = "update dog_talking_board set likes=likes+1 where num=?";

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, num);
            pstmt.execute();
        } catch (SQLException e) {
            System.out.println("SQL에러: " + e.getMessage());
            e.printStackTrace();
        } finally {
            db.dbClose(pstmt, conn);
        }
    }

    //조회수 1 증가
    public void updateReadCount(String num) {
        Connection conn = db.getConnection();
        PreparedStatement pstmt = null;

        String sql = "update dog_talking_board set readcount=readcount+1 where num=?";
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

    //update
    public void updateBoard(DogTalkingBoardDto dto) {
        Connection conn = db.getConnection();
        PreparedStatement pstmt = null;
        String sql = "update dog_talking_board set photo=?,content=? where num=?";

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, dto.getPhoto());
            pstmt.setString(2, dto.getContent());
            pstmt.setString(3, dto.getNum());
            pstmt.execute();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.dbClose(pstmt, conn);
        }
    }

    //search
    public List<DogTalkingBoardDto> searchThis(String word) {
        List<DogTalkingBoardDto> searchList = new ArrayList<DogTalkingBoardDto>();
        Connection conn = db.getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "select * from dog_talking_board where content like ? order by num desc";

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, "%" + word + "%");
            rs = pstmt.executeQuery();

            while (rs.next()) {
                DogTalkingBoardDto dto = new DogTalkingBoardDto();
                dto.setNum(rs.getString("num"));
                dto.setId(rs.getString("id"));
                dto.setPhoto(rs.getString("photo"));
                dto.setContent(rs.getString("content"));
                dto.setWriteday(rs.getTimestamp("writeday"));
                dto.setReadCount(rs.getInt("readcount"));
                dto.setLikes(rs.getInt("likes"));
                searchList.add(dto);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.dbClose(rs, pstmt, conn);
        }
        return searchList;
    }
}
