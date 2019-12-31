package user;
import java.util.List;
public class calendar {

	private String userID;
	private List playDate;
	private List playResult;
	private String winCount;
	private String loseCount;
	private String cid;
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public List getPlayDate() {
		return playDate;
	}
	public void setPlayDate(List playDate) {
		this.playDate = playDate;
	}
	public List getPlayResult() {
		return playResult;
	}
	public void setPlayResult(List playResult) {
		this.playResult = playResult;
	}
	public String getWinCount() {
		return winCount;
	}
	public void setWinCount(String winCount) {
		this.winCount = winCount;
	}
	public String getLoseCount() {
		return loseCount;
	}
	public void setLoseCount(String loseCount) {
		this.loseCount = loseCount;
	}
	public String getCid() {
		return cid;
	}
	public void setCid(String cid) {
		this.cid = cid;
	}

	
}
