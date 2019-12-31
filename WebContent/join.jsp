<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
<script src="//code.jquery.com/jquery.min.js"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>

<!-- Custom fonts for this template-->
<link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet"
	type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">

<!-- Custom styles for this template-->
<link href="css/sb-admin-2.min.css?after" rel="stylesheet">

<title>회원가입</title>
</head>
<body class="bg-gradient-primary">

	<div class="container">

		<div class="card o-hidden border-0 shadow-lg my-5">
			<div class="card-body p-0">
				<!-- Nested Row within Card Body -->
				<div class="row">
					<div class="col-lg-5 d-none d-lg-block bg-register-image"></div>
					<div class="col-lg-7">
						<div class="p-5">
							<div class="text-center">
								<h1 class="h4 text-gray-900 mb-4">Create an Account!</h1>
							</div>
							<form class="user" method="post" action="joinAction.jsp">
								<div class="form-group row">
									<div class="col-sm-6 mb-3 mb-sm-0">
										<input type="text" name="userID"
											class="form-control form-control-user" id="userID"
											placeholder="아이디">
									</div>
									<div class="col-sm-6">
										<input type="text" name="userNickname"
											class="form-control form-control-user" id="userNickname"
											placeholder="닉네임">
									</div>

								</div>
								<script>
									var playersList = [];
									
									function testListner(obj) {
										//alert(obj.value);
										var teamSelect = obj.value;
										$.ajax({

											type : "get",
											url : "join.do?team=" + teamSelect,
											async: false,
											dataType : "json",
											data : {
												'team' : teamSelect
											},

											success : function(playerList) {
											
												//console.log(playerList);
												playersList = playerList.players;
												$(function() {

													var test = "";
													
												    var availableCity = [test];
												    availableCity =	playersList;

												    $("#star").autocomplete({

												    	
												        source: playersList,

												        select: function(event, ui) {

												            console.log(ui.item);

												        },

												        focus: function(event, ui) {

												            return false;

												            //event.preventDefault();

												        }

												    });

												});
												//setData(data.players);
												//console.log(players);
											},
											error : function() {

												alert("오류입니다.");
											}

										});
									}
									
									function setData(data) {
										players = data;
									}
									
								</script>
								<div class="form-group row">
									<div class="col-sm-6 mb-3 mb-sm-0">
										<select class="form-control-user" name="userTeam"
											id="userTeam" onchange="javascript:testListner(this);">
											<option value="" selected disabled>팀선택</option>
											<option id="SK" value="SK">SK</option>
											<option id="Doosan" value="두산">두산</option>
											<option id="Kiwoom" value="키움">키움</option>
											<option id="LG" value="LG">LG</option>
											<option id="NC" value="NC">NC</option>
											<option id="KT" value="KT">KT</option>
											<option id="Kia" value="KIA">기아</option>
											<option id="Samsung" value="삼성">삼성</option>
											<option id="Hanhwa" value="한화">한화</option>
											<option id="Lotte" value="롯데">롯데</option>
										</select>


									</div>
									
									<div class="col-sm-6">
										<input id="star" type="text" name="userFan"
											class="form-control form-control-user" id="userFan"
											placeholder="관심선수">
									</div>




								</div>


								<div class="form-group row">
									<div class="col-sm-6 mb-3 mb-sm-0">
										<input type="password" name="userPassword"
											class="form-control form-control-user" id="userPassword"
											placeholder="Password">
									</div>
									<div class="col-sm-6">
										<input type="password" name="userPassword"
											class="form-control form-control-user" id="userPassword"
											placeholder="Repeat Password">
									</div>
								</div>
								<input type="submit" class="btn btn-primary btn-user btn-block"
									value="회원가입">
								<hr>

							</form>
							<div class="text-center">
								<a class="small" href="forgot-password.html">비밀번호 찾기</a>
							</div>
							<div class="text-center">
								<a class="small" href="index.jsp">로그인</a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

	</div>





	<!-- Bootstrap core JavaScript-->

	<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

	<!-- Core plugin JavaScript-->
	<script src="vendor/jquery-easing/jquery.easing.min.js"></script>

	<!-- Custom scripts for all pages-->
	<script src="js/sb-admin-2.min.js"></script>

</body>
</html>