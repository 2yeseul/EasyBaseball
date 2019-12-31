<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="user.playerInfo"%>
<%@ page import="user.calendar"%>
<%@ page import="user.links"%>
<%@ page import="user.calendar"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="com.example.model.searchFans"%>
<%@ page import="com.example.model.searchStats"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.io.IOException"%>
<%@ page import="org.jsoup.Jsoup"%>
<%@ page import="org.jsoup.nodes.Document"%>
<%@ page import="org.jsoup.select.Elements"%>
<%@ page import="java.text.DecimalFormat"%>

<%
	request.setCharacterEncoding("UTF-8");
%>

<%
	String userID = null;
	String userNickname = null;
	String userTeam = null;
	String userFan = null;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
		Connection conn = UserDAO.getMySQLConnection();
		String SQL = "select * from user where userID = ?";

		PreparedStatement pstmt = conn.prepareStatement(SQL);
		pstmt.setString(1, userID);
		ResultSet rs = pstmt.executeQuery();
		rs.next();
		userNickname = rs.getString("userNickname");
		userTeam = rs.getString("userTeam");
		userFan = rs.getString("userFan");

	}

	List myRate = new ArrayList();
	UserDAO rate = new UserDAO();
	myRate = rate.getMyRate(userID);
	String winCount = "0";
	String loseCount = "0";
	if (myRate.size() != 0) {
		winCount = myRate.get(0).toString();
		loseCount = myRate.get(1).toString();
	}
	//float visitRate = ((Integer.parseInt(winCount))/((Integer.parseInt(loseCount))+Integer.parseInt(winCount))); // 승률
	double visitRate = ((Double.parseDouble(winCount))
			/ ((Double.parseDouble(winCount)) + (Double.parseDouble(loseCount))));
	String vr = String.format("%.3f", visitRate);
%>
<!DOCTYPE html>
<html>
<script>

var winCount = "<%=winCount%>";
var loseCount ="<%=loseCount%>";

</script>
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>FullCalendar Example</title>
<link rel=" shortcut icon" href="image/favicon.ico">

<link rel="stylesheet" href="calendar/vendor/css/fullcalendar.min.css" />
<link rel="stylesheet" href="calendar/vendor/css/bootstrap.min.css">
<link rel="stylesheet" href='calendar/vendor/css/select2.min.css' />
<link rel="stylesheet"
	href='calendar/vendor/css/bootstrap-datetimepicker.min.css' />

<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Open+Sans:400,500,600">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/icon?family=Material+Icons">

<link rel="stylesheet" href="calendar/css/main.css">


</head>
<body>
	<div class="container">



		<div id="wrapper">
			<div id="loading"></div>
			<div id="calendar"></div>
		</div>

		<div class="panel panel-default">

			<div class="panel-heading">
				<h3 class="panel-title">나의 직관 승률</h3>
			</div>

			<div class="panel-body">

				<div class="col-lg-6">
					<div id = "win" for="calendar_view">이긴날 :<script>document.write(winCount);</script> 번</div>
					<div id ="lose" for="calendar_view">진날 :<script>document.write(loseCount);</script> 번</div>
					<div id="rate" for="calendar_view">나의 승률 : <%=vr%></div>
				</div>
			</div>



		</div>

		<!-- ì¼ì  ì¶ê° MODAL -->
		<div class="modal fade" tabindex="-1" role="dialog" id="eventModal">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title"></h4>
					</div>

				</div>
				<!-- /.modal-content -->
			</div>
			<!-- /.modal-dialog -->
		</div>
		<!-- /.modal -->


		<!-- /.filter panel -->
	</div>
	<!-- /.container -->

	<script src="calendar/vendor/js/jquery.min.js"></script>
	<script src="calendar/vendor/js/bootstrap.min.js"></script>
	<script src="calendar/vendor/js/moment.min.js"></script>
	<script src="calendar/vendor/js/fullcalendar.min.js"></script>
	<script src="calendar/vendor/js/ko.js"></script>
	<script src="calendar/vendor/js/select2.min.js"></script>
	<script src="calendar/vendor/js/bootstrap-datetimepicker.min.js"></script>
	<%
		String team = userTeam;
		UserDAO u = new UserDAO();
		calendar cal = new calendar();

		cal = u.getCalendar(cal, team, userID);

		//String latestResult = cal.getPlayResult().get(cal.getPlayResult().size()-1).toString();
	%>
	<script>
	var draggedEventIsAllDay;
	var activeInactiveWeekends = true;
	var myteam = "<%=userTeam%>";

	var userID = "<%=userID%>";
	var userTeam = "<%=userTeam%>";
	
	/* calendar 보여지는 부분 */
	var calendar =	$('#calendar').fullCalendar({
		
		/* event 출력 부분 */
				events : [
			<%
				if (cal.getPlayDate() != null) {
				for (int i = 0; i < cal.getPlayDate().size(); i++)  {
					
					String title =  cal.getPlayResult().get(i).toString();
					String bc ="red";
					if(title.substring(0,1).equals("W")) {
						title = "승리요정! "+title.substring(2)+" 로 승리!";
					}
					else {
						title ="패배요정 ㅠ.ㅠ" +title.substring(2)+" 로 패배..";
						bc ="black";
					}
					out.println("{ title : '" + title + "', start: '2019-"
							+ cal.getPlayDate().get(i).toString() 
							+ "', backgroundColor:'"+bc+"'},");
				}

			}%>
		],  
		
		/* 일정 클릭 시 db로 저장 */
		
				dayClick : function(date) {
								var tdtd = date.format('MM-DD');
								var myTitle ="title";
								var result = confirm('직관간 날 등록 하시겠습니까?');
								//window.location.replace("testcalendar.jsp?playdate="+tdtd);
								var sendData = {
									"date" : tdtd
								};
								if (result) {
									
									$.ajax({
												type : "get",
												url : "saveVisit.do?date="+tdtd+"&userID="+userID+"&userTeam="+userTeam,
												dataType : "html",
												async : true,
												data : {
													'date' : tdtd,
													'userID' : userID,
													'userTeam' : userTeam
												},
												
												success : function(data) {
													
													var myTitle =data;
													var myColor ="red";
													if(myTitle.substring(0,1)=="W") {
														myTitle ="승리요정! "+myTitle.substring(2)+ "로 승리!";
														var tempWinCount = parseInt(winCount)+1;
														winCount = String(tempWinCount);
														$("#win").html("이긴날 : "+winCount+"번");
													}
													else  {
														myTitle ="패배요정 ㅠ.ㅠ  "+myTitle.substring(2)+" 로 패배.."; 
														myColor ="black";
														var tempLoseCount = parseInt(loseCount)+1;
														loseCount = String(tempLoseCount);
														$("#lose").html("진날: "+loseCount+"번");
													}
													
													var rate = parseFloat(parseInt(winCount)/(parseInt(winCount)+parseInt(loseCount)));
													rate = rate.toFixed(3);
													$("#rate").html("나의 승률: "+rate);
													
													
													var eventData = {
															title : myTitle,
															start : "2019-"+tdtd,
															backgroundColor : myColor
													};
													$("#calendar").fullCalendar('renderEvent', eventData, true);
													
											},
											 error: function(){
										            alert("경기가 없는 날입니다.");
										        }												
												
											});
									
									
								
									
									
								} else
									alert("취소하였습니다.");
								return false;
							}
	
	//console.log(myTitle);
							/* function setEvent(myTitle, callback){
								console.log(myTitle);
								callback();
							}
								
							
								function mevent(){
									var eventData = {
											title : myTitle,
											start : "2019-"+tdtd
									};
									$("#calendar").fullCalendar('renderEvent', eventData, true);
								}
								setEvent(myTitle,mevent); */
						 
								});
	</script>
	<script src="calendar/js/main.js"></script>

</body>

</html>