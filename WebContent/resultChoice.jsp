<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.SQLException"%>


<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.util.*"%>
<%@ page import="totalRatio.TotalRatioDAO"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.Statement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="com.example.model.searchFans"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.io.IOException"%>
<%@ page import="org.jsoup.Jsoup"%>
<%@ page import="org.jsoup.nodes.Document"%>
<%@ page import="org.jsoup.select.Elements"%>

<jsp:useBean id="totalRatio" class="totalRatio.TotalRatio" scope="page" />
<jsp:setProperty property="*" name="totalRatio" />

<%
	request.setCharacterEncoding("UTF-8");
%>



<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty name="user" property="userID" />
<jsp:setProperty name="user" property="userPassword" />
<jsp:setProperty name="user" property="userNickname" />
<jsp:setProperty name="user" property="userTeam" />
<jsp:setProperty name="user" property="userFan" />
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
%>
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
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css">
</head>
<script>
	/**
	 * 중복서브밋 방지
	 * 
	 * @returns {Boolean}
	 */
	var doubleSubmitFlag = false;
	function doubleSubmitCheck() {
		if (doubleSubmitFlag) {
			return doubleSubmitFlag;
		} else {
			doubleSubmitFlag = true;
			return false;
		}
	}

	function insert() {
		if (doubleSubmitCheck())
			return;

		alert("등록");
	}
</script>

<body id="page-top">


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

			<!-- 자유게시판 -->
			<li class="nav-item"><a class="nav-link" href="board.jsp"> <i
					class="far fa-comments"></i> <span>자유게시판</span>
			</a></li>

			<!-- 위닝초이스 -->
			<li class="nav-item"><a class="nav-link" href="choice.jsp">
					<i class="far fa-check-square"></i> <span>위닝 초이스</span>
			</a></li>

			<!-- 선수기록검색 -->
			<li class="nav-item"><a class="nav-link"
				href="searchRecordTmp.jsp"> <i class="fas fa-search fa-sm"></i>
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
			<div id="collapseUtilities" class="collapse"
				aria-labelledby="headingUtilities" data-parent="#accordionSidebar">
				<div class="bg-white py-2 collapse-inner rounded">
					<h6 class="collapse-header">Custom Utilities:</h6>
					<a class="collapse-item" href="utilities-color.html">Colors</a> <a
						class="collapse-item" href="utilities-border.html">Borders</a> <a
						class="collapse-item" href="utilities-animation.html">Animations</a>
					<a class="collapse-item" href="utilities-other.html">Other</a>
				</div>
			</div>


			<!-- Nav Item - Utilities Collapse Menu -->
			<li class="nav-item"><a class="nav-link collapsed" href="#"
				data-toggle="collapse" data-target="#collapseDiary"
				aria-expanded="true" aria-controls="collapseDiary"> <i
					class="fas fa-book"></i> <span>직관 일기</span>
			</a>
				<div id="collapseDiary" class="collapse"
					aria-labelledby="headingDiary" data-parent="#accordionSidebar">
					<div class="bg-white py-2 collapse-inner rounded">
						<a class="collapse-item" href="utilities-color.html">일기 작성</a> <a
							class="collapse-item" href="utilities-border.html">나의 직관 달력</a> <a
							class="collapse-item" href="utilities-animation.html">소통하기</a>
					</div>
				</div></li>

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
						<a class="collapse-item" href="login.html">SK</a> <a
							class="collapse-item" href="register.html">두산</a> <a
							class="collapse-item" href="forgot-password.html">엘지</a> <a
							class="collapse-item" href="404.html">롯데</a> <a
							class="collapse-item" href="blank.html">기아</a> <a
							class="collapse-item" href="blank.html">삼성</a> <a
							class="collapse-item" href="blank.html">NC</a> <a
							class="collapse-item" href="blank.html">KT</a> <a
							class="collapse-item" href="blank.html">키움</a> <a
							class="collapse-item" href="blank.html">한화</a>
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
								<b> 당근뽯따</b>님 어서오세요
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
								class="mr-2 d-none d-lg-inline text-gray-600"> 당근뽯따 </span> <img
								class="img-profile rounded-circle" src="css/SK와이번스.png">
						</a> <!-- Dropdown - User Information -->
							<div
								class="dropdown-menu dropdown-menu-right shadow animated--grow-in"
								aria-labelledby="userDropdown">
								<a class="dropdown-item" href="#"> <i
									class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i> Profile
								</a> <a class="dropdown-item" href="#"> <i
									class="fas fa-cogs fa-sm fa-fw mr-2 text-gray-400"></i>
									Settings
								</a> <a class="dropdown-item" href="#"> <i
									class="fas fa-list fa-sm fa-fw mr-2 text-gray-400"></i>
									Activity Log
								</a>
								<div class="dropdown-divider"></div>
								<a class="dropdown-item" href="#" data-toggle="modal"
									data-target="#logoutModal"> <i
									class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
									Logout
								</a>
							</div></li>

					</ul>

				</nav>


				<!-- End of Topbar -->
				<%
					TotalRatioDAO t = new TotalRatioDAO();
					if (totalRatio.getSelectTeam().contains("sk")) {
						totalRatio = t.getRatio(totalRatio);
						int num = Integer.parseInt(t.getRatio(totalRatio).getSk());
						num += 1;
						totalRatio.setSk(Integer.toString(num));
						//out.println(totalRatio.getSk() + "<br>");
						t.setRatio(totalRatio);
						//out.println(t.getRatio(totalRatio).getSk() + " " + t.getRatio(totalRatio).getSamsung());
					}

					else if (totalRatio.getSelectTeam().contains("doosan")) {
						totalRatio = t.getRatio(totalRatio);
						int num2 = Integer.parseInt(t.getRatio(totalRatio).getDoosan());
						num2 += 1;
						totalRatio.setDoosan(Integer.toString(num2));
						//out.println(totalRatio.getSamsung() + "<br>");
						t.setRatio(totalRatio);
						//out.println(t.getRatio(totalRatio).getSamsung() + " " + t.getRatio(totalRatio).getSk());
					}
					
					else if (totalRatio.getSelectTeam().contains("hanhwa")) {
						totalRatio = t.getRatio(totalRatio);
						int num2 = Integer.parseInt(t.getRatio(totalRatio).getHanhwa());
						num2 += 1;
						totalRatio.setHanhwa(Integer.toString(num2));
						//out.println(totalRatio.getSamsung() + "<br>");
						t.setRatio(totalRatio);
						//out.println(t.getRatio(totalRatio).getSamsung() + " " + t.getRatio(totalRatio).getSk());
					}
					
					else if (totalRatio.getSelectTeam().contains("kia")) {
						totalRatio = t.getRatio(totalRatio);
						int num2 = Integer.parseInt(t.getRatio(totalRatio).getKia());
						num2 += 1;
						totalRatio.setKia(Integer.toString(num2));
						//out.println(totalRatio.getSamsung() + "<br>");
						t.setRatio(totalRatio);
						//out.println(t.getRatio(totalRatio).getSamsung() + " " + t.getRatio(totalRatio).getSk());
					}
					
					else if (totalRatio.getSelectTeam().contains("kiwoom")) {
						totalRatio = t.getRatio(totalRatio);
						int num2 = Integer.parseInt(t.getRatio(totalRatio).getKiwoom());
						num2 += 1;
						totalRatio.setKiwoom(Integer.toString(num2));
						//out.println(totalRatio.getSamsung() + "<br>");
						t.setRatio(totalRatio);
						//out.println(t.getRatio(totalRatio).getSamsung() + " " + t.getRatio(totalRatio).getSk());
					}
					
					else if (totalRatio.getSelectTeam().contains("kt")) {
						totalRatio = t.getRatio(totalRatio);
						int num2 = Integer.parseInt(t.getRatio(totalRatio).getKt());
						num2 += 1;
						totalRatio.setKt(Integer.toString(num2));
						//out.println(totalRatio.getSamsung() + "<br>");
						t.setRatio(totalRatio);
						//out.println(t.getRatio(totalRatio).getSamsung() + " " + t.getRatio(totalRatio).getSk());
					}
					
					else if (totalRatio.getSelectTeam().contains("lg")) {
						totalRatio = t.getRatio(totalRatio);
						int num2 = Integer.parseInt(t.getRatio(totalRatio).getLg());
						num2 += 1;
						totalRatio.setLg(Integer.toString(num2));
						//out.println(totalRatio.getSamsung() + "<br>");
						t.setRatio(totalRatio);
						//out.println(t.getRatio(totalRatio).getSamsung() + " " + t.getRatio(totalRatio).getSk());
					}
					
					else if (totalRatio.getSelectTeam().contains("lotte")) {
						totalRatio = t.getRatio(totalRatio);
						int num2 = Integer.parseInt(t.getRatio(totalRatio).getLotte());
						num2 += 1;
						totalRatio.setLotte(Integer.toString(num2));
						//out.println(totalRatio.getSamsung() + "<br>");
						t.setRatio(totalRatio);
						//out.println(t.getRatio(totalRatio).getSamsung() + " " + t.getRatio(totalRatio).getSk());
					}
					
					else if (totalRatio.getSelectTeam().contains("nc")) {
						totalRatio = t.getRatio(totalRatio);
						int num2 = Integer.parseInt(t.getRatio(totalRatio).getNc());
						num2 += 1;
						totalRatio.setNc(Integer.toString(num2));
						//out.println(totalRatio.getSamsung() + "<br>");
						t.setRatio(totalRatio);
						//out.println(t.getRatio(totalRatio).getSamsung() + " " + t.getRatio(totalRatio).getSk());
					}
					
					else if (totalRatio.getSelectTeam().contains("samsung")) {
						totalRatio = t.getRatio(totalRatio);
						int num2 = Integer.parseInt(t.getRatio(totalRatio).getSamsung());
						num2 += 1;
						totalRatio.setSamsung(Integer.toString(num2));
						//out.println(totalRatio.getSamsung() + "<br>");
						t.setRatio(totalRatio);
						//out.println(t.getRatio(totalRatio).getSamsung() + " " + t.getRatio(totalRatio).getSk());
					}
					
					//else out.println(totalRatio.getSk());

					int leftRatio = Integer.parseInt(totalRatio.getSk());
					int rightRatio = Integer.parseInt(totalRatio.getSamsung());
					//out.print(leftRatio);
					
				%>
				
				
									<%
										searchFans play = new searchFans();
										List tm = new ArrayList();
										tm = play.getSchedule(userTeam);
										String leftTeam = tm.get(1).toString();
										String rightTeam = tm.get(2).toString();
										String[] teamName = {"SK","두산","키움","LG","NC","KT","KIA",
										                     "삼성","한화","롯데"};
										String[] teamValue = {"sk","doosan","kiwoom","lg","nc","kt","kia",
																"samsung","hanhwa","lotte"};
										String[] realData = {totalRatio.getSk(), totalRatio.getDoosan(), totalRatio.getKiwoom(), 
															 totalRatio.getLg(), totalRatio.getNc(), totalRatio.getKt(), 
															 totalRatio.getKia(), totalRatio.getSamsung(), totalRatio.getHanhwa(),
															 totalRatio.getLotte()
															};
										
										String leftValue="";
										String rightValue="";
										
										int lRatio=0;
										int rRatio=0;
							
										
										for(int i=0;i<10;i++){
											if(leftTeam.contains(teamName[i])) {
												leftValue = teamValue[i];
												lRatio = Integer.parseInt(realData[i]);
											}
											if(rightTeam.contains(teamName[i])) {
												rightValue = teamValue[i];
												rRatio = Integer.parseInt(realData[i]);
											}
										}
										
										double left = (double) ((double) lRatio / (double) ((double) lRatio + (double) rRatio)) * 100;
										double right = (double) ((double) rRatio / (double) ((double) lRatio + (double) rRatio)) * 100;
										
									%>

				<div class="container-fluid">
					<div class="row">
						<div class="col-12">
							<div class="card shadow">

								<div class="card-body" style="color: black;">
									<div class="mb-4">
										<h4>
											<strong>승리팀 예측</strong>
										</h4>
									</div>
										<div class="mb-3">
											<div class="mb-2">

												
												<strong><%=leftTeam%></strong>

											</div>

											<div class="progress" style="height: 30px;">
												<div class="progress-bar bg-danger" role="progressbar"
													aria-valuenow="60" aria-valuemin="0" aria-valuemax="100"
													style="width: <%=(int) left%>%; font-size: 15px;"><%=(int) left%>%
												</div>
											</div>
										</div>

										<div>
											<div class="mb-2">

												
												<strong><%=rightTeam%></strong>

											</div>

										</div>
										<div class="progress" style="height: 30px;">
											<div class="progress-bar" role="progressbar"
												aria-valuenow="40" aria-valuemin="0" aria-valuemax="100"
												style="width: <%=(int) right%>%; font-size: 15px;"><%=(int) right%>%
											</div>
										</div>
								
								</div>




							</div>
						</div>
					</div>



				</div>

			</div>




		</div>
	</div>


	<!-- Bootstrap core JavaScript-->
	<script src="vendor/jquery/jquery.min.js"></script>
	<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

	<!-- Core plugin JavaScript-->
	<script src="vendor/jquery-easing/jquery.easing.min.js"></script>

	<!-- Custom scripts for all pages-->
	<script src="js/sb-admin-2.min.js"></script>

	<!-- Page level plugins -->
	<script src="vendor/chart.js/Chart.min.js"></script>

	<!-- Page level custom scripts -->
	<script src="js/demo/chart-area-demo.js"></script>
	<script src="js/demo/chart-pie-demo.js"></script>


</body>
</html>