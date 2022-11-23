package dao;
import java.sql.*;
import util.*;
import vo.*;
public class MemberDao { // 2. Model
	public Member login(Member paramMember) throws Exception { // 로그인
		Member resultMember = null; // 반환할 변수초기화
		DBUtil dbUtil = new DBUtil(); 
		Connection conn = dbUtil.getConnection(); // db연결 메서드
		String sql = "SELECT member_id memberId, member_name memberName FROM member WHERE member_id = ? AND member_pw = PASSWORD(?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramMember.getMemberId());
		stmt.setString(2, paramMember.getMemberPw());
		ResultSet rs = stmt.executeQuery();
		if(rs.next()==false) { // 디버깅
			//System.out.println("로그인 실패");
		}else {
			//System.out.println("로그인 성공");
			resultMember = new Member(); // 로그인 성공시에 객체 생성
			resultMember.setMemberId(rs.getString("memberId"));  
			resultMember.setMemberName(rs.getString("memberName"));
		}
		rs.close();
		stmt.close();
		conn.close();
		return resultMember;
	}
	public boolean idDup(String memberId) throws Exception { // 아이디 중복검사
		boolean result = false;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT member_id FROM member WHERE member_id=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberId);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			result = true;
		}
		rs.close();
		stmt.close();
		conn.close();
		return result;
	}
	public boolean insertMember(Member paramMember) throws Exception { // 회원가입
		boolean result = false;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "INSERT INTO member(member_id, member_pw, member_name, updatedate, createdate) VALUES(?,?,?,curdate(),curdate())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramMember.getMemberId());
		stmt.setString(2, paramMember.getMemberPw());
		stmt.setString(3, paramMember.getMemberName());
		int row = stmt.executeUpdate();
		if(row==1) {
			//System.out.println("회원가입 성공");
			result=true;
		}
		stmt.close();
		conn.close();
		return result;
	}
	public Member updateMember(Member paramMember) throws Exception { // 회원정보수정
		Member resultMember = new Member();
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql="UPDATE member SET member_name=?, updatedate=CURDATE(), createdate=CURDATE() WHERE member_id=? AND member_pw=PASSWORD(?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramMember.getMemberName());
		stmt.setString(2, paramMember.getMemberId());
		stmt.setString(3, paramMember.getMemberPw());
		int row = stmt.executeUpdate();
		if(row==1) {
			//System.out.println("회원정보 수정 성공");
			resultMember.setMemberId(paramMember.getMemberId());
			resultMember.setMemberName(paramMember.getMemberName());
		}
		stmt.close();
		conn.close();
		return resultMember;
	}
	public boolean updateMemberPw(String memberId, String memberPw, String newMemberPw) throws Exception { // 비밀번호 변경
		boolean result=false;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "UPDATE member SET member_pw=PASSWORD(?), updatedate=CURDATE(), createdate=CURDATE() WHERE member_id=? AND member_pw=PASSWORD(?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, newMemberPw);
		stmt.setString(2, memberId);
		stmt.setString(3, memberPw);
		int row = stmt.executeUpdate();
		if(row==1) {
			//System.out.println("pw 변경 성공");
			result=true;
		}
		return result;
	}
}
