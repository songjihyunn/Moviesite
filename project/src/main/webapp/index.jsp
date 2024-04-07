<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<script src="http://code.jquery.com/jquery=migrate-1.4.1.min.js"></script>

<script src="/swiper.min.js"></script>
<link rel="stylesheet" href="/swiper.min.css">

<%@ include file="../include/dbconnection.jsp" %>
<style>
	/*전체form*/
	#bd{
		padding: 0px;
	    margin: 0px;
	    position: absolute;
	    font-family: "Sunflower", sans-serif;
	    overflow-x: hidden;
		display:grid;
		width: 2000;
		justify-content: center;
	}
	/*상단 메뉴바*/
	#bar{
		margin-left: 10px;
		text-align: left;
		word-spacing: 20px;
		font-size: 20px;
		font-weight: bold;
		color: white;
		text-align: center;
		text-decoration: none;
		padding-left:10px;
	}
    /*검색창*/
    #search{
        width: 600px;
        height: 50px;
        border-radius: 10px;
        font-size: 20px;
        font-weight: bold;
        border-color: #0099FF;
        border-style:double;
        padding-left: 10px;
    }
    #search:focus{
    	outline: lightseagreen;
    }
    a{
        text-decoration: none;
        color: black;
    }
    /*아이디 td*/
    #login{
        border: 0px solid blue;
        float: right;
        font-size: 15px;
    }
    /*아이디, 비밀번호 입력*/
    #id, #password{
        width: 80%;
        float: right;
        height: 30px;
    }
    /*상단 메뉴바*/
    #menu{
        margin-left: 10px;
        text-align: left;
        word-spacing: 20px;
        font-size: 20px;
        font-weight: bold;
        color: white;
        text-align: center;
    }
    /*로그인 버튼*/
    #login_1{
        width: 100%;
        height: 20px;
        background-color: white;
        border:0px;
    }
    /*회원가입, 아이디 찾기, 비밀번호 찾기*/
    #create, #find{
        font-size: 11px;
        color: dimgray;
        text-decoration: none;
    }
    /*영화, 개봉 일정, 전체, BEST, 자유게시판 menu_bar*/
    #menu_bar{
        width: 200;
        color: white;
        font-size: 15px;
        background-color: #0099FF; 
        height: 30px; 
        border-radius: 5px;
    }
    /*전체, BEST, 게시판 숫자*/
    #number{
        height:35px;
        text-align:center; 
        background-color: lightgray; 
        border-radius: 5px; 
        border: 0px solid black;  
        font-weight: bold;
    }
    /*영화제목, 날짜 bar*/
    #date_bar{
        font-weight: bold;
        background-color: #787878; 
        border-radius: 5px;
        border: 0px solid black;
        padding-left: 10px;
    }    
    /*영화제목, 날짜 게시판*/
    #movie_name, #movie_date{
        height: 40; 
        font-size: 15px;
        font-weight:500;
        padding-left: 10px;
    }
    /*로그아웃, 회원수정 버튼  */
    #out, #create_up{
        	color: black;	
        }
    /* 검색 이미지 버튼 */
    .img_btn{
    	background-image: url(../img/search.PNG);
    	background-position: 0px 0px;
 		background-size: 50px;
 		border: none;
		width: 50px;
		height: 50px;
		vertical-align: middle;	
    }
    	/* swiper */
	.visual .swiper-container{
		max-width: 1920px;
		margin: 0 auto;            
		position: relative; 
	}
	.visual img{
		vertical-align: top;
		width: 100%;
	}
	/* swiper 하단 버튼 디자인  */
	.visual .swiper-pagination{
		position: absolute;
		left: 0;
		bottom: 3%;
		z-index: 100;            
		text-align: center;
		width: 12px;
		height: 12px;
		background: red;
		opacity: 1;
	}
	.visual .swiper-pagination .swiper-pagination-bullet{
		width: 12px;
		height: 12px;
		background: #fff;
		opacity: 1;
	}
	.visual .swiper-pagination .swiper-pagination-bullet-active{
		background: #ff6600;
	}
</style>
<script type="text/javascript">
    function loglog(){
        if(id.value==""){
            alert("아이디를 입력해주세요.");
            return false;
        }
        if(password.value==""){
            alert("비밀번호를 입력해주세요.");
            return false;
        }
    }
    
    function getTime() {
            var d = new Date();
            var hur = d.getHours();		// 시
            var min = d.getMinutes();	//분
            var sec = d.getSeconds();	//초

            var timeBoard = document.getElementById("WhatTimeIsItNow"); // 값이 입력될 공간

            var time =hur + "시 " + min + "분 " + sec + "초"	// 형식 지정

            timeBoard.innerHTML = time;	// 출력

            setTimeout(getTime, 1000);	//1000밀리초(1초) 마다 반복
        }

</script>
<body id="bd" onload="getTime()">
<%
String session_name = (String)session.getAttribute("name");
String session_id = (String)session.getAttribute("id");
String session_level = (String)session.getAttribute("level");
%>
    <table border="0" style="width: 100%; height: 100%;">
       <tr height="50">
           <td colspan="8"></td>
       </tr>
        <tr>
            <td width="100"></td>
            <td width="200" style="text-align: center;">  <!--로고-->
            	<img src="../img/logo2.PNG" style="width:80px;">
            </td>   
            <td width="700" colspan="4" style="padding-top: 20px;">
                <form action="/search/list.jsp"><!--검색-->
	                <input id = "search" name="keyword">
	                <button class= "img_btn" ></button>
                </form>
            </td>
            <td width="300">
                <div id="current_date" style="font-weight: bold;">
                        <script>
                            const options = { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric'};
                            document.getElementById("current_date").innerHTML = new Date().toLocaleString('ko-KR', options);
                        </script>
                </div>
                <p id="WhatTimeIsItNow" style="font-weight: bold;"></p>
            </td>
            <td width="100"></td>
        </tr>
        <tr>
            <td colspan="8" style="height: 10;"></td>
        </tr>
        <tr><!--상단 메뉴바-->
           <td></td>
           <td  colspan="6" style="background-color:#0099FF ; height: 50px; border-radius: 5px;">
           <table id="menu">
               <tr>
                   <td style="padding-left: 20px;"><a href="../contents/list.jsp?code=free" style="color: white;">자유게시판</a></td>
                    <td style="padding-left: 50px;"><a href="../contents/list.jsp?code=info" style="color: white;">영화</a></td>
                    <td style="padding-left: 50px;"><a href="../contents/list.jsp?code=notice" style="color: white;">공지사항</a></td>
                    <td style="padding-left: 50px;"><a href="../contents2/list.jsp?code=qna" style="color: white;">Q&A</a></td>
               </tr>
           </table>
           </td>
           <td></td>
        </tr>
        <tr>
            <td colspan="8" style="height: 10;"></td>
        </tr>
        <tr>
            <td></td>
            <td colspan="4">	<!--광고배너-->
            <%
						String sql6 = "select * from info order by signdate desc limit 5";
						
						Connection conn6 = DriverManager.getConnection(url, user, password);
						Statement stmt6 = conn6.createStatement();
						ResultSet rs6 = stmt6.executeQuery(sql6);
						
						while(rs6.next()){
							int uid = rs6.getInt("uid");
					%>
            	<div class="visual" style = "width: 1000px;">
					<div class="swiper-container">
						<div class="swiper-wrapper" >
							<div class="swiper-slide">
								<img src="img/adv.jpg" style="width: 1000px; height: 100px;"onclick="location.href='../contents/view.jsp?code=info&uid=<%=uid%>'">
							</div>
							<div class="swiper-slide">
								<img src="img/adv2.png" style="width: 1000px; height: 100px;"onclick="location.href='../contents/view.jsp?code=info&uid=<%=uid%>">
							</div>
							<%} %>
							<div class="swiper-pagination"></div>
						</div>
						
				</div>
				</div>
				<script>
					/* 자동실행, left, right버튼 기능 api 추가 */
					var swiper = new Swiper('.swiper-container', {
						autoplay: {
							delay: 4000,
							disableOnInteraction: false
						},
						slidesPerView: 1,
						loop: true,
						pagination: {
							el: '.swiper-pagination',
							clickable: true,
						},
					});
				</script>
            </td>    
            <td></td>
            <td id="login" width="100%" style=" height: 35px; width:100%">    
            <form action="../member/login_update.jsp" method="post">
                <table border=0 style="height: 100px; width:100%; border: 0px solid gray; border-radius: 10px;">    <!--로그인-->
                    <tr style="height: 30px">
                        <td colspan="2" style="padding-top: 10px;">
                        <%if(session_name !=null){ %>
                           <strong><%=session_name %>님<br></strong><br>
                               <a id="out" href = "/member/logout.jsp" style="font-color: black;">[로그아웃]</a>
                               <a id="create_up" href = "../member/create_up.jsp">[회원수정]</a>
                           <%}else{%>      
                        ID <input id="id" name="id" placeholder="아이디 입력" tabindex="1"></td>
                        <td width="10"></td>
                        <td rowspan="2" style="padding-top: 10px;">                  
                        	<button id="login_1" onclick="loglog();" tabindex = "3" style="border: 1px solid gray; width: 55px; height: 100%">로그인</button>
                        </td>
                    </tr>
                    <tr style="padding-top: 10px;">
                        <td colspan="2">PW  <input type="password" id="password" name="pw" placeholder="비밀번호 입력" tabindex="2"></td>
                    </tr>
                    <tr>
                        <td style="width:90px; text-align: right;"><a id = "create" onclick="create()" href="../member/create.jsp" tabindex="4">회원가입</a></td>    <!--회원가입-->
                        <td style="width:70px; text-align: left; padding-left: 10px;" colspan="3">
                            <a id = "find" onclick="find()" href="../member/find.jsp" tabindex="5">아이디 찾기/비밀번호 찾기</a><!--아이디/비밀번호 찾기-->
                        </td>    
                        <%} %>
                    </tr>    
                </table>
                </form>
            </td>
            <td></td>
        </tr>
        <tr>
            <td colspan="8" style="height: 10;"></td>
        </tr>
        <tr>    <!--영화, 개봉일정 menu_bar-->
            <td></td>
            <td colspan="4" id="menu_bar" style="padding-left: 10px; font-weight: bold;">영화</td>
            <td style="width: 20"></td>
            <td id="menu_bar" style="padding-left: 10px; font-weight: bold;">개봉 일정</td>
            <td></td>
        </tr>
        <tr>
            <td></td>
            <td colspan="4" style="height: 200px;">
                <table border=0 id="movie_info">     <!--영화 포스터-->
                    <tr>
                    <%
						String sql4 = "select * from info order by signdate desc limit 5";
						
						Connection conn4 = DriverManager.getConnection(url, user, password);
						Statement stmt4 = conn4.createStatement();
						ResultSet rs4 = stmt4.executeQuery(sql4);
						
						while(rs4.next()){
							int uid = rs4.getInt("uid");
							String file1 = rs4.getString("file1");
					%>
	                    <td>
	                    	<img src = "/upload/<%=file1 %>"  onclick="location.href='../contents/view.jsp?code=info&uid=<%=uid%>'"style="width: 185px; height: 260px; padding-right: 9px;">
	                 	</td>
	                 	<%} %>  
	                </tr>
                </table>
            </td>
         	<td></td>
            <td style="vertical-align: top">
                <table border=0 style = "height: 200px; width:100%;">    <!--영화 제목, 날짜-->
                    <tr>
                        <td style="width: 60%; height: 30px; padding: 5px 0px 5px 10px;" id="date_bar">영화제목</td>
                        <td id="date_bar">날짜</td>
                    </tr>
                    <%
                    
                    %>
                    <%
						String sql5 = "select * from info order by signdate desc limit 5";
                    
						Connection conn5 = DriverManager.getConnection(url, user, password);
						Statement stmt5 = conn5.createStatement();
						ResultSet rs5 = stmt5.executeQuery(sql5);
						
						while(rs5.next()){
							int uid = rs5.getInt("uid");
							String subject = rs5.getString("subject");
							
							//제목 길이 ... 처리
							int len_num = subject.length();	//제목길이
							
							if(len_num > 12){	//길이 비교
								subject = subject.substring(0,12) + "...";
							}else{
								subject = subject;
							}
							
							java.sql.Date openDate = rs5.getDate("open_d");
							String formatDate="";
							
							if(openDate != null){
								SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
								formatDate = sdf.format(openDate);
							}else{
								formatDate = "No Date";
							}
					%>
                    <tr>
					<td style="padding: 10px 0px; font-weight: bold;">
						<a href="../contents/view.jsp?code=info&uid=<%=uid%>" style="padding-left: 10px; text-align: center; height:35;"><%=subject %></a>
					</td>
					<td style="width: 25; height:35; text-align: center; background-color: lightgray; border-radius: 5px; font-weight: bold;"><%=formatDate%></td>
					<%} %>
					</tr>
                </table>
            </td>
            <td></td>
        </tr>
        
        <tr>
            <td colspan="8" style="height: 10;"></td>
        </tr>
        <tr>    <!--전체, BEST, 자유게시판 menu_bar-->
            <td></td>
            <td colspan="2" style="width: 210; padding-left: 10px; font-weight: bold;" id="menu_bar" style="color: white;">최신글</td>
            <td style="width: 20"></td>
            <td style="width:350; padding-left: 10px; font-weight: bold;" id="menu_bar">자유 게시판</td>
            <td style="width: 20"></td>
            <td id="menu_bar" style="padding-left: 10px; font-weight: bold;">공지사항</td>
            <td></td>
        </tr>
        <tr>
            <td></td>
            <td colspan=2>
                <form action="../contents/view.jsp" method="get">
    				<table border="0">    <!-- 최신글 내용 -->
			        <%  
			        String[] codes = {"free", "notice", "info"};
			        
			        // 모든 테이블에서 최신순으로 5개의 데이터를 가져오는 SQL 쿼리 작성
			        String sql2 = "SELECT * FROM (";
			        for (int i = 0; i < codes.length; i++) {
			            if (i > 0) {
			                sql2 += " UNION ALL ";
			            }
			            sql2 += "SELECT '" + codes[i] + "' AS type, uid, subject, signdate FROM " + codes[i];
			        }
			        sql2 += ") AS combined ORDER BY signdate DESC LIMIT 5";
			        
			            Connection conn2 = null;
			            Statement stmt2 = null;
			            ResultSet rs2 = null;

			            conn2 = DriverManager.getConnection(url, user, password);
			            stmt2 = conn2.createStatement();
			            rs2 = stmt2.executeQuery(sql2);
			            
			            int count = 1;
			            while(rs2.next()) {
			                int uid = rs2.getInt("uid");
			        %>
			        <tr>
			            <td style="width: 25; height: 35; text-align: center; background-color: lightgray; border-radius: 5px; font-weight: bold;"><%=count%></td>
			            <% count++; %>
			            <td style="width: 420; padding-left: 10px;">
			                <a href="../contents/view.jsp?code=<%=rs2.getString("type")%>&uid=<%=uid%>"><%=rs2.getString("subject") %></a>
			            </td>
			        </tr>
			        <%  
			            }
			            rs2.close();
			            stmt2.close();
			            conn2.close();
			        %>
    </table>
</form>


            </td>
            <td></td>
            <td align=center valign=top>
                <table border=0>    <!--자유게시판 내용-->
                	<%
						String sql3 = "select uid, subject from free order by uid desc limit 5";
						
						Connection conn3 = DriverManager.getConnection(url, user, password);
						Statement stmt3 = conn3.createStatement();
						ResultSet rs3 = stmt3.executeQuery(sql3);
						
						int count1=1;
						while(rs3.next()){
							int uid = rs3.getInt("uid");
					%>
                    <tr>
                        <td style="width: 25; height:35; text-align: center; background-color: lightgray; border-radius: 5px;  font-weight: bold;"><%=count1%></td>
                        <%count1++; %>
                        <td style="width: 420; padding-left: 10px;">
                        	<a href="../contents/view.jsp?code=free&uid=<%=uid%>"><%=rs3.getString("subject") %></a>
                        </td>
                    </tr>
                    <%
					}
					%>
                </table>
            </td>
            <td></td>
            <td align=center valign=top>
                <table border=0>    <!--공지사항 내용-->
                	<%
						String sql = "select * from notice order by uid desc limit 5";
						
						Connection conn = DriverManager.getConnection(url, user, password);
						Statement stmt = conn.createStatement();
						ResultSet rs = stmt.executeQuery(sql);
						int count2=1;
						while(rs.next()){
							int uid = rs.getInt("uid");
					%>
                    <tr>
                        <td style="width: 25; height:35; text-align: center; background-color: lightgray; border-radius: 5px; font-weight: bold;"><%=count2%></td>
                        <%count2++; %>
                        <td style="width: 420; padding-left: 10px;"><a href="../contents/view.jsp?code=notice&uid=<%=uid%>"><%=rs.getString("subject") %></a></td>
                    </tr>
                    <%
					}
					%>
                </table>
            </td>
        </tr>
    </table>
    <br>    
    <table border = "0">
        <tr>    <!--맨 아래 -->
        	<td width = "100"></td>
            <td style="height: 80; width:1300px; text-align: center; background-color: darkgray;">Copyright© 무비무비 All rights reserved.</td>
        	<td width = "100"></td>
        </tr>
</table> 
</body>

