package dao;
import java.util.*;
import java.sql.*;
import util.*;
import vo.*;
public class CategoryDao {
	public ArrayList<Category> selectCategoryList() throws Exception{ // category목록(cash 입력시 <select>목록)
		ArrayList<Category> list = new ArrayList<Category>();
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT category_no categoryNo, category_kind categoryKind, category_name categoryName FROM category";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			Category category = new Category();
			category.setCategoryNo(rs.getInt("categoryNo"));
			category.setCategoryKind(rs.getString("categoryKind"));
			category.setCategoryName(rs.getString("categoryName"));
			list.add(category);
		}
		dbUtil.close(rs, stmt, conn);
		return list;
	}
	//--admin 기능--
	public ArrayList<Category> selectCategoryListByAdmin() throws Exception{ // category목록
		ArrayList<Category> list = new ArrayList<Category>();
		DBUtil dbUtil = new DBUtil(); // null값으로 초기화 시키고 사용하는게 좋음
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT category_no categoryNo, category_kind categoryKind, category_name categoryName, updatedate, createdate FROM category";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			Category category = new Category();
			category.setCategoryNo(rs.getInt("categoryNo")); // rs.getInt(1) 1: select절의 순서
			category.setCategoryKind(rs.getString("categoryKind"));
			category.setCategoryName(rs.getString("categoryName"));
			category.setUpdatedate(rs.getString("updatedate"));
			category.setCreatedate(rs.getString("createdate"));
			list.add(category);
		}
		dbUtil.close(rs, stmt, conn); // db 자원(jdbc API) 반납
		return list;
	}
	public int insertCategory(Category category) throws Exception { // insertCategoryAction
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "INSERT INTO category(category_kind, category_name, updatedate, createdate) VALUES(?,?,NOW(),NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, category.getCategoryKind());
		stmt.setString(2, category.getCategoryName());
		int row = stmt.executeUpdate();
		dbUtil.close(null, stmt, conn);
		return row;
	}
	public int deleteCategory(int categoryNo) throws Exception { // deleteCategory
		int row = 0; // 리턴할 변수 초기화
		String sql = "DELETE FROM category WHERE category_no =?";
		DBUtil dbUtil = new DBUtil();
		Connection conn = null; // 먼저 null값으로 초기화한 후 사용
		PreparedStatement stmt = null;
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, categoryNo);
		row = stmt.executeUpdate();
		dbUtil.close(null, stmt, conn);
		return row;
	}
	public Category selectCategoryOne(int categoryNo) throws Exception { // updateCategoryForm
		Category category = null;
		String sql = "SELECT category_no categoryNo, category_kind categoryKind, category_name categoryName FROM category WHERE category_no =?";
		DBUtil dbUtil = new DBUtil();
		Connection conn=null;
		PreparedStatement stmt=null;
		conn=dbUtil.getConnection();
		stmt=conn.prepareStatement(sql);
		stmt.setInt(1, categoryNo);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			category=new Category();
			category.setCategoryNo(rs.getInt("categoryNo"));
			category.setCategoryKind(rs.getString("categoryKind"));
			category.setCategoryName(rs.getString("categoryName"));
		}
		dbUtil.close(rs, stmt, conn);
		return category;
	}
	public int updateCategoryName(Category category) throws Exception { // updateCategoryAction
		int row=0;
		String sql="UPDATE category SET category_name = ?, updatedate=NOW() WHERE category_no=?";
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		conn=dbUtil.getConnection();
		stmt=conn.prepareStatement(sql);
		stmt.setString(1, category.getCategoryName());
		stmt.setInt(2, category.getCategoryNo());
		row = stmt.executeUpdate();
		dbUtil.close(null, stmt, conn);
		return row;
	}
}