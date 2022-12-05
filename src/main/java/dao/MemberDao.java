package dao;
import java.sql.*;
import java.util.*;
import util.*;
import vo.*;
public class MemberDao { // 2. Model
	public Member login(Member paramMember) { // 로그인
		Member resultMember = null; // 반환할 변수초기화
		DBUtil dbUtil = new DBUtil(); 
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			conn = dbUtil.getConnection(); // db연결 메서드
			String sql = "SELECT member_id memberId, member_name memberName, member_level memberLevel FROM member WHERE member_id = ? AND member_pw = PASSWORD(?)";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, paramMember.getMemberId());
			stmt.setString(2, paramMember.getMemberPw());
			rs = stmt.executeQuery();
			if(rs.next()) { 
				//System.out.println("로그인 성공");
				resultMember = new Member(); // 로그인 성공시에 객체 생성
				resultMember.setMemberId(rs.getString("memberId"));  
				resultMember.setMemberName(rs.getString("memberName"));
				resultMember.setMemberLevel(rs.getInt("memberLevel"));
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
		return resultMember;
	}
	// 하나의 메서드엔 최소한의 쿼리로 분리시키기
	public boolean idDup(String memberId) { // 회원가입에 필요한 아이디 중복검사
		boolean result = false;
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			conn = dbUtil.getConnection();
			String sql = "SELECT member_id FROM member WHERE member_id=?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, memberId);
			rs = stmt.executeQuery();
			if(rs.next()) {
				//System.out.println("중복된 아이디");
				result = true;
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
		return result;
	}
	public int insertMember(Member paramMember) { // 회원가입
		int row = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		try {
			conn = dbUtil.getConnection();
			String sql = "INSERT INTO member(member_id, member_pw, member_name, updatedate, createdate) VALUES(?,PASSWORD(?),?,NOW(),NOW())";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, paramMember.getMemberId());
			stmt.setString(2, paramMember.getMemberPw());
			stmt.setString(3, paramMember.getMemberName());
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
	public Member updateMember(Member paramMember) { // 회원정보수정
		Member resultMember = null;
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		try {
			conn = dbUtil.getConnection();
			String sql="UPDATE member SET member_name=?, updatedate=NOW() WHERE member_id=? AND member_pw=PASSWORD(?)";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, paramMember.getMemberName());
			stmt.setString(2, paramMember.getMemberId());
			stmt.setString(3, paramMember.getMemberPw());
			int row = stmt.executeUpdate();
			if(row==1) {
				//System.out.println("회원정보 수정 성공");
				resultMember = new Member();
				resultMember.setMemberId(paramMember.getMemberId());
				resultMember.setMemberName(paramMember.getMemberName());
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(null, stmt, conn);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return resultMember;
	}
	public int updateMemberPw(String memberId, String memberPw, String newMemberPw) { // 비밀번호 변경
		int row = 0; // 반환할 변수 초기화
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		try {
			conn = dbUtil.getConnection();
			String sql = "UPDATE member SET member_pw=PASSWORD(?), updatedate=NOW() WHERE member_id=? AND member_pw=PASSWORD(?)";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, newMemberPw);
			stmt.setString(2, memberId);
			stmt.setString(3, memberPw);
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
	public int deleteMember(Member member) { // 회원탈퇴
		int row = 0; // 반환할 변수 초기화
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		try {
			conn = dbUtil.getConnection(); // db 연결
			String sql = "DELETE FROM member WHERE member_id=? AND member_pw=PASSWORD(?)";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, member.getMemberId());
			stmt.setString(2, member.getMemberPw());
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
	// ---관리자 기능---
	public ArrayList<Member> selectMemberListByPage(int beginRow, int rowPerPage, String search) { // 멤버 목록출력 (검색기능추가)
		ArrayList<Member> memberList = null;
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			conn = dbUtil.getConnection();
			String sql = null;
			stmt = null;
			if(search==null) {
				sql = "SELECT member_no memberNo, member_id memberId, member_level memberLevel, member_name memberName, updatedate, createdate FROM member LIMIT ?,?";
				stmt = conn.prepareStatement(sql);
				stmt.setInt(1, beginRow);
				stmt.setInt(2, rowPerPage);	
			} else {
				sql = "SELECT member_no memberNo, member_id memberId, member_level memberLevel, member_name memberName, updatedate, createdate FROM member WHERE member_id LIKE ? LIMIT ?,?";
				stmt = conn.prepareStatement(sql);
				stmt.setString(1, "%"+search+"%");
				stmt.setInt(2, beginRow);
				stmt.setInt(3, rowPerPage);	
			}		
			rs = stmt.executeQuery();
			memberList = new ArrayList<Member>();
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
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(rs, stmt, conn);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return memberList;
	}
	public int deleteMemberByAdmin(String memberId) { // 멤버 강제 탈퇴
		int row = 0; // 반환할 변수 초기화
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		try {
			conn = dbUtil.getConnection(); // db 연결
			String sql = "DELETE FROM member WHERE member_id=?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, memberId);
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
	public int totalCount() { // 멤버 수
		int count = 0; // 리턴할 변수 초기화
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			conn = dbUtil.getConnection(); // db 연결
			String sql = "SELECT COUNT(*) count FROM member";
			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();
			
			if(rs.next()) {
				count=rs.getInt("count");
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
		return count;
	}
	public int updateMemberLevelByAdmin(Member paramMember) { // 멤버 레벨 수정
		int row = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		try {
			conn = dbUtil.getConnection(); // db 연결
			String sql = "UPDATE member SET member_level = ?, updatedate=NOW() WHERE member_id=?";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, paramMember.getMemberLevel());
			stmt.setString(2, paramMember.getMemberId());
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