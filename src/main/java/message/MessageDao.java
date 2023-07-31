package message;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import board.qna.QnaBoardDto;
import mysql.db.DbConnect;

public class MessageDao {
    DbConnect db = new DbConnect();

    //insert
    public void insertMessage(MessageDto dto) {
        Connection conn = db.getConnection();
        PreparedStatement pstmt = null;
        String sql = "insert into message(sender, receiver, content, writeday) values(?,?,?,now())";

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, dto.getSender());
            pstmt.setString(2, dto.getReceiver());
            pstmt.setString(3, dto.getContent());
            pstmt.execute();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.dbClose(pstmt, conn);
        }
    }

    //select
    public List<MessageDto> showAllMessage(int start, int perpage, String id) {
        List<MessageDto> list = new ArrayList<MessageDto>();

        Connection conn = db.getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        String sql = "select * from message where receiver=? order by num desc limit ?,?";

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, id);
            pstmt.setInt(2, start);
            pstmt.setInt(3, perpage);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                MessageDto dto = new MessageDto();
                dto.setNum(rs.getString("num"));
                dto.setReceiver(rs.getString("receiver"));
                dto.setSender(rs.getString("sender"));
                dto.setContent(rs.getString("content"));
                dto.setWriteday(rs.getTimestamp("writeday"));
                dto.setIsRead(rs.getInt("is_read"));
                list.add(dto);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.dbClose(rs, pstmt, conn);
        }
        return list;
    }

    //전체 글 개수
    public int getMyCount(String id) {
        int n = 0;

        Connection conn = db.getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        String sql = "select count(*) from message where receiver=?";

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, id);

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

    //안읽은 쪽지 개수
    public int getUnreadCount(String id) {
        int n = 0;

        Connection conn = db.getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        String sql = "select count(*) from message where receiver=? and is_read=0";

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, id);

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

    //detail
    public MessageDto showMessageDetail(String num) {
        MessageDto dto = new MessageDto();

        Connection conn = db.getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        String sql = "select * from message where num=?";

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, num);

            rs = pstmt.executeQuery();

            if (rs.next()) {
                dto.setNum(rs.getString("num"));
                dto.setReceiver(rs.getString("receiver"));
                dto.setSender(rs.getString("sender"));
                dto.setContent(rs.getString("content"));
                dto.setWriteday(rs.getTimestamp("writeday"));
                dto.setIsRead(rs.getInt("is_read"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.dbClose(rs, pstmt, conn);
        }
        return dto;
    }

    //읽음 표시
    public void updateRead(String num) {
        Connection conn = db.getConnection();
        PreparedStatement pstmt = null;

        String sql = "update message set is_read=1 where num=?";

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

    //delete
    public void deleteMessage(String num) {
        Connection conn = db.getConnection();
        PreparedStatement pstmt = null;

        String sql = "delete from message where num=?";

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
