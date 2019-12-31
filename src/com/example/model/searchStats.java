package com.example.model;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;

import com.example.model.searchFans;;

public class searchStats {
	public List dates = new ArrayList();
	public List teams = new ArrayList();
	public List atBats = new ArrayList();
	public List records = new ArrayList();
	public ArrayList<Integer> hits = new ArrayList();
	public List clipUrl = new ArrayList();
	public String myTeam;
	public List players = new ArrayList();
	

	public List getRecord(String batterName) {

		
		String getBirth = "https://search.daum.net/search?w=tot&DA=YZR&t__nil_searchbox=btn&sug=&sugo=&q=야구선수+"+batterName;

		Document doc = null;
		Document doc2 = null;
		Document doc3 = null;
		
		
		try {
			doc3 = Jsoup.connect(getBirth).get();
		}catch (IOException e){
			e.printStackTrace();
		}
		
		Elements element3 = doc3.select(".em_birthday");
		String birth = element3.get(0).text();
		int yearIdx = birth.indexOf("년");
		int monthIdx = birth.indexOf("월");
		int dayIdx = birth.indexOf("일");
		String year = birth.substring(0, yearIdx);
		String month,day;
		month=birth.substring(yearIdx+1,monthIdx);
		day=birth.substring(monthIdx+1, dayIdx);
		if(month.length()==3)
			month = month.substring(1, 3);
		else
			month = "0"+month.substring(1,2);
		if(day.length()==3)
			day = day.substring(1, 3);
		else
			day = "0"+day.substring(1, 2);
		birth = year+"-"+month+"-"+day;
		String url = "http://www.statiz.co.kr/player.php?opt=3&name=" + batterName+"&birth="+birth;
		
		try {
			doc = Jsoup.connect(url).timeout(500000).get();
			doc2 = Jsoup.connect(url).timeout(500000).get();
			
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

				records.add(element.get(i).text() + " " + element.get(i + 1).text());
				records.add(element2.get(i).text() + " " + element2.get(i + 1).text());

			}
			records.add(element.get(i).text() + " " + element.get(i + 1).text());

		}

		else {
			for (int i = 0; i < count2; i += 31) {

				records.add(element.get(i).text() + " " + element.get(i + 1).text());
				records.add(element2.get(i).text() + " " + element2.get(i + 1).text());
			}
		}
		return (records);
	}

	public List getDate(String batterName) {

		String getBirth = "https://search.daum.net/search?w=tot&DA=YZR&t__nil_searchbox=btn&sug=&sugo=&q=야구선수+"+batterName;

		Document doc = null;
		Document doc2 = null;
		Document doc3 = null;
		
		
		try {
			doc3 = Jsoup.connect(getBirth).get();
		}catch (IOException e){
			e.printStackTrace();
		}
		
		Elements element3 = doc3.select(".em_birthday");
		String birth = element3.get(0).text();
		int yearIdx = birth.indexOf("년");
		int monthIdx = birth.indexOf("월");
		int dayIdx = birth.indexOf("일");
		String year = birth.substring(0, yearIdx);
		String month,day;
		month=birth.substring(yearIdx+1,monthIdx);
		day=birth.substring(monthIdx+1, dayIdx);
		if(month.length()==3)
			month = month.substring(1, 3);
		else
			month = "0"+month.substring(1,2);
		if(day.length()==3)
			day = day.substring(1, 3);
		else
			day = "0"+day.substring(1, 2);
		birth = year+"-"+month+"-"+day;
		String url = "http://www.statiz.co.kr/player.php?opt=3&name=" + batterName+"&birth="+birth;
		
		try {
			doc = Jsoup.connect(url).timeout(500000).get();
			doc2 = Jsoup.connect(url).timeout(500000).get();
			
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

				dates.add(element.get(i).text());
				dates.add(element2.get(i).text());

			}
			dates.add(element.get(i).text());

		}

		else {
			for (int i = 0; i < count2; i += 31) {

				dates.add(element.get(i).text());
				dates.add(element2.get(i).text());
			}
		}
		return (dates);
	}

	public List getTeam(String batterName) {

		String getBirth = "https://search.daum.net/search?w=tot&DA=YZR&t__nil_searchbox=btn&sug=&sugo=&q=야구선수+"+batterName;

		Document doc = null;
		Document doc2 = null;
		Document doc3 = null;
		Document doc4 = null;
		
		
		try {
			doc3 = Jsoup.connect(getBirth).get();
		}catch (IOException e){
			e.printStackTrace();
		}
		
		Elements element3 = doc3.select(".em_birthday");
		String birth = element3.get(0).text();
		int yearIdx = birth.indexOf("년");
		int monthIdx = birth.indexOf("월");
		int dayIdx = birth.indexOf("일");
		String year = birth.substring(0, yearIdx);
		String month,day;
		month=birth.substring(yearIdx+1,monthIdx);
		day=birth.substring(monthIdx+1, dayIdx);
		if(month.length()==3)
			month = month.substring(1, 3);
		else
			month = "0"+month.substring(1,2);
		if(day.length()==3)
			day = day.substring(1, 3);
		else
			day = "0"+day.substring(1, 2);
		birth = year+"-"+month+"-"+day;
		String url = "http://www.statiz.co.kr/player.php?opt=3&name=" + batterName+"&birth="+birth;
		
		try {
			doc = Jsoup.connect(url).timeout(500000).get();
			doc2 = Jsoup.connect(url).timeout(500000).get();
			doc4 = Jsoup.connect(url).timeout(500000).get();
			
		} catch (IOException e) {
			e.printStackTrace();
		}

		int count = 0;
		int count2 = 0;
		Elements element = doc.select(".oddrow_stz0 span");
		Elements element2 = doc2.select(".evenrow_stz0 span");
		Elements element4 = doc4.select(".dropdown-menu-left li");


		count = element.size();
		count2 = element2.size();

		if (count > count2) {
			int i = 0;
			for (i = 0; i < count2; i += 31) {

				teams.add(element.get(i + 1).text());
				teams.add(element2.get(i + 1).text());

			}
			teams.add(element.get(i + 1).text());

		}

		else {
			for (int i = 0; i < count2; i += 31) {

				teams.add(element.get(i + 1).text());
				teams.add(element2.get(i + 1).text());
			}
		}
		String mt = element4.get(6).text();
		mt = mt.substring(6,mt.length());
		teams.add(mt);
		return (teams);
	}

	public List getAB(String batterName) {

		String getBirth = "https://search.daum.net/search?w=tot&DA=YZR&t__nil_searchbox=btn&sug=&sugo=&q=야구선수+"+batterName;

		Document doc = null;
		Document doc2 = null;
		Document doc3 = null;
		
		
		try {
			doc3 = Jsoup.connect(getBirth).get();
		}catch (IOException e){
			e.printStackTrace();
		}
		
		Elements element3 = doc3.select(".em_birthday");
		String birth = element3.get(0).text();
		int yearIdx = birth.indexOf("년");
		int monthIdx = birth.indexOf("월");
		int dayIdx = birth.indexOf("일");
		String year = birth.substring(0, yearIdx);
		String month,day;
		month=birth.substring(yearIdx+1,monthIdx);
		day=birth.substring(monthIdx+1, dayIdx);
		if(month.length()==3)
			month = month.substring(1, 3);
		else
			month = "0"+month.substring(1,2);
		if(day.length()==3)
			day = day.substring(1, 3);
		else
			day = "0"+day.substring(1, 2);
		birth = year+"-"+month+"-"+day;
		String url = "http://www.statiz.co.kr/player.php?opt=3&name=" + batterName+"&birth="+birth;
		
		try {
			doc = Jsoup.connect(url).timeout(500000).get();
			doc2 = Jsoup.connect(url).timeout(500000).get();
			
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

				atBats.add(element.get(i + 6).text());
				atBats.add(element2.get(i + 6).text());

			}
			atBats.add(element.get(i + 6).text());

		}

		else {
			for (int i = 0; i < count2; i += 31) {

				atBats.add(element.get(i + 6).text());
				atBats.add(element2.get(i + 6).text());
			}
		}
		return (atBats);
	}

	public ArrayList getHits(String batterName) {

		String getBirth = "https://search.daum.net/search?w=tot&DA=YZR&t__nil_searchbox=btn&sug=&sugo=&q=야구선수+"+batterName;

		Document doc = null;
		Document doc2 = null;
		Document doc3 = null;
		
		
		try {
			doc3 = Jsoup.connect(getBirth).get();
		}catch (IOException e){
			e.printStackTrace();
		}
		
		Elements element3 = doc3.select(".em_birthday");
		String birth = element3.get(0).text();
		int yearIdx = birth.indexOf("년");
		int monthIdx = birth.indexOf("월");
		int dayIdx = birth.indexOf("일");
		String year = birth.substring(0, yearIdx);
		String month,day;
		month=birth.substring(yearIdx+1,monthIdx);
		day=birth.substring(monthIdx+1, dayIdx);
		if(month.length()==3)
			month = month.substring(1, 3);
		else
			month = "0"+month.substring(1,2);
		if(day.length()==3)
			day = day.substring(1, 3);
		else
			day = "0"+day.substring(1, 2);
		birth = year+"-"+month+"-"+day;
		String url = "http://www.statiz.co.kr/player.php?opt=3&name=" + batterName+"&birth="+birth;
		
		try {
			doc = Jsoup.connect(url).timeout(500000).get();
			doc2 = Jsoup.connect(url).timeout(500000).get();
			
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

				hits.add(Integer.parseInt(element.get(i + 8).text()));
				hits.add(Integer.parseInt(element2.get(i + 8).text()));

			}
			hits.add(Integer.parseInt(element.get(i + 8).text()));

		}

		else {
			for (int i = 0; i < count2; i += 31) {

				hits.add(Integer.parseInt(element.get(i + 8).text()));
				hits.add(Integer.parseInt(element2.get(i + 8).text()));
			}
		}

		return (hits);
	}

	public List getUrl(String date) {

		String month = date.substring(0, 1);
		String day = date.substring(3, 4);
		return (clipUrl);
	}
}
