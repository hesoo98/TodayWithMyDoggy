package board.qna;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Vector;

import mysql.db.DbConnect;
import profile.dogProfile.DogProfileDto;

public class QnaBoardDao {
    DbConnect db = new DbConnect();

    //insert
    public void insertQna(QnaBoardDto dto) {
        Connection conn = db.getConnection();
        PreparedStatement pstmt = null;
        String sql = "insert into qna_board(id, title, content, secret,writeday) values(?,?,?,?,now())";

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, dto.getId());
            pstmt.setString(2, dto.getTitle());
            pstmt.setString(3, dto.getContent());
            pstmt.setString(4, dto.getSecret());
            pstmt.execute();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.dbClose(pstmt, conn);
        }
    }

    //select
    public List<QnaBoardDto> showAllQna(int start, int perpage, String word) {
        List<QnaBoardDto> list = new ArrayList<QnaBoardDto>();
        Connection conn = db.getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        if (word != null) {
            sql = "select * from qna_board where title like ? or content like ? order by num desc limit ?,?";

            try {
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, "%" + word + "%");
                pstmt.setString(2, "%" + word + "%");
                pstmt.setInt(3, start);
                pstmt.setInt(4, perpage);
                rs = pstmt.executeQuery();

                while (rs.next()) {
                    QnaBoardDto dto = new QnaBoardDto();
                    dto.setNum(rs.getString("num"));
                    dto.setId(rs.getString("id"));
                    dto.setTitle(rs.getString("title"));
                    dto.setContent(rs.getString("content"));
                    dto.setWriteday(rs.getTimestamp("writeday"));
                    dto.setReadcount(rs.getInt("readcount"));
                    dto.setSecret(rs.getString("secret"));
                    list.add(dto);
                }
            } catch (SQLException e) {
                e.printStackTrace();
            } finally {
                db.dbClose(rs, pstmt, conn);
            }
            return list;

        } else {
            sql = "select * from qna_board order by num desc limit ?,?";

            try {
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, start);
                pstmt.setInt(2, perpage);
                rs = pstmt.executeQuery();

                while (rs.next()) {
                    QnaBoardDto dto = new QnaBoardDto();
                    dto.setNum(rs.getString("num"));
                    dto.setId(rs.getString("id"));
                    dto.setTitle(rs.getString("title"));
                    dto.setContent(rs.getString("content"));
                    dto.setWriteday(rs.getTimestamp("writeday"));
                    dto.setReadcount(rs.getInt("readcount"));
                    dto.setSecret(rs.getString("secret"));
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

    //전체 글 개수
    public int getTotalCount() {
        int n = 0;

        Connection conn = db.getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        String sql = "select count(*) from qna_board";

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


    //비밀글 체크
    public String isSecret(String num) {
        String secret = "0";

        Connection conn = db.getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        String sql = "select * from qna_board where num=?";

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, num);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                secret = rs.getString("secret");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.dbClose(rs, pstmt, conn);
        }
        return secret;
    }

    //detailpage getdata
    public QnaBoardDto getData(String num) {
        QnaBoardDto dto = new QnaBoardDto();
        Connection conn = db.getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "select * from qna_board where num=?";

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, num);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                dto.setNum(rs.getString("num"));
                dto.setId(rs.getString("id"));
                dto.setTitle(rs.getString("title"));
                dto.setContent(rs.getString("content"));
                dto.setWriteday(rs.getTimestamp("writeday"));
                dto.setReadcount(rs.getInt("readcount"));
                dto.setSecret(rs.getString("secret"));
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
        String sql = "delete from qna_board where num=?";

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
    public void updateBoard(QnaBoardDto dto) {
        Connection conn = db.getConnection();
        PreparedStatement pstmt = null;
        String sql = "update qna_board set title=?,content=? where num=?";

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

    // 로그인한 사용자가 쓴 글을 모두 조회
    public List<QnaBoardDto> getMyBoardList(String id) {
        List<QnaBoardDto> list = new Vector<>();
        Connection conn = db.getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "select * from qna_board where id = ?";

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, id);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                QnaBoardDto dto = new QnaBoardDto();
                dto.setNum(rs.getString("num"));
                dto.setId(rs.getString("id"));
                dto.setTitle(rs.getString("title"));
                dto.setContent(rs.getString("content"));
                dto.setWriteday(rs.getTimestamp("writeday"));
                dto.setReadcount(rs.getInt("readcount"));
                dto.setSecret(rs.getString("secret"));
                list.add(dto);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.dbClose(rs, pstmt, conn);
        }
        return list;
    }

    // 로그인한 사용자가 쓴 글을 모두 조회 페이징 기능 추가된.
    public List<QnaBoardDto> getMyBoardList(int start, int perpage, String id) {
        List<QnaBoardDto> list = new Vector<>();
        Connection conn = db.getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "select * from qna_board where id = ?";

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, id);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                QnaBoardDto dto = new QnaBoardDto();
                dto.setNum(rs.getString("num"));
                dto.setId(rs.getString("id"));
                dto.setTitle(rs.getString("title"));
                dto.setContent(rs.getString("content"));
                dto.setWriteday(rs.getTimestamp("writeday"));
                dto.setReadcount(rs.getInt("readcount"));
                dto.setSecret(rs.getString("secret"));
                list.add(dto);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.dbClose(rs, pstmt, conn);
        }
        return list;
    }

    //관리자 페이지에서 쓰는 getAllQnaList()
    public List<QnaBoardDto> getAllQnaList() {
        List<QnaBoardDto> list = new ArrayList<QnaBoardDto>();
        Connection conn = db.getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "select * from qna_board order by num desc";

        try {
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                QnaBoardDto dto = new QnaBoardDto();
                dto.setNum(rs.getString("num"));
                dto.setId(rs.getString("id"));
                dto.setTitle(rs.getString("title"));
                dto.setContent(rs.getString("content"));
                dto.setWriteday(rs.getTimestamp("writeday"));
                dto.setReadcount(rs.getInt("readcount"));
                dto.setSecret(rs.getString("secret"));
                list.add(dto);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.dbClose(rs, pstmt, conn);
        }
        return list;
    }

    //관리자 페이지에서 답변하지 않은 Q&A 질문만 가져옴
    public List<QnaBoardDto> getAnswerPendingQList() {
        List<QnaBoardDto> list = new ArrayList<QnaBoardDto>();
        Connection conn = db.getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "select * from qna_board where num not in (select board_num from qna_answer)";

        try {
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                QnaBoardDto dto = new QnaBoardDto();
                dto.setNum(rs.getString("num"));
                dto.setId(rs.getString("id"));
                dto.setTitle(rs.getString("title"));
                dto.setContent(rs.getString("content"));
                dto.setWriteday(rs.getTimestamp("writeday"));
                dto.setReadcount(rs.getInt("readcount"));
                dto.setSecret(rs.getString("secret"));
                list.add(dto);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.dbClose(rs, pstmt, conn);
        }
        return list;
    }

    //관리자 페이지에서 답변하지 않은 Q&A 질문만 가져옴 페이징 처리한 메서드
    public List<QnaBoardDto> getAnswerPendingQList(int start, int perpage) {
        List<QnaBoardDto> list = new ArrayList<QnaBoardDto>();
        Connection conn = db.getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "select * from qna_board where num not in (select board_num from qna_answer) order by num desc limit ?,?";

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, start);
            pstmt.setInt(2, perpage);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                QnaBoardDto dto = new QnaBoardDto();
                dto.setNum(rs.getString("num"));
                dto.setId(rs.getString("id"));
                dto.setTitle(rs.getString("title"));
                dto.setContent(rs.getString("content"));
                dto.setWriteday(rs.getTimestamp("writeday"));
                dto.setReadcount(rs.getInt("readcount"));
                dto.setSecret(rs.getString("secret"));
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
