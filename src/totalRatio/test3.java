package totalRatio;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import totalRatio.TotalRatio;
import totalRatio.TotalRatioDAO;

import com.mysql.jdbc.Statement;
public class test3 {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		TotalRatio totalRatio = new TotalRatio();
		TotalRatioDAO t = new TotalRatioDAO();
		totalRatio.setSelectTeam("sk");
		if(totalRatio.getSelectTeam().contains("sk")) {
			totalRatio = t.getRatio(totalRatio);
			int num = Integer.parseInt(t.getRatio(totalRatio).getSk());
			num+=1;
			totalRatio.setSk(Integer.toString(num));
			System.out.println(totalRatio.getSk()+" "+totalRatio.getDoosan());
			t.setRatio(totalRatio);
			System.out.println(t.getRatio(totalRatio).getSk());
		}
	}

}
