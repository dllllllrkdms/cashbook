package dao;
import java.util.*;
import java.sql.*;
import util.*;
import vo.*;
public class CashDao { 
	public ArrayList<HashMap<String, Object>> selectCashListByMonth(String memberId, int year, int month) throws Exception{ // cashList
		ArrayList<HashMap<String, Object>> cashList = new ArrayList<HashMap<String, Object>>();
		HashMap<String, Object> hmCash=null;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection(); // db연결
		String sql = "SELECT c.cash_no cashNo, c.cash_date cashDate, c.cash_price cashPrice, c.category_no categoryNo, c.cash_memo cashMemo, ct.category_name categoryName, ct.category_kind categoryKind "
				+ "FROM cash c INNER JOIN category ct ON c.category_no = ct.category_no WHERE c.member_id = ? AND YEAR(c.cash_date) = ? AND MONTH(c.cash_date) = ? ORDER BY c.cash_date ASC, ct.category_kind ASC"; // c.cash_date가 같으면 ct.category_kind ASC정렬
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberId);
		stmt.setInt(2, year);
		stmt.setInt(3, month);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			hmCash = new HashMap<String, Object>(); // HashMap객체생성
			hmCash.put("cashNo", rs.getInt("cashNo"));
			hmCash.put("cashDate", rs.getString("cashDate"));
			hmCash.put("cashPrice", rs.getLong("cashPrice"));
			hmCash.put("categoryNo", rs.getInt("categoryNo"));
			hmCash.put("cashMemo", rs.getString("cashMemo"));
			hmCash.put("categoryName", rs.getString("categoryName"));
			hmCash.put("categoryKind", rs.getString("categoryKind"));
			cashList.add(hmCash);
		}
		//System.out.println(cashList);
		dbUtil.close(rs, stmt, conn);
		return cashList;
	}
	public ArrayList<HashMap<String, Object>> selectCashListByDate(String memberId, String cashDate) throws Exception{ // cashDateList 상세보기
		ArrayList<HashMap<String, Object>> cashDateList = new ArrayList<HashMap<String, Object>>();
		HashMap<String, Object> hmCash=null;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection(); // db연결
		String sql = "SELECT c.cash_no cashNo, c.cash_date cashDate, c.cash_price cashPrice, c.cash_memo cashMemo, ct.category_name categoryName, ct.category_kind categoryKind"
				+ " FROM cash c INNER JOIN category ct ON c.category_no = ct.category_no WHERE c.member_id = ? AND c.cash_date=? ORDER BY ct.category_kind ASC"; // c.cash_date가 같으면 ct.category_kind ASC정렬
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberId);
		stmt.setString(2, cashDate);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			hmCash = new HashMap<String, Object>(); // HashMap객체생성
			hmCash.put("cashNo", rs.getInt("cashNo"));
			hmCash.put("cashDate", rs.getString("cashDate"));
			hmCash.put("cashPrice", rs.getLong("cashPrice"));
			hmCash.put("cashMemo", rs.getString("cashMemo"));
			hmCash.put("categoryName", rs.getString("categoryName"));
			hmCash.put("categoryKind", rs.getString("categoryKind"));
			cashDateList.add(hmCash);
		}
		dbUtil.close(rs, stmt, conn);
		return cashDateList;
	}
	public HashMap<String, Object> selectCashOne(String cashDate, int cashNo) throws Exception{ // updateCashListForm
		HashMap<String, Object> hmCash = null;
		DBUtil dbUtil = new DBUtil();
		Connection conn=null;
		PreparedStatement stmt = null;
		String sql = "SELECT c.cash_no cashNo, c.cash_price cashPrice, c.cash_memo cashMemo, ct.category_name categoryName, ct.category_kind categoryKind"
				+ " FROM cash c INNER JOIN category ct ON c.category_no = ct.category_no WHERE c.cash_date = ? AND c.cash_no = ?";
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, cashDate);
		stmt.setInt(2, cashNo);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			hmCash =  new HashMap<String, Object>();
			hmCash.put("cashNo", rs.getInt("cashNo"));
			hmCash.put("cashPrice", rs.getLong("cashPrice"));
			hmCash.put("cashMemo", rs.getString("cashMemo"));
			hmCash.put("categoryName", rs.getString("categoryName"));
			hmCash.put("categoryKind", rs.getString("categoryKind"));
		}
		return hmCash;
	}
	public int insertCashList(Cash cash) throws Exception{ // cashDate 추가하기
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "INSERT INTO cash(member_id, category_no, cash_date, cash_price, cash_memo, updatedate, createdate) VALUES(?,?,?,?,?,NOW(),NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, cash.getMemberId());
		stmt.setInt(2, cash.getCategoryNo());
		stmt.setString(3, cash.getCashDate());
		stmt.setLong(4, cash.getCashPrice());
		stmt.setString(5, cash.getCashMemo());
		int row = stmt.executeUpdate();
		dbUtil.close(null, stmt, conn);
		return row;
	}
	public int updateCashList(Cash cash) throws Exception { // cashDateList 수정
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "UPDATE cash SET category_no=?, cash_price=?, cash_date=?, cash_memo=?, updatedate=NOW(), createdate=NOW() WHERE member_id=? AND cash_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, cash.getCategoryNo());
		stmt.setLong(2, cash.getCashPrice());
		stmt.setString(3, cash.getCashDate());
		stmt.setString(4, cash.getCashMemo());
		stmt.setString(5, cash.getMemberId());
		stmt.setInt(6, cash.getCashNo());
		int row = stmt.executeUpdate();
		dbUtil.close(null, stmt, conn);
		return row;
	} 
	public int deleteCashList(String memberId, int cashNo) throws Exception { // cashDateList 삭제
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "DELETE FROM cash WHERE member_id=? AND cash_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberId);
		stmt.setInt(2, cashNo);
		int row = stmt.executeUpdate();
		dbUtil.close(null, stmt, conn); // db자원 반납
		return row;
	}
}