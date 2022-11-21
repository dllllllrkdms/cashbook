package dao;
import java.util.*;
import java.sql.*;
import util.*;
public class CashDao {
	public ArrayList<HashMap<String, Object>> selectCashListByMonth(int year, int month) throws Exception{
		ArrayList<HashMap<String, Object>> cashList = new ArrayList<HashMap<String, Object>>();
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection(); // db연결
		String sql = "SELECT c.cash_no cashNo, c.cash_date cashDate, c.cash_price cashPrice, c.category_no categoryNo, ct.category_name categoryName, ct.category_kind categoryKind FROM cash c INNER JOIN category ct ON c.category_no = ct.category_no "
				+ "WHERE YEAR(c.cash_date) = ? AND MONTH(c.cash_date) = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, year);
		stmt.setInt(2, month);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			System.out.println("selectCashListByMonth 성공");
			HashMap<String, Object> hmCash = new HashMap<String, Object>(); // HashMap객체생성
			hmCash.put("cashNo", rs.getInt("cashNo"));
			hmCash.put("cashDate", rs.getString("cashDate"));
			hmCash.put("cashPrice", rs.getString("cashPrice"));
			hmCash.put("categoryNo", rs.getInt("categoryNo"));
			hmCash.put("categoryName", rs.getString("categoryName"));
			hmCash.put("categoryKind", rs.getString("categoryKind"));
			cashList.add(hmCash);
		}
		rs.close();
		stmt.close();
		conn.close();
		return cashList;
	}
}