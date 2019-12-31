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

public class setVideoLinkDB {

	public static void main(String[] args) {
		// TODO Auto-generated method stub

		UserDAO fan = new UserDAO();
		searchFans hl = new searchFans();
		String url;
		records r = new records();

		r = fan.getVideoLink(r, hl);

		for (int i = 0; i < r.getPlayDate().size(); i++) {
			fan.setVideoLink(r);
		}

	}

}
