package dao;
import java.util.*;
import java.sql.*;
import util.*;
import vo.*;
public class NoticeDao {
	// loginForm.jsp 공지 목록
	public ArrayList<Notice> selectNoticeListByPage(int beginRow, int rowPerPage) throws Exception{
		ArrayList<Notice> noticeList = new ArrayList<Notice>();
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT notice_no noticeNo, notice_memo noticeMemo, updatedate FROM notice ORDER BY updatedate DESC LIMIT ?,?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			Notice n = new Notice();
			n.setNoticeNo(rs.getInt("noticeNo"));
			n.setNoticeMemo(rs.getString("noticeMemo"));
			n.setUpdatedate(rs.getString("updatedate"));
			noticeList.add(n);
		}
		dbUtil.close(rs, stmt, conn);
		return noticeList;
	}
}
