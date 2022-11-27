package dao;
import java.util.*;
import java.sql.*;
import util.*;
import vo.*;
public class NoticeDao {
	public int totalCount() throws Exception { // total count
		int count = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection(); // db 연결
		String sql = "SELECT COUNT(*) count FROM notice";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			count = rs.getInt("count");
		}
		dbUtil.close(rs, stmt, conn); // db 연결 해제
		return count;
	}
	public ArrayList<Notice> selectNoticeListByPage(int beginRow, int rowPerPage) throws Exception{ // noticeList 출력
		ArrayList<Notice> noticeList = new ArrayList<Notice>();
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT notice_no noticeNo, notice_memo noticeMemo, createdate FROM notice ORDER BY createdate DESC LIMIT ?,?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			Notice n = new Notice();
			n.setNoticeNo(rs.getInt("noticeNo"));
			n.setNoticeMemo(rs.getString("noticeMemo"));
			n.setCreatedate(rs.getString("createdate"));
			noticeList.add(n);
		}
		dbUtil.close(rs, stmt, conn);
		return noticeList;
	}
	public Notice selectNoticeOne(int noticeNo) throws Exception { // notice 하나 출력
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT notice_memo noticeMemo, createdate FROM notice WHERE notice_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1,noticeNo);
		ResultSet rs = stmt.executeQuery();
		Notice notice = new Notice();
		if(rs.next()) {
			notice.setNoticeNo(noticeNo);
			notice.setNoticeMemo(rs.getString("noticeMemo"));
			notice.setCreatedate(rs.getString("createdate"));
		}
		return notice;
	}
	public int insertNotice(Notice notice) throws Exception { // notice 입력
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "INSERT INTO notice(notice_memo, updatedate, createdate) VALUES(?,NOW(),NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, notice.getNoticeMemo());
		int row = stmt.executeUpdate();
		dbUtil.close(null, stmt, conn);
		return row;
	}
	public int updateNotice(Notice notice) throws Exception { // notice 수정
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "UPDATE notice SET notice_memo=?, updatedate=NOW() WHERE notice_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, notice.getNoticeMemo());
		stmt.setInt(2, notice.getNoticeNo());
		int row = stmt.executeUpdate();
		dbUtil.close(null, stmt, conn);
		return row;
	}
	public int deleteNotice(int noticeNo) throws Exception { // notice 삭제
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "DELETE FROM notice WHERE notice_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, noticeNo);
		int row = stmt.executeUpdate();
		dbUtil.close(null, stmt, conn);
		return row;
	}
}
