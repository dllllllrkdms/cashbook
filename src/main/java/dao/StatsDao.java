package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import util.DBUtil;

public class StatsDao {
	public ArrayList<HashMap<String, Object>> selectStatsByYear(String memberId){ // 사용자별, 연도별 수입/지출 합계, 평균 보기
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			conn = dbUtil.getConnection();
			String sql = "SELECT EXTRACT(YEAR FROM t2.cash_date) year" // 인라인 뷰 사용 
					+ "			, SUM(t2.importCash) sumImport"
					+ "			, round(AVG(t2.importCash)) avgImport"
					+ "			, SUM(t2.exportCash) sumExport"
					+ "			, round(AVG(t2.exportCash)) avgExport"
					+ "		FROM (SELECT t.member_id"
					+ "					, t.cash_date"
					+ "					, t.category_kind"
					+ "					, if(t.category_kind='수입', t.cash_price, NULL) importCash" //if(조건문, 참일때 값, 거짓일 때 값)
					+ "					, if(t.category_kind='지출', t.cash_price, NULL) exportCash"
					+ "			FROM (SELECT cs.member_id"
					+ "						, cs.cash_date"
					+ "						, cs.cash_price"
					+ "						, cg.category_kind"
					+ "				FROM cash cs"
					+ "					INNER JOIN category cg"
					+ "					ON cs.category_no = cg.category_no) t) t2"
					+ " 	WHERE member_id=?"
					+ "	 	GROUP BY EXTRACT(YEAR FROM t2.cash_date)"
					+ " 	ORDER BY EXTRACT(YEAR FROM t2.cash_date) ASC";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, memberId);
			rs = stmt.executeQuery();
			while(rs.next()) {
				HashMap<String, Object> m = new HashMap<String, Object>();
				m.put("year", rs.getInt("year"));
				m.put("sumImport", rs.getLong("sumImport"));
				m.put("avgImport", rs.getLong("avgImport"));
				m.put("sumExport", rs.getLong("sumExport"));
				m.put("avgExport", rs.getLong("avgExport"));
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
	public ArrayList<HashMap<String, Object>> selectStatsByMonth(String memberId, int year){ // 사용자별, 월별 수입/지출 합계, 평균 보기
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			conn = dbUtil.getConnection();
			String sql = "SELECT EXTRACT(month FROM t2.cash_date) month" // 인라인뷰 사용
					+ "			, SUM(t2.importCash) sumImport"
					+ "			, round(AVG(t2.importCash)) avgImport"
					+ "			, SUM(t2.exportCash) sumExport"
					+ "			, round(AVG(t2.exportCash)) avgExport"
					+ "		FROM (SELECT t.member_id"
					+ "					, t.cash_date"
					+ "					, t.category_kind"
					+ "					, if(t.category_kind='수입', t.cash_price, NULL) importCash" //if(조건문, 참일때 값, 거짓일 때 값)
					+ "					, if(t.category_kind='지출', t.cash_price, NULL) exportCash"
					+ "			FROM (SELECT cs.member_id"
					+ "						, cs.cash_date"
					+ "						, cs.cash_price"
					+ "						, cg.category_kind"
					+ "				FROM cash cs"
					+ "					INNER JOIN category cg"
					+ "					ON cs.category_no = cg.category_no) t) t2"
					+ " 	WHERE member_id=? AND EXTRACT(YEAR FROM t2.cash_date)=?"
					+ "	 	GROUP BY EXTRACT(month FROM t2.cash_date)"
					+ " 	ORDER BY EXTRACT(month FROM t2.cash_date) ASC";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, memberId);
			stmt.setInt(2, year);
			rs = stmt.executeQuery();
			while(rs.next()) {
				HashMap<String, Object> m = new HashMap<String, Object>();
				m.put("month", rs.getInt("month"));
				m.put("sumImport", rs.getLong("sumImport"));
				m.put("avgImport", rs.getLong("avgImport"));
				m.put("sumExport", rs.getLong("sumExport"));
				m.put("avgExport", rs.getLong("avgExport"));
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
	public HashMap<String, Integer> selectMinMaxYear(String memberId){ // 페이징. 가계부가 작성된 최소 최대 연도 구하기
		HashMap<String, Integer> m = null;
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			conn = dbUtil.getConnection();
			String sql = "SELECT (SELECT MIN(EXTRACT(YEAR FROM cash_date)) FROM cash WHERE member_id=?) minYear, (SELECT MAX(EXTRACT(YEAR FROM cash_date)) FROM cash WHERE member_id=?) maxYear FROM dual";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, memberId);
			stmt.setString(2, memberId);
			rs = stmt.executeQuery();
			if(rs.next()) {
				m = new HashMap<String, Integer>();
				m.put("minYear", rs.getInt("minYear"));
				m.put("maxYear", rs.getInt("maxYear"));
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
		return m;
	}
	public ArrayList<HashMap<String, Object>> selectStatsByCategory(String memberId, int year, String categoryKind){ // 카테고리별 상세보기
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			conn = dbUtil.getConnection();
			String sql = "SELECT EXTRACT(month FROM t2.cash_date) month"
					+ "			, category_kind categoryKind"
					+ "			, category_name categoryName"
					+ "			, SUM(t2.cashPrice) sumCashPrice"
					+ "			, round(AVG(t2.cashPrice)) avgCashPrice"
					+ "		FROM (SELECT member_id"
					+ "			, cash_date"
					+ "			, category_kind"
					+ "			, category_name"
					+ "			, if(category_kind=? , cash_price, NULL) cashPrice" //if(조건문, 참일때 값, 거짓일 때 값)
					+ "				FROM (SELECT cs.member_id"
					+ "							, cs.cash_date"
					+ "							, cs.cash_price"
					+ "							, cg.category_kind"
					+ "							, cg.category_name"
					+ "						FROM cash cs"
					+ "							INNER JOIN category cg"
					+ "							ON cs.category_no = cg.category_no) t) t2"
					+ " WHERE member_id=? AND EXTRACT(YEAR FROM t2.cash_date)=? AND category_kind=?"
					+ " GROUP BY EXTRACT(month FROM t2.cash_date)"
					+ " ORDER BY EXTRACT(month FROM t2.cash_date) ASC";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, categoryKind);
			stmt.setString(2, memberId);
			stmt.setInt(3, year);
			stmt.setString(4, categoryKind);
			rs = stmt.executeQuery();
			while(rs.next()) {
				HashMap<String, Object> m = new HashMap<String, Object>();
				m.put("month", rs.getInt("month"));
				m.put("categoryKind", rs.getString("categoryKind"));
				m.put("categoryName", rs.getString("categoryName"));
				m.put("sumCashPrice", rs.getLong("sumCashPrice"));
				m.put("avgCashPrice", rs.getLong("avgCashPrice"));
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
}