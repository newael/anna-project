<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1, minimum-scale=1">
<title>수정하기</title>

    <script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
   	<script src="${ path }/js/bootstrap.js"></script>
	<script src="${ path }/js/common/common.js"></script>
	
		<script type='text/javascript' src='https://sgisapi.kostat.go.kr/OpenAPI3/auth/javascriptAuth?consumer_key=9ff16331dfd542b6a5b0'></script>	
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ad11d9178deb7b571198c476ec55ad0f&libraries=services"></script>
	<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<!-- 써머노트 -->
<link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.js"></script>

    
<!-- 스타일 시트는 여기에 추가로 작성해서 사용 -->
	
	<link href="${ path }/css/bootstrap.css" rel="stylesheet" type="text/css" />
	<link href="${ path }/css/offcanvas.css" rel="stylesheet" type="text/css" />
	<link href="${ path }/css/common/layout.css" rel="stylesheet" type="text/css" />
<style>

.map_wrap, .map_wrap * {margin:0;padding:0;font-family:'Malgun Gothic',dotum,'돋움',sans-serif;font-size:12px;}
.map_wrap a, .map_wrap a:hover, .map_wrap a:active{color:#000;text-decoration: none;}
.map_wrap {position:relative;width:100%;height:500px;}
#menu_wrap {position:absolute;top:0;left:0;bottom:0;width:250px;margin:10px 0 30px 10px;padding:5px;overflow-y:auto;background:rgba(255, 255, 255, 0.7);z-index: 1;font-size:12px;border-radius: 10px;}
.bg_white {background:#fff;}
#menu_wrap hr {display: block; height: 1px;border: 0; border-top: 2px solid #5F5F5F;margin:3px 0;}
#menu_wrap .option{text-align: center;}
#menu_wrap .option p {margin:10px 0;}  
#menu_wrap .option button {margin-left:5px;}
#placesList li {list-style: none;}
#placesList .item {position:relative;border-bottom:1px solid #888;overflow: hidden;cursor: pointer;min-height: 65px;}
#placesList .item span {display: block;margin-top:4px;}
#placesList .item h5, #placesList .item .info {text-overflow: ellipsis;overflow: hidden;white-space: nowrap;}
#placesList .item .info{padding:10px 0 10px 55px;}
#placesList .info .gray {color:#8a8a8a;}
#placesList .info .jibun {padding-left:26px;background:url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_jibun.png) no-repeat;}
#placesList .info .tel {color:#009900;}
#placesList .item .markerbg {float:left;position:absolute;width:36px; height:37px;margin:10px 0 0 10px;background:url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png) no-repeat;}
#placesList .item .marker_1 {background-position: 0 -10px;}
#placesList .item .marker_2 {background-position: 0 -56px;}
#placesList .item .marker_3 {background-position: 0 -102px}
#placesList .item .marker_4 {background-position: 0 -148px;}
#placesList .item .marker_5 {background-position: 0 -194px;}
#placesList .item .marker_6 {background-position: 0 -240px;}
#placesList .item .marker_7 {background-position: 0 -286px;}
#placesList .item .marker_8 {background-position: 0 -332px;}
#placesList .item .marker_9 {background-position: 0 -378px;}
#placesList .item .marker_10 {background-position: 0 -423px;}
#placesList .item .marker_11 {background-position: 0 -470px;}
#placesList .item .marker_12 {background-position: 0 -516px;}
#placesList .item .marker_13 {background-position: 0 -562px;}
#placesList .item .marker_14 {background-position: 0 -608px;}
#placesList .item .marker_15 {background-position: 0 -654px;}
#pagination {margin:10px auto;text-align: center;}
#pagination a {display:inline-block;margin-right:10px;}
#pagination .on {font-weight: bold; cursor: default;color:#777;}
</style>

<style>

.file{

width : calc(100% - 50px);

}
    

.viewimg{

display : none;
position: fixed;
    top: 36%;
    left: 37%;
    z-index: 3;

}

.viewimg2{

display : none;
position: fixed;
    top: 36%;
    left: 37%;
 z-index: 3;
}
.viewimg3{

display : none;
position: fixed;
    top: 36%;
    left: 37%;
 z-index: 3;
}
.viewimg4{

display : none;
position: fixed;
    top: 36%;
    left: 37%;
 z-index: 3;
}
.viewimg5{

display : none;
position: fixed;
    top: 36%;
    left: 37%;
 z-index: 3;
}


.th {
	background:#eee;
	text-align:center;
	vertical-align:middle;
}
.th, .td{
	padding:10px;
}

.tr{
	display:table; 
	width:100%;
}

    
</style>

</head>
<body style="overflow-y: hidden;">

<div class="wrapper">
		<!-- 헤더 및 메뉴 -->
		<%@ include file="/WEB-INF/views/common/header.jsp" %>
		<!-- 메뉴는 수정이 필요하면 헤더를 복사해서 메뉴명, 링크만 수정해서 사용할것! -->
		
		<div class="wrapper  main">
			<div class="container" >
				<h3 class="border-bottom" style="padding:1rem; margin:0px;">글 수정</h3>
		
				<form action="BoardModify.do" method="post" enctype="multipart/form-data" id="frm">
					<input type="hidden" name="Location" value="${userLoginInfo.location_auth}">
					<input type="hidden" name="Bidx" value="${bv.bidx }">
					<div class="row border-bottom tr">
						<div class="col-4 th" style="display:table-cell;">제목</div>
						<div class="col-8 td" style="display:table-cell;">
							<input type="text" class="form-control" id="Title" name="Title" placeholder="제목을 입력해주세요" value="${bv.title}">
						</div>
					</div>
					
					<div class="row border-bottom tr">
						<div class="col-4 th" style="display:table-cell;">게시판 분류</div>
						<div class="col-8 td" style="display:table-cell;">
							<select name="board_type" onchange="javascript:locationMap(this);" id="board_type">
								<option value="free" <c:if test="${ bv.board_type eq 'free' }"> selected </c:if>>일상&amp;소통</option>
								<option value="job" <c:if test="${ bv.board_type eq 'job' }"> selected </c:if>>구인구직</option>
								<option value="meeting" <c:if test="${ bv.board_type eq 'meeeting' }"> selected </c:if>>모임</option>
								<option value="hotplace" <c:if test="${ bv.board_type eq 'hotplace' }"> selected </c:if>>핫플레이스</option>
							</select>
						</div>
					</div>
					
					<div class="row border-bottom tr">
						<div class="col-4 th" style="display:table-cell;">내용</div>
						<div class="col-8 td" style="display:table-cell;">
							<textarea class="form-control" id="summernote" name="contents" rows="10" cols="25">${bv.contents }</textarea>
							<div class="contet_count" style="float:right;"></div>
						</div>
					</div>
					
					<div class="row border-bottom tr">
						<div class="col-4 th" style="display:table-cell;">첨부 이미지 파일</div>
						<div id="boxWrap" class="col-8 td" style="display:table-cell;">
							<c:if test="${bv.image1 != null}">
								<span class="view">${bv.image1}</span><br>
							</c:if>
							<c:if test="${bv.image2 != null}">
								<span class="view2">${bv.image2}</span><br>
								
							</c:if>
							<c:if test="${bv.image3 != null}">
								<span class="view3">${bv.image3}</span><br>
							</c:if>
							<c:if test="${bv.image4 != null}">
								<span class="view4">${bv.image4}</span><br>
								
							</c:if>
							<c:if test="${bv.image5 != null}">
								<span class="view5">${bv.image5}</span>
								
							</c:if>
	
						</div>
					</div>
					<%-- <div class="row border-bottom tr">
						<div class="col-4 th" style="display:table-cell;">기존 이미지 파일</div>
						<div id="carouselExampleControls" class="carousel slide" style="width:auto;" data-bs-ride="carousel">
							  <div class="carousel-inner">
							  <c:if test="${bv.image1 != null}">
							    <div class="carousel-item active">
							      <img src="../resources/upload/${bv.image1}" class="d-block " alt="..." style="max-width:auto;height:auto;">
							    </div>
						 	 </c:if>
						 	  <c:if test="${bv.image2 != null}">
							    <div class="carousel-item">
							      <img src="../resources/upload/${bv.image2}" class="d-block" alt="..." style="max-width:auto;height:auto">
							    </div>
							  </c:if>
							  <c:if test="${bv.image3 != null}">
							    <div class="carousel-item">
							      <img src="../resources/upload/${bv.image3}" class="d-block" alt="..." style="max-width:auto;height:auto">
							    </div>
							  </c:if>
							  <c:if test="${bv.image4 != null}">
							    <div class="carousel-item">
							      <img src="../resources/upload/${bv.image4}" class="d-block" alt="..." style="max-width:auto;height:auto">
							    </div>
							  </c:if>
							  <c:if test="${bv.image5 != null}">
							    <div class="carousel-item">
							      <img src="../resources/upload/${bv.image5}" class="d-block " alt="..." style="max-width:auto;height:auto">
							    </div>
							  </c:if>  
							  </div>
							  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleControls" data-bs-slide="prev">
							    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
							    <span class="visually-hidden">Prev</span>
							  </button>
							  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleControls" data-bs-slide="next">
							    <span class="carousel-control-next-icon"  aria-hidden="true"></span>
							    <span class="visually-hidden">Next</span>
							  </button>
							</div>
						

					
					</div> --%>
					
					

					<div class="map_wrap">
					    <div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>
					
					    <div id="menu_wrap" class="bg_white">
					        <div class="option">
					            <div>
					                
					                    키워드 : <input type="text" value="" id="keyword" size="15"> 
					                    <button type="button" onclick="searchPlaces(); return false;">검색하기</button> 
					                
					            </div>
					        </div>
					        <hr>
					        <ul id="placesList"></ul>
					        <div id="pagination"></div>
					    </div>
					</div>
					
					
					<div id="clickLatlng"></div>
					<input type="hidden" class="boardtype" value="${bv.board_type}">
					<input type="hidden" id="place_location" name="original_place_location" value="${bv.place_location}">
					<div class="text-end tr">
						<div class="td">
							<button class="btn" style="background:#00AAB2; color:#fff;" onclick="check()">수정</button>
							<button class="btn" style="background:#00AAB2; color:#fff;" type="button" onclick="history.back();">취소</button>
						</div>
					</div>
					
				</form>
						
				
			</div>
		</div>




		
		<!-- 푸터는 고정 -->
		<%@ include file="/WEB-INF/views/common/footer.jsp" %>
		<!-- 푸터 수정 하지마시오 링크 걸어야하면 공동작업해야하므로 팀장에게 말할것! -->		
	</div>

<script type="text/javascript">

//카카오맵 API

console.log($("#place_location").val());



//마커를 담을 배열입니다
var markers = [];

if($("#place_location").val() == ''){
	var x = 33.450701;
	var y = 126.570667;

}else{
	var xy = $("#place_location").val().split(',');
	
	x= xy[0];
	y= xy[1];
	
	
}




var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {

 		center: new kakao.maps.LatLng(x,y), //지도의 중심좌표
        level: 5 // 지도의 확대 레벨
        
        
    };
console.log(mapOption);


var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

if($("#place_location").val() != ''){
	var marker = new kakao.maps.Marker({ 
	    // 지도 중심좌표에 마커를 생성합니다 
	    position: map.getCenter() 
	});
	
		marker.setMap(map);
		markers.push(marker);
}
//장소 검색 객체를 생성합니다
var ps = new kakao.maps.services.Places();

//검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
var infowindow = new kakao.maps.InfoWindow({zIndex:1});

searchPlaces();


//키워드 검색을 요청하는 함수입니다
function searchPlaces() {

    var keyword = document.getElementById('keyword').value;

    if (!keyword.replace(/^\s+|\s+$/g, '')) {
        
        return false;
    }

    // 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
    ps.keywordSearch( keyword, placesSearchCB); 
}

// 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
function placesSearchCB(data, status, pagination) {
    if (status === kakao.maps.services.Status.OK) {

        // 정상적으로 검색이 완료됐으면
        // 검색 목록과 마커를 표출합니다
        displayPlaces(data);

        // 페이지 번호를 표출합니다
        displayPagination(pagination);

    } else if (status === kakao.maps.services.Status.ZERO_RESULT) {

        alert('검색 결과가 존재하지 않습니다.');
        return;

    } else if (status === kakao.maps.services.Status.ERROR) {

        alert('검색 결과 중 오류가 발생했습니다.');
        return;

    }
}

// 검색 결과 목록과 마커를 표출하는 함수입니다
function displayPlaces(places) {
	
	

    var listEl = document.getElementById('placesList'), 
    menuEl = document.getElementById('menu_wrap'),
    fragment = document.createDocumentFragment(), 
    bounds = new kakao.maps.LatLngBounds(), 
    listStr = '';
    
    // 검색 결과 목록에 추가된 항목들을 제거합니다
    removeAllChildNods(listEl);

    // 지도에 표시되고 있는 마커를 제거합니다
    removeMarker();
    
    for ( var i=0; i<places.length; i++ ) {

        // 마커를 생성하고 지도에 표시합니다
        var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x),
            marker = addMarker(placePosition, i), 
            itemEl = getListItem(i, places[i]); // 검색 결과 항목 Element를 생성합니다
            
             

        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
        // LatLngBounds 객체에 좌표를 추가합니다
        bounds.extend(placePosition);

        // 마커와 검색결과 항목에 mouseover 했을때
        // 해당 장소에 인포윈도우에 장소명을 표시합니다
        // mouseout 했을 때는 인포윈도우를 닫습니다
        (function(marker, title) {
            kakao.maps.event.addListener(marker, 'mouseover', function() {
                displayInfowindow(marker, title);
                
            });

            kakao.maps.event.addListener(marker, 'mouseout', function() {
                infowindow.close();
            });
            
            kakao.maps.event.addListener(marker, 'click', function(){
            	
            	
            	var x = marker.getPosition().Ma;
            	var y = marker.getPosition().La;
            		
            	console.log(title);
            	
            	console.log(x,y);
            	
            	var html ="<input type='hidden' id='place_location' name='place_location' value='"+x+","+y+"'>"
            	html += "<input type='hidden' id='place_name' name='place_name' value='"+title+"'>"
            	
            	 $("#clickLatlng").html(html);
            	
            	removeMarker();
            	
            	
            	var cmarker = new kakao.maps.Marker();
            	

            		 cmarker.setPosition(new kakao.maps.LatLng(x,y));
            		 
            		 
            		 
            		 cmarker.setMap(map);
            		 
            		 markers.push(cmarker);

            });

            itemEl.onmouseover =  function () {
                displayInfowindow(marker, title);
                
            };

            itemEl.onmouseout =  function () {
                infowindow.close();
            };
            
            itemEl.onclick = function(){
            	
            	
            	console.log(marker.getPosition());

            	
            	var x = marker.getPosition().Ma;
            	var y = marker.getPosition().La;
            	
            	
            	
            	console.log(x,y);
            	
            	var html ="<input type='hidden' id='place_location' name='place_location' value='"+x+","+y+"'>"
            	html += "<input type='hidden' id='place_name' name='place_name' value='"+title+"'>"
            	
            	 $("#clickLatlng").html(html);
            	
            	removeMarker();
            	
            	
            	var cmarker = new kakao.maps.Marker();

            		 
            		 cmarker.setPosition(new kakao.maps.LatLng(x,y));
            		 
            		 
            		 
            		 cmarker.setMap(map);
            		 
            		 markers.push(cmarker);
            		  
            };
            
           
        })(marker, places[i].place_name);

        fragment.appendChild(itemEl);
        
        
        
        
    }

    // 검색결과 항목들을 검색결과 목록 Element에 추가합니다
    listEl.appendChild(fragment);
    menuEl.scrollTop = 0;

    // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
    map.setBounds(bounds);
    
    
    

}

// 검색결과 항목을 Element로 반환하는 함수입니다
function getListItem(index, places) {


    var el = document.createElement('li'),
    itemStr = '<span class="markerbg marker_' + (index+1) + '"></span>' +
                '<div class="info">' +
                '   <h5>' + places.place_name + '</h5>';

    if (places.road_address_name) {
        itemStr += '    <span>' + places.road_address_name + '</span>' +
                    '   <span class="jibun gray">' +  places.address_name  + '</span>';
    } else {
        itemStr += '    <span>' +  places.address_name  + '</span>'; 
    }
                 
      itemStr += '  <span class="tel">' + places.phone  + '</span>' + '<span></div>';           

    el.innerHTML = itemStr;
    el.className = 'item';
    
    

    return el;
}



// 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
function addMarker(position, idx, title) {
    var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
        imageSize = new kakao.maps.Size(36, 37),  // 마커 이미지의 크기
        imgOptions =  {
            spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
            spriteOrigin : new kakao.maps.Point(0, (idx*46)+10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
            offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
        },
        markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
            marker = new kakao.maps.Marker({
            position: position, // 마커의 위치
            image: markerImage 
        });

    marker.setMap(map); // 지도 위에 마커를 표출합니다
    markers.push(marker);  // 배열에 생성된 마커를 추가합니다

    return marker;
}

// 지도 위에 표시되고 있는 마커를 모두 제거합니다
function removeMarker() {
    for ( var i = 0; i < markers.length; i++ ) {
        markers[i].setMap(null);
        
    }   
    markers = [];
}

// 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
function displayPagination(pagination) {
    var paginationEl = document.getElementById('pagination'),
        fragment = document.createDocumentFragment(),
        i; 

    // 기존에 추가된 페이지번호를 삭제합니다
    while (paginationEl.hasChildNodes()) {
        paginationEl.removeChild (paginationEl.lastChild);
    }

    for (i=1; i<=pagination.last; i++) {
        var el = document.createElement('a');
        el.href = "#";
        el.innerHTML = i;

        if (i===pagination.current) {
            el.className = 'on';
        } else {
            el.onclick = (function(i) {
                return function() {
                    pagination.gotoPage(i);
                }
            })(i);
        }

        fragment.appendChild(el);
    }
    paginationEl.appendChild(fragment);
}

// 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
// 인포윈도우에 장소명을 표시합니다
function displayInfowindow(marker, title) {
    var content = '<div style="padding:5px;z-index:1;">' + title + '</div>';

    infowindow.setContent(content);
    infowindow.open(map, marker);
    
    
    
}

 // 검색결과 목록의 자식 Element를 제거하는 함수입니다
function removeAllChildNods(el) {   
    while (el.hasChildNodes()) {
        el.removeChild (el.lastChild);
    }
}
 


// 유효성 검사

var title = $("#Title").val();

function check(){
	
	var title = $("#Title").val();
	
	if(title == ""){
		alert("제목을 입력하세요");
		$("#Title").focus();
		return false;
	}
	else if($("#board_type").val()==""){
		alert("게시글 분류를 선택해주세요");
		$("#board_type").focus();
		return false;
	}else if($("#summernote").val()==""){
		alert("내용을 입력하세요");
		$("#summernote").focus();
		return false;
	}else{
		
		$("#frm").submit();
	}
	

}


//카카오맵 온/오프

var board_type = $("#board_type").val();

if(board_type != 'free'){

	$(".map_wrap").css("display","block")

}else if(board_type == 'free'){
	
	$(".map_wrap").css("display","none")
}

function locationMap(obj){
	
	var board_type = $("#board_type option:selected").val();
	
	if(board_type != 'free'){
		$(".map_wrap").css("display","block")

	}else if(board_type == 'free'){
		$(".map_wrap").css("display","none")
	}
}

//로그인 확인

if(${uidx == null}){
	alert("로그인 이후 이용해주세요");
	location.href="/anna/user/login.do";
}


//써머노트
$(document).ready(function () {
	
	 
    //위와 같이 값을 먼저 넣어준 후 초기화를 시킨다. 그럼 아래와 같이 입력이 된다.
    //초기화
	$('#summernote').summernote({
        height : 400, // set editor height
        minHeight : null, // set minimum height of editor
        maxHeight : null, // set maximum height of editor
        focus : true,
        lang : 'ko-KR', // 기본 메뉴언어 US->KR로 변경
        popover: {         //팝오버 설정
			image: [], //이미지 삭제
			link: [],  //링크 삭제
			air: []
	      },

        callbacks: {
               onChange: function(contents, $editable) {
                 console.log('onChange:', contents, $editable);
                 console.log(contents.length+"글자수");
                 
                 $('.contet_count').html("("+$(this).val().length+" / 500)"); //클래스 안에 0 / 500 출력
                
                 if($(this).val().length > 500) {
                    $(this).val($(this).val().substring(0, 500)); //500자가 넘으면 500자 까지 잘라냄
                    alert("내용은 최대 500자 까지 입력 가능합니다.");
                    $('.contet_count').html("(500 / 500)"); //500자 라고 출력
                }

             }
           }
     });
    
	
});



	

</script>


</body>
</html>