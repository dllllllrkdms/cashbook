package util;
import java.sql.*;
public class DBUtil { // 반복되는 db 연결 코드를 하나의 메서드로 분리
	public Connection getConnection() throws Exception { 
		String driver = "org.mariadb.jdbc.Driver";
		String dbUrl = "jdbc:mariadb://3.37.118.214:3306/cashbook";
		String dbUser = "root";
		String dbPw = "java1234";
		Class.forName(driver);
		Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPw);
		return conn;
	}
	public void close(ResultSet rs, PreparedStatement stmt, Connection conn) throws Exception { // -> rs를 실행하지 않는 insert,update,delete 문에는 null값을 넣어줌
		if(rs!=null) { // null값을 close하면 nullPointException 발생 -> 분기문으로 처리
			rs.close(); 
		}
		if(stmt!=null) {
			stmt.close();
		}
		if(conn!=null) {
			conn.close();
		}
	}
}