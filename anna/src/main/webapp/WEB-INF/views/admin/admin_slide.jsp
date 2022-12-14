<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true"%>
<%@ page language="java" contentType="text/html; charset=utf-8"    pageEncoding="utf-8"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<%@page session="true" %>

<head>
<meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
<title>이벤트배너 설정</title>

		<link href="https://cdn.jsdelivr.net/npm/simple-datatables@latest/dist/style.css" rel="stylesheet" />
        <link href="<%=request.getContextPath()%>/css/admin_user.css" rel="stylesheet" />
        <script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js" crossorigin="anonymous"></script>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
		<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
        
        <style>
           .col-md-10 {
            padding-top: 90px;
            margin-bottom: 60px;           
     	    margin-left: 200px;
           }
           
           tbody > tr > th {
           font-size : 14px;
           	font-weight : normal;
           	text-align: center;           		
           
           }
           
           .btn {
           		line-height: 0.65;
           		font-size: 0.85rem;
           		height : 30px;
           }
           
  			.dataTable-table > tbody > tr > th {
  				vertical-align: middle;
  			}
  			.card-body {
					padding-left: 50px;
					padding-right: 50px;
				}
           

        </style>
        
        
        <!-- 관리자 정보 메뉴  -->
<style type="text/css">

			#modal {
				position: fixed;
				width: 100%;
				height: 100%;
				background: rgba(0, 0, 0, 0.5);
				top: 0;
				left: 0;
				z-index: 99;
				display: none;
			}

			#banner_online {
			    height: 700px;
  			    width: 503px;
				border: 1px solid black;
				box-shadow: 3px 3px 7px 1px grey;
				background-color: white;
				z-index: 9999;
				margin-left: -50%;
				margin-top: -18%;
				display: none;
				position: fixed;
			}
			
			#banner_online h1 {
			    font-weight: bold;
				text-align: center;
				font-size: 20px;
				margin: 43px -12px 28px auto;
			}
			
			#banner_online p .second {
				margin-left: 6px;
			}
			
			.pop_content {
				font-size: 13px;
				margin-left: 80px;
  				margin-right: 80px;
				text-align: center;
			}
			
			#banner_online_how {
				height: 78px;
				width: 444px;
				margin-left: 28px;
				border: 1px solid #82bf77;
				margin-top: 22px;
			}
			
			#banner_online_how h3 {
				font-size: 12px;
				margin-left: 6px;
				margin-top: 16px;
			}
			
			.p_bottom {
				margin-left: 30px;
			}
			
			
			#modal_list > table > tr > td{
				width : 30px;			
				border-bottom: 1px solid #cdd0d4;	
				
			}
			
			#td_line {
			border-bottom: 1px solid #cdd0d4;	
			}
			
			.form-select-sm {

			    width: 83px;
			}
			
			#menu_box {
				display: flex;
				padding : ;
				position: relative;
  				left: 52px;
  				margin : 30 0 10 0;
  				

			}
			#close_button {
				width: 83px;
				height : 31px;				
			}
			
			#test_button {
				width: 95px;
				height : 31px;				
			}
			
			.form-select form-select-sm{
				border:1px solid #3881B4;
			}
			
			#slide_write{
				
			}
			
			.form-select {
				width :75px;				
				margin-left: auto; margin-right: auto;
			}
			
</style>


 

</head>
<body>


</head>
    <body class="sb-nav-fixed">
        <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
            <!-- Navbar Brand-->
            <a class="navbar-brand ps-3" href="../admin/admin_user.do">관리자페이지</a>
            <!-- Sidebar Toggle-->
            
            <h5 style="color:#fff; margin-left:1550px; cursor:pointer;" onclick="javascript:location.href='<%=request.getContextPath()%>/';">HOME</h5> 

            
        </nav>
        <div id="layoutSidenav">
            <div id="layoutSidenav_nav">
                <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
                    <div class="sb-sidenav-menu">
                        <div class="nav">
                            <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapseLayouts" aria-expanded="false" aria-controls="collapseLayouts">
                                <div class="fas fa-user-friends"><i class=" "></i></div>
                                &nbsp;회원관리
                                <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                            </a>
                            <div class="collapse" id="collapseLayouts" aria-labelledby="headingOne" data-bs-parent="#sidenavAccordion">
                                <nav class="sb-sidenav-menu-nested nav">
                                    <a class="nav-link"  href="../admin/admin_user.do">회원리스트</a>
                                    <a class="nav-link" href="../admin/admin_report.do">신고리스트</a>
                                </nav>
                            </div>
                            <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapsePages" aria-expanded="false" aria-controls="collapsePages">
                                <div class="sb-nav-link-icon"><i class="fas fa-book-open"></i></div>
                                사이트 관리
                                <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                            </a>
                            <div class="collapse" id="collapsePages" aria-labelledby="headingTwo" data-bs-parent="#sidenavAccordion">
                                <nav class="sb-sidenav-menu-nested nav accordion" id="sidenavAccordionPages">
                                   <a class="nav-link collapsed" href="../admin/admin_boarditem.do">판매글 관리</a>
                                   <a class="nav-link collapsed" href="../admin/admin_qna.do">문의사항</a>
                                   <a class="nav-link collapsed" href="../admin/admin_notice.do">공지사항</a>
                                   <a class="nav-link collapsed" href="../admin/admin_board.do">커뮤니티</a>
                                   <a class="nav-link collapsed" href="../admin/admin_slide.do" >이벤트 배너 설정</a>
                                </nav>
                            </div>
                </nav>
            </div>



            <div id="layoutSidenav_content"> 
                <main>
                <div class="container-fluid px-4">
           <!-- 검색 -->
					<div class="container">
						<div class="d-md-none d-lg-block d-xl-block">
					    <div class="row">
					        <div class="col-md-1 col-sm-0"></div>
					        <div class="col-md-10  col-sm-12" >
                                <h6 style="font-weight:bold">⚫️ 이벤트 배너 설정   &nbsp;&nbsp;ex)</h6>
                                <br>
                                 <div id="slide_write">
						          	<img src="../images/admin_slide_img.png" width=" 80%">
						         </div>

					        
					        </div>
					        <div class="col-md-1 col-sm-0"></div>
					    </div>
					    </div>
					    </div>	
                        </div>
				  	<!-- 검색 -->
          	
          						
                            <div class="card mb-4">
                                <div class="card-body">
                                <button type="button" class="btn " style="float: right; background-color: #00AAB2; color: #fff;" onclick="javascript:location.href='<%=request.getContextPath()%>/admin/admin_slideWrite.do'" style="font-size: 14px;">등록</button>
                                    <table id="datatablesSimple">
                                        <thead>
                                            <tr>
                                                <th>No</th>
                                                <th>배너 적용 이미지</th>
                                                <th>링크</th>
                                                <th>시작일</th>
                                                <th>종료일</th>
                                                <th>첨부파일</th>
                                                <th>삭제</th>

                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr >
                                                <th>
                                                  <select class="form-select" aria-label="Default select example">
												  <option selected>1</option>
												  <option value="1">2</option>
												  <option value="2">3</option>
												</select></th>
                                                <th><img src="../images/admin_slide_ex.png"></th>
                                                <th>/board/boardlest.do</th>
                                                <th>2022-07-25</th>
                                                <th>2022-08-31</th>
                                                <th>
                                                 asdfcas.jpg
												    </th>
                                              	<th>
                                             		   <button type="button" id="openModalPop" class="btn " style="background-color: #E51D21; color: #fff;"  style="font-size: 14px;">삭제</button></th>
                                                </tr>
                                                
                                               
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </main>
                    </div>
                   


                
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="<%=request.getContextPath()%>/js/admin_user.js"></script>
        <script src="<%=request.getContextPath()%>/js/simple-datatables@latest.js"></script>

        <script src="<%=request.getContextPath()%>/js/admin_user2.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
        
    </body>
</html>