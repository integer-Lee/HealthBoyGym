<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>header</title>
</head>
<body>
<div class = "container">
	<c:choose>
		<c:when test="${LoginMember==null}">
			<header>
				<div id="logo">
					<a href='<c:url value="/"/>'> <!--로고를 클릭하면 사이트의 첫 화면으로 이동할 수 있는 <a>태그를 추가.-->
						<h1>HealthBoy Gym</h1>
					</a>
				</div>
				<nav>
					<ul id="topMenu">
						<li><a href="#">게시판 <span>▼</span></a>
							<ul id="firstUl">
								<li><a href='<c:url value="/notice/noticeList.do"/>'>공지사항</a></li>
								<li><a href='<c:url value="/board/boardList.do"/>'>문의</a></li>
							</ul></li>
						<li><a href="#">트레이너 소개 <span>▼</span></a>
							<ul id="secondUl">
								<li><a href="#">헬스보이 이정수대표</a></li>
								<li><a href="#">러시아 불곰 밍키쌤</a></li>
								<li><a href="#">타란튤라 이지영쌤</a></li>
							</ul></li>
						<li id="memberJoinForm"><a href='javascript:void(0)'>회원 가입</a></li>
						<li id="loginForm"><a href='javascript:void(0)'>로그인</a></li>
					</ul>
				</nav>
			</header>
		</c:when>
		<c:otherwise>
			<header>
				<div id="logo">
					<a href='<c:url value="/"/>'> <!--로고를 클릭하면 사이트의 첫 화면으로 이동할 수 있는 <a>태그를 추가.-->
						<h1>Health Boy Gym</h1>
					</a>
				</div>
				<nav>
					<ul id="topMenu">
						<li><a href="#">게시판 <span>▼</span></a>
							<ul id="firstUl">
								<li><a href='<c:url value="/notice/noticeList.do"/>'>공지사항</a></li>
								<li><a href='<c:url value="/board/boardList.do"/>'>문의</a></li>
							</ul></li>
						<li><a href="#">트레이너 소개 <span>▼</span></a>
							<ul id="secondUl">
								<li><a href="#">헬스보이 이정수대표</a></li>
								<li><a href="#">러시아 불곰 밍키쌤</a></li>
								<li><a href="#">타란튤라 이지영쌤</a></li>
							</ul></li>
						<li><a href="#">마이페이지<span>▼</span></a>
							<ul id="thirdUl">
								<li id="memberDetailForm"><a href='javascript:void(0)'>회원정보상세보기</a></li>
								<li id="memberUpdateForm"><a href='javascript:void(0)'>회원정보수정</a></li>
							</ul></li>
						<li><a href="" onclick="logout()">로그아웃</a></li>
					</ul>
				</nav>
			</header>
		</c:otherwise>
	</c:choose>
</div>	
<div id="LoginDialog" title="로그인">
  <form id = "loginFormTag" method="post" onsubmit="return false;">
        <fieldset>
            <table>
                <tr>
                    <th class = "MemberTh" width="80px">ID</th>
                    <td class = "MemberTd"><input type="text" name="uid" id="loginUid" placeholder="아이디를 입력하세요" size="30" required="required"></td>    
                </tr>
                <tr>
                    <th class = "MemberTh" width="80px">비밀번호</th>
                    <td class = "MemberTd"><input type="text" name="pwd" id="loginPwd" placeholder="비밀번호를 입력하세요." size="30" required="required"></td>
                </tr>
            </table>
        </fieldset>
        <input type="submit" id="login" value="로그인">
        <br><br>
        <div id="login_link">
            <a href="<c:url value='/member/insertForm.do'/>">회원가입</a>
            <!-- <a href="#">아이디 찾기</a>  -->
            <a href="findPwd.html">비밀번호 찾기</a>
        </div>
  </form>
</div>

<div id="MemberJoinDialog" title="회원가입" onsubmit="return false;">
	<form id="memberFormTag" method="post" >
		<fieldset id = "MemberJoinfieldset">
		    <legend>필수 입력 사항</legend>
			    <table id = "MemberJoinTable">
			        <tr>
			            <th width="80px" class = "MemberTh">ID</th>
			            <td class = "MemberTd"><input type="text" name="uid" id="joinUid" placeholder="영문자, 숫자 포함하여 총 4 ~ 12자로 입력하시오. 단, 첫 글자는 반드시 영문자로." size="30"></td>
			            <td class = "MemberTd"><input type="button" id="isExistUid" value="중복확인"></td>                 
			        </tr>
			        <tr>
			            <th width="80px" class = "MemberTh">이름</th>
			            <!-- id="name"으로 접근할 수 없으므로 임의로 uname이라고 붙였다. -->
			            <td class = "MemberTd"><input type="text" name="name" id="joinUname" placeholder="한글로만 이루어져야 되며 2글자 이상으로 입력하시오." size="30"></td>
			        </tr>
			        <tr>
			            <th width="80px" class = "MemberTh">비밀번호</th>
			            <td class = "MemberTd"><input type="text" name="pwd" id="joinPwd" placeholder="영문자, 숫자, 특수문자 포함하여 총 8 ~ 15자로 입력하시오." size="30"></td>
			        </tr>
			        <tr>
			            <th width="110px" class = "MemberTh">비밀번호 확인</th>
			            <td class = "MemberTd"><input type="text" name="pwd2" id="joinPwd2" placeholder="위의 비밀번호와 일치하게 입력하시오." size="30"></td>
			        </tr>
			        <tr>
			            <th width="80px" class = "MemberTh">전화번호</th>
			            <td class = "MemberTd"><input type="tel" name="phone" id="joinPhone" placeholder="'-'를 포함해서 전화번호를 입력하세요." size="30"></td>
			        </tr>      
			    </table>
		</fieldset>
	
	    <br>
	<!--         <input type="submit" id="submit" value="회원가입" onclick="memberJoin()"> -->    
	    <input type="button" id="memberJoin" value="회원가입" />    
	    <input type="reset" value="다시입력">
	    <input type="button" value="메인으로" onclick="window.location.href = '/project2MVC2_AJAX/index/index.do'">
	</form>
</div> 

<div id="MemberUpdateDialog" title="회원정보수정" onsubmit="return false;">
	<form id="memberFormTag" method="post">
        <fieldset>
            <legend>회원정보 수정하기</legend><br> 
            <table id = "MemberTable"> 
            	 <tr>
                    <th width="80px" class = "MemberTh">ID</th>
                    <td class = "MemberTd"><input type="text" name="uid" id="updateUid" size="30" value="${LoginMember.userid}" readonly="readonly"></td>                 
                </tr>              
                <tr>
                    <th width="80px" class = "MemberTh">이름</th>
                    <td class = "MemberTd"><input type="text" name="uname" id="updateUname" placeholder="한글로만 이루어져야 되며 2글자 이상으로 입력하시오." size="30" value="${LoginMember.name}" ></td>
                </tr>
                <tr>
                    <th width="80px" class = "MemberTh">비밀번호</th>
                    <td class = "MemberTd"><input type="text" name="pwd" id="updatePwd" size="30" placeholder="영문자, 숫자, 특수문자 포함하여 총 8 ~ 15자로 입력하시오." value="${LoginMember.pwd}" ></td>
                </tr>
                <tr>
                    <th width="110px" class = "MemberTh">비밀번호 확인</th>
                    <td class = "MemberTd"><input type="text" name="pwd2" id="updatePwd2" placeholder="위의 비밀번호와 일치하게 입력하시오." size="30" value="${LoginMember.pwd}" ></td>
                </tr>
                <tr>
                    <th width="80px" class = "MemberTh">전화번호</th>
                    <td class = "MemberTd"><input type="tel" name="phone" id="updatePhone" size="30" placeholder="'-'를 포함해서 전화번호를 입력하세요." value="${LoginMember.phone}" ></td>
                </tr>      
            </table>
        </fieldset>
        
		<br>
        <input type="button" id="memberUpdate" value="회원정보수정">    
        <input type="reset" value="다시입력">
        <input type="button" value="회원탈퇴" id="withdrawl" >               
    </form>
</div> 
    
<div id="MemberDetailDialog" title="회원정보상세보기" onsubmit="return false;">
	<form id="memberFormTag" method="post">
        <fieldset>
            <legend>회원정보 상세보기</legend><br> 
            <table id = "MemberTable"> 
            	 <tr>
                    <th width="80px" class = "MemberTh">ID</th>
                    <td class = "MemberTd"><input type="text" name="uid" id="detailUid" size="30" value="${LoginMember.userid}" readonly="readonly"></td>                 
                </tr>              
                <tr>
                    <th width="80px" class = "MemberTh">이름</th>
                    <td class = "MemberTd"><input type="text" name="uname" id="detailUname" size="30" value="${LoginMember.name}" readonly="readonly"></td>
                </tr>
                <tr>
                    <th width="80px" class = "MemberTh">비밀번호</th>
                    <td class = "MemberTd"><input type="text" name="pwd" id="detailPwd" size="30" value="${LoginMember.pwd}" readonly="readonly"></td>
                </tr>
                <tr>
                    <th width="80px" class = "MemberTh">전화번호</th>
                    <td class = "MemberTd"><input type="tel" name="phone" id="detailPhone" size="30" value="${LoginMember.phone}" readonly="readonly"></td>
                </tr>      
            </table>
        </fieldset>
    </form>
</div> 
    
	<script type="text/javascript">
		function logout(){
		  /* 로그아웃 ajax구문 */
			 $.ajax({
			        url: "<c:url value='/member/logout.do '/>",
			        method: "GET",
			        headers: {
			            "Content-Type": "application/json; charset=UTF-8"
			        },
			        dataType: "json"
			    })
			    .done(function(json) {
			        alert(json.message);
			        if (json.status) {
			            location.href = "<c:url value='/'/>"
			        }
			    })
			    .fail(function() {
			        // 오류 처리
			        alert("오류가 발생했습니다.");
			    });
		};
		
		/* 로그인 다이얼로그 창 띄우는 jquery */
		 var loginDialog = $( "#LoginDialog" ).dialog({
	      autoOpen: false,
	      height: 300,
	      width: 500,
	      modal: true,
	    /*   buttons: {
	        "login": login,
	        Cancel: function() {
	        	loginDialog.dialog( "close" );
	        }
	      }, */
	      close: function() {
	      }
	    });
		
		/* 회원가입 다이얼로그 창 띄우는 jquery */
		var memberJoinDialog = $( "#MemberJoinDialog" ).dialog({
	      autoOpen: false,
	      height: 600,
	      width: 1000,
	      modal: true,
	      close: function() {
	      }
	    });
		
		/* 회원정보 수정 다이얼로그 창 띄우는 jquery */
		var memberUpdateDialog = $( "#MemberUpdateDialog" ).dialog({
	      autoOpen: false,
	      height: 600,
	      width: 1000,
	      modal: true,
	      close: function() {
	      }
	    });
		
		/* 회원정보 상세보기 다이얼로그 창 띄우는 jquery */
		var memberDetailDialog = $( "#MemberDetailDialog" ).dialog({
	      autoOpen: false,
	      height: 500,
	      width: 900,
	      modal: true,
	      close: function() {
	      }
	    });
		
		
	    /* 다이얼로그 이벤트핸들러  JQuery방법 1*/
	    /* $(document).on("click", "#loginForm", function() {
	    	loginDialog.dialog("open");
	    }); */
	    
	    /* 로그인 다이얼로그 이벤트핸들러  JQuery방법 2*/
	    $("#loginForm").on("click", function() {
	    	loginDialog.dialog("open");
	    });
	    
	    /* 회원가입 다이얼로그 이벤트핸들러  JQuery방법 2*/
	    $("#memberJoinForm").on("click", function() {
	    	memberJoinDialog.dialog("open");
	    });
	    
	    /* 회원정보 수정 다이얼로그 이벤트핸들러  JQuery방법 2*/
	    $("#memberUpdateForm").on("click", function() {
	    	memberUpdateDialog.dialog("open");
	    });
	    
	    /* 회원정보 상세보기 다이얼로그 이벤트핸들러  JQuery방법 2*/
	    $("#memberDetailForm").on("click", function() {
	    	memberDetailDialog.dialog("open");
	    });
	    
	    
	    /* 다이얼로그 이벤트핸들러  JQuery방법 3*/
	    /* $("#loginForm").click(function() {
	    	loginDialog.dialog("open");
	    }); */
	    
	    /* 다이얼로그 이벤트핸들러 JavaSciprt 방법 1*/
	  /*   document.querySelector("#loginForm").addEventListener("click", function() {
	    	loginDialog.dialog("open");
	    }); */
		
	  /* 로그인버튼 클릭 시 inputType=text값이 VO의 필드로 매칭되는 이벤트핸들러 */    
      $(document).on("click", "#login", function() {
    	  	const uidInput = $("#loginUid");
		    const pwdInput = $("#loginPwd");
		
		    const uid = uidInput.val();
		    const pwd = pwdInput.val();
		    
		    if (uid === "") {
		        alert("아이디를 입력하세요.");
		        uidInput.focus();
		        return;
		    }
		
		    if (pwd === "") {
		        alert("비밀번호를 입력하세요.");
		        pwdInput.focus();
		        return;
		    }
		
		    const param = {
		    	userid: uid,
		        pwd: pwd
		    };
    	  login(param);
	    });
	    
	  /* 회원가입버튼 클릭 시 inputType=text값이 VO의 필드로 매칭되는 이벤트핸들러 */
      $(document).on("click", "#memberJoin", function() {
    	  	const uidInput = $("#joinUid");
		    const pwdInput = $("#joinPwd");
		    const pwdInput2 = $("#joinPwd2");
		    const unameInput = $("#joinUname");
		    const phoneInput = $("#joinPhone");
		
		    const uid = uidInput.val();
		    const pwd = pwdInput.val();
		    const pwd2 = pwdInput2.val();
		    const uname = unameInput.val();
		    const phone = phoneInput.val(); 
		    
		    if (uid === "") {
		        alert("아이디를 입력하세요.");
		        uidInput.focus();
		        return;
		    }
		
		    if (pwd === "") {
		        alert("비밀번호를 입력하세요.");
		        pwdInput.focus();
		        return;
		    }
		
		    if (pwd2 === "") {
		        alert("비밀번호 확인을 입력하세요.");
		        pwdInput2.focus();
		        return;
		    }
		
		    if (uname === "") {
		        alert("이름을 입력하세요.");
		        unameInput.focus();
		        return;
		    }
		
		    if (phone === "") {
		        alert("전화번호를 입력하세요.");
		        phoneInput.focus();
		        return;
		    }
		
		    const param = {
		    	userid: uid,
		        pwd: pwd,
		        name :uname,
		        phone : phone
		    };
    	  memberJoin(param);
	    });
	    
	  /* 회원정보 수정버튼 클릭 시 inputType=text값이 VO의 필드로 매칭되는 이벤트핸들러 */
      $(document).on("click", "#memberUpdate", function() {
    	  	const uidInput = $("#updateUid");
		    const pwdInput = $("#updatePwd");
		    const pwdInput2 = $("#updatePwd2");
		    const unameInput = $("#updateUname");
		    const phoneInput = $("#updatePhone");
		
		    const uid = uidInput.val();
		    const pwd = pwdInput.val();
		    const pwd2 = pwdInput2.val();
		    const uname = unameInput.val();
		    const phone = phoneInput.val(); 
		    
		    if (uid === "") {
		        alert("아이디를 입력하세요.");
		        uidInput.focus();
		        return;
		    }
		
		    if (pwd === "") {
		        alert("비밀번호를 입력하세요.");
		        pwdInput.focus();
		        return;
		    }
		
		    if (pwd2 === "") {
		        alert("비밀번호 확인을 입력하세요.");
		        pwdInput2.focus();
		        return;
		    }
		
		    if (uname === "") {
		        alert("이름을 입력하세요.");
		        unameInput.focus();
		        return;
		    }
		
		    if (phone === "") {
		        alert("전화번호를 입력하세요.");
		        phoneInput.focus();
		        return;
		    }
		
		    const param = {
		    	userid: uid,
		        pwd: pwd,
		        name :uname,
		        phone : phone
		    };
    	  memberUpdate(param, pwd, uname, phone);
	    });
	    
	   /* 로그인 다이얼로그창에서 로그인버튼클릭 시 controller로 넘어가는 비동기통신 */
      function login(param) {
    	    $.ajax({
    	        url: "<c:url value='/member/login.do'/>"
    	         , type: 'POST'
    	      , data: JSON.stringify(param)
    	      , contentType : 'application/json; charset=UTF-8'
    	      , dataType : 'json'
    	      , success : function(data) {
	     	         alert(data.message);
					 if (data.status) {
						 location.href = "<c:url value='/'/>"
					 }
    	        }
    	    });
    	}
 
	   /* 회원가입 다이얼로그창에서 회원가입버튼클릭 시 controller로 넘어가는 비동기통신 */
      function memberJoin(param) {
		   /* 아이디 중복확인 부분에서 오류남 */
    	  /* 	if (existUidChecked) {
				alert("아이디 중복을 확인 해주세요");
				isExistUid.focus();
				return;
			} */
    	  	
    	    $.ajax({
    	        url: "<c:url value='/member/join.do'/>"
    	         , type: 'POST'
    	      , data: JSON.stringify(param)
    	      , contentType : 'application/json; charset=UTF-8'
    	      , dataType : 'json'
    	      , success : function(data) {
	     	         alert(data.message);
					 if (data.status) {
						 location.href = "<c:url value='/'/>"
					 }
    	        }
    	    });
    	}
	   
	   /* 회원정보 수정 다이얼로그창에서 회원정보수정 버튼클릭 시 controller로 넘어가는 비동기통신 */
      function memberUpdate(param, pwd, uname, phone) {
    	    $.ajax({
    	        url: "<c:url value='/member/update.do'/>"
    	         , type: 'POST'
    	      , data: JSON.stringify(param)
    	      , contentType : 'application/json; charset=UTF-8'
    	      , dataType : 'json'
    	      , success : function(data) {
	     	         alert(data.message);
					 if (data.status) {
	                	  $("#updatePwd").val(pwd);
	                      $("#updateUname").val(uname);
	                      $("#updatePhone").val(phone); 
						 location.href = "<c:url value='/'/>"
					 }
    	        }
    	    });
    	}
	   
	   /* 회원탈퇴 버튼 클릭 시 서버로 넘어가는 비동기 통신 */
     	$("#withdrawl").on("click", () => {
			$.ajax({
				 url: "<c:url value='/member/withdrawl.do'/>",
	            type: "POST",
	            contentType: "application/json; charset=UTF-8",
	            dataType: "json",
	            success: function(data) {
	            	alert(data.message);
	  		        if (data.status) {
	  		        	location.href = "<c:url value='/'/>";
	  		        }
	            }
	         });   		
		}) 
	</script>
	
		<script type="text/javascript">
		//회원가입&아이디중복확인 ajax방식 적용
		    $(document).ready(function() {
            let existUidChecked = true;

            $('#isExistUid').click(function() {
                const param = { userid: $('#joinUid').val() };

                $.ajax({
                    type: 'POST',
         	        url: "<c:url value='/member/isExistUid.do '/>",
                    contentType: 'application/json; charset=UTF-8',
                    data: JSON.stringify(param),
                    success: function(json) {
                        alert(json.message);
                        console.log(json)
                        if (!json.status) {
                            existUidChecked = false;
                        } else {
                            $('#joinUid').val('');
                            $('#joinUid').focus();
                            existUidChecked = true;
                        }
                    },
                    error: function() {
                        alert('서버 요청에 실패했습니다.');
                    }
                });
            });
        }); 
	</script>
	
</body>
</html>