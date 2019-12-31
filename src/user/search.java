package user;

import java.io.IOException;
import java.util.List;
import java.util.ArrayList;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

public class search {


	public List getDate(String batterName) {
		List getDate = new ArrayList();

		String url = "http://www.statiz.co.kr/player.php?opt=6&sopt=0&name=" + batterName + "&re=0&da=2";

		Document doc = null;
		Document doc2 = null;

		try {
			doc = Jsoup.connect(url).get();
			doc2 = Jsoup.connect(url).get();
		} catch (IOException e) {
			e.printStackTrace();
		}

		Elements element = doc.select(".oddrow_stz0 span");
		int count = element.size();
		Elements element2 = doc2.select(".evenrow_stz0 span");
		int count2 = element2.size();

		for (int i = 0; i < count; i += 15) {
			
			if (count > count2) {
				
				if (element2.get(i).text() != null) {
					getDate.add(element.get(i).text());
					getDate.add(element2.get(i).text());
				}
				
				else {
					getDate.add(element.get(i).text());
				}
			}
			
			else 
			getDate.add(element.get(i).text());
			getDate.add(element2.get(i).text());
		}
		return (getDate);
	}
}
