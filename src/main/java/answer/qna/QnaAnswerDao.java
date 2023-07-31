package answer.qna;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import mysql.db.DbConnect;

public class QnaAnswerDao {

    DbConnect db = new DbConnect();

    //insert
    public void insertAnswer(QnaAnswerDto dto) {
        Connection conn = db.getConnection();
        PreparedStatement pstmt = null;
        String sql = "insert into qna_answer values(null,?,?,?,now())";

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, dto.getBoardNum());
            pstmt.setString(2, dto.getAdminId());
            pstmt.setString(3, dto.getContent());
            pstmt.execute();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.dbClose(pstmt, conn);
        }
    }

    //해당 num의 질문 내용 불러오기
    public QnaAnswerDto getAnswer(String num) {
        QnaAnswerDto dto = new QnaAnswerDto();
        Connection conn = db.getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "select * from qna_answer where board_num=?";

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, num);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                dto.setIdx(rs.getString("idx"));
                dto.setBoardNum(rs.getString("board_num"));
                dto.setAdminId(rs.getString("admin_id"));
                dto.setContent(rs.getString("content"));
                dto.setWriteday(rs.getTimestamp("writeday"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.dbClose(pstmt, conn);
        }
        return dto;
    }

    //delete
    public void deleteAnswer(String idx) {
        Connection conn = db.getConnection();
        PreparedStatement pstmt = null;
        String sql = "delete from qna_answer where idx=?";

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

    //update
    public void updateAnswer(QnaAnswerDto dto) {
        Connection conn = db.getConnection();
        PreparedStatement pstmt = null;
        String sql = "update qna_answer set admin_id=?,content=? where idx=?";

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, dto.getAdminId());
            pstmt.setString(2, dto.getContent());
            pstmt.setString(3, dto.getIdx());
            pstmt.execute();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.dbClose(pstmt, conn);
        }
    }
}
