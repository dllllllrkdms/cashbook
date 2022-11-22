package dao;
import java.util.*;
import java.sql.*;
import util.*;
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
	// 가계부 상세보기
	public ArrayList<HashMap<String, Object>> selectCashListByDate(String memberId, int year, int month, int date) throws Exception{
		//System.out.println(memberId);
		//System.out.println(year);
		//System.out.println(month);
		//System.out.println(date);
		ArrayList<HashMap<String, Object>> cashDateList = new ArrayList<HashMap<String, Object>>();
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection(); // db연결
		String sql = "SELECT c.cash_date cashDate, c.cash_price cashPrice, c.cash_memo cashMemo, ct.category_name categoryName, ct.category_kind categoryKind "
				+ "FROM cash c INNER JOIN category ct ON c.category_no = ct.category_no WHERE c.member_id = ? AND YEAR(c.cash_date) = ? AND MONTH(c.cash_date) = ? AND DAY(c.cash_date)=? ORDER BY ct.category_kind ASC"; // c.cash_date가 같으면 ct.category_kind ASC정렬
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberId);
		stmt.setInt(2, year);
		stmt.setInt(3, month);
		stmt.setInt(4, date);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			HashMap<String, Object> hmCash = new HashMap<String, Object>(); // HashMap객체생성
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
}