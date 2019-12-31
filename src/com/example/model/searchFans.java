package com.example.model;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;

import user.UserDAO;

public class searchFans {

	public List infos = new ArrayList();
	public String thumb;
	public List schedule = new ArrayList();
	public List videos = new ArrayList();
	public String url;

	// 경기 하이라이트
	public String getVideos(String date, String team, String myTeam) {
		String month, day;
		int endIndex = date.indexOf("-");
		
		month = date.substring(0, endIndex);
		day = date.substring(endIndex + 1, date.length());
		
		String dateID = "2019" + month + day;
		String teamID;

		String yourTeam=team;
		if (team.substring(0, 1).equals("@")) {
			yourTeam = team.substring(team.indexOf("@") + 1, team.length());
		}
		
		String[] teamNames = { "SK", "두산", "키움", "LG", "NC", "KT", "KIA", "삼성", "한화", "롯데" };
		String[] keyWords = { "SK", "OB", "WO", "LG", "NC", "KT", "HT", "SS", "HH", "LT" };

		String teamKeyWords = "";
		String myTeamKeyWords = "";

		for (int i = 0; i < teamNames.length; i++) {
			if (myTeam.equals(teamNames[i]))
				myTeamKeyWords = keyWords[i];
			if (yourTeam.equals(teamNames[i]))
				teamKeyWords = keyWords[i];
		}

		/* 포스트 시즌 여부 먼저 확인 */

		/* 와일드 카드 */
		if (date.equals("10-03"))
			url = "https://sports.news.naver.com/gameCenter/gameVideo.nhn?category=kbo&gameId=44441003NCLG02019";
		/* 준플레이오프 */
		else if (date.equals("10-06"))
			url = "https://sports.news.naver.com/gameCenter/gameVideo.nhn?category=kbo&gameId=33331006LGWO02019";
		else if (date.equals("10-07"))
			url = "https://sports.news.naver.com/gameCenter/gameVideo.nhn?category=kbo&gameId=33331007LGWO02019";
		else if (date.equals("10-09"))
			url = "https://sports.news.naver.com/gameCenter/gameVideo.nhn?category=kbo&gameId=33331009LGWO02019";
		else if (date.equals("10-10"))
			url = "https://sports.news.naver.com/gameCenter/gameVideo.nhn?category=kbo&gameId=33331010LGWO02019";

		/* 플레이오프 */
		else if (date.equals("10-14"))
			url = "https://sports.news.naver.com/gameCenter/gameVideo.nhn?category=kbo&gameId=55551014WOSK02019";
		else if (date.equals("10-15"))
			url = "https://sports.news.naver.com/gameCenter/gameVideo.nhn?category=kbo&gameId=55551015WOSK02019";
		else if (date.equals("10-17"))
			url = "https://sports.news.naver.com/gameCenter/gameVideo.nhn?category=kbo&gameId=55551017WOSK02019";

		/* 한국시리즈 */

		else if (date.equals("10-22"))
			url = "https://sports.news.naver.com/gameCenter/gameVideo.nhn?category=kbo&gameId=77771022WOOB02019";
		else if (date.equals("10-23"))
			url = "https://sports.news.naver.com/gameCenter/gameVideo.nhn?category=kbo&gameId=77771023WOOB02019";
		else if (date.equals("10-25"))
			url = "https://sports.news.naver.com/gameCenter/gameVideo.nhn?category=kbo&gameId=77771025WOOB02019";
		else if (date.equals("10-26"))
			url = "https://sports.news.naver.com/gameCenter/gameVideo.nhn?category=kbo&gameId=77771026WOOB02019";

		/* 정규시즌 경기 */
		
		else {

			if (team.substring(0,1).equals("@"))
				url = "https://sports.news.naver.com/gameCenter/gameVideo.nhn?category=kbo&gameId=2019" + month + day
						+ myTeamKeyWords + teamKeyWords+"02019";
			else
				url ="https://sports.news.naver.com/gameCenter/gameVideo.nhn?category=kbo&gameId=2019"+month+day
					  + teamKeyWords+myTeamKeyWords+"02019";
		}

		return (url);
	}

	// 관심선수의 프로필 사진
	public String getThumb(String batterName) {
		String url = "https://search.naver.com/search.naver?sm=top_hty&fbm=1&ie=utf8&query=야구선수+" + batterName;
		Document doc3 = null;
		try {
			doc3 = Jsoup.connect(url).get();
		} catch (IOException e) {
			e.printStackTrace();
		}

		Elements element3 = doc3.select(".big_thumb img[src $=png]");
		if(element3.attr("src")=="") {
			thumb="no data";
		}
		else
		 thumb = element3.attr("src");

		return (thumb);
	}

	// 응원팀의 일정과 정보
	public List getSchedule(String userTeam) {
		String url = "https://search.naver.com/search.naver?sm=top_hty&fbm=0&ie=utf8&query=" + userTeam;
		Document doc = null;
		try {
			doc = Jsoup.connect(url).get();
		} catch (IOException e) {
			e.printStackTrace();
		}

		Elements element = doc.select(".tx_date");
		Elements element2 = doc.select(".team_lft");
		Elements element3 = doc.select(".team_rgt");
		Elements element4 = doc.select(".score_lft");
		Elements element5 = doc.select(".score_rgt");

		String date = element.get(element.size() - 1).text();
		String leftTeam;
		if (element2.get(element.size() - 1).text().substring(0, 2) == "KI") {
			leftTeam = element2.get(element.size() - 1).text().substring(0, 3);
		} else {
			leftTeam = element2.get(element.size() - 1).text().substring(0, 2);
		}
		String rightTeam;

		if (element3.get(element3.size() - 1).text().substring(0, 2).substring(0, 2) == "KI") {
			rightTeam = element3.get(element.size() - 1).text().substring(0, 3);
		} else {
			rightTeam = element3.get(element.size() - 1).text().substring(0, 2);
		}
		String leftScore = element4.get(element4.size() - 1).text();
		String rightScore = element5.get(element5.size() - 1).text();

		schedule.add(date);
		schedule.add(leftTeam);
		schedule.add(rightTeam);
		schedule.add(leftScore);
		schedule.add(rightScore);

		return (schedule);
	}

	// 관심선수의 정보
	public List getInfos(String batterName) {

		String url = "https://search.daum.net/search?w=tot&DA=YZR&t__nil_searchbox=btn&sug=&sugo=&q=야구선수+" + batterName;
		String url2 = "https://search.naver.com/search.naver?sm=top_hty&fbm=1&ie=utf8&query=야구선수+" + batterName;
		Document doc = null;
		Document doc2 = null;

		try {
			doc = Jsoup.connect(url).get();
			doc2 = Jsoup.connect(url).get();
		} catch (IOException e) {
			e.printStackTrace();
		}

		Elements element = doc.select(".type_politics th");
		Elements element2 = doc2.select(".txt_ac td");

		infos.add(element.get(0).text());
		infos.add(element2.get(0).text());

		infos.add(element.get(1).text());
		infos.add(element2.get(1).text());

		infos.add(element.get(2).text());
		infos.add(element2.get(2).text());

		infos.add(element.get(3).text());
		infos.add(element2.get(3).text());

		return (infos);
	}

}
