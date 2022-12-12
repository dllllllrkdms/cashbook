package dao;
import java.util.*;
import java.sql.*;
import util.*;
import vo.*;
public class CashDao { 
	public ArrayList<HashMap<String, Object>> selectCashListByMonth(String memberId, int year, int month) { // cashList 목록출력(사용되지 않음)
		ArrayList<HashMap<String, Object>> cashList = new ArrayList<HashMap<String, Object>>();
		HashMap<String, Object> hmCash=null;
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			conn = dbUtil.getConnection(); // db연결
			String sql = "SELECT c.cash_no cashNo, c.cash_date cashDate, c.cash_price cashPrice, c.category_no categoryNo, c.cash_memo cashMemo, ct.category_name categoryName, ct.category_kind categoryKind "
					+ "FROM cash c INNER JOIN category ct ON c.category_no = ct.category_no WHERE c.member_id = ? AND YEAR(c.cash_date) = ? AND MONTH(c.cash_date) = ? ORDER BY c.cash_date ASC, ct.category_kind ASC"; // c.cash_date가 같으면 ct.category_kind ASC정렬
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, memberId);
			stmt.setInt(2, year);
			stmt.setInt(3, month);
			rs = stmt.executeQuery();
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
			
		} catch (Exception e) {
			e.printStackTrace(); // 예외출력 메시지
		} finally {
			try {
				dbUtil.close(rs, stmt, conn);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return cashList;
	}
	public ArrayList<HashMap<String, Object>> selectCashListByDate(String memberId, String cashDate) { // cashDateList 상세보기
		ArrayList<HashMap<String, Object>> cashDateList = new ArrayList<HashMap<String, Object>>();
		HashMap<String, Object> hmCash=null;
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			conn = dbUtil.getConnection();// db연결
			String sql = "SELECT c.cash_no cashNo, c.cash_date cashDate, c.cash_price cashPrice, c.cash_memo cashMemo, ct.category_name categoryName, ct.category_kind categoryKind"
					+ " FROM cash c INNER JOIN category ct ON c.category_no = ct.category_no WHERE c.member_id = ? AND c.cash_date=? ORDER BY ct.category_kind ASC"; // c.cash_date가 같으면 ct.category_kind ASC정렬
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, memberId);
			stmt.setString(2, cashDate);
			rs = stmt.executeQuery();
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
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(rs, stmt, conn);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		return cashDateList;
	}
	public HashMap<String, Object> selectCashOne(String cashDate, int cashNo) { // cash 하나 출력 <-updateCashListForm 
		HashMap<String, Object> hmCash = null;
		DBUtil dbUtil = new DBUtil();
		Connection conn=null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "SELECT c.cash_no cashNo, c.cash_price cashPrice, c.cash_memo cashMemo, ct.category_name categoryName, ct.category_kind categoryKind"
				+ " FROM cash c INNER JOIN category ct ON c.category_no = ct.category_no WHERE c.cash_date = ? AND c.cash_no = ?";
		try {
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, cashDate);
			stmt.setInt(2, cashNo);
			rs = stmt.executeQuery();
			if(rs.next()) {
				hmCash =  new HashMap<String, Object>();
				hmCash.put("cashNo", rs.getInt("cashNo"));
				hmCash.put("cashPrice", rs.getLong("cashPrice"));
				hmCash.put("cashMemo", rs.getString("cashMemo"));
				hmCash.put("categoryName", rs.getString("categoryName"));
				hmCash.put("categoryKind", rs.getString("categoryKind"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				dbUtil.close(rs, stmt, conn);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return hmCash;
	}
	public int insertCashList(Cash cash) { // cashDate 추가하기
		int row = 0; // 리턴할 변수 초기화
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		try {
			conn = dbUtil.getConnection();
			String sql = "INSERT INTO cash(member_id, category_no, cash_date, cash_price, cash_memo, updatedate, createdate) VALUES(?,?,?,?,?,NOW(),NOW())";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, cash.getMemberId());
			stmt.setInt(2, cash.getCategoryNo());
			stmt.setString(3, cash.getCashDate());
			stmt.setLong(4, cash.getCashPrice());
			stmt.setString(5, cash.getCashMemo());
			row = stmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(null, stmt, conn);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return row;
	}
	public int updateCashList(Cash cash) { // cashDateList 수정
		int row = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		try {
			conn = dbUtil.getConnection();
			String sql = "UPDATE cash SET category_no=?, cash_price=?, cash_date=?, cash_memo=?, updatedate=NOW(), createdate=NOW() WHERE member_id=? AND cash_no=?";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, cash.getCategoryNo());
			stmt.setLong(2, cash.getCashPrice());
			stmt.setString(3, cash.getCashDate());
			stmt.setString(4, cash.getCashMemo());
			stmt.setString(5, cash.getMemberId());
			stmt.setInt(6, cash.getCashNo());
			row = stmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(null, stmt, conn);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return row;
	} 
	public int deleteCashList(String memberId, int cashNo) { // cashDateList 삭제
		int row = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		try {
			conn = dbUtil.getConnection();
			String sql = "DELETE FROM cash WHERE member_id=? AND cash_no=?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, memberId);
			stmt.setInt(2, cashNo);
			row = stmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(null, stmt, conn); // db자원 반납
			} catch (Exception e) {
				e.printStackTrace();
			} 
		}
		return row;
	}
	public ArrayList<HashMap<String, Object>> selectCashSumByYear(String memberId, String categoryKind){ // 연도별 카테고리종류 합계 보기
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			conn = dbUtil.getConnection();
			String sql = "SELECT ct.category_kind categoryKind, SUM(cash_price) price, EXTRACT(year FROM cash_date) year FROM cash c INNER JOIN category ct ON c.category_no=ct.category_no"
					+ " WHERE member_id=? AND ct.category_kind=? GROUP BY EXTRACT(year FROM cash_date) ORDER BY EXTRACT(year FROM cash_date) ASC";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, memberId);
			stmt.setString(2, categoryKind);
			rs = stmt.executeQuery();
			while(rs.next()) {
				HashMap<String, Object> m = new HashMap<String, Object>();
				m.put("categoryKind", rs.getString("categoryKind"));
				m.put("price", rs.getLong("price"));
				m.put("year", rs.getInt("year"));
				list.add(m);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(rs, stmt, conn); // db자원 반납
			} catch (Exception e) {
				e.printStackTrace();
			} 
		}
		return list;
	}
	public ArrayList<HashMap<String, Object>> selectCashSumByMonth(String memberId, String category){
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		try {
			conn = dbUtil.getConnection();
			String sql = "";
		} catch (Exception e) {
			e.printStackTrace();
		}
		ResultSet rs = null;
		return list;
	}
}