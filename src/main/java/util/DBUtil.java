package util;
import java.sql.*;
public class DBUtil { // 반복되는 db 연결 코드를 하나의 메서드로 분리
	public Connection getConnection() throws Exception { 
		String driver = "org.mariadb.jdbc.Driver";
		String dbUrl = "jdbc:mariadb://localhost:3306/cashbook";
		String dbUser = "root";
		String dbPw = "java1234";
		Class.forName(driver);
		Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPw);
		return conn;
	}
}