<%@page import="board.qna.QnaBoardDto"%>
<%@page import="board.qna.QnaBoardDao"%>
<%@page import="java.util.List"%>
<%@page import="member.MemberDao"%>
<%@page import="member.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>Insert title here</title>
	<script src="https://code.jquery.com/jquery-13.6.3.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
	<script src="https://kit.fontawesome.com/2663817d27.js" crossorigin="anonymous"></script>
	<script src="https://code.highcharts.com/highcharts.js"></script>
	<script src="https://code.highcharts.com/modules/series-label.js"></script>
	<style>
		<!-- 차트 -->
		.highcharts-figure, .highcharts-data-table table {
		    min-width: 320px;
		    max-width: 800px;
		    margin: 1em auto;
		}
		
		.highcharts-data-table table {
		    font-family: Verdana, sans-serif;
		    border-collapse: collapse;
		    border: 1px solid #ebebeb;
		    margin: 10px auto;
		    text-align: center;
		    width: 100%;
		    max-width: 500px;
		}
		
		.highcharts-data-table caption {
		    padding: 1em 0;
		    font-size: 1.2em;
		    color: #555;
		}
		
		.highcharts-data-table th {
		    font-weight: 600;
		    padding: 0.5em;
		}
		
		.highcharts-data-table td,
		.highcharts-data-table th,
		.highcharts-data-table caption {
		    padding: 0.5em;
		}
		
		.highcharts-data-table thead tr,
		.highcharts-data-table tr:nth-child(even) {
		    background: #f8f8f8;
		}
		
		.highcharts-data-table tr:hover {
		    background: #f1f7ff;
		}
		
		input[type="number"] {
		    min-width: 50px;
		}

		<!-- -->
		.rectangle {
			
			width:500px;
			height: 500px;
		}
		.rectangle_b {
			
			width:1000px;
			height: 500px;
		}
		
		.moreBtn {
			margin-right:10px;
			margin-left: auto;
		}
		
		table {
			table-layout:fixed;
			text-overflow: ellipsis;
			max-width: 500px;
			white-space: nowrap;
		}
		
		.a-tag {
			color: black;
		}
		
		.a-tag:hover{
			color: black;
		}
		
		.highcharts-credits {
		 display: none;
		}
	</style>
</head>
<body>
<%
	MemberDao mdao = new MemberDao();
	List<MemberDto> userList = mdao.getAllUserList();
	
	//Qna
	QnaBoardDao qnaDao = new QnaBoardDao();
	List<QnaBoardDto> qnaList = qnaDao.getAnswerPendingQList();
	
	// 유저 지역 분포
	int totalUsercount = userList.size();
	/*
	int gangwon = 0;
	int gyeonggi=0;
	int gyeongnam=0;
	int gyeongbuk = 0;
	int gwangju = 0;
	int daegu = 0;
	int daejeon = 0;
	int busan=0;
	int seoul=0;
	int sejong=0;
	int ulsan=0;
	int incheon=0;
	int jeonnam=0;
	int jeonbuk=0;
	int jeju=0;
	int chungnam=0;
	int chungbuk=0;
	*/
	
	double gangwon = 0;
	double gyeonggi=0;
	double gyeongnam=0;
	double gyeongbuk = 0;
	double gwangju = 0;
	double daegu = 0;
	double daejeon = 0;
	double busan=0;
	double seoul=0;
	double sejong=0;
	double ulsan=0;
	double incheon=0;
	double jeonnam=0;
	double jeonbuk=0;
	double jeju=0;
	double chungnam=0;
	double chungbuk=0;
	
	for(MemberDto mdto: userList) {
		if(mdto.getAddr() == null) {
			continue;
		} else if (mdto.getAddr().equals("강원")) {
			gangwon += 1;
		} else if (mdto.getAddr().equals("경기")) {
			gyeonggi += 1;
		} else if (mdto.getAddr().equals("경남")) {
			gyeongnam += 1;
		} else if (mdto.getAddr().equals("경북")) {
			gyeongbuk += 1;
		} else if (mdto.getAddr().equals("광주")) {
			gwangju += 1;
		} else if (mdto.getAddr().equals("대구")) {
			daegu += 1;
		} else if (mdto.getAddr().equals("대전")) {
			daejeon += 1;
		} else if (mdto.getAddr().equals("부산")) {
			busan += 1;
		} else if (mdto.getAddr().equals("서울")) {
			seoul += 1;
		} else if (mdto.getAddr().equals("세종")) {
			sejong += 1;
		} else if (mdto.getAddr().equals("울산")) {
			ulsan += 1;
		} else if (mdto.getAddr().equals("인천")) {
			incheon += 1;
		} else if (mdto.getAddr().equals("전남")) {
			jeonnam += 1;
		} else if (mdto.getAddr().equals("전북")) {
			jeonbuk += 1;
		} else if (mdto.getAddr().equals("제주")) {
			jeju += 1;
		} else if (mdto.getAddr().equals("충남")) {
			chungnam += 1;
		} else if (mdto.getAddr().equals("충북")) {
			chungbuk += 1;
		}
	}
	
	double gangwon_p = gangwon / totalUsercount * 100;
	double gyeonggi_p=gyeonggi / totalUsercount* 100;
	double gyeongnam_p=gyeongnam / totalUsercount* 100;
	double gyeongbuk_p = gyeongbuk / totalUsercount* 100;
	double gwangju_p = gwangju / totalUsercount* 100;
	double daegu_p = daegu / totalUsercount* 100;
	double daejeon_p = daejeon / totalUsercount* 100;
	double busan_p=busan / totalUsercount* 100;
	double seoul_p=seoul/totalUsercount* 100;
	double sejong_p=sejong / totalUsercount* 100;
	double ulsan_p=ulsan/totalUsercount* 100;
	double incheon_p=incheon/totalUsercount* 100;
	double jeonnam_p=jeonnam/totalUsercount* 100;
	double jeonbuk_p=jeonbuk/totalUsercount* 100;
	double jeju_p=jeju/totalUsercount* 100;
	double chungnam_p=chungnam/totalUsercount* 100;
	double chungbuk_p=chungbuk/totalUsercount* 100;
	
	/*System.out.println(totalUsercount);
	System.out.println(seoul);
	System.out.println(seoul_p);*/
	
%>
	<div class="container" style="display: flex; justify-content: center;">
		<div class="" style="width: 1000px; display: flex; flex-direction: column;">	
			<span> | 관리자 페이지 | </span><br>
			
			<div style="flex-direction: row; display: flex;">
				<div class="rectangle" style="padding:10px 20px;">
					<div style="margin-bottom: 20px;">
						<span>유저 관리</span>
						<button class="moreBtn btn btn-sm btn-light"
								style="float:right;"
								onclick="location.href='index.jsp?main=mypage/admin/manageUserList.jsp'">더 보기</button>
					</div>
					
					<div>
						<table class="table">
							<tr>
								<td width="20">번호</td>
								<td width="50">닉네임</td>
								<td width="50">아이디</td>
								<td width="30">주소</td>
							</tr>
					<%if(userList.size() == 0) { %>
						<tr>
							<td colspan="4" align="center">
								<h3>등록된 유저가 없습니다.</h3>
							</td>
						</tr>
						
					<%} else if(userList.size() < 8) {%>
						<%for(MemberDto m : userList) {%>
							<tr><%=m.getNum() %></tr>
							<tr><%=m.getNickname() %></tr>
							<tr><%=m.getId() %></tr>
							<tr><%=m.getAddr() %></tr>
						<%}%>
					<%} else {%>
							
						<%for(int i = 0 ; i < 8 ; i++) {%>
							<tr>
								<td><%=userList.get(i).getNum() %></td>
								<td><%=userList.get(i).getNickname() %></td>
								<td><%=userList.get(i).getId() %></td>
								<td><%=userList.get(i).getAddr() %></td>
							</tr>
						<%}%>
					<%}%>
						</table>
					</div>
				</div>
				
				<div class="rectangle" style="padding:10px 20px;">
					<div style="margin-bottom: 20px;">
						<span>답변을 기다리는 질문</span>
						<button class="moreBtn btn btn-sm btn-light" 
								style="float:right;"
								onclick="location.href='index.jsp?main=mypage/admin/showWaitingQuestion.jsp'">더 보기</button>
					</div>
					<div>
						<table class="table">
							<tr>
								<td width="50">번호</td>
								<td width="100">작성자</td>
								<td>제목</td>
							</tr>
						<%if(qnaList.size() == 0) { %>
							<tr>
								<td colspan="3" align="center">
									<h3>등록된 질문글이 없습니다.</h3>
								</td>
							</tr>
						
						<%} else if(qnaList.size() < 8) { %>
							<%for(QnaBoardDto q : qnaList) {
							//닉네임설정
							String nickname = mdao.getNickname(q.getId());%>
							<tr>
								<td><%=q.getNum() %></td>
								<td><%=nickname %></td>
								<td style='width:350px;overflow:hidden;text-overflow:ellipsis;'><a class="a-tag" href="index.jsp?main=qna/detail.jsp?num=<%=q.getNum()%>"><%=q.getTitle() %></a></td>
							</tr>
							<%}%>
						<%} else {%>
							<%for(int i = 0 ; i < 8 ; i ++) { 
							//닉네임설정
							String nickname = mdao.getNickname(qnaList.get(i).getId());%>
							<tr>
								<td><%=qnaList.get(i).getNum() %></td>
								<td><%=nickname %></td>
								<td style='width:350px;overflow:hidden;text-overflow:ellipsis;'><a class="a-tag" href="index.jsp?main=qna/detail.jsp?num=<%=qnaList.get(i).getNum()%>"><%=qnaList.get(i).getTitle() %></a></td>
							</tr>
							<%}%>
						<%}%>
							
						
						</table>
					</div>
				</div>
			</div>
			
			<div style="flex-direction: row; display: flex;">
				<div class="rectangle_b" style="padding:10px 20px; margin-top: 50px;">
					<div style="margin-bottom: 20px;">
						<!-- <span>사용자 지역 분석</span> -->
						<div style="width:1000px; height: 500px;" id="graph"></div>
					</div>
				</div>
			
			<!-- <div style="flex-direction: row; display: flex;">
				<div class="rectangle">
					<div style="flex-direction: row; display: flex;">
						<p>??????</p>
						<button class="moreBtn btn btn-xs btn-warning">더 보기</button>
					</div>
					<div></div>
				</div>
				
				<div class="rectangle">
					<div style="flex-direction: row; display: flex;">
						<p>방문자 현황</p>
						<button class="moreBtn btn btn-xs btn-warning">더 보기</button>
					</div>
					<div></div>
				</div>
			</div>
			 -->
			</div>
		</div>
	</div>
	
<script type="text/javascript">
//Data retrieved from https://netmarketshare.com
Highcharts.chart('graph', {
    chart: {
        plotBackgroundColor: null,
        plotBorderWidth: null,
        plotShadow: false,
        type: 'pie'
    },
    title: {
        text: '사용자별 지역 분석',
        align: 'left'
    },
    tooltip: {
        pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
    },
    accessibility: {
        point: {
            valueSuffix: '%'
        }
    },
    plotOptions: {
        pie: {
            allowPointSelect: true,
            cursor: 'pointer',
            dataLabels: {
                enabled: true,
                format: '<b>{point.name}</b>: {point.percentage:.1f} %'
            }
        }
    },
    series: [{
        name: '지역',
        colorByPoint: true,
        data: [{
            name: '서울',
            y: <%=seoul_p%>,
            sliced: true,
            selected: true
        }, {
            name: '강원',
            y: <%=gangwon_p%>
        },  {
            name: '경기',
            y: <%=gyeonggi_p%>
        }, {
            name: '경남',
            y: <%=gyeongnam_p%>
        }, {
            name: '경북',
            y: <%=gyeongbuk_p%>
        },  {
            name: '광주',
            y: <%=gwangju_p%>
        }, {
            name: '대구',
            y: <%=daegu_p%>
        }, {
            name: '대전',
            y: <%=daejeon_p%>
        }, {
            name: '부산',
            y: <%=busan_p%>
        },{
            name: '세종',
            y: <%=sejong_p%>
        },{
            name: '울산',
            y: <%=ulsan_p%>
        },{
            name: '인천',
            y: <%=incheon_p%>
        },{
            name: '전남',
            y: <%=jeonnam_p%>
        },{
            name: '전북',
            y: <%=jeonbuk_p%>
        },{
            name: '제주',
            y: <%=jeju_p%>
        }]
    }]
});

</script>
</body>
</html>