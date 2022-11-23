package dao;
import java.util.*;
import java.sql.*;
import util.*;
import vo.*;
public class CategoryDao {
	public ArrayList<Category> selectCategoryList() throws Exception{
		ArrayList<Category> categoryList = new ArrayList<Category>();
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
			categoryList.add(category);
		}
		rs.close();
		stmt.close();
		conn.close();
		return categoryList;
	}
}
