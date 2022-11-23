package dao;
import java.util.*;
import java.sql.*;
import util.*;
import vo.*;
public class CashDao { 
	// cashList
	public ArrayList<HashMap<String, Object>> selectCashListByMonth(String memberId, int year, int month) throws Exception{
		ArrayList<HashMap<String, Object>> cashList = new ArrayList<HashMap<String, Object>>();
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
			HashMap<String, Object> hmCash = new HashMap<String, Object>(); // HashMap객체생성
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
		rs.close();
		stmt.close();
		conn.close();
		return cashList;
	}
	// cashDateList 상세보기
	public ArrayList<HashMap<String, Object>> selectCashListByDate(String memberId, String cashDate) throws Exception{
		ArrayList<HashMap<String, Object>> cashDateList = new ArrayList<HashMap<String, Object>>();
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection(); // db연결
		String sql = "SELECT c.cash_no cashNo, c.cash_date cashDate, c.cash_price cashPrice, c.cash_memo cashMemo, ct.category_name categoryName, ct.category_kind categoryKind "
				+ "FROM cash c INNER JOIN category ct ON c.category_no = ct.category_no WHERE c.member_id = ? AND c.cash_date=? ORDER BY ct.category_kind ASC"; // c.cash_date가 같으면 ct.category_kind ASC정렬
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberId);
		stmt.setString(2, cashDate);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			HashMap<String, Object> hmCash = new HashMap<String, Object>(); // HashMap객체생성
			hmCash.put("cashNo", rs.getInt("cashNo"));
			hmCash.put("cashDate", rs.getString("cashDate"));
			hmCash.put("cashPrice", rs.getLong("cashPrice"));
			hmCash.put("cashMemo", rs.getString("cashMemo"));
			hmCash.put("categoryName", rs.getString("categoryName"));
			hmCash.put("categoryKind", rs.getString("categoryKind"));
			cashDateList.add(hmCash);
		}
		rs.close();
		stmt.close();
		conn.close();
		return cashDateList;
	}
	// cashDate 상세보기
	// cashDate 추가하기
	public boolean insertCashList(Cash cash) throws Exception{
		boolean result = false;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "INSERT INTO cash(member_id, category_no, cash_date, cash_price, cash_memo, updatedate, createdate) VALUES(?,?,?,?,?,CURDATE(),CURDATE())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, cash.getMemberId());
		stmt.setInt(2, cash.getCategoryNo());
		stmt.setString(3, cash.getCashDate());
		stmt.setLong(4, cash.getCashPrice());
		stmt.setString(5, cash.getCashMemo());
		int row = stmt.executeUpdate();
		if(row==1) {
			//System.out.println("insertCashList 성공");
			result=true;
		}
		stmt.close();
		conn.close();
		return result;
	}
	// cashDateList 수정
	public boolean updateCashList(Cash cash) throws Exception {
		boolean result = false;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "UPDATE cash SET category_no=?, cash_price=?, cash_date=?, cash_memo=?, updatedate=CURDATE(), createdate=CURDATE() WHERE member_id=? AND cash_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, cash.getCategoryNo());
		stmt.setLong(2, cash.getCashPrice());
		stmt.setString(3, cash.getCashDate());
		stmt.setString(4, cash.getCashMemo());
		stmt.setString(5, cash.getMemberId());
		stmt.setInt(6, cash.getCashNo());
		int row = stmt.executeUpdate();
		if(row==1) {
			result = true;
			System.out.println(result+"<--updateCashList");
		}
		return result;
	}
	// cashDateList 삭제 
	public boolean deleteCashList(String memberId, int cashNo) throws Exception {
		boolean result = false;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "DELETE FROM cash WHERE member_id=? AND cash_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberId);
		stmt.setInt(2, cashNo);
		int row = stmt.executeUpdate();
		if(row==1) {
			result=true;
			//System.out.println(result+"<--deleteCashList");
		}
		return result;
	}
}