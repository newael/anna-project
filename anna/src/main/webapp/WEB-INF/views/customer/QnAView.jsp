<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@ page session="true" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<html>
<head>
<title>안녕? 나야!</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1, minimum-scale=1">
<script src="${ path }/js/jquery-3.6.0.js"></script>
<script src="${ path }/js/bootstrap.js"></script>
<script src="${ path }/js/common/common.js"></script>

<!-- 지도 API - 필요없으면 지워도 됨 -->
<script type='text/javascript' src='https://sgisapi.kostat.go.kr/OpenAPI3/auth/javascriptAuth?consumer_key=9ff16331dfd542b6a5b0'></script>	
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ad11d9178deb7b571198c476ec55ad0f"></script>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<!-- 지도 API -->

<!-- 스타일 시트는 여기에 추가로 작성해서 사용 -->
<link href="${ path }/css/bootstrap.css" rel="stylesheet" type="text/css" />
<link href="${ path }/css/offcanvas.css" rel="stylesheet" type="text/css" />
<link href="${ path }/css/common/layout.css" rel="stylesheet" type="text/css" />
<!-- path는 request.getContextPath()를 가져온것. -->
<script>
	
	$(function(){

		if("${ userLoginInfo.isAdmin }" == 'Y'){
			$("textarea[name=answer]").focus();
		}
	});
	function Answer(){
		let answer = $("textarea[name=answer]");
		
		if(answer.val() == ""){
			alert("답변 내용을 입력하세요");
			answer.focus();
		}else{
			let url ="QnAAnswer.do?qidx=${QnAItem.qidx}&answer="+answer.val()+"&uidx=${QnAItem.uidx}";
			//console.log(url);
			location.href = url;
		}
		
	}
	
	function openModal(){
		$(".imagePreviewModal").fadeIn();
	}
	
	function closeModal(){
		$(".imagePreviewModal").fadeOut();
	}

</script>
</head>
<body>
	<div class="wrapper">
		<!-- 헤더 및 메뉴 -->
		<%@ include file="/WEB-INF/views/common/header.jsp" %>
		<!-- 메뉴는 수정이 필요하면 헤더를 복사해서 메뉴명, 링크만 수정해서 사용할것! -->
		
		<div class="wrapper main">
			<div class="container">
				<div class="imagePreviewModal" style="width:100%; height:100%; position:absolute; left:0; top:0; display:none;">
					<div style="width:100%; height:100%; background:rgba(0,0,0,0.5); display:flex; align-items:center; overflow:auto;" onclick="closeModal()">
						<img src="${ path }/resources/QnA/${QnAItem.attach}" style="width:80%; padding:20px; height:auto; margin:auto;">
					</div>
				</div>
				<div class="container">				
					<h3 class="border-bottom" style="padding:1rem; margin:0px;">문의하기 - ${ QnAItem.title }</h3>
					<div class="row border-bottom tr">
						<div class="col-4 th" style="display:table-cell;">작성일</div>
						<div class="col-8 td" style="display:table-cell;">
							${ QnAItem.wDate }
						</div>
					</div>
					<div class="row border-bottom tr">
						<div class="col-4 th" style="display:table-cell;">문의유형</div>
						<div class="col-8 td" style="display:table-cell;">
							${ QnAItem.qType }
						</div>
					</div>
					<div class="row border-bottom tr">
						<div class="col-4 th" style="display:table-cell;">처리상태</div>
						<div class="col-8 td" style="display:table-cell;">
							<c:if test="${ QnAItem.state eq 0 }">
								처리중
							</c:if>
							<c:if test="${ QnAItem.state eq 1 }">
								처리완료
							</c:if>
						</div>
					</div>
					<div class="row border-bottom tr">
						<div class="col-4 th">내용</div>
						<div class="col-8 td">
							${QnAItem.contents}
						</div>
					</div>
					<div class="row border-bottom tr">
						<div class="col-4 th">첨부파일</div>
						<div class="col-8 td">
	    					<c:set var = "length" value = "${fn:length(QnAItem.attach)}"/>
							<c:if test="${ length >= 20 }" >
								${ fn:substring(QnAItem.attach,0,5) }...${ fn:substring(QnAItem.attach,length-10,length) } 
							</c:if>
							<c:if test="${ length < 20 }" >
								${ QnAItem.attach } 
							</c:if>
							<button type="button" class="btn btn-sm" style="background: #00AAB2; color: #fff;" onclick="openModal()">첨부파일 보기</button>
						</div>
					</div>
					<c:if test="${ userLoginInfo.isAdmin eq 'N' and QnAItem.state eq 1}">
						<div class="row border-bottom tr">
							<div class="col-4 th">답변자</div>
							<div class="col-8 td">
								관리자
							</div>
						</div>
						<div class="row border-bottom tr">
							<div class="col-4 th">답변일</div>
							<div class="col-8 td">
								${ QnAItem.ans_date }
							</div>
						</div>
						<div class="row border-bottom tr">
							<div class="col-4 th">답변</div>
							<div class="col-8 td">
								${QnAItem.answer}
							</div>
						</div>
					</c:if>
					<c:if test="${ userLoginInfo.isAdmin eq 'Y' }">
						<c:if test="${ empty QnAItem.answer }">
							<div class="row border-bottom tr">
								<div class="col-4 th">답변</div>
								<div class="col-8 td">
									<textarea wrap="hard" name="answer" class="form-control" style="resize:none; height:120px;">${ QnAItem.answer }</textarea>
								</div>
							</div>
						</c:if>
						<c:if test="${ not empty QnAItem.answer }">
							<div class="row border-bottom tr">
								<div class="col-4 th">답변</div>
								<div class="col-8 td">
									${ QnAItem.answer }
								</div>
							</div>
						</c:if>
					</c:if>
					<div class="row tr">
						<div class="col-12 td text-end">
							<c:if test="${ userLoginInfo.isAdmin eq 'Y' }">
								<c:if test="${ not empty QnAItem.answer }">
									<button class="btn" type="button" style="background:#00AAB2; color:#fff;" onclick="alert('준비중입니다.');">수정</button>
								</c:if>
								<c:if test="${ empty QnAItem.answer }">
									<button class="btn" type="button" style="background:#00AAB2; color:#fff;" onclick="Answer()">답변</button>
								</c:if>
								<button class="btn" type="button" style="background:#00AAB2; color:#fff;" onclick="location.href='${path}/admin/admin_qna.do'">관리 목록</button>
							</c:if>
							<c:if test="${ userLoginInfo.isAdmin ne 'Y' }">
								<button class="btn" type="button" style="background:#00AAB2; color:#fff;" onclick="location.href='${path}/customer/QnADel.do?qidx=<%=request.getParameter("qidx")%>'">삭제</button>
								<button class="btn" type="button" style="background:#00AAB2; color:#fff;" onclick="location.href='${path}/customer/QnAList.do'">목록</button>
							</c:if>
						</div>
					</div>
				</div>	
			</div>
		</div>
		<!-- 푸터는 고정 -->
		<%@ include file="/WEB-INF/views/common/footer.jsp" %>
		<!-- 푸터 수정 하지마시오 링크 걸어야하면 공동작업해야하므로 팀장에게 말할것! -->	
	</div>
</body>
</html>
