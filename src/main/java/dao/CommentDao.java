package dao;
import java.sql.*;
import util.*;
import vo.*;
public class CommentDao {
	public int insertComment(Comment comment) { // insertCommentAction
		int row =0;
		DBUtil dbUtil = new DBUtil();
		Connection conn=null;
		PreparedStatement stmt=null;
		try {
			conn = dbUtil.getConnection();
			String sql = "INSERT INTO comment(help_no, comment_memo, member_id, updatedate, createdate) VALUES(?,?,?,NOW(),NOW())";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, comment.getHelpNo());
			stmt.setString(2, comment.getCommentMemo());
			stmt.setString(3, comment.getMemberId());
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
	public Comment selectCommentOne(int commentNo) { // updateCommentForm
		Comment comment =null;
		DBUtil dbUtil = new DBUtil();
		Connection conn=null;
		PreparedStatement stmt=null;
		ResultSet rs= null;
		try {
			conn = dbUtil.getConnection();
			String sql = "SELECT comment_memo commentMemo, help_no helpNo, member_id memberId FROM comment WHERE comment_no = ?";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, commentNo);
			rs = stmt.executeQuery();
			if(rs.next()) {
				comment=new Comment();
				comment.setCommentMemo(rs.getString("commentMemo"));
				comment.setMemberId(rs.getString("memberId"));
				comment.setHelpNo(Integer.parseInt(rs.getString("helpNo")));
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
		return comment;
	}
	public int updateComment(Comment comment) { // updateCommentAction
		int row=0;
		DBUtil dbUtil = new DBUtil();
		Connection conn=null;
		PreparedStatement stmt=null;
		try {
			conn = dbUtil.getConnection();
			String sql = "UPDATE comment SET comment_memo=?, member_id=?, updatedate=NOW() WHERE comment_no=?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, comment.getCommentMemo());
			stmt.setString(2, comment.getMemberId());
			stmt.setInt(3, comment.getCommentNo());
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
	public int deleteCommemt(int commentNo) { // deleteComment
		int row = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn=null;
		PreparedStatement stmt=null;
		try {
			conn = dbUtil.getConnection();
			String sql = "DELETE FROM comment WHERE comment_no=?";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1,commentNo);
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