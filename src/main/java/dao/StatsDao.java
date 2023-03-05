package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import util.DBUtil;

public class StatsDao {
	
	// 사용자별, 연도별 수입/지출 합계, 평균 보기
	public ArrayList<HashMap<String, Object>> selectStatsByYear(String memberId){ 
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
					+ "				INNER JOIN category cg"
					+ "				ON cs.category_no = cg.category_no"
					+ "				WHERE member_id=?) t) t2"
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
	
	// 사용자별, 월별 수입/지출 합계, 평균 보기
	public ArrayList<HashMap<String, Object>> selectStatsByMonth(String memberId, int year){
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
					+ "					FROM cash cs"
					+ "					INNER JOIN category cg"
					+ "					ON cs.category_no = cg.category_no"
					+ "					WHERE member_id=? AND EXTRACT(YEAR FROM cs.cash_date)=?) t) t2"
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
	
	// 사용자별 전월,이달의 수입/지출 분석 (전월대비 증감내역 출력)
	public HashMap<String, Object> selectIncrementByMonth(String memberId, int year, int month){
		HashMap<String, Object> m = new HashMap<String, Object>();
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			conn = dbUtil.getConnection();
			String sql = " SELECT t3.currentImportCash-t3.lastImportCash AS importIncrement"
					+ "			, t3.currentExportCash-t3.lastExportCash AS exportIncrement"
					+ "		FROM ( SELECT SUM(if(t2.month=? AND t2.category_kind='수입', t2.cash_price, NULL)) lastImportCash"
					+ "					, SUM(if(t2.month=? AND t2.category_kind='수입', t2.cash_price, NULL)) currentImportCash"
					+ "					, SUM(if(t2.month=? AND t2.category_kind='지출', t2.cash_price, NULL)) lastExportCash"
					+ "					, SUM(if(t2.month=? AND t2.category_kind='지출', t2.cash_price, NULL)) currentExportCash"
					+ "				FROM (SELECT cs.member_id"
					+ "							, cs.cash_price"
					+ "							, EXTRACT(YEAR FROM cs.cash_date) year"
					+ "							, EXTRACT(month FROM cs.cash_date) month"
					+ "							, cg.category_kind"
					+ "						FROM cash cs"
					+ "						INNER JOIN category cg"
					+ "						ON cs.category_no = cg.category_no"
					+ "						WHERE cs.member_id = ?"
					+ "						AND EXTRACT(YEAR FROM cs.cash_date) = ?"
					+ "						AND EXTRACT(MONTH FROM cs.cash_date) IN (?,?) ) t2) t3";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, month-1);
			stmt.setInt(2, month);
			stmt.setInt(3, month-1);
			stmt.setInt(4, month);
			stmt.setString(5, memberId);
			stmt.setInt(6, year);
			stmt.setInt(7, month-1);
			stmt.setInt(8, month);
			rs = stmt.executeQuery();
			if(rs.next()) {
				m.put("importIncrement", rs.getLong("importIncrement"));
				m.put("exportIncrement", rs.getLong("exportIncrement"));
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
	
	// 이달의 가장 많이 지출한 카테고리와 금액
	public HashMap<String, Object> selectMaxPriceByCategory(String memberId, int year, int month){
		HashMap<String, Object> m = new HashMap<String, Object>();
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			conn = dbUtil.getConnection();
			String sql = " SELECT t2.sumCashPrice maxCashPrice"
					+ "			, t2.category_name categoryName"
					+ "		FROM ( SELECT ROW_NUMBER() over(ORDER BY t.sumCashPrice desc) rowNum "
					+ "					, t.sumCashPrice"
					+ "					, t.category_name"
					+ "				FROM( SELECT SUM(cs.cash_price) sumCashPrice"
					+ "							, cg.category_kind"
					+ "							, cg.category_name"
					+ "						FROM cash cs"
					+ "						INNER JOIN category cg"
					+ "						ON cs.category_no = cg.category_no"
					+ "						WHERE member_id=? AND EXTRACT(YEAR FROM cs.cash_date)=? AND EXTRACT(MONTH FROM cs.cash_date)=? AND cg.category_kind='지출'"
					+ "						GROUP BY category_name ) t ) t2"
					+ " 	WHERE t2.rowNum = 1";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, memberId);
			stmt.setInt(2, year);
			stmt.setInt(3, month);
			rs = stmt.executeQuery();
			if(rs.next()) {
				m.put("categoryName", rs.getString("categoryName"));
				m.put("maxCashPrice", rs.getInt("maxCashPrice"));
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
	
	// 페이징. 가계부가 작성된 최소 최대 연도 구하기
	public HashMap<String, Integer> selectMinMaxDate(String memberId){ 
		HashMap<String, Integer> m = null;
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			conn = dbUtil.getConnection();
			String sql = "SELECT (SELECT MIN(EXTRACT(MONTH FROM cash_date)) FROM cash WHERE member_id=? AND EXTRACT(YEAR FROM cash_date)=t.minYear) minMonth"
					+ "		, (SELECT MAX(EXTRACT(MONTH FROM cash_date)) FROM cash WHERE member_id=? AND EXTRACT(YEAR FROM cash_date)=t.maxYear) maxMonth"
					+ "		, minYear"
					+ "		, maxYear"
					+ "		FROM (SELECT (SELECT MIN(EXTRACT(YEAR FROM cash_date)) FROM cash WHERE member_id=?) minYear"
					+ "					, (SELECT MAX(EXTRACT(YEAR FROM cash_date)) FROM cash WHERE member_id=?) maxYear"
					+ "				FROM DUAL) t";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, memberId);
			stmt.setString(2, memberId);
			stmt.setString(3, memberId);
			stmt.setString(4, memberId);
			rs = stmt.executeQuery();
			if(rs.next()) {
				m = new HashMap<String, Integer>();
				m.put("minYear", rs.getInt("minYear"));
				m.put("maxYear", rs.getInt("maxYear"));
				m.put("minMonth", rs.getInt("minMonth"));
				m.put("maxMonth", rs.getInt("maxMonth"));
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
	
	// 카테고리별 상세보기
	public ArrayList<HashMap<String, Object>> selectStatsByCategory(String memberId, int year, int month){ 
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
					+ "			, SUM(t2.cash_price) sumCashPrice"
					+ "			, round(AVG(t2.cash_price)) avgCashPrice"
					+ "		FROM (SELECT member_id"
					+ "			, cash_date"
					+ "			, category_kind"
					+ "			, category_name"
					+ "			, cash_price"
					+ "				FROM (SELECT cs.member_id"
					+ "							, cs.cash_date"
					+ "							, cs.cash_price"
					+ "							, cg.category_kind"
					+ "							, cg.category_name"
					+ "						FROM cash cs"
					+ "							INNER JOIN category cg"
					+ "							ON cs.category_no = cg.category_no"
					+ "						WHERE member_id=? AND EXTRACT(YEAR FROM cs.cash_date)=? AND EXTRACT(MONTH FROM cs.cash_date)=?) t) t2"
					+ " GROUP BY category_name"
					+ " ORDER BY category_kind ASC";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, memberId);
			stmt.setInt(2, year);
			stmt.setInt(3, month);
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