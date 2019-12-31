<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="user.playerInfo"%>
<%@ page import="user.links"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="com.example.model.searchFans"%>
<%@ page import="com.example.model.searchStats"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.io.IOException"%>
<%@ page import="org.jsoup.Jsoup"%>
<%@ page import="org.jsoup.nodes.Document"%>
<%@ page import="org.jsoup.select.Elements"%>
<%@ page import="java.text.DecimalFormat"%>
<%@ page import="user.calendar"%>
<%
	request.setCharacterEncoding("UTF-8");
%>



<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty name="user" property="userID" />
<jsp:setProperty name="user" property="userPassword" />
<jsp:setProperty name="user" property="userNickname" />
<jsp:setProperty name="user" property="userTeam" />
<jsp:setProperty name="user" property="userFan" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
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

		String date = request.getParameter("date");
		UserDAO test = new UserDAO();
		String result="";
		result = test.getPlayResult(date, userTeam);
		
		test.setCalData(userID, date, userTeam, result);
		
		calendar cal = new calendar();
		cal = test.getCalendar(cal, userTeam, userID);
		
		out.println("hi");
		
		/* request.setAttribute("cal2", cal);
		
		RequestDispatcher view = request.getRequestDispatcher("testcalendar.jsp");
		view.forward(request, response);
		 */
		//out.println("날짜: " + date);
	%>
</body>
</html>