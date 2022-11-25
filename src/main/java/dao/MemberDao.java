package dao;
import java.sql.*;
import java.util.*;
import util.*;
import vo.*;
public class MemberDao { // 2. Model
	public Member login(Member paramMember) throws Exception { // 로그인
		Member resultMember = null; // 반환할 변수초기화
		DBUtil dbUtil = new DBUtil(); 
		Connection conn = dbUtil.getConnection(); // db연결 메서드
		String sql = "SELECT member_id memberId, member_name memberName, member_level memberLevel FROM member WHERE member_id = ? AND member_pw = PASSWORD(?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramMember.getMemberId());
		stmt.setString(2, paramMember.getMemberPw());
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) { 
			//System.out.println("로그인 성공");
			resultMember = new Member(); // 로그인 성공시에 객체 생성
			resultMember.setMemberId(rs.getString("memberId"));  
			resultMember.setMemberName(rs.getString("memberName"));
			resultMember.setMemberLevel(rs.getInt("memberLevel"));
		}
		dbUtil.close(rs, stmt, conn);
		return resultMember;
	}
	// 하나의 메서드엔 최소한의 쿼리로 분리시키기
	public boolean idDup(String memberId) throws Exception { // 회원가입에 필요한 아이디 중복검사
		boolean result = false;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT member_id FROM member WHERE member_id=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberId);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			//System.out.println("중복된 아이디");
			result = true;
		}
		dbUtil.close(rs, stmt, conn);
		return result;
	}
	public int insertMember(Member paramMember) throws Exception { // 회원가입
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "INSERT INTO member(member_id, member_pw, member_name, updatedate, createdate) VALUES(?,PASSWORD(?),?,curdate(),curdate())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramMember.getMemberId());
		stmt.setString(2, paramMember.getMemberPw());
		stmt.setString(3, paramMember.getMemberName());
		int row = stmt.executeUpdate();
		dbUtil.close(null, stmt, conn);
		return row;
	}
	public Member updateMember(Member paramMember) throws Exception { // 회원정보수정
		Member resultMember = new Member();
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql="UPDATE member SET member_name=?, updatedate=CURDATE() WHERE member_id=? AND member_pw=PASSWORD(?)";
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
		dbUtil.close(null, stmt, conn);
		return resultMember;
	}
	public int updateMemberPw(String memberId, String memberPw, String newMemberPw) throws Exception { // 비밀번호 변경
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "UPDATE member SET member_pw=PASSWORD(?), updatedate=CURDATE() WHERE member_id=? AND member_pw=PASSWORD(?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, newMemberPw);
		stmt.setString(2, memberId);
		stmt.setString(3, memberPw);
		int row = stmt.executeUpdate();
		return row;
	}
	public int deleteMember(Member member) throws Exception { // 회원탈퇴
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection(); // db 연결
		String sql = "DELETE FROM member WHERE member_id=? AND member_pw=PASSWORD(?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, member.getMemberId());
		stmt.setString(2, member.getMemberPw());
		int row = stmt.executeUpdate();
		dbUtil.close(null, stmt, conn);
		return row;
	}
	// ---관리자 기능---
	public ArrayList<Member> selectMemberListByPage(int beginRow, int rowPerPage) throws Exception{ // 멤버 목록출력 
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT member_no memberNo, member_id memberId, member_level memberLevel, member_name memberName, updatedate, createdate FROM member";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		ArrayList<Member> memberList = new ArrayList<Member>();
		while(rs.next()) {
			Member member = new Member();
			member.setMemberNo(rs.getInt("memberNo"));
			member.setMemberId(rs.getString("memberId"));
			member.setMemberLevel(rs.getInt("memberLevel"));
			member.setMemberName(rs.getString("memberName"));
			member.setUpdatedate(rs.getString("updatedate"));
			member.setCreatedate(rs.getString("createdate"));
			memberList.add(member);
		}
		dbUtil.close(rs, stmt, conn);
		return memberList;
	}
	public int deleteMemberByAdmin(String memberId) throws Exception { // 멤버 강제 탈퇴
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection(); // db 연결
		String sql = "DELETE FROM member WHERE member_id=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberId);
		int row = stmt.executeUpdate();
		dbUtil.close(null, stmt, conn); // 연결 해제
		return row;
	}
	public int totalCount() throws Exception { // 멤버 수
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection(); // db 연결
		String sql = "SELECT COUNT(*) count FROM member";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		int count = 0; // 리턴할 변수 초기화
		if(rs.next()) {
			count=rs.getInt("count");
		}
		dbUtil.close(rs, stmt, conn); // db 연결 해제
		return count;
	}
	public int updateMemberLevel(Member paramMember) throws Exception { // 멤버 레벨 수정
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection(); // db 연결
		String sql = "UPDATE member SET member_level = ? WHERE member_id=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, paramMember.getMemberLevel());
		stmt.setString(2, paramMember.getMemberId());
		int row = stmt.executeUpdate();
		dbUtil.close(null, stmt, conn);
		return row;
	}
}
