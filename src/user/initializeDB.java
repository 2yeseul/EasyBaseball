package user;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;

import com.example.model.searchFans;
import com.example.model.searchStats;
import com.example.model.searchPlayerInfo;;

/*

크롤링한 데이터 initialize


*/

public class initializeDB {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		searchPlayerInfo players = new searchPlayerInfo();
		String urls = "http://www.statiz.co.kr/stat.php?cn=H,1,0,RBI,,0";
		List names = players.getPlayerName(urls);

		List totalurls = players.getPlayerUrl(urls);
		String newurl = totalurls.get(0).toString();

		UserDAO pushData = new UserDAO();
		playerInfo playersInfo = new playerInfo();

		List totalData = new ArrayList();

		for (int i = 0; i < names.size(); i++) {
			List dates = players.getPlayDate(totalurls.get(i).toString());
			List teams = players.getPlayerPlayTeam(totalurls.get(i).toString());
			List results = players.getPlayResult(totalurls.get(i).toString());
			List hits = players.getPlayerHits(totalurls.get(i).toString());
			List homeruns = players.getPlayerHomeruns(totalurls.get(i).toString());
			List avg = players.getPlayerAvg(totalurls.get(i).toString());
			List wpa = players.getPlayerWpa(totalurls.get(i).toString());
			String myTeam = players.getMyTeam(totalurls.get(i).toString());
			String totalAvg = players.getTotalAvg(totalurls.get(i).toString());
			String totalWar = players.getTotalWar(totalurls.get(i).toString());
			String totalHits = players.getTotalHits(totalurls.get(i).toString());

			for (int j = 0, numPid = 0; j < dates.size(); j++, numPid++) {

				playersInfo.setPlayDate(dates.get(j).toString());
				playersInfo.setPlayTeam(teams.get(j).toString());
				playersInfo.setPlayResult(results.get(j).toString());
				playersInfo.setPlayHits(hits.get(j).toString());
				playersInfo.setPlayHomeruns(homeruns.get(j).toString());
				playersInfo.setPlayAvg(avg.get(j).toString());
				playersInfo.setPlayWpa(wpa.get(j).toString());
				playersInfo.setPlayerName(names.get(i).toString());
				playersInfo.setMyTeam(myTeam);
				playersInfo.setTotalAvg(totalAvg);
				playersInfo.setTotalWar(totalWar);
				playersInfo.setTotalHits(totalHits);
				playersInfo.setPid(Integer.toString(numPid));

				/* DB로 총 데이터 삽입 */
				pushData.setPlayerInfo(playersInfo);

			}

		}

	}
}
