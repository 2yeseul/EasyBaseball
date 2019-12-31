package com.example.model;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;

public class searchPlayerInfo {

	public List playDate = new ArrayList();
	public List playTeam = new ArrayList();
	public List playResult = new ArrayList();
	public List playHits = new ArrayList();
	public List playHomeruns = new ArrayList();
	public List playAvg = new ArrayList();
	public List playWpa = new ArrayList();

	public List playerName = new ArrayList();
	public String myTeam;
	public String totalAvg;
	public String totalWar;
	public String totalHits;
	public List playerUrl = new ArrayList();

	public List getPlayDate(String url) {
		Document doc = null;
		Document doc2 = null;
		try {
			doc = Jsoup.connect(url + "&opt=3").timeout(500000).get();
			doc2 = Jsoup.connect(url + "&opt=3").timeout(500000).get();
		} catch (IOException e) {
			e.printStackTrace();
		}

		int count = 0;
		int count2 = 0;
		Elements element = doc.select(".oddrow_stz0 span");
		Elements element2 = doc2.select(".evenrow_stz0 span");

		count = element.size();
		count2 = element2.size();

		if (count > count2) {
			int i = 0;
			for (i = 0; i < count2; i += 31) {

				playDate.add(element.get(i).text());
				playDate.add(element2.get(i).text());

			}
			playDate.add(element.get(i).text());

		}

		else {
			for (int i = 0; i < count2; i += 31) {

				playDate.add(element.get(i).text());
				playDate.add(element2.get(i).text());
			}
		}

		return (playDate);
	}

	public List getPlayerPlayTeam(String url) {
		Document doc = null;
		Document doc2 = null;
		try {
			doc = Jsoup.connect(url + "&opt=3").timeout(500000).get();
			doc2 = Jsoup.connect(url + "&opt=3").timeout(500000).get();

		} catch (IOException e) {
			e.printStackTrace();
		}

		int count = 0;
		int count2 = 0;

		Elements element = doc.select(".oddrow_stz0 span");
		Elements element2 = doc2.select(".evenrow_stz0 span");

		count = element.size();
		count2 = element2.size();

		if (count > count2) {
			int i = 0;
			for (i = 0; i < count2; i += 31) {

				playTeam.add(element.get(i + 1).text());
				playTeam.add(element2.get(i + 1).text());

			}
			playTeam.add(element.get(i + 1).text());

		}

		else {
			for (int i = 0; i < count2; i += 31) {

				playTeam.add(element.get(i + 1).text());
				playTeam.add(element2.get(i + 1).text());
			}
		}
		return (playTeam);
	}

	public List getPlayResult(String url) {
		Document doc = null;
		Document doc2 = null;
		try {
			doc = Jsoup.connect(url + "&opt=3").timeout(500000).get();
			doc2 = Jsoup.connect(url + "&opt=3").timeout(500000).get();
		} catch (IOException e) {
			e.printStackTrace();
		}

		int count = 0;
		int count2 = 0;
		Elements element = doc.select(".oddrow_stz0 span");
		Elements element2 = doc2.select(".evenrow_stz0 span");

		count = element.size();
		count2 = element2.size();

		if (count > count2) {
			int i = 0;
			for (i = 0; i < count2; i += 31) {

				playResult.add(element.get(i + 2).text());
				playResult.add(element2.get(i + 2).text());

			}
			playResult.add(element.get(i + 2).text());

		}

		else {
			for (int i = 0; i < count2; i += 31) {

				playResult.add(element.get(i + 2).text());
				playResult.add(element2.get(i + 2).text());
			}
		}

		return (playResult);
	}

	public List getPlayerHits(String url) {
		Document doc = null;
		Document doc2 = null;
		try {
			doc = Jsoup.connect(url + "&opt=3").timeout(500000).get();
			doc2 = Jsoup.connect(url + "&opt=3").timeout(500000).get();

		} catch (IOException e) {
			e.printStackTrace();
		}

		int count = 0;
		int count2 = 0;

		Elements element = doc.select(".oddrow_stz0 span");
		Elements element2 = doc2.select(".evenrow_stz0 span");

		count = element.size();
		count2 = element2.size();

		if (count > count2) {
			int i = 0;
			for (i = 0; i < count2; i += 31) {

				playHits.add(element.get(i + 8).text());
				playHits.add(element2.get(i + 8).text());

			}
			playHits.add(element.get(i + 8).text());

		}

		else {
			for (int i = 0; i < count2; i += 31) {

				playHits.add(element.get(i + 8).text());
				playHits.add(element2.get(i + 8).text());
			}
		}
		return (playHits);
	}

	public List getPlayerHomeruns(String url) {
		Document doc = null;
		Document doc2 = null;
		try {
			doc = Jsoup.connect(url + "&opt=3").timeout(500000).get();
			doc2 = Jsoup.connect(url + "&opt=3").timeout(500000).get();

		} catch (IOException e) {
			e.printStackTrace();
		}

		int count = 0;
		int count2 = 0;

		Elements element = doc.select(".oddrow_stz0 span");
		Elements element2 = doc2.select(".evenrow_stz0 span");

		count = element.size();
		count2 = element2.size();

		if (count > count2) {
			int i = 0;
			for (i = 0; i < count2; i += 31) {

				playHomeruns.add(element.get(i + 11).text());
				playHomeruns.add(element2.get(i + 11).text());

			}
			playHomeruns.add(element.get(i + 11).text());

		}

		else {
			for (int i = 0; i < count2; i += 31) {

				playHomeruns.add(element.get(i + 11).text());
				playHomeruns.add(element2.get(i + 11).text());
			}
		}
		return (playHomeruns);
	}

	public List getPlayerAvg(String url) {
		Document doc = null;
		Document doc2 = null;
		try {
			doc = Jsoup.connect(url + "&opt=3").timeout(500000).get();
			doc2 = Jsoup.connect(url + "&opt=3").timeout(500000).get();

		} catch (IOException e) {
			e.printStackTrace();
		}

		int count = 0;
		int count2 = 0;

		Elements element = doc.select(".oddrow_stz0 span");
		Elements element2 = doc2.select(".evenrow_stz0 span");

		count = element.size();
		count2 = element2.size();

		if (count > count2) {
			int i = 0;
			for (i = 0; i < count2; i += 31) {

				playAvg.add(element.get(i + 23).text());
				playAvg.add(element2.get(i + 23).text());

			}
			playAvg.add(element.get(i + 23).text());

		}

		else {
			for (int i = 0; i < count2; i += 31) {

				playAvg.add(element.get(i + 23).text());
				playAvg.add(element2.get(i + 23).text());
			}
		}
		return (playAvg);
	}

	public List getPlayerWpa(String url) {
		Document doc = null;
		Document doc2 = null;
		try {
			doc = Jsoup.connect(url + "&opt=3").timeout(500000).get();
			doc2 = Jsoup.connect(url + "&opt=3").timeout(500000).get();

		} catch (IOException e) {
			e.printStackTrace();
		}

		int count = 0;
		int count2 = 0;

		Elements element = doc.select(".oddrow_stz0 span");
		Elements element2 = doc2.select(".evenrow_stz0 span");

		count = element.size();
		count2 = element2.size();

		if (count > count2) {
			int i = 0;
			for (i = 0; i < count2; i += 31) {

				playWpa.add(element.get(i + 30).text());
				playWpa.add(element2.get(i + 30).text());

			}
			playWpa.add(element.get(i + 30).text());

		}

		else {
			for (int i = 0; i < count2; i += 31) {

				playWpa.add(element.get(i + 30).text());
				playWpa.add(element2.get(i + 30).text());
			}
		}
		return (playWpa);
	}

	/*------------------------------------------------------------*/

	public List getPlayerName(String url) {
		Document doc = null;
		for (int i = 0; i < 264; i += 30) {
			String pa;
			if (i == 0)
				pa = "";
			else
				pa = "&pa=" + i;
			try {
				doc = Jsoup.connect(url + pa).get();
			} catch (IOException e) {
				e.printStackTrace();
			}

			/* 이름 삽입 */
			Elements element = doc.select("#fixcolhide td");

			for (int j = 1; j < element.size(); j += 4) {

				playerName.add(element.get(j).text());
			}
		}

		return (playerName);
	}

	public String getMyTeam(String url) {
		Document doc = null;
		try {
			doc = Jsoup.connect(url).timeout(500000).get();

		} catch (IOException e) {
			e.printStackTrace();
		}

		Elements element = doc.select(".oddrow_stz0 span");
		myTeam = element.get(2).text();
		return (myTeam);
	}

	public String getTotalAvg(String url) {
		Document doc = null;
		try {
			doc = Jsoup.connect(url).timeout(500000).get();

		} catch (IOException e) {
			e.printStackTrace();
		}

		Elements element = doc.select(".oddrow_stz0 span");
		totalAvg = element.get(24).text();
		return (totalAvg);
	}

	public String getTotalWar(String url) {
		Document doc = null;
		try {
			doc = Jsoup.connect(url).timeout(500000).get();

		} catch (IOException e) {
			e.printStackTrace();
		}

		Elements element = doc.select(".oddrow_stz0 span");
		//if (element.get(30).text()!= null)
			totalWar = element.get(30).text();
		return (totalWar);
	}

	public String getTotalHits(String url) {
		Document doc = null;
		try {
			doc = Jsoup.connect(url).timeout(500000).get();

		} catch (IOException e) {
			e.printStackTrace();
		}

		Elements element = doc.select(".oddrow_stz0 span");
		totalHits = element.get(9).text();
		return (totalHits);
	}

	public List getPlayerUrl(String url) {

		Document doc = null;
		for (int i = 0; i < 357; i += 30) {
			String pa;
			if (i == 0)
				pa = "";
			else
				pa = "&pa=" + i;
			try {
				doc = Jsoup.connect(url + pa).get();
			} catch (IOException e) {
				e.printStackTrace();
			}

			/* url 삽입 */
			Elements element = doc.select("#fixcolhide td a");

			for (int j = 0; j < element.size(); j++) {
				if (!element.get(7).text().equals("0"))
					playerUrl.add("http://www.statiz.co.kr/" + element.get(j).attr("href").toString());
			}
		}

		return (playerUrl);
	}

}
