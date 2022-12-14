<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1, minimum-scale=1">
<title>글쓰기 페이지</title>
<!-- include libraries(jQuery, bootstrap) -->
    <script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
   	<script src="${ path }/js/bootstrap.js"></script>
	<script src="${ path }/js/common/common.js"></script>

<!-- 지도 API - 필요없으면 지워도 됨 -->
	<script type='text/javascript' src='https://sgisapi.kostat.go.kr/OpenAPI3/auth/javascriptAuth?consumer_key=9ff16331dfd542b6a5b0'></script>	
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ad11d9178deb7b571198c476ec55ad0f&libraries=services"></script>
	<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<!-- 지도 API -->
<!-- 써머노트 -->
<link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.js"></script>

<!-- 스타일 시트는 여기에 추가로 작성해서 사용 -->
	
	<link href="${ path }/css/bootstrap.css" rel="stylesheet" type="text/css" />
	<link href="${ path }/css/offcanvas.css" rel="stylesheet" type="text/css" />
	<link href="${ path }/css/common/layout.css" rel="stylesheet" type="text/css" />
	<!-- include summernote css/js-->

<!-- path는 request.getContextPath()를 가져온것. -->

<style>
    
#file{
	width: 100%;

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

html{

width : 100%;

}

body {


}






</style>
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
<script>
	$(function(){
		$("#keyword").keydown(function(e){
			if(e.keyCode == 13){
				searchPlaces();
				return false;
			}
		});
	});
	<c:if test="${ empty userLoginInfo.location_auth}">
		<c:if test="${userLoginInfo.isAdmin ne 'Y' }">
			alert("동네설정이 필요한 서비스 입니다.");
			location.href="${path}/user/locationAuth.do";
		</c:if>
	</c:if>
</script>
</head>
<body>

<div class="wrapper">
		<!-- 헤더 및 메뉴 -->
		<%@ include file="/WEB-INF/views/common/header.jsp" %>
		<!-- 메뉴는 수정이 필요하면 헤더를 복사해서 메뉴명, 링크만 수정해서 사용할것! -->
	<div class="wrapper main">
		<div class="container">
		
			
				<h3 class="border-bottom" style="padding:1rem; margin:0px;">글 쓰기</h3>
		
				<form action="BoardWrite.do" method="post" enctype="multipart/form-data" id="frm" >
					<input type="hidden" name="uidx" value="${uidx}">
					<c:if test="${ pm.board_type eq 'notice' }">
						<input type="hidden" name="Location" value="notice">
					</c:if>
					<c:if test="${ pm.board_type ne 'notice' }">
						<input type="hidden" name="Location" value="${userLoginInfo.location_auth}">
					</c:if>
					
				
					<div class="row border-bottom tr">
						<div class="col-4 th" style="display:table-cell;">제목</div>
						<div class="col-8 td" style="display:table-cell;">
							<input type="text" class="form-control" name="Title" id="Title" placeholder="제목을 입력해주세요">
						</div>
					</div>
					
					<div class="row border-bottom tr">
						<div class="col-4 th" style="display:table-cell;">게시판 분류</div>
						<div class="col-8 td" style="display:table-cell;">
							<c:if test="${ pm.board_type eq 'notice' }"> 
								공지사항 
								<input type="hidden" name="board_type" id="board_type" value="notice">
							</c:if>
							<c:if test="${ pm.board_type ne 'notice' }">
								<select name="board_type" onchange="javascript:locationMap(this);" id="board_type">
									<option value="free" <c:if test="${ pm.board_type eq 'free' }"> selected </c:if>>일상&amp;소통</option>
									<option value="job" <c:if test="${ pm.board_type eq 'job' }"> selected </c:if>>구인구직</option>
									<option value="meeting" <c:if test="${ pm.board_type eq 'meeting' }"> selected </c:if>>모임</option>
									<option value="hotplace" <c:if test="${ pm.board_type eq 'hotplace' }"> selected </c:if>>핫플레이스</option>
								</select>
							</c:if>
						</div>
					</div>
					
					<div class="row border-bottom tr">
						<div class="col-4 th" style="display:table-cell;">내용</div>
						<div class="col-8 td" style="display:table-cell;">
							<textarea class="form-control" id="summernote" name="contents" rows="10" cols="25"></textarea>
							<div class="contet_count" style="float:right;"></div>
							
						</div>
					</div>
					
					<div class="row border-bottom tr">
						<div class="col-4 th" style="display:table-cell;">첨부 파일</div>
						
						<div id="boxWrap" class="col-8 td" style="display:table-cell;">
							<div class="d-flex" style=" width:100%;">
								<div style="flex:1">
									<input class="form-control" type="file" id="file" name="FileName1" accept='image/jpeg,image/gif,image/png' onchange='chk_file_type(this)'>
								</div>
								<div>
									<button type="button" class="btn" id="file_btn">추가</button>
								</div>
							</div>
							
						</div>
					</div>
					
					
					<c:if test="${ pm.board_type ne 'notice' }">
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
					</c:if>
					
					
					<div id="clickLatlng"></div>
					
					<div class="text-end tr">
						<div class="td">
							<button class="btn" type="button" id="write"style="background:#00AAB2; color:#fff;" onclick="check()">작성</button>
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

<script>
//마커를 담을 배열입니다
var markers = [];

var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = { 
        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };

var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
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
                 
      itemStr += '  <span class="tel">' + places.phone  + '</span></div>';           

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
 
 
 

	
	
		
	
 
</script>




<script>


$(document).ready(function() {
	var i=2; // 변수설정은 함수의 바깥에 설정!
  $("#file_btn").click(function() {
    if(i<=5){
    	
    	$("#boxWrap").append("<input class='form-control' type='file' name='FileName"+i+"' accept='image/jpeg,image/gif,image/png' onchange='chk_file_type(this)'>");
    }
    
    i++;
    
    if(i==6){
    	$("#file_btn").css("display","none");
    }
   
    

  });
});

function chk_file_type(obj) {
    var file_kind = obj.value.lastIndexOf('.');
    var file_name = obj.value.substring(file_kind+1,obj.length); 
    var file_type = file_name.toLowerCase();



   var check_file_type = new Array();
    check_file_type=['jpg','gif','png','jpeg','bmp',];



    if(check_file_type.indexOf(file_type)==-1){
     alert('이미지 파일만 선택할 수 있습니다.');
     var parent_Obj=obj.parentNode
     var node=parent_Obj.replaceChild(obj.cloneNode(true),obj);
     return false;
     
     }
    
}



</script>
<script>

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


	
	if(${uidx == null}){
		alert("로그인 이후 이용해주세요");
		location.href="/anna/user/login.do";
	}


        
		
var title = $("#Title").val();
		
	function check(){
		
		var title = $("#Title").val();
		
		if(title == ""){
			alert("제목을 입력하세요");
			$("#Title").focus();
			
		}else if($("#board_type").val()==""){
			alert("게시글 분류를 선택해주세요");
			$("#board_type").focus();
		}else if($("#summernote").val()==""){
			alert("내용을 입력하세요");
			$("#summernote").focus();
			
		}else{
			
			$("#frm").submit();
			
		}
	
	}
		
    
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