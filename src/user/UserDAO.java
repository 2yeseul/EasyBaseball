package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.mysql.jdbc.Statement;
import com.example.model.searchFans;
import com.example.model.searchPlayerInfo;;

public class UserDAO {

	private Connection conn;
	private PreparedStatement pstmt, pstmt2;
	private ResultSet rs, rs2;

	public UserDAO() {
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

	public int login(String userID, String userPassword) {
		String SQL = "SELECT userPassword FROM user WHERE userID = ?";

		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				if (rs.getString(1).equals(userPassword)) {
					return 1;
				} else
					return 0;
			}
			return -1;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -2;
	}

	public int join(User user) {
		String SQL = "insert into user values(?,?,?,?,?)";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserNickname());
			pstmt.setString(4, user.getUserTeam());
			pstmt.setString(5, user.getUserFan());
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}

	public links getAllplayer(links info) {
		String SQL = "select distinct myteam, playerName from playerinfo order by myTeam";
		List names = new ArrayList();
		List teams = new ArrayList();
		try {
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				names.add(rs.getString("playerName"));
				teams.add(rs.getString("myTeam"));
				info.setNames(names);
				info.setMyTeam(teams);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return info;
	}

	public playerInfo getFanInfo(String name, playerInfo info) {
		String SQL = "select myTeam, playerName, totalAvg, totalWar, totalHits from playerinfo where playerName ='"
				+ name + "' order by cast(pid as signed) desc limit 1";
		try {
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				info.setMyTeam(rs.getString("myTeam"));
				info.setPlayerName(rs.getString("playerName"));
				info.setTotalAvg(rs.getString("totalAvg"));
				info.setTotalWar(rs.getString("totalWar"));
				info.setTotalHits(rs.getString("totalHits"));
			}
			return info;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public List getLatestFanRecord(String name, List info) {
		String SQL = "select playAvg, playDate from playerinfo where playerName ='" + name
				+ "' order by cast(pid as signed) desc limit 5";
		try {
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				info.add(rs.getString("playAvg"));
				info.add(rs.getString("playDate"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return info;
	}

	public void setPlayerInfo(playerInfo info) {
		String SQL = "insert into playerInfo values(?,?,?,?,?,?,?,?,?,?,?,?,?)";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, info.getPlayDate());
			pstmt.setString(2, info.getPlayTeam());
			pstmt.setString(3, info.getPlayResult());
			pstmt.setString(4, info.getPlayHits());
			pstmt.setString(5, info.getPlayHomeruns());
			pstmt.setString(6, info.getPlayAvg());
			pstmt.setString(7, info.getPlayWpa());
			pstmt.setString(8, info.getPlayerName());
			pstmt.setString(9, info.getMyTeam());
			pstmt.setString(10, info.getTotalAvg());
			pstmt.setString(11, info.getTotalHits());
			pstmt.setString(12, info.getTotalWar());
			pstmt.setString(13, info.getPid());
			pstmt.addBatch();
			pstmt.executeBatch();
			pstmt.clearParameters();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

	}

	public links getThumbnail(String name, links link) {

		String SQL = "select thumbNail from links where playerName ='" + name + "'";
		try {
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			while (rs.next())
				link.setThumbNails(rs.getString("thumbNail"));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return link;
	}

	public records getBatterRecord(records r, String BatterName, String numberOfHits) {

		String SQL = "select playDate, playTeam from playerinfo where playerName ='" + BatterName + "'and playHits >= '"
				+ numberOfHits + "' order by playDate";
		List playDate = new ArrayList();
		List playTeam = new ArrayList();
		try {
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				playDate.add(rs.getString("playDate"));
				playTeam.add(rs.getString("playTeam"));
				r.setPlayDate(playDate);
				r.setPlayTeam(playTeam);
				// records.add(rs.getString("playDate")+" "+rs.getString("playTeam"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return r;
	}

	public records getBatterHomeruns(records r, String BatterName, String numberOfHomeruns) {
		String SQL = "select playDate, playTeam from playerinfo where playerName ='" + BatterName + "'and playHomeruns >= '"
				+ numberOfHomeruns + "' order by playDate";
		List playDate = new ArrayList();
		List playTeam = new ArrayList();
		try {
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				playDate.add(rs.getString("playDate"));
				playTeam.add(rs.getString("playTeam"));
				r.setPlayDate(playDate);
				r.setPlayTeam(playTeam);
				// records.add(rs.getString("playDate")+" "+rs.getString("playTeam"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return r;
	}
	public void setPlayerthumb(links info, searchFans thumb) {

		String SQL = "insert into links values(?,?,?,?)";
		try {

			for (int i = 0; i < info.getNames().size(); i++) {
				pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, info.getNames().get(i).toString());
				pstmt.setString(2, thumb.getThumb(info.getNames().get(i).toString()));
				pstmt.setString(3, info.getMyTeam().get(i).toString());
				pstmt.setString(4, Integer.toString(i + 1));
				pstmt.addBatch();
				pstmt.executeBatch();
				pstmt.clearParameters();
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	public void setVideoLink(records info) {
		String SQL = "insert into video values(?,?,?,?,?)";
		try {
			for (int i = 0; i < info.getPlayDate().size(); i++) {
				pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, info.getPlayDate().get(i).toString());
				pstmt.setString(2, info.getPlayTeam().get(i).toString());
				pstmt.setString(3, info.getMyTeam().get(i).toString());
				pstmt.setString(4, info.getUrl().get(i).toString());
				pstmt.setString(5, Integer.toString(i + 1));
				pstmt.addBatch();
				pstmt.executeBatch();
				pstmt.clearParameters();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

	}
	
	public List getLatestPlay(List info,String userTeam) {
		
		String SQL ="select playDate,playTeam from video where '"+userTeam+"' like concat('%',myteam,'%') order by playdate desc limit 1";
		try {
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				info.add(rs.getString("playDate"));
				info.add(rs.getString("playTeam"));
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return info;
	}

	public records getVideoLink(records info, searchFans video) {

		String SQL = "select distinct playTeam,  myTeam,  playDate from playerinfo where myteam not like ('%,%') order by playDate";
		List playDate = new ArrayList();
		List playTeam = new ArrayList();
		List myTeam = new ArrayList();
		List url = new ArrayList();
		try {
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				int i = 0;
				playTeam.add(rs.getString("playTeam"));
				myTeam.add(rs.getString("myTeam"));
				playDate.add(rs.getString("playDate"));
				url.add(video.getVideos(rs.getString("playDate"), rs.getString("playTeam"), rs.getString("myTeam")));

				info.setPlayTeam(playTeam);
				info.setMyTeam(myTeam);
				info.setPlayDate(playDate);
				info.setUrl(url);
				i++;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return info;
	}

	public String getSearchVideo(String date, String playTeam, String url) {

		String SQL = "select url from video where playDate = '" + date + "' and playTeam='" + playTeam + "'";
		try {
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				url = rs.getString("url");
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return url;
	}


	/* 날짜를 클릭하면 result 저장 */
	public void setCalData(String userID, String date, String userTeam, String result) {
		if (result.substring(0, 1).equals("W")) {
			String SQL = "select * from calendar where userID = '" + userID + "'";
			try {
				pstmt2 = conn.prepareStatement(SQL);
				rs2 = pstmt2.executeQuery();
				if (rs2.next()) {
					String SQL2 = "insert into calendar(userID,playDate,userTeam, winCount, loseCount, cid) values(?,?,?,"
							+ " (select a.wincount from calendar as a where a.userID = '" + userID
							+ "'  order by a.cid desc limit 1)+1 , (select a.loseCount from calendar as a where a.userID = '"
							+ userID + "'  order by a.cid desc limit 1), (select a.cid from calendar as a where a.userID ='"+userID+"' order by a.cid desc limit 1)+1);";
					try {
						pstmt = conn.prepareStatement(SQL2);
						pstmt.setString(1, userID);
						pstmt.setString(2, date);
						pstmt.setString(3, userTeam);
						pstmt.executeUpdate();
					} catch (Exception e) {
						e.printStackTrace();
					}
				}

				else {
					String SQL2 = "insert into calendar(userID,playDate,userTeam, winCount, loseCount, cid) values(?,?,?,?,?,?)";
					try {
						pstmt = conn.prepareStatement(SQL2);
						pstmt.setString(1, userID);
						pstmt.setString(2, date);
						pstmt.setString(3, userTeam);
						pstmt.setInt(4, 1);
						pstmt.setInt(5, 0);
						pstmt.setInt(6, 1);
						pstmt.executeUpdate();
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		else {
			String SQL = "select * from calendar where userID = '" + userID + "'";
			try {
				pstmt2 = conn.prepareStatement(SQL);
				rs2 = pstmt2.executeQuery();
				if (rs2.next()) {
					String SQL2 = "insert into calendar(userID,playDate,userTeam, winCount, loseCount, cid) values(?,?,?,"
							+ " (select a.wincount from calendar as a where a.userID = '" + userID
							+ "'  order by a.cid desc limit 1) , (select a.loseCount from calendar as a where a.userID = '"
							+ userID + "'  order by a.cid desc limit 1)+1 , (select a.cid from calendar as a where a.userID ='"+userID+"' order by a.cid desc limit 1)+1);";
					try {
						pstmt = conn.prepareStatement(SQL2);
						pstmt.setString(1, userID);
						pstmt.setString(2, date);
						pstmt.setString(3, userTeam);
						pstmt.executeUpdate();
					} catch (Exception e) {
						e.printStackTrace();
					}
				}

				else {
					String SQL2 = "insert into calendar(userID,playDate,userTeam, winCount, loseCount, cid) values(?,?,?,?,?,?)";
					try {
						pstmt = conn.prepareStatement(SQL2);
						pstmt.setString(1, userID);
						pstmt.setString(2, date);
						pstmt.setString(3, userTeam);
						pstmt.setInt(4, 0);
						pstmt.setInt(5, 1);
						pstmt.setInt(6, 1);
						pstmt.executeUpdate();
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	public calendar getCalendar(calendar c, String userTeam, String userID) {

		String SQL = "select distinct c.playDate, p.playResult, c.winCount, c.loseCount from calendar as c left join playerinfo as p on '"
				+ userTeam + "' like concat('%', p.myTeam, '%') where c.playDate = p.playDate and c.userID = '" + userID
				+ "'";
		List playDate = new ArrayList();
		List playResult = new ArrayList();
		String winCount = "", loseCount = "";

		try {
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				int i = 0;
				playDate.add(rs.getString("playDate"));
				playResult.add(rs.getString("playResult"));
				winCount = rs.getString("winCount");
				loseCount = rs.getString("loseCount");
				c.setPlayDate(playDate);
				c.setPlayResult(playResult);
				c.setWinCount(winCount);
				c.setLoseCount(loseCount);

			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return c;
	}

	public String getPlayResult(String playDate, String userTeam) {
		String result = "";
		String SQL ="select distinct playResult from playerinfo where playDate ='"+playDate+"' and '"+userTeam+"' like concat('%',myteam,'%');";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				result = rs.getString("playResult");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}
	
	public List getMyRate(String userID) {
		List myRate = new ArrayList();
		String SQL = "select winCount, loseCount from calendar where userID ='"+userID+"' order by cid desc limit 1";
		try {
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				myRate.add(rs.getString("winCount"));
				myRate.add(rs.getString("loseCount"));
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return myRate;
	}
	
	public List getTeamPlayers(String team) {
		List players = new ArrayList();
		if(team.equals("기아")) team = "KIA";
		String SQL = "select distinct playerName from playerinfo where myTeam = '"+team+"'";
		try {
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				players.add(rs.getString("playerName"));
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return players;
	}

}
