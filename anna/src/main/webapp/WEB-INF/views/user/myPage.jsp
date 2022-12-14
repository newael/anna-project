<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page session="true" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<html>
<head>
<title>안녕? 나야! - 마이 페이지</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1, minimum-scale=1">
<script src="${ path }/js/jquery-3.6.0.js"></script>
<script src="${ path }/js/bootstrap.js"></script>
<script src="${ path }/js/common/common.js"></script>
<script>
	$(function(){
		let slide;
		let slideWidth = 0;
		
		$(window).resize(function(){
			$(".slide-container").css("left","0px");
		});
		
		$(".slide-btn-prev").click(function(){
			let slideContainer = $(this).data("container");
			slideWidth = $(slideContainer).css("width").replace("px","");
			let itemSize = $(this).data("itemsize");
			let NextMax = -((Math.ceil(itemSize / 5) - 1) * slideWidth);
			slide = $($(this).data("slide"));
			if((parseInt(slide.css("left").replace("px",""))%slideWidth) == 0){
				let left = slide.css("left").replace("px","");
				if(slide.css("left").replace("px","") == 0){
					left = NextMax;
				}else if((parseInt(left)+parseInt(slideWidth)) > 0){
					left = 0;
				}
				else{
					left = parseInt(left)+parseInt(slideWidth);
				}
				slide.css("left",left+"px");
			}
		});
		
		$(".slide-btn-next").click(function(){
			let itemSize = $(this).data("itemsize");
			let slideContainer = $(this).data("container");
			slideWidth = $(slideContainer).css("width").replace("px","");
			slide = $($(this).data("slide"));
			if((parseInt(slide.css("left").replace("px",""))%slideWidth) == 0){
				left = slide.css("left").replace("px","");
				let NextMax = -((Math.ceil(itemSize / 5) - 1) * slideWidth);
				if((parseInt(left)-parseInt(slideWidth)) >= parseInt(NextMax)){
					left = (parseInt(left)-parseInt(slideWidth));
				}else{
					left = 0;
				}
			}
			slide.css("left",left+"px");
		});
		
		
		
	});
</script>
<link href="${ path }/css/bootstrap.css" rel="stylesheet" type="text/css" />
<link href="${ path }/css/offcanvas.css" rel="stylesheet" type="text/css" />
<link href="${ path }/css/common/layout.css" rel="stylesheet" type="text/css" />
<style>

/*
반응형 기준 기록
	아주작은(xs)  576px 미만	  스마트폰 세로
	작은(sm) 	  576px 이상	  스마트폰 가로
	중간(md)	  768px 이상	  타블렛
	큰(lg)   	  992px 이상	  데스크탑
	아주큰(xl)	  1200px 이상	  큰 데스크탑
*/


.card {
    margin-left: 3px;
    cursor:pointer;
}

@media all and (max-width:  767px){
	
	#container-pc {
		display:none;
	}
	
}

@media all and (min-width :768px){

	#footer, #container-mobile{
		display:none
	}
	
}

.prev{
	position: absolute;
    top: 0;
    bottom: 0;
    z-index: 1;
    display: flex;
    padding-left:15px;
    align-items: center;
    justify-content: center;
    color: #000;
    text-align: center;
    background: none;
    border: 0;
    opacity: 0.5;
    transition: opacity 0.15s ease;
}

.next{
	position: absolute;
    top: 0;
    bottom: 0;
    z-index: 1;
    padding-right:15px;
    display: flex;
    align-items: center;
    justify-content: center;
    right:0;
    color: #000;
    text-align: center;
    background: none;
    border: 0;
    opacity: 0.5;
    transition: opacity 0.15s ease;
}

.btn-circle {
	border-radius:100px; 
	background:#777; 
	width:50px;
	height:50px; 
	margin:auto;
	margin-top:20px; 
	color:#fff; 
	position:relative; 
	display:flex; 
	align-items:center;
}

.card-body{
	padding:10px;
}

.slide-btn {
	position:absolute;
	z-index:100; 
	height:100%; 
	top:0; 
	bottom:0; 
	align-items:center; 
	display:flex;
	cursor:pointer;
}


</style>
</head>
<body>
	<div class="wrapper">
		<%@ include file="/WEB-INF/views/common/header.jsp" %>
		
		<div class="wrapper main" id="container-pc">
			<!-- MyPage for Pc -->
			<div class="container ">
				<h3 class="border-bottom" style="padding:1rem;">마이 페이지</h3>
				<div id="listOfInterested">
					<div style="float:left; padding:5px;">${ userLoginInfo.nickName }님이 관심있어 할만한 상품</div>
					<div style="float:right; padding:5px;" onclick="location.href='${path}/boarditem/itemlist.do?WishCheck=4'">더 보기</div>
					
					<c:if test="${ not empty userLoginInfo.interested }">
						<c:if test="${interestedList.size() > 0}">
							<div id="slideOfInterested" style="width:100%; clear:both; overflow:hidden; position:relative;">
								<c:if test="${interestedList.size() > 5}">
									<div class="slide-btn slide-btn-prev" data-slide="#slider-interested" data-container="#slideOfInterested" data-itemsize="${ interestedList.size() }" id="slide-btn-prev" style="left:0;"><img src='${path}/images/slicbtn_prev.png'></div>
									<div class="slide-btn slide-btn-next" data-slide="#slider-interested" data-container="#slideOfInterested" data-itemsize="${ interestedList.size() }" id="slide-btn-next" style="right:0;"><img src='${path}/images/slicbtn_next.png'></div>
								</c:if>
								<div id="slider-interested" class="slide-container" style="display:flex; white-space:nowrap; font-size:0px; left:0; position:relative; transition: left 0.6s ease-in-out;">
									<c:forEach var="vo" items="${interestedList}">
										<div style="width:20%; display:inline-block; font-size:1rem; flex:none;">
											<div class="card" style="margin:5px;" onclick="location.href='${path}/boarditem/itemview.do?item_idx=${ vo.item_idx }'">
												<div style="width:100%; height:210px; background:url('${ path }/resources/upload/${ vo.image1 }'),url('${path}/images/no_image.gif'); background-size:cover; background-position:center; background-repeat:no-repeat;" class="card-img-top" ></div>
												<div class="card-body">
													<div class="text-start" style="height:30px; display:flex; align-items:center;">
														<c:if test="${ fn:length(vo.title) > 8 }">
															<b>${fn:substring(vo.title,0,8) }...</b>
														</c:if>
														<c:if test="${ fn:length(vo.title) <= 8 }">
															<b>${ vo.title }</b>
														</c:if>
														<c:if test="${ vo.state eq 2 }"><span style="padding:3px; border-radius:5px; background:green; color:#fff; font-size:0.8rem; margin-left:5px;">예약중</span></c:if>
														<c:if test="${ vo.state eq 3 }"><span style="padding:3px; border-radius:5px; background:gray; color:#fff; font-size:0.8rem; margin-left:5px;">거래완료</span></c:if>
													</div>
													<div>
														<span style="color:#00AAB2;"><fmt:formatNumber value="${ vo.price }" pattern="#,###"/></span>원
													</div>
											    	<div class="text-end">
											    		<img src="${path}/images/icon_wish_count.png" style="width:26px; padding:2px;"> ${ vo.wishCount }&nbsp;<img src="${path}/images/icon_chat_count.png" style="width:28px; padding:1px;"> ${ vo.chatCount }
											    	</div>
											  	</div>
											</div>
										</div>
									</c:forEach>
								</div>
							</div>
						</c:if>
						<c:if test="${interestedList.size() eq 0}">
							<div style="width:100%; height:200px; clear:both; display:flex;">
								<div style="flex:1; margin:auto; text-align:center; ">
									등록된 키워드로 등록된상품이 없습니다.
								</div>
							</div>
						</c:if>
					</c:if>
					<c:if test="${ empty userLoginInfo.interested }">
						<div style="width:100%; height:200px; clear:both; display:flex;">
							<div style="flex:1; margin:auto; text-align:center; cursor:pointer;" onclick="location.href='userInfoMod.do'">
								등록된 키워드가 없습니다. 키워드를 등록해주세요.
							</div>
						</div>
					</c:if>
				</div>
				<hr>
				
				<div id="listOfCommunity">
					<div style="float:left; padding:5px;">${ userLoginInfo.nickName }님의 판매중인 상품</div>
					<div style="float:right; padding:5px;" onclick="location.href='${path}/boarditem/itemlist.do?searchUidx=${uidx}'">더 보기</div>
					<%-- <div style="float:right; padding:5px;" onclick="location.href='${path}/boarditem/itemlist.do?searchUidx=${uidx}'">더 보기</div> --%>
					
					<c:if test="${myBoardItemList.size() > 0}">
						<div id="slideOfMyItem" style="width:100%; clear:both; overflow:hidden; position:relative;">
							<c:if test="${myBoardItemList.size() > 5}">
								<div class="slide-btn slide-btn-prev" data-slide="#slider-myItem" data-container="#slideOfMyItem" data-itemsize="${ myBoardItemList.size() }" id="slide-btn-prev" style="left:0;"><img src='${path}/images/slicbtn_prev.png'></div>
								<div class="slide-btn slide-btn-next" data-slide="#slider-myItem" data-container="#slideOfMyItem" data-itemsize="${ myBoardItemList.size() }" id="slide-btn-next" style="right:0;"><img src='${path}/images/slicbtn_next.png'></div>
							</c:if>
							<div id="slider-myItem" class="slide-container" style="display:flex; white-space:nowrap; font-size:0px; left:0; position:relative; transition: left 0.6s ease-in-out;">
								<c:forEach var="vo" items="${myBoardItemList}">
									<div style="width:20%; display:inline-block; font-size:1rem; flex:none;">
										<div class="card" style="margin:5px;" onclick="location.href='${path}/boarditem/itemview.do?item_idx=${ vo.item_idx }'">
											<div style="width:100%; height:210px; background:url('${ path }/resources/upload/${ vo.image1 }'),url('${path}/images/no_image.gif'); background-size:cover; background-position:center; background-repeat:no-repeat;" class="card-img-top" ></div>
											<%-- <img src="${ path }/resources/upload/${ vo.image1 }" style="width:100%; height:210px;" onerror="this.onerror=null; this.src='<%=request.getContextPath()%>/images/no_image.gif';" class="card-img-top" alt="..."> --%>
											<div class="card-body">
												<div class="text-start" style="height:30px; display:flex; align-items:center;">
													<c:if test="${ fn:length(vo.title) > 8 }">
														<b>${fn:substring(vo.title,0,8) }...</b>
													</c:if>
													<c:if test="${ fn:length(vo.title) <= 8 }">
														<b>${ vo.title }</b>
													</c:if>
													<c:if test="${ vo.state eq 2 }"><span style="padding:3px; border-radius:5px; background:green; color:#fff; font-size:0.8rem; margin-left:5px;">예약중</span></c:if>
													<c:if test="${ vo.state eq 3 }"><span style="padding:3px; border-radius:5px; background:gray; color:#fff; font-size:0.8rem; margin-left:5px;">거래완료</span></c:if>
												</div>
												<div>
													<span style="color:#00AAB2;"><fmt:formatNumber value="${ vo.price }" pattern="#,###"/></span>원
												</div>
										    	<div class="text-end">
										    		<img src="${path}/images/icon_wish_count.png" style="width:26px; padding:2px;"> ${ vo.wishCount }&nbsp;<img src="${path}/images/icon_chat_count.png" style="width:28px; padding:1px;"> ${ vo.chatCount }
										    	</div>
										  	</div>
										</div>
									</div>
								</c:forEach>
							</div>
						</div>
					</c:if>
					<c:if test="${myBoardItemList.size() eq 0}">
						<div style="width:100%; height:200px; clear:both; display:flex;">
							<div style="flex:1; margin:auto; text-align:center;">
								현재 판매중인 상품이 없습니다.
							</div>
						</div>
					</c:if>
				</div>
				<hr>
				
				<div id="listOfCommunity">
					<div style="float:left; padding:5px;">우리동네 커뮤니티</div>
					<div style="float:right; padding:5px;" onclick="location.href='${path}/board/boardlist.do?location_auth=${userLoginInfo.location_auth}'">더 보기</div>
					<div class="list">
				
						<div class="tr border-bottom">
							<div class="th" style="width:50%;">제목</div>
							<div class="th" style="width:10%;">구분</div>
							<div class="th" style="width:10%;">작성자</div>
							<div class="th" style="width:20%;">작성일</div>
							<div class="th" style="width:10%;">조회수</div>
						</div>
						<c:if test="${ not empty myTownCommunityList }">
							<c:forEach var="i" items="${ myTownCommunityList }">
								<div class="tr border-bottom" onclick="location.href='${path}/board/viewBoard.do?Bidx=${i.bidx}'">
									<div class="td text-center" style="width:50%;">${ i.title }</div>
									<div class="td text-center" style="width:10%;">${ i.board_type }</div>
									<div class="td text-center" style="width:10%;">${ i.nickName }</div>
									<div class="td text-center" style="width:20%;">${ i.wdate }</div>
									<div class="td text-center" style="width:10%;">${ i.hit }</div>
								</div>
							</c:forEach>
						</c:if>
						<c:if test="${ empty myTownCommunityList }">
							<div class="tr border-bottom" style="height:200px; display:flex; margin-bottom:20px;">
								<div style="flex:1; margin:auto; text-align:center;">현재 등록된 동네에는 등록된 게시글이 없습니다.</div>
							</div>
						</c:if>
					</div>
				</div>
				
				<div id="myCommunity">
					<div style="float:left; padding:5px;">내가 작성한 글</div>
					<div style="float:right; padding:5px;" onclick="location.href='${path}/board/boardlist.do?searchUidx=${uidx}'">더 보기</div>
					<div class="list">
				
						<div class="tr border-bottom">
							<div class="th" style="width:50%;">제목</div>
							<div class="th" style="width:10%;">구분</div>
							<div class="th" style="width:10%;">작성자</div>
							<div class="th" style="width:20%;">작성일</div>
							<div class="th" style="width:10%;">조회수</div>
						</div>
						<c:if test="${ not empty myCommunity }">
							<c:forEach var="i" items="${ myCommunity }">
								<div class="tr border-bottom" onclick="location.href='${path}/board/viewBoard.do?Bidx=${i.bidx}'">
									<div class="td text-center" style="width:50%;">${ i.title }</div>
									<div class="td text-center" style="width:10%;">${ i.board_type }</div>
									<div class="td text-center" style="width:10%;">${ i.nickName }</div>
									<div class="td text-center" style="width:20%;">${ i.wdate }</div>
									<div class="td text-center" style="width:10%;">${ i.hit }</div>
								</div>
							</c:forEach>
						</c:if>
						<c:if test="${ empty myCommunity }">
							<div class="tr border-bottom" style="height:200px; display:flex; margin-bottom:20px;">
								<div style="flex:1; margin:auto; text-align:center;">아직 작성한 게시글이 없습니다.</div>
							</div>
						</c:if>
					</div>
				</div>
			</div>
			<!-- MyPage for Pc -->
		</div>
		
		<div class="wrapper main" id='container-mobile'>
			<!-- MyPage for Mobile -->
			<div class="container" style="overflow:auto;">
				<div class="border-bottom border-top" style="display:flex;">
					<div style="display:inline-block;">
						<div style="border-radius:100px; margin:20px; width:80px; height:80px; background:url('${userInfo.profile_image}'),url('${path}/images/NoProfile.png'); background-position: center; background-repeat: no-repeat; background-size: cover;"></div>
					</div>
					<div style="display:flex; vertical-align: middle; flex:1; align-items:center;">
						<div>
							<div style="padding:5px 5px 5px 0; font-size:1.1rem;"><b>${ userInfo.nickName }</b></div>
							<div><span onclick="location.href='userInfoView.do'">내 정보</span>&nbsp;<span onclick="location.href='logout.do'">로그아웃</span></div>
						</div>
						
					</div>
				</div>
				<div class="row">
					<div class="col-4" style="padding:0px;">
						<div class="text-center btn-circle" onclick="location.href='chatList.do?type=buy'" style="background:#00AAB2;">
							<c:if test="${ chkBuyNewMessage ne 0}">
								<div style="display:inline-block; width:18px; height:18px; font-size:0.8rem; position:absolute; padding:2px; right:0; top:0; background:red; border-radius:10px; color:#fff;">${ chkBuyNewMessage }</div>
							</c:if>
							<div style="flex:1;">구매</div>
						</div>
						<div class="text-center">구매 내역</div>
					</div>
					<div class="col-4" style="padding:0px;">
						<div class="text-center btn-circle" onclick="location.href='chatList.do?type=sell'" style="background:#00AAB2;">
							<c:if test="${ chkSellNewMessage ne 0}">
								<div style="display:inline-block; width:18px; height:18px; font-size:0.8rem; position:absolute; padding:2px; right:0; top:0; background:red; border-radius:10px; color:#fff;">${ chkSellNewMessage }</div>
							</c:if>
							<div style="flex:1;">판매</div>
						</div>
						<div class="text-center">판매 내역</div>
					</div>
					<div class="col-4" style="padding:0px;">
						<div class="text-center btn-circle" onclick="location.href='alarmView.do'" style="background:#00AAB2;">
							<c:if test="${ chkAlarm ne 0}">
								<div style="display:inline-block; width:18px; height:18px; font-size:0.8rem; position:absolute; padding:2px; right:0; top:0; background:red; border-radius:10px; color:#fff;">${ chkAlarm }</div>
							</c:if>
							<div style="flex:1;">알림</div>
						</div>
						<div class="text-center">알림</div>
					</div>
					<div class="col-4" style="padding:0px;" onclick="location.href='wishList.do'">
						<div class="text-center btn-circle" style="background:#BBCE53;"><div style="flex:1;">찜</div></div>
						<div class="text-center">찜 목록</div>
					</div>
					<div class="col-4" style="padding:0px;" onclick="location.href='${path}/boarditem/itemlist.do?interested=${userLoginInfo.interested}'">
						<div class="text-center btn-circle" style="background:#BBCE53;"><div style="flex:1;">관심</div></div>
						<div class="text-center">관심 상품</div>
					</div>
					<div class="col-4" style="padding:0px;" onclick="location.href='${path}/board/boardlist.do?board_type=notice'">
						<div class="text-center btn-circle" style="background:#BBCE53;"><div style="flex:1;">공지</div></div>
						<div class="text-center">공지사항</div>
					</div>
					<div class="col-4" style="padding:0px;" onclick="location.href='neighborMng.do'">
						<div class="text-center btn-circle" style="background:#fab915;"><div style="flex:1;">이웃</div></div>
						<div class="text-center">이웃 관리</div>
					</div>
					<div class="col-4" style="padding:0px;" onclick="location.href='${path}/customer/FaQList.do'">
						<div class="text-center btn-circle" style="background:#fab915;"><div style="flex:1;">질문</div></div>
						<div class="text-center">자주하는 질문</div>
					</div>
					<div class="col-4" style="padding:0px;" onclick="location.href='${path}/customer/QnAList.do'">
						<div class="text-center btn-circle" style="background:#fab915;"><div style="flex:1;">QnA</div></div>
						<div class="text-center">문의 내역</div>
					</div>
				</div>
			</div>
			<!-- MyPage for Mobile -->
		</div>
		
		<%@ include file="/WEB-INF/views/common/footer.jsp" %>
	</div>
</body>
</html>
