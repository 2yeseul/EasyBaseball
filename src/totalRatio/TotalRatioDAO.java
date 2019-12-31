package totalRatio;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.mysql.jdbc.Statement;

public class TotalRatioDAO {

	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public TotalRatioDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/bbs?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
			String dbID = "root";
			String dbPassword = "root";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static Connection getMySQLConnection() {
		Connection conn2 = null;
		try {
			String dbURL = "jdbc:mysql://localhost:3306/bbs?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
			String dbID = "root";
			String dbPassword = "root";
			Class.forName("com.mysql.jdbc.Driver");
			conn2 = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return conn2;
	}

	public TotalRatio getRatio(TotalRatio total) {
		String SQL = "select * from totalRatio order by pid desc limit 1";
		try {
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				total.setSk(rs.getString("sk"));
				total.setDoosan(rs.getString("doosan"));
				total.setKiwoom(rs.getString("kiwoom"));
				total.setLg(rs.getString("lg"));
				total.setNc(rs.getString("nc"));
				total.setKt(rs.getString("kt"));
				total.setKia(rs.getString("kia"));
				total.setSamsung(rs.getString("samsung"));
				total.setHanhwa(rs.getString("hanhwa"));
				total.setLotte(rs.getString("lotte"));
				total.setPid(rs.getInt("pid"));
			}
			return total;
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return null;
	}

	public int setRatio(TotalRatio total) {
		String SQL = "insert into totalRatio values" + "(?,?,?,?,?,?,?,?,?,?,?)";

		try {

			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, total.getSk());
			pstmt.setString(2, total.getDoosan());
			pstmt.setString(3, total.getKiwoom());
			pstmt.setString(4, total.getLg());
			pstmt.setString(5, total.getNc());
			pstmt.setString(6, total.getKt());
			pstmt.setString(7, total.getKia());
			pstmt.setString(8, total.getSamsung());
			pstmt.setString(9, total.getHanhwa());
			pstmt.setString(10, total.getLotte());
			pstmt.setInt(11, total.getPid()+1);
			return pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
		
	}
}
