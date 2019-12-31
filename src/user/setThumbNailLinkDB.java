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

public class setThumbNailLinkDB {

	public static void main(String[] args) {
		// TODO Auto- method stub
		
		UserDAO user = new UserDAO();
		searchFans thumb = new searchFans();
		links info = new links();
		info = user.getAllplayer(info);
		user.setPlayerthumb(info, thumb);

	}
}
