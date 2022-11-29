package dao;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import util.DBUtil;
import vo.Help;
public class HelpDao {
	public int insertHelp(Help help) throws Exception { // insertHelpAction
		int row = 0; // 반환할 변수 초기화
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		String sql = "INSERT INTO help(help_memo, member_id, updatedate, createdate) VALUES(?,?,NOW(),NOW())";
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, help.getHelpMemo());
		stmt.setString(2, help.getMemberId());
		row = stmt.executeUpdate();
		dbUtil.close(null, stmt, conn); // db자원 반납
		return row;
	}
	public ArrayList<HashMap<String, Object>> selectHelpList(String memberId) throws Exception { // 세션에 로그인된 아이디가 작성한 help목록 comment 출력 , comment가 달리지 않았어도 help는 모든 목록 출력-> left join
		ArrayList<HashMap<String, Object>> helpList= new ArrayList<HashMap<String, Object>>();
		HashMap<String, Object> m = null;
		DBUtil dbUtil = new DBUtil();
		String sql = "SELECT h.help_no helpNo, h.help_memo helpMemo, c.comment_memo commentMemo, c.createdate commentCreatedate, h.createdate helpCreatedate FROM help h LEFT JOIN comment c ON h.help_no = c.help_no WHERE h.member_id=?";
		Connection conn = dbUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberId);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			m = new HashMap<String, Object>(); // 쿼리 실행결과값이 있을 경우에만 객체 생성
			m.put("helpNo", rs.getInt("helpNo"));
			m.put("helpMemo", rs.getString("helpMemo"));
			m.put("helpCreatedate", rs.getString("helpCreatedate"));
			m.put("commentMemo", rs.getString("commentMemo"));
			m.put("commentCreatedate", rs.getString("commentCreatedate"));
			helpList.add(m);
		}
		dbUtil.close(rs, stmt, conn);
		return helpList;
	}
	public int updateHelp(Help help) throws Exception { // updateHelpAction
		int row =0;
		DBUtil dbUtil = new DBUtil();
		String sql = "UPDATE help SET help_memo=?, updatedate=NOW() WHERE help_no=? AND member_id=?";
		Connection conn = dbUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, help.getHelpMemo());
		stmt.setInt(2, help.getHelpNo());
		stmt.setString(3, help.getMemberId());
		row = stmt.executeUpdate();
		dbUtil.close(null, stmt, conn);
		return row;
	}
	public int deleteHelp(int helpNo) throws Exception {
		int row=0;
		DBUtil dbUtil = new DBUtil();
		String sql = "DELETE FROM help WHERE help_no=?";
		Connection conn = dbUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, helpNo);
		row=stmt.executeUpdate();
		dbUtil.close(null, stmt, conn);
		return row;
	}
	//--관리자기능--
	public ArrayList<HashMap<String, Object>> selectHelpList(int beginRow, int rowPerPage) throws Exception{ // 메서드 오버로딩(매개변수가 다르면 메서드명은 같아도 됨)
		ArrayList<HashMap<String, Object>> helpList= new ArrayList<HashMap<String, Object>>();
		HashMap<String, Object> m = null;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql="SELECT h.help_no helpNo, h.help_memo helpMemo, h.member_id memberId, h.createdate helpCreatedate, c.comment_no commentNo, c.comment_memo commentMemo, c.createdate commentCreatedate FROM help h LEFT JOIN comment c ON h.help_no=c.help_no ORDER BY h.createdate DESC LIMIT ?,?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			m = new HashMap<String, Object>(); // 쿼리 실행결과값이 있을 경우에만 객체 생성
			m.put("helpNo", rs.getInt("helpNo"));
			m.put("helpMemo", rs.getString("helpMemo"));
			m.put("memberId", rs.getString("memberId"));
			m.put("helpCreatedate", rs.getString("helpCreatedate"));
			m.put("commentNo", rs.getInt("commentNo"));
			m.put("commentMemo", rs.getString("commentMemo"));
			m.put("commentCreatedate", rs.getString("commentCreatedate"));
			helpList.add(m);
		}
		dbUtil.close(rs, stmt, conn);
		return helpList;
	}
	public Help selectHelpOne(int helpNo) throws Exception { // 문의글 하나만 보기 insertCommentForm, updateHelpListForm
		Help help = null;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql="SELECT help_memo helpMemo, member_id memberId, createdate FROM help WHERE help_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, helpNo);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			help=new Help();
			help.setHelpMemo(rs.getString("helpMemo"));
			help.setMemberId(rs.getString("memberId"));
			help.setCreatedate(rs.getString("createdate"));
		}
		dbUtil.close(rs, stmt, conn);
		return help;
	}
	public int totalCountHelpList() throws Exception { // 페이징
		int count =0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql="SELECT COUNT(*) count FROM help";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			count=rs.getInt("count");
		}
		dbUtil.close(rs, stmt, conn); // db자원 반납
		return count;
	}
}