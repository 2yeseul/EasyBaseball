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
<!-- 
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- 뷰포트 -->
<meta name="viewport" content="width=divice-width" initial-scale="1">
<!-- stylesheet -->
<link rel="stylesheet" href="css/sb-admin-2.css">
<!-- <link rel="stylesheet" href="css/bootstrap.min.css">  -->
<title>Easy baseball</title>

<!-- Custom fonts for this template-->
<link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet"
	type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">

<!-- Custom styles for this template-->
<link href="css/sb-admin-2.min.css" rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />

</head>

<body id="page-top">

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

		UserDAO fan = new UserDAO();
		playerInfo info = new playerInfo();
		links l = new links();
		fan.getFanInfo(userFan, info);
		List data = new ArrayList();
		data = fan.getLatestFanRecord(userFan, data);

		l = fan.getThumbnail(userFan, l);
		String thumb = l.getThumbNails();

		String MyTeam = info.getMyTeam();
		String playername = info.getPlayerName();
		String totalAvg = info.getTotalAvg();
		String totalWar = info.getTotalWar();
		String totalHits = info.getTotalHits();

		String avg1 = data.get(9).toString();
		double date1 = Double.parseDouble(data.get(8).toString());

		String avg2 = data.get(7).toString();
		double date2 = Double.parseDouble(data.get(6).toString());

		String avg3 = data.get(5).toString();
		double date3 = Double.parseDouble(data.get(4).toString());

		String avg4 = data.get(3).toString();
		double date4 = Double.parseDouble(data.get(2).toString());

		String avg5 = data.get(1).toString();
		double date5 = Double.parseDouble(data.get(0).toString());
	%>



	<!-- Page Wrapper -->
	<div id="wrapper">

		<!-- Sidebar -->
		<ul
			class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion"
			id="accordionSidebar">

			<!-- Sidebar - Brand -->
			<a
				class="sidebar-brand d-flex align-items-center justify-content-center"
				href="main.jsp">

				<div class="sidebar-brand-icon rotate-n-15">
					<i class="fas fa-baseball-ball"></i>
				</div>

				<div class="sidebar-brand-text mx-3">easy baseball</div>
			</a>

			<!-- Divider -->
			<hr class="sidebar-divider my-0">

			<!-- Nav Item - Dashboard -->
			<li class="nav-item active"><a class="nav-link" href="main.jsp"><i
					class="fas fa-home"></i><span>메인페이지</span></a></li>

			<hr class="sidebar-divider my-0">

			<!-- Divider -->
			<hr class="sidebar-divider">

			<!-- Heading -->
			<div class="sidebar-heading">커뮤니티</div>


			<!-- 위닝초이스 -->
			<li class="nav-item"><a class="nav-link" href="choice.jsp">
					<i class="far fa-check-square"></i> <span>위닝 초이스</span>
			</a></li>

			<!-- 선수기록검색 -->
			<li class="nav-item"><a class="nav-link"
				href="searchRecord.jsp"> <i class="fas fa-search fa-sm"></i>
					<span>선수기록검색</span>
			</a></li>

			<!-- Divider -->
			<hr class="sidebar-divider">

			<!-- Heading -->
			<div class="sidebar-heading">마이페이지</div>

			<!-- Nav Item - Utilities Collapse Menu -->
			<li class="nav-item"><a class="nav-link" href="setting.jsp">
					<i class="fas fa-fw fa-cog"></i> <span>설정</span>
			</a></li>



			<!-- Nav Item - Utilities Collapse Menu -->
			<li class="nav-item"><a class="nav-link" href="star.jsp"> <i
					class="fas fa-star"></i> <span>관심선수의 오늘</span>
			</a></li>
			
			<li class="nav-item"><a class="nav-link" href="calendar.jsp"> <i
					class="fas fa-book"></i> <span>직관 일기</span>
			</a></li>

			

			<!-- Divider -->
			<hr class="sidebar-divider">

			<!-- Heading -->
			<div class="sidebar-heading">배워보기</div>

			<!-- Nav Item - Pages Collapse Menu -->
			<li class="nav-item"><a class="nav-link collapsed" href="#"
				data-toggle="collapse" data-target="#collapsePages"
				aria-expanded="true" aria-controls="collapsePages"> <i
					class="fas fa-music"></i> <span>응원가</span>
			</a>
				<div id="collapsePages" class="collapse"
					aria-labelledby="headingPages" data-parent="#accordionSidebar">
					<div class="bg-white py-2 collapse-inner rounded">
						<a class="collapse-item" href="main.jsp">SK</a> <a
							class="collapse-item" href="main.jsp">두산</a> <a
							class="collapse-item" href="main.jsp">엘지</a> <a
							class="collapse-item" href="main.jsp">롯데</a> <a
							class="collapse-item" href="main.jsp">기아</a> <a
							class="collapse-item" href="main.jsp">삼성</a> <a
							class="collapse-item" href="main.jsp">NC</a> <a
							class="collapse-item" href="main.jsp">KT</a> <a
							class="collapse-item" href="main.jsp">키움</a> <a
							class="collapse-item" href="main.jsp">한화</a>
					</div>
				</div></li>

			<!-- Nav Item - Charts -->
			<li class="nav-item"><a class="nav-link" href="charts.html">
					<i class="fas fa-fw fa-chart-area"></i> <span>RULE</span>
			</a></li>


			<!-- Divider -->
			<hr class="sidebar-divider d-none d-md-block">

			<!-- Sidebar Toggler (Sidebar) -->
			<div class="text-center d-none d-md-inline">
				<button class="rounded-circle border-0" id="sidebarToggle"></button>
			</div>

		</ul>
		<!-- End of Sidebar -->

		<!-- Content Wrapper -->
		<div id="content-wrapper" class="d-flex flex-column">

			<!-- Main Content -->
			<div id="content">

				<!-- Topbar -->
				<nav
					class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

					<!-- Sidebar Toggle (Topbar) -->
					<button id="sidebarToggleTop"
						class="btn btn-link d-md-none rounded-circle mr-3">
						<i class="fa fa-bars"></i>
					</button>

					<!-- Topbar Search -->
					<form
						class="d-none d-sm-inline-block form-inline mr-auto ml-md-3 my-2 my-md-0 mw-100 navbar-search">
						<div class="input-group">
							<h1 class="h6 mb-0 text-gray-800">
								<b> <%=userNickname%></b>님 어서오세요
							</h1>

						</div>
					</form>

					<!-- Topbar Navbar -->
					<ul class="navbar-nav ml-auto">

						<!-- Nav Item - Search Dropdown (Visible Only XS) -->
						<li class="nav-item dropdown no-arrow d-sm-none"><a
							class="nav-link dropdown-toggle" href="#" id="searchDropdown"
							role="button" data-toggle="dropdown" aria-haspopup="true"
							aria-expanded="false"> <i class="fas fa-search fa-fw"></i>
						</a> <!-- Dropdown - Messages -->
							<div
								class="dropdown-menu dropdown-menu-right p-3 shadow animated--grow-in"
								aria-labelledby="searchDropdown">
								<form class="form-inline mr-auto w-100 navbar-search">
									<div class="input-group">
										<input type="text"
											class="form-control bg-light border-0 small"
											placeholder="Search for..." aria-label="Search"
											aria-describedby="basic-addon2">
										<div class="input-group-append">
											<button class="btn btn-primary" type="button">
												<i class="fas fa-search fa-sm"></i>
											</button>
										</div>
									</div>
								</form>
							</div></li>

						<!-- Nav Item - Alerts -->
						<li class="nav-item dropdown no-arrow mx-1"><a
							class="nav-link dropdown-toggle" href="#" id="alertsDropdown"
							role="button" data-toggle="dropdown" aria-haspopup="true"
							aria-expanded="false"> <i class="fas fa-bell fa-fw"></i> <!-- Counter - Alerts -->
								<span class="badge badge-danger badge-counter">3+</span>
						</a> <!-- Dropdown - Alerts -->
							<div
								class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in"
								aria-labelledby="alertsDropdown">
								<h6 class="dropdown-header">Alerts Center</h6>
								<a class="dropdown-item d-flex align-items-center" href="#">
									<div class="mr-3">
										<div class="icon-circle bg-primary">
											<i class="fas fa-file-alt text-white"></i>
										</div>
									</div>
									<div>
										<div class="small text-gray-500">December 12, 2019</div>
										<span class="font-weight-bold">A new monthly report is
											ready to download!</span>
									</div>
								</a> <a class="dropdown-item d-flex align-items-center" href="#">
									<div class="mr-3">
										<div class="icon-circle bg-success">
											<i class="fas fa-donate text-white"></i>
										</div>
									</div>
									<div>
										<div class="small text-gray-500">December 7, 2019</div>
										$290.29 has been deposited into your account!
									</div>
								</a> <a class="dropdown-item d-flex align-items-center" href="#">
									<div class="mr-3">
										<div class="icon-circle bg-warning">
											<i class="fas fa-exclamation-triangle text-white"></i>
										</div>
									</div>
									<div>
										<div class="small text-gray-500">December 2, 2019</div>
										Spending Alert: We've noticed unusually high spending for your
										account.
									</div>
								</a> <a class="dropdown-item text-center small text-gray-500"
									href="#">Show All Alerts</a>
							</div></li>

						<!-- Nav Item - Messages -->
						<li class="nav-item dropdown no-arrow mx-1"><a
							class="nav-link dropdown-toggle" href="#" id="messagesDropdown"
							role="button" data-toggle="dropdown" aria-haspopup="true"
							aria-expanded="false"> <i class="fas fa-envelope fa-fw"></i>
								<!-- Counter - Messages --> <span
								class="badge badge-danger badge-counter">7</span>
						</a> <!-- Dropdown - Messages -->
							<div
								class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in"
								aria-labelledby="messagesDropdown">
								<h6 class="dropdown-header">Message Center</h6>
								<a class="dropdown-item d-flex align-items-center" href="#">
									<div class="dropdown-list-image mr-3">
										<img class="rounded-circle"
											src="https://source.unsplash.com/fn_BT9fwg_E/60x60" alt="">
										<div class="status-indicator bg-success"></div>
									</div>
									<div class="font-weight-bold">
										<div class="text-truncate">Hi there! I am wondering if
											you can help me with a problem I've been having.</div>
										<div class="small text-gray-500">Emily Fowler · 58m</div>
									</div>
								</a> <a class="dropdown-item d-flex align-items-center" href="#">
									<div class="dropdown-list-image mr-3">
										<img class="rounded-circle"
											src="https://source.unsplash.com/AU4VPcFN4LE/60x60" alt="">
										<div class="status-indicator"></div>
									</div>
									<div>
										<div class="text-truncate">I have the photos that you
											ordered last month, how would you like them sent to you?</div>
										<div class="small text-gray-500">Jae Chun · 1d</div>
									</div>
								</a> <a class="dropdown-item d-flex align-items-center" href="#">
									<div class="dropdown-list-image mr-3">
										<img class="rounded-circle"
											src="https://source.unsplash.com/CS2uCrpNzJY/60x60" alt="">
										<div class="status-indicator bg-warning"></div>
									</div>
									<div>
										<div class="text-truncate">Last month's report looks
											great, I am very happy with the progress so far, keep up the
											good work!</div>
										<div class="small text-gray-500">Morgan Alvarez · 2d</div>
									</div>
								</a> <a class="dropdown-item d-flex align-items-center" href="#">
									<div class="dropdown-list-image mr-3">
										<img class="rounded-circle"
											src="https://source.unsplash.com/Mv9hjnEUHR4/60x60" alt="">
										<div class="status-indicator bg-success"></div>
									</div>
									<div>
										<div class="text-truncate">Am I a good boy? The reason I
											ask is because someone told me that people say this to all
											dogs, even if they aren't good...</div>
										<div class="small text-gray-500">Chicken the Dog · 2w</div>
									</div>
								</a> <a class="dropdown-item text-center small text-gray-500"
									href="#">Read More Messages</a>
							</div></li>

						<div class="topbar-divider d-none d-sm-block"></div>

						<!-- 상단 프로필 사진 및 닉네임 -->
						<li class="nav-item dropdown no-arrow"><a
							class="nav-link dropdown-toggle" href="#" id="userDropdown"
							role="button" data-toggle="dropdown" aria-haspopup="true"
							aria-expanded="false"> <span
								class="mr-2 d-none d-lg-inline text-gray-600"> <%=userNickname%>
							</span> <img class="img-profile rounded-circle"
								src='css/<%=userTeam%>.png'>
						</a> <!-- Dropdown - User Information -->
							</li>

					</ul>

				</nav>
				<!-- End of Topbar -->
				<div class="container-fluid">
					<div class="row" style="margin-top:50px">
						<div class="col-xl-4 col-lg-3">
							<div class="row" >
								<div class="col-sm-12">
									<div class="card shadow mb-4">
										<div
											class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
											<h6 class="m-0 font-weight-bold text-primary">응원선수</h6>

										</div>
										<div class="card-body">
											<div class="text-left"
												style="margin-bottom: 10px; margin-right: 15px; float: left;">
												<img src="<%=thumb%>">


											</div>
											<div class="text-left" style="float: left; color: black;">

											
												<p>

													<%
														out.println("<strong>" + MyTeam + " " + playername + "</strong><br>");
														out.println("타율 : " + totalAvg + "<br>");
														out.println("안타 : " + totalWar + "개 <br>");
														out.println("war : " + totalHits);
													%>
												</p>

											</div>


										</div>

									</div>
								</div>


							</div>
							<div class="row">
								<div class="col-sm-12">

									<div style="color: black;">
										<div class="row">
											<div class="col-sm-12">

												<div class="card border-left-primary shadow mb-4">
													<div style="height: 130px; padding: 10px;">
														<div class="text-primary">
															<h4>
																<strong>오늘의 경기</strong>
															</h4>
																
														</div>

														<p>
														<h5>
															<%
																UserDAO latest = new UserDAO();
																List todayplay = new ArrayList();
																todayplay = latest.getLatestPlay(todayplay, userTeam);
																out.println(todayplay.get(0).toString()+"<br>");
																if(todayplay.get(1).toString().substring(0,1).equals("@"))
																	out.println("상대팀 : "+todayplay.get(1).toString().substring(1));
																else out.println("상대팀 : "+todayplay.get(1).toString());
																//printLatestPlay = fan.getLatestPlay(printLatestPlay, userTeam);
																//out.println(printLatestPlay.get(0).toString());
															%>
														</h5>
														</p>
													</div>
												</div>

											</div>
										</div>


									</div>


								</div>
							</div>

						</div>



						<div class="col-xl-8 col-lg-7">
							<div class="card shadow mb-4">
								<!-- Card Header - Dropdown -->
								<div
									class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
									<h6 class="m-0 font-weight-bold text-primary">최근 경기 감각</h6>

								</div>
								<!-- Card Body -->
								<div class="card-body">
									<div class="chart-area">
										<canvas id="myAreaChart"></canvas>
									</div>
								</div>
							</div>
						</div>







					</div>
					<!-- row의 끝 -->





				<!-- Bootstrap core JavaScript-->
				<script src="vendor/jquery/jquery.min.js"></script>
				<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

				<!-- Core plugin JavaScript-->
				<script src="vendor/jquery-easing/jquery.easing.min.js"></script>

				<!-- Custom scripts for all pages-->
				<script src="js/sb-admin-2.js"></script>
				<!-- Page level plugins -->
				<script src="vendor/chart.js/Chart.min.js"></script>


				<!-- Page level custom scripts -->
				<script src="js/demo/chart-pie-demo.js"></script>


				<link rel="stylesheet"
					href="//cdnjs.cloudflare.com/ajax/libs/morris.js/0.5.1/morris.css">
				<script
					src="//ajax.googleapis.com/ajax/libs/jquery/1.9.0/jquery.min.js"></script>
				<script
					src="//cdnjs.cloudflare.com/ajax/libs/raphael/2.1.0/raphael-min.js"></script>
				<script
					src="//cdnjs.cloudflare.com/ajax/libs/morris.js/0.5.1/morris.min.js"></script>

				<script>

				// Set new default font family and font color to mimic Bootstrap's default styling
				Chart.defaults.global.defaultFontFamily = 'Nunito', '-apple-system,system-ui,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif';
				Chart.defaults.global.defaultFontColor = '#858796';

				function number_format(number, decimals, dec_point, thousands_sep) {
				  // *     example: number_format(1234.56, 2, ',', ' ');
				  // *     return: '1 234,56'
				  number = (number + '').replace(',', '').replace(' ', '');
				  var n = !isFinite(+number) ? 0 : +number,
				    prec = !isFinite(+decimals) ? 0 : Math.abs(decimals),
				    sep = (typeof thousands_sep === 'undefined') ? ',' : thousands_sep,
				    dec = (typeof dec_point === 'undefined') ? '.' : dec_point,
				    s = '',
				    toFixedFix = function(n, prec) {
				      var k = Math.pow(10, prec);
				      return '' + Math.round(n * k) / k;
				    };
				  // Fix for IE parseFloat(0.55).toFixed(0) = 0;
				  s = (prec ? toFixedFix(n, prec) : '' + Math.round(n)).split('.');
				  if (s[0].length > 3) {
				    s[0] = s[0].replace(/\B(?=(?:\d{3})+(?!\d))/g, sep);
				  }
				  if ((s[1] || '').length < prec) {
				    s[1] = s[1] || '';
				    s[1] += new Array(prec - s[1].length + 1).join('0');
				  }
				  return s.join(dec);
				}

				// Area Chart Example
				var ctx = document.getElementById("myAreaChart");
				var myLineChart = new Chart(ctx, {
				  type: 'line',
				  data: {
				    labels: ["<%=avg1%>","<%=avg2%>","<%=avg3%>","<%=avg4%>","<%=avg5%>"
					 ],
									datasets : [ {
										label : "타율",
										lineTension : 0.3,
										backgroundColor : "rgba(78, 115, 223, 0.05)",
										borderColor : "rgba(78, 115, 223, 1)",
										pointRadius : 3,
										pointBackgroundColor : "rgba(78, 115, 223, 1)",
										pointBorderColor : "rgba(78, 115, 223, 1)",
										pointHoverRadius : 3,
										pointHoverBackgroundColor : "rgba(78, 115, 223, 1)",
										pointHoverBorderColor : "rgba(78, 115, 223, 1)",
										pointHitRadius : 10,
										pointBorderWidth : 2,
										data : [<%=date1%>, <%=date2%>,	<%=date3%>,	<%=date4%>,	<%=date5%>],
									} ],
								},
								options : {
									maintainAspectRatio : false,
									layout : {
										padding : {
											left : 10,
											right : 25,
											top : 25,
											bottom : 0
										}
									},
									scales : {
										xAxes : [ {
											time : {
												unit : 'date'
											},
											gridLines : {
												display : false,
												drawBorder : false
											},
											ticks : {
												maxTicksLimit : 7
											}
										} ],
										yAxes : [ {
											ticks : {
												maxTicksLimit : 5,
												padding : 10,
												// Include a dollar sign in the ticks
												callback : function(value,
														index, values) {
													return value;
												}
											},
											gridLines : {
												color : "rgb(234, 236, 244)",
												zeroLineColor : "rgb(234, 236, 244)",
												drawBorder : false,
												borderDash : [ 2 ],
												zeroLineBorderDash : [ 2 ]
											}
										} ],
									},
									legend : {
										display : false
									},
									tooltips : {
										backgroundColor : "rgb(255,255,255)",
										bodyFontColor : "#858796",
										titleMarginBottom : 10,
										titleFontColor : '#6e707e',
										titleFontSize : 14,
										borderColor : '#dddfeb',
										borderWidth : 1,
										xPadding : 5,
										yPadding : 5,
										displayColors : false,
										intersect : false,
										mode : 'index',
										caretPadding : 10,
										callbacks : {
											label : function(tooltipItem, chart) {
												var datasetLabel = chart.datasets[tooltipItem.datasetIndex].label
														|| '';
												return datasetLabel
														+ tooltipItem.yLabel;
											}
										}
									}
								}
							});
				</script>
</body>

</html>