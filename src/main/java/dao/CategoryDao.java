package dao;
import java.util.*;
import java.sql.*;
import util.*;
import vo.*;
public class CategoryDao {
	//--admin 기능--
	public ArrayList<Category> selectCategoryList() { // category목록(cash 입력시 <select>목록
		ArrayList<Category> list = new ArrayList<Category>();
		DBUtil dbUtil = new DBUtil(); // null값으로 초기화 시키고 사용하는게 좋음
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			conn = dbUtil.getConnection();
			String sql = "SELECT category_no categoryNo, category_kind categoryKind, category_name categoryName, updatedate, createdate FROM category";
			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();
			while(rs.next()) {
				Category category = new Category();
				category.setCategoryNo(rs.getInt("categoryNo")); // rs.getInt(1) 1: select절의 순서
				category.setCategoryKind(rs.getString("categoryKind"));
				category.setCategoryName(rs.getString("categoryName"));
				category.setUpdatedate(rs.getString("updatedate"));
				category.setCreatedate(rs.getString("createdate"));
				list.add(category);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				dbUtil.close(rs, stmt, conn); // db 자원(jdbc API) 반납
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return list;
	}
	public ArrayList<Category> selectCategoryList(int beginRow, int rowPerPage) { // category목록(cash 입력시 <select>목록
		ArrayList<Category> list = new ArrayList<Category>();
		DBUtil dbUtil = new DBUtil(); // null값으로 초기화 시키고 사용하는게 좋음
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			conn = dbUtil.getConnection();
			String sql = "SELECT category_no categoryNo, category_kind categoryKind, category_name categoryName, updatedate, createdate FROM category ORDER BY updatedate DESC LIMIT ?,?";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
			rs = stmt.executeQuery();
			while(rs.next()) {
				Category category = new Category();
				category.setCategoryNo(rs.getInt("categoryNo")); // rs.getInt(1) 1: select절의 순서
				category.setCategoryKind(rs.getString("categoryKind"));
				category.setCategoryName(rs.getString("categoryName"));
				category.setUpdatedate(rs.getString("updatedate"));
				category.setCreatedate(rs.getString("createdate"));
				list.add(category);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				dbUtil.close(rs, stmt, conn); // db 자원(jdbc API) 반납
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return list;
	}
	public int insertCategory(Category category) { // insertCategoryAction
		int row = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		try {
			conn = dbUtil.getConnection();
			String sql = "INSERT INTO category(category_kind, category_name, updatedate, createdate) VALUES(?,?,NOW(),NOW())";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, category.getCategoryKind());
			stmt.setString(2, category.getCategoryName());
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
	public int deleteCategory(int categoryNo) { // deleteCategory
		int row = 0; // 리턴할 변수 초기화
		Connection conn = null;
		PreparedStatement stmt = null;
		
		DBUtil dbUtil = new DBUtil();
		try {
			conn = dbUtil.getConnection();
			String sql = "DELETE FROM category WHERE category_no =?";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, categoryNo);
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
	public Category selectCategoryOne(int categoryNo) { // updateCategoryForm
		Category category = null;
		String sql = "SELECT category_no categoryNo, category_kind categoryKind, category_name categoryName FROM category WHERE category_no =?";
		DBUtil dbUtil = new DBUtil();
		Connection conn=null;
		PreparedStatement stmt=null;
		ResultSet rs= null;
		try {
			conn=dbUtil.getConnection();
			stmt=conn.prepareStatement(sql);
			stmt.setInt(1, categoryNo);
			rs = stmt.executeQuery();
			if(rs.next()) {
				category=new Category();
				category.setCategoryNo(rs.getInt("categoryNo"));
				category.setCategoryKind(rs.getString("categoryKind"));
				category.setCategoryName(rs.getString("categoryName"));
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
		return category;
	}
	public int updateCategoryName(Category category) { // updateCategoryAction
		int row=0;
		String sql="UPDATE category SET category_name = ?, updatedate=NOW() WHERE category_no=?";
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		try {
			conn=dbUtil.getConnection();
			stmt=conn.prepareStatement(sql);
			stmt.setString(1, category.getCategoryName());
			stmt.setInt(2, category.getCategoryNo());
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
}