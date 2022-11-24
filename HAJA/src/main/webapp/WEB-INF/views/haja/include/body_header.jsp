<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 2022-10-22 HEADER DESKTOP-->
<header class="header-desktop" style="left: 0;">
	<div class="section__content section__content--p30">
		<div class="container-fluid">
			<div class="header-wrap">
				<div class="logo">
					<a href="${path}/"><img src="/resources/assets/brand/haja-banner.jpg" width="100px"></a>
				</div>

				<div class="dummy"></div>

				<c:choose>
					<c:when test="${sessionScope.userid == null}">
						<!-- 로그인하지 않은 상태  -->
						<div class="header-button">
							<div class="noti__item" align="center">
								<a href="${path}/member/login.do"> 
								<i class="zmdi zmdi-account"></i> <br>
								<span style="color: #a9b3c8; font-weight: bold;">로그인</span>
								</a>
							</div>
							<div class="noti__item" align="center">
								<a href="${path}/member/join.do"> 
								<i class="zmdi zmdi-account-add" style="margin-right: 9%;"></i> <br>
								<span style="color: #a9b3c8; font-weight: bold;">회원가입</span>
								</a>
							</div>
						</div>

					</c:when>
					<c:otherwise>
						<!-- 로그인한 상태 -->
						<div class="header-button">
							<div class="noti-wrap">
								<div id="message" class="noti__item js-item-menu">
									<i class="zmdi zmdi-comment-more"></i> <span id="message-cnt" class="quantity">${sessionScope.messageNviewCnt}</span>
									<div class="mess-dropdown js-dropdown">
										<div class="mess__title">
											<p>안읽은 메세지가 <span id="messageCnt"></span>개 있습니다</p>
										</div>
										<div id="message_list"></div>
										<div class="mess__footer">
											<a href="${path}/message/messageList.do">모든 메세지보기</a>
										</div>
									</div>
								</div>
								<div id="alarm" class="noti__item js-item-menu">
									<i class="zmdi zmdi-notifications"></i> <span id="alarm-cnt" class="quantity">${sessionScope.alarmNviewCnt}</span>
									<div class="notifi-dropdown js-dropdown">
										<div class="notifi__title">
											<p>안읽은 알람이 <span id="alarmCnt"></span>개 있습니다</p>
										</div>
										<div id="notifi_list"></div>
										<div class="notifi__footer">
											<a href="${path}/alarm/alarmList">모든 알람보기</a>
										</div>
									</div>
								</div>
							</div>
							<div class="account-wrap">
								<div class="account-item clearfix js-item-menu">
									<div class="content">
										<a class="js-acc-btn" href="#">${sessionScope.userid}</a>
									</div>
									<div class="account-dropdown js-dropdown">
										<div class="info clearfix">
											<div class="content" style="margin-left: 0;">
												<h5 class="name">
													<a href="#">${sessionScope.userid}</a>
												</h5>
												<span class="email">${sessionScope.teamid}</span>
											</div>
										</div>
										
										<div class="account-dropdown__body">
											<div class="account-dropdown__item">
												<c:choose>
													<c:when test="${sessionScope.isadmin == 'y'}">
														<a href="${path}/member/admin.do">
														<i class="zmdi zmdi-account"></i>관리자 모드</a>
													</c:when>
													<c:otherwise>
														<a href="${path}/member/view.do"> 
														<i class="zmdi zmdi-account"></i>정보수정</a>
													</c:otherwise>
												</c:choose>
											</div>
											<div class="account-dropdown__item">
												<a href="${path}/join/matchList"> <i class="zmdi zmdi-calendar"></i>매칭현황
												</a>
											</div>
											<div class="account-dropdown__item">
												<a href="${path}/message/messageForm"> <i class="zmdi zmdi-email"></i>메세지 보내기
												</a>
											</div>
										</div>
										<div class="account-dropdown__footer">
											<a href="${path}/member/logout.do"> <i
												class="zmdi zmdi-power"></i>로그아웃
											</a>
										</div>
									</div>
								</div>
							</div>
						</div>
					</c:otherwise>
				</c:choose>


			</div>
		</div>
	</div>
	
	<script type="text/javascript">
	$(function() {
		$("#message").click(function() {
			if ($("#message").hasClass("show-dropdown")) {
				$.ajax({
					type : "get",
					url : "${path}/message/recentMessageUpdate.do",
					success : function(result) {
						$("#message-cnt").html(result.messageCnt);
						$("#messageCnt").html(result.messageCnt);
						
						var output = "";
						for (var i in result.list) {
							var text = result.list[i].text;
							var messagetext = text.substr(0, 25)+".....";
							
							output += "<div class='mess__item'>";
							output += "<div class='content'><p>"+messagetext+"</p>";
							output += "<span class='date'>"+result.list[i].send+"&nbsp;&nbsp;"+changeDate(result.list[i].regdate)+"</span></div></div>";
						}
						
						$("#message_list").html(output);
					}
				});	
			}
		});
		
		$("#alarm").click(function() {
			if ($("#alarm").hasClass("show-dropdown")) {
				$.ajax({
					type : "get",
					url : "${path}/alarm/recentAlarmUpdate.do",
					success : function(result) {
						$("#alarm-cnt").html(result.alarmCnt);
						$("#alarmCnt").html(result.alarmCnt);
						
						var output = "";
						for (var i in result.list) {
							output += "<div class='notifi__item'>";
							output += "<div class='bg-c3 img-cir img-40'>";
							output += "<i class='zmdi zmdi-notifications'></i></div>";
							output += "<div class='content'><p>"+result.list[i].alarmtext+"</p>";
							output += "<span class='date'>"+changeDate(result.list[i].regdate)+"</span></div></div>";
						}
						
						$("#notifi_list").html(output);
					}
				});	
			}
		});
	});
	
	function changeDate(date) {
		date = new Date(parseInt(date));
		year=date.getFullYear();
		month=date.getMonth();
		day=date.getDate();
		hour=date.getHours();
		minute=date.getMinutes();
		strDate = 
			year+"-"+month+"-"+day+" "+hour+":"+minute;
		return strDate;
	}
	</script>
</header>
<!-- END HEADER DESKTOP-->
