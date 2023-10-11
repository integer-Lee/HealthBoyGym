<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 게시판</title>
</head>
<body id = "boardBody">
	<form name="pageForm" id="pageForm" action="<c:url value='/notice/noticeList.do'/>" method="post" >
		<input type="hidden" name="pageNo" id="pageNo" value="${result.notice.pageNo}" />
		<input type="hidden" name="searchTitle" id="searchTitle" value="${result.notice.searchTitle}" >
		<input type="hidden" name="pageLength" id="pageLength" value="${result.notice.pageLength}" >
	</form>
	
	<!-- id = "formTag"  -->
	<form name="mForm" id = "mForm" class="board" action="deleteSelectedPage.jsp" method='post'>
		<div id="contain">
		    <table class="table">
		      <caption>공지사항 게시판</caption>
		        <tr class="head">
		          <th>전체선택 <input type='checkbox' id='chk'></th>
		          <th>글번호</th>
		          <th>제목</th>		      
		          <th>작성자</th>
		          <th>작성날짜</th>
		        </tr>
		
					<c:forEach var="notice" items="${result.list}">
						<c:set var="fixedClass" value="${notice.fixed_yn eq 'Y' ? 'fixed' : ''}" />
						<tr class="${fixedClass}">
						    <th><input type="checkbox" class="noticeId" name="noticeId" value="${notice.noticeId}" readonly="readonly"></th>
						    <td class="textNumber">${notice.noticeId}</td>
						    <td class="noticeTitle" data-noticeid="${notice.noticeId}">${notice.title}</td>						 
						    <td>${notice.userId}</td>
						    <td>${notice.regDate}</td>
						</tr>
					</c:forEach>
					
			  		<c:if test="${empty result.list}">
		             	<tr>
		             		<td colspan=7>검색결과가 없습니다</td>
		              	</tr>
	       		  	</c:if>
		</table>
		
		<div style="text-align: center; margin-top:20px;">
		   	<c:if test="${result.notice.navStart != 1}">
		   		<a href="javascript:jsPageNo(${result.notice.navStart-1})" style="padding: 10px;"> &lt; </a> 
		   	</c:if>
		   	
		   	<c:forEach var="item" begin="${result.notice.navStart}" end="${result.notice.navEnd}">
		   		<c:choose>
		   		
		   			<c:when test="${result.notice.pageNo != item }">
		   				<a href="javascript:jsPageNo(${item})" style="padding: 10px; border: 1px solid gray; ">${item}</a>  
		   			</c:when>
		   			
		   			<c:otherwise>
		   				<strong style="font-size:1.2rem">${item}</strong>   
		   			</c:otherwise>
		   			
		   		</c:choose>
		   		
		   	</c:forEach>
		   	
		   	<c:if test="${result.notice.navEnd != result.notice.totalPageSize}">
		   		<a href="javascript:jsPageNo(${result.notice.navEnd+1})" style="padding: 10px;"> &gt; </a> 
		   	</c:if>
	   	</div>  
		
		<input type="button" value="메인페이지" onclick="window.location.href = '/project2MVC2_AJAX/index/index.do'">
		<input type="button" id = "noticeInsert" value="등록" >
		
		</div>
	</form>
	<!----------------------------- 게시판 다이얼로그관련 소스코드---------------------------------- -->
	<!-- 게시글 상세보기 다이얼로그 -->
	<div id="noticeDialog" style = "display:none;" title="공지사항 게시글 상세보기">
		<form>
		<%-- 	noticeId를 hidden속성으로 보내주거나 아래 주석처럼 2가지 방법으로 보내줄 수 있다.
				<input name="noticeId" id="noticeId"
				data-noticeId = "${notice.noticeId}" /> --%>
			<input type="hidden" id = "noticeHiddenId" value="">
			<h2 id="noticeDialogTitle">공지사항  상세보기</h2>
			<br>
			<table class="tb">
				<tr>
					<th class="col">제목</th>
					<td id = "detailTitle"></td>
				</tr>
				<tr>
					<th class="col">작성자</th>
					<td id="detailUserId"></td>
				</tr>
				<tr>
					<th class="col">내용</th>
					<td>
						<div id="detailContents"></div>
					</td>
				</tr>
				<tr>
					<th class="col">조회수</th>
					<td id = "detailHit"></td>
				</tr>
			</table>
			
			<div id="reviseDelete">
				<!-- 조건문은 로그인한 계정만 수정가능 -->
				<c:if test="${LoginMember.userid == 'admin'}">	
					<input type="button" id="revise" value="수정화면전환" >
					<input type="button" id ="delete" value="삭제">
				</c:if>
			</div>
		</form>
	</div>
	
	<!-- 게시글 삽입 다이얼로그 -->
	<div id = "insertDialog" style="display:none" title="공지사항 게시글 삽입">
	<form  method="post" name = "mForm" id = "mForm" autocomplete="off">
		<input type="hidden" name="fixed_yn" id="fixed_yn" value="N">
		<input type="hidden" name="boardType" id="boardType" value="공지사항">
			<table class="tb">
				<caption>공지사항 게시글 작성</caption>
				<tr>
					<th class="col">작성자</th>
					<td><input class="text" type="text" name="memberid" id="memberid" value="${LoginMember.userid}" readonly /></td>
				</tr>
				<tr>
					<th class="col"><label for="title">제목</label></th>
					<td><input class="text" type="text" name="title" id="title" class ="text_title" required/></td>
				</tr>
				<tr>
					<th class="col"><label for="contents">내용</label></th>
					<td><input class="text" type="text" name="contents" id="contents"  class = "notice_contetns" required/></td>
				</tr>
				<tr>
                   <th class="col"><label for="fixed_yn_ui">상단 고정</label></th>
                   <td><input type="checkbox" name="fixed_yn_ui" id="fixed_yn_ui" value='Y'/></td>
               </tr>
			</table>
		<!-- <li id="memberJoinForm"><a href='javascript:void(0)'>회원 가입</a></li> -->
		<input id="noticeInsertForm" type="button" value="등록" /> 
		<input type="reset" value="초기화" />
	</form>
	</div>
	
	<!-- 게시글 수정 다이얼로그 -->
	<div id = "updateDialog" style="display:none" title="공지사항 게시글 수정">
		<form action="" name="mForm" id="mForm" method="post" autocomplete="off">
		   	<input type="hidden" name="noticeUpdateId" id="noticeUpdateId" value=""/> 
		   	<input type="hidden" name="fixed_yn" id="fixed_yn" value="N">
			<table class="tb">
				<caption>공지사항 게시글 수정</caption>
				<tr>
					<th class="col">작성자</th>
					<td><input class="text" type="text" name="updateMemberid" id="updateMemberid" value="${LoginMember.userid}" readonly /></td>
				</tr>
				<tr>
					<th class="col"><label for="title">제목</label></th>
					<td><input class="text" type="text" name="updateTitle" id="updateTitle" value="" class ="text_title" required/></td>
				</tr>
				<tr>
					<th class="col"><label for="contents">내용</label></th>
					<td><input class="text" type="text" name="updateContents" id="updateContents" value="" class = "notice_contetns" required/></td>
				</tr>
				<tr>
	                   <th class="col"><label for="fixed_yn_ui">상단 고정</label></th>
	                   <td><input type="checkbox" name="fixed_yn_ui" id="fixed_yn_ui"/></td>
	               </tr>
			</table>
			<input id="reviseSuccess" type="button" value="수정하기" /> 
			<input type="reset" value="초기화" />
		</form>	
	</div>
<!---------------------------------------- <SCRIPT>태그 ---------------------------------------->
	<!-- 페이징 관련 스크립트 태그 -->
	<script type="text/javascript">
		function jsPageNo(pageNo) {
			document.querySelector("#pageForm > #pageNo").value = pageNo;
			document.querySelector("#pageForm").submit(); 
		}
		
		document.querySelector("#mForm").addEventListener("submit", e => {
			document.querySelector("#mForm > #pageNo").value = "1";
			
			return true;
		});
	</script>
	<!------------------------------------------------------------------------------------------------------------>
	
	<script type="text/javascript">
			let allChk = document.querySelector("#chk");
		    let noticeIds = document.querySelectorAll(".noticeId");
		    allChk.addEventListener("change", function() {
		        for (var i = 0; i < noticeIds.length; i++) {
		            noticeIds[i].checked = allChk.checked;
		        }
		    });
		    let sendDelete = document.querySelector("#deleteAllCheckBox");
		    let noticeId = "";
		    
		  /*   sendDelete.addEventListener("click", function (e) {
		    	  e.preventDefault();
		    	  var form = document.getElementById("formTag");
		    	  form.submit();
		    }); */
		  
		    $(document).ready(function() {  
			  $(document).on("click", ".noticeTitle", function(e) {
				  e.preventDefault();
				  
				    /* 게시글 상세보기 다이얼로그 창 띄우는 jquery */
					 $( "#noticeDialog" ).dialog({
				      autoOpen: false,
				      height: 700,
				      width: 800,
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
				   
				   noticeId = $(this).data("noticeid");  // noticeid 값을 가져옵니다.
				   // 서버에 AJAX 요청을 보내서 해당 공지사항의 내용을 가져옵니다.
				   $.ajax({
				      type: "POST",
					  url: "<c:url value='/notice/noticeView.do'/>",  
				      contentType: "application/json; charset=UTF-8",
				      data: JSON.stringify({ noticeId: noticeId }),
				      dataType: "json",
				      success: function(response) {
				    	  console.log(response);
				    	  if(response.status){
				    		  const notice = response.notice;
					         // 응답으로 받은 데이터를 다이얼로그에 설정합니다.
					         $('#detailTitle').text(notice.title);
					         $('#detailUserId').text(notice.userId);
					         $('#detailContents').text(notice.contents);
					         $('#detailRegDate').text(notice.regDate);
					         $('#detailHit').text(notice.hit); 
					         $('#noticeHiddenId').val(notice.noticeId); 
						     // 다이얼로그를 오픈합니다.
					         $('#noticeDialog').dialog("open");
				    	  }
				      },
				      error: function(error) {
				         alert("데이터를 가져오는 데 실패했습니다.");
				      }
				   });
				   
				});
		    });
		   /****************************** 공지사항 삽입 scirpt 다이얼로그 *****************************/ 
		    /* 공지사항  삽입 다이얼로그  창 띄우는 jquery*/
		    	/* 공지사항  삽입 다이얼로그 창 띄우는 jquery */
			var noticeInsertDialog = $( "#insertDialog" ).dialog({
		      autoOpen: false,
		      height: 700,
		      width: 800,
		      modal: true,
		      close: function() {
		      }
		    });
		    
			 /* 공지사항 게시글 삽입 다이얼로그 이벤트핸들러  JQuery방법 2*/
		    $("#noticeInsert").on("click", function() {
		    	noticeInsertDialog.dialog("open");
		    });
			 
		    /* 공지사항 게시글 삽입버튼 클릭 시 inputType=text값이 VO의 필드로 매칭되는 이벤트핸들러 */
		      $(document).on("click", "#noticeInsertForm", function() {
				    const noticeTitle = $("#title");
				    const noticeContents = $("#contents");
				
				    const Title = noticeTitle.val();
				    const Contents = noticeContents.val();
				    
				    if (Title === "") {
				        alert("제목을 입력하세요.");
				        title.focus();
				        return;
				    }
				
				    if (Contents === "") {
				        alert("내용을 입력하세요.");
				        contents.focus();
				        return;
				    }
				
				    const param = {
				    	userId : $("#memberid").val(),
				    	title: Title,
				    	contents :Contents,
				    };
		    	  noticeInsert(param);
			    });
		    
			   /* 공지사항 게시판 삽입 다이얼로그창에서 등록 버튼클릭 시 controller로 넘어가는 비동기통신 */
		      function noticeInsert(param) {
		    	    $.ajax({
		    	        url: "<c:url value='/notice/insert.do'/>"
		    	        
		    	         , type: 'POST'
		    	      , data: JSON.stringify(param)
		    	      , contentType : 'application/json; charset=UTF-8'
		    	      , dataType : 'json'
		    	      , success : function(data) {
			     	         alert(data.message);
							 if (data.status) {
								 location.href = "<c:url value='/notice/noticeList.do'/>"
							 }
		    	        }
		    	    });
		    	}
		/**************************************************************************/
		
		/****************************** 공지사항 수정 scirpt 다이얼로그 *****************************/
		 /* 공지사항  수정 다이얼로그  창 띄우는 jquery*/
		    	/* 공지사항  수정다이얼로그 창 띄우는 jquery */
			var noticeUpdateDialog = $( "#updateDialog" ).dialog({
		      autoOpen: false,
		      height: 700,
		      width: 800,
		      modal: true,
		      close: function() {
		      }
		    });
		    
		
			 /* 공지사항 게시글 수정 다이얼로그 이벤트핸들러  JQuery방법 2*/
		    $("#revise").on("click", function() {
		    	//const noticeID = noticeId;//$("#noticeHiddenId").val();
		    	console.log(noticeId)
		    	 // 서버에 AJAX 요청을 보내서 해당 공지사항의 내용을 가져옵니다.
				   $.ajax({
				      type: "POST",
					  url: "<c:url value='/notice/noticeView.do'/>",  
				      contentType: "application/json; charset=UTF-8",
				      data: JSON.stringify({ noticeId: noticeId }),
				      dataType: "json",
				      success: function(response) {
				    	  if(response.status){
				    		  const notice = response.notice;
				    		  console.log("확인용 " + notice);
					         // 응답으로 받은 데이터를 다이얼로그에 설정합니다.
					         $('#updateTitle').val(notice.title);
					         $('#updateContents').val(notice.contents);
						     // 다이얼로그를 오픈합니다.
					         noticeUpdateDialog.dialog("open"); 
				    	  }
				    	  
				      },
				      error: function(error) {
				         alert("데이터를 가져오는 데 실패했습니다.");
				      }
				   });
		    	
		    	
		    });
			 
		    /* 공지사항 게시글 수정하기버튼 클릭 시 inputType=text값이 VO의 필드로 매칭되는 이벤트핸들러 */
		        $(document).on("click", "#reviseSuccess", function() {
				    const noticeTitle = $("#updateTitle");
				    const noticeContents = $("#updateContents");
				
				    const Title = noticeTitle.val();
				    const Contents = noticeContents.val();
				    
				    if (Title === "") {
				        alert("제목을 입력하세요.");
				        title.focus();
				        return;
				    }
				
				    if (Contents === "") {
				        alert("내용을 입력하세요.");
				        contents.focus();
				        return;
				    }
				
				    const param = {
				    	userId : $("#updateMemberid").val(),
				    	noticeId : noticeId,
				    	title: Title,
				    	contents :Contents,
				    };
		    	  noticeUpdate(param);
			    }); 
		    
			   /* 공지사항 게시판 수정 다이얼로그창에서 수정 버튼클릭 시 controller로 넘어가는 비동기통신 */
		        function noticeUpdate(param) {
		    	    $.ajax({
		    	        url: "<c:url value='/notice/update.do'/>"
		    	         , type: 'POST'
		    	      , data: JSON.stringify(param)
		    	      , contentType : 'application/json; charset=UTF-8'
		    	      , dataType : 'json'
		    	      , success : function(data) {
			     	         alert(data.message);
							 if (data.status) {
								 location.href = "<c:url value='/notice/noticeList.do'/>"
							 }
		    	        }
		    	    });
		    	}  
		    
			   /* 
			   	    공지사항 게시판 상세보기 다이얼로그창에서 삭제 버튼클릭 시 
			   	  sciprt태그에서 전역변수로 선언한noticeId를 
			   	    서버로 넘겨주는 ajax구문
			   	*/
			    $("#delete").on("click", function() {
		    	    $.ajax({
		    	        url: "<c:url value='/notice/delete.do'/>"
		    	         , type: 'POST'
		    	      ,data: JSON.stringify({ noticeId: noticeId })
		    	      , contentType : 'application/json; charset=UTF-8'
		    	      , dataType : 'json'
		    	      , success : function(data) {
			     	         alert(data.message);
							 if (data.status) {
								 location.href = "<c:url value='/notice/noticeList.do'/>"
							 }
		    	        }
		    	    });
		    	});  
		/**************************************************************************/
		</script>
</body>
</html>