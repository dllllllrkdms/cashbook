package dao;
import java.sql.*;
import util.*;
import vo.*;
public class CommentDao {
	public int insertComment(Comment comment) throws Exception { // insertCommentAction
		int row =0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "INSERT INTO comment(help_no, comment_memo, member_id, updatedate, createdate) VALUES(?,?,?,NOW(),NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, comment.getHelpNo());
		stmt.setString(2, comment.getCommentMemo());
		stmt.setString(3, comment.getMemberId());
		row = stmt.executeUpdate();
		dbUtil.close(null, stmt, conn); // db자원 반납
		return row;
	}
	public Comment selectCommentOne(int commentNo) throws Exception { // updateCommentForm
		Comment comment =null;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT comment_memo commentMemo, help_no helpNo, member_id memberId FROM comment WHERE comment_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, commentNo);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			comment=new Comment();
			comment.setCommentMemo(rs.getString("commentMemo"));
			comment.setMemberId(rs.getString("memberId"));
			comment.setHelpNo(Integer.parseInt(rs.getString("helpNo")));
		}
		dbUtil.close(rs, stmt, conn); // db자원반납
		return comment;
	}
	public int updateComment(Comment comment) throws Exception { // updateCommentAction
		int row=0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "UPDATE comment SET comment_memo=?, member_id=?, updatedate=NOW() WHERE comment_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, comment.getCommentMemo());
		stmt.setString(2, comment.getMemberId());
		stmt.setInt(3, comment.getCommentNo());
		row = stmt.executeUpdate();
		dbUtil.close(null, stmt, conn); // db자원 반납
		return row;
	}
	public int deleteCommemt(int commentNo) throws Exception { // deleteComment
		int row = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "DELETE FROM comment WHERE comment_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1,commentNo);
		row = stmt.executeUpdate();
		dbUtil.close(null, stmt, conn);
		return row;
	}
}