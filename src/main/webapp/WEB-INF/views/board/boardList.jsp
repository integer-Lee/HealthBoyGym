<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>답변형 게시판</title>
</head>
<body id = "boardBody">
	<form name="pageForm" id="pageForm" action="<c:url value='/board/boardList.do'/>" method="post" >
		<input type="hidden" name="pageNo" id="pageNo" value="${result.board.pageNo}" />
		<input type="hidden" name="searchTitle" id="searchTitle" value="${result.board.searchTitle}" >
		<input type="hidden" name="pageLength" id="pageLength" value="${result.board.pageLength}" >
	</form>
	
	<!-- id = "formTag"  -->
	<form name="mForm" id = "mForm" class="board" method='post'>
		<div id="contain">
		    <table class="table">
		      <caption>답변형 게시판</caption>
		        <tr class="head">
		          <th>글번호</th>
		          <th>제목</th>		      
		          <th>작성자</th>
		          <th>작성날짜</th>
		        </tr>
		
					<c:forEach var="board" items="${result.list}">
						<tr>
						    <td class="textNumber">${board.boardId}</td>
						    <td class="boardTitle" data-boardid="${board.boardId}" style="text-align: left;">
						    	<span style="padding-left:${(board.level-1)*20}px"></span>
						    	${board.level != 1 ? "[답변] " : ""}
						    	${board.title}
						    </td>						 
						    <td>${board.userId}</td>
						    <td>${board.regDate}</td>
						</tr>
					</c:forEach>
					
			  		<c:if test="${empty result.list}">
		             	<tr>
		             		<td colspan=7>검색결과가 없습니다</td>
		              	</tr>
	       		  	</c:if>
		</table>
		
		<div style="text-align: center; margin-top:20px;">
		   	<c:if test="${result.board.navStart != 1}">
		   		<a href="javascript:jsPageNo(${result.board.navStart-1})" style="padding: 10px;"> &lt; </a> 
		   	</c:if>
		   	
		   	<c:forEach var="item" begin="${result.board.navStart}" end="${result.board.navEnd}">
		   		<c:choose>
		   			<c:when test="${result.board.pageNo != item }">
		   				<a href="javascript:jsPageNo(${item})" style="padding: 10px; border: 1px solid gray; ">${item}</a>  
		   			</c:when>
		   			
		   			<c:otherwise>
		   				<strong style="font-size:1.2rem; margin-left: 15px" >${item}</strong>   
		   			</c:otherwise>
		   			
		   		</c:choose>
		   		
		   	</c:forEach>
		   	
		   	<c:if test="${result.board.navEnd != result.board.totalPageSize}">
		   		<a href="javascript:jsPageNo(${result.board.navEnd+1})" style="padding: 10px;"> &gt; </a> 
		   	</c:if>
	   	</div>  
		
		<input type="button" id = "boardInsert" value="등록" >
		
		</div>
	</form>
	<!----------------------------- 게시판 다이얼로그관련 소스코드---------------------------------- -->
	<!-- 게시글 상세보기 다이얼로그 -->
 	<div id="boardDialog" style = "display:none;" title="게시글 상세보기">
		<form>
			<input type="hidden" id = "boardHiddenId" value="">
			<h2 id="boardDialogTitle">게시글  상세보기</h2>
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
					<input type="button" id="reviseScreenSwitch" value="수정화면전환" >
					<input type="button" id ="delete" value="삭제">
				</c:if>
				<input type="button" id="replyForm" value="답글화면전환" >
			</div>
			<br>
			<!-- 
				댓글 작성 부분
				input값을 홈으로 보내줄 필요가 없기때문에 form태그로 감싸주지 않아도 된다. 
			-->
			<div id="comment-wirte">
				<input type = "text" id="commentWriter" value="${LoginMember.userid}" placeholder="작성자">
				<input type = "text" id="commentContents" value="" placeholder="내용">
				<input type = "hidden" id="commentRegDate" value="" placeholder="날짜">
				<input type = "button" id="comment-write-btn" value="댓글작성">
			</div>
			
			<!-- 댓글 출력 부분 -->
			<div id = "commentList" data-loaded="false">
			</div>
			
		</form>
	</div> 
	
	<!-- 게시판 게시글 삽입 다이얼로그 -->
	<div id = "insertDialog" style="display:none" title="게시판 게시글 삽입">
	<form  method="post" name = "mForm" id = "mForm" autocomplete="off">
		<input type="hidden" name="fixed_yn" id="fixed_yn" value="N">
			<table class="tb">
				<caption>게시글 작성</caption>
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
					<td><input class="text" type="text" name="contents" id="contents"  class = "board_contetns" required/></td>
				</tr>
			</table>
		<input id="boardInsertForm" type="button" value="등록" /> 
		<input type="reset" value="초기화" />
	</form>
	</div> 
	
	<!-- 게시글 수정 다이얼로그 -->
	<div id = "boardUpdateDialog" style="display:none" title="게시글 수정">
		<form action="" name="mForm" id="mForm" method="post" autocomplete="off">
		   	<input type="hidden" name="noticeUpdateId" id="noticeUpdateId" value=""/> 
		   	<input type="hidden" name="fixed_yn" id="fixed_yn" value="N">
			<table class="tb">
				<caption>게시글 수정</caption>
				<tr>
					<th class="col">작성자</th>
					<td><input class="text" type="text" name="updateMemberid" id="updateMemberid" value="${LoginMember.userid}" readonly /></td>
				</tr>
				<tr>
					<th class="col"><label for="updateTitle">제목</label></th>
					<td><input class="text" type="text" name="updateTitle" id="updateTitle" value="" class ="text_title" required/></td>
				</tr>
				<tr>
					<th class="col"><label for="updateContents">내용</label></th>
					<td><input class="text" type="text" name="updateContents" id="updateContents" value="" class = "board_contetns" required/></td>
				</tr>
			</table>
			<input id="revise" type="button" value="수정하기" /> 
			<input type="reset" value="초기화" />
		</form>	
	</div>
	
	<!----------------------------- 답글 다이얼로그관련 소스코드------------------------------------->
	<!-- 답글 삽입 다이얼로그 -->
	<div id = "replyDialog" style="display:none" title="답글 작성화면">
	<form  method="post" name = "mForm" id = "mForm" autocomplete="off">
		<input type="hidden" name="fixed_yn" id="fixed_yn" value="N">
			<table class="tb">
				<caption>답글 작성화면</caption>
				<tr>
					<th class="col">작성자</th>
					<td><input class="text" type="text" name="memberid" id="memberid" value="${LoginMember.userid}" readonly /></td>
				</tr>
				<tr>
					<th class="col"><label for="title">제목</label></th>
					<td><input class="text" type="text" name="replyTitle" id="replyTitle" class ="text_title" required/></td>
				</tr>
				<tr>
					<th class="col"><label for="contents">내용</label></th>
					<td><input class="text" type="text" name="replyContents" id="replyContents"  class = "board_contetns" required/></td>
				</tr>
			</table>
		<input id="replyRegistration" type="button" value="답글 등록" /> 
		<input type="reset" value="초기화" />
	</form>
	</div> 
	<!----------------------------------------------------------------------------------------------->
	
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
	$(document).ready(function() {
	    let boardId = ""; // boardId를 어떻게 설정하는지에 따라서 이 값이 할당되어야 합니다.
	    
	    //댓글 로딩 함수
	    function loadComments(listComment) {
	    	     const commentListHTML = document.querySelector("#commentList");

	    	     listComment.forEach(comment => {
	    	          console.log("댓글 데이터:", comment); // 댓글 데이터 확인
	    	          const commentItem = document.createElement("div");
	    	          commentItem.className = "comment";

	    	          commentItem.innerHTML = 
	    	             "<input type='hidden' value='" + comment.commentNo + "' class='comment-id'>"  +
	    	              "<p>작성자: " + comment.userId + "</p>" + 
	    	              "<p>작성일: " +  comment.regDate + "</p>" + 
	    	              "<p>내용: " + comment.comments + "</p>" +
	    	               "<button type='button'>수정</button>" +
	    	               "<button id='deleteCnt' type='button'>삭제</button>";
	    	          commentListHTML.appendChild(commentItem);
	    	      });
		}
		    
			  $(document).on("click", ".boardTitle", function(e) {
				  e.preventDefault();
				  
				  boardId = $(this).data("boardid");  // 클릭된 title의 boardId 값을 가져옵니다.
				  console.log(boardId);
				  
				    /* 게시글 상세보기 다이얼로그 창 띄우는 jquery */
					 $( "#boardDialog" ).dialog({
				      autoOpen: false,
				      height: 700,
				      width: 800,
				      modal: true,
				      close: function() {
				    	  $(".comment").remove();
				      }
				    });
					
				   // 서버에 AJAX 요청을 보내서 해당 게시글의 내용을 가져옵니다.
				   $.ajax({
				      type: "POST",
					  url: "<c:url value='/board/boardView.do'/>",  
				      contentType: "application/json; charset=UTF-8",
				      data: JSON.stringify({ boardId: boardId }),
				      dataType: "json",
				      success: function(response) {
				    	  console.log(response);
				    	  if(response.status){
				    		  const board = response.board;
					         // 응답으로 받은 데이터를 다이얼로그에 설정합니다.
					         $('#detailTitle').text(board.title);
					         $('#detailUserId').text(board.userId);
					         $('#detailContents').text(board.contents);
					         $('#detailRegDate').text(board.regDate);
					         $('#detailHit').text(board.hit); 
					         $('#noticeHiddenId').val(board.boardId);
					         console.log("댓글", response.listComment);
					         
					         loadComments(response.listComment); // 댓글목록을 출력하는 함수호출 
					         
							// 다이얼로그를 오픈합니다.
					         $('#boardDialog').dialog("open");
				    	  }
				      },
				      error: function(error) {
				         alert("데이터를 가져오는 데 실패했습니다.");
				      }
				   });
				   
				});
		    
/************************************************* 댓글 삽입 Ajax구문 **************************************************/
 
			 $("#comment-write-btn").on("click", function() {
			    const writer = $("#commentWriter").val();
			    const contents = $("#commentContents").val();
			    const regDate = $("#commentContents").val();
			
			    // AJAX 요청에 전달할 데이터 객체
			    const param = {
			        userId: writer,
			        boardId: boardId,   // 전역 변수로 받아온 boardId
			        comments: contents
			    };
			
			    // AJAX 요청 보내기
			    $.ajax({
			        url: "<c:url value='/comment/save.do'/>",
			        type: 'POST',
			        data: JSON.stringify(param),
			        contentType: 'application/json; charset=UTF-8',
			        dataType: 'json',
			        success: function(data) {
			            alert(data.message);
			            if (data.status) {
			                // 댓글 작성 성공 시, 작성한 댓글을 화면에 추가합니다.
			                const commentListHTML = document.querySelector("#commentList");
			                const commentItem = document.createElement("div");
			                commentItem.className = "comment"; //commentItem의 class의 속성을 "commentList"로 지정합니다.
			                commentItem.innerHTML =
			                    "<p>작성자: " + writer + "</p>" +
			                    "<p>내용: " + contents + "</p>" +
			                    "<p>날짜: " +  data.commetVo.regDate + "</p>" + 
			                    "<button type='button'>수정</button>" +
			                    "<button id='deleteCnt' type='button'>삭제</button>";
			                commentListHTML.appendChild(commentItem);
			
			                // 입력 필드 초기화
			                $("#commentContents").val("");
			            }
			        },
			        error: function(error) {
			            console.log("요청 실패", error);
			            // 오류 처리를 수행하세요.
			        }
			    });
			});


		   /****************************** 게시판 게시글 삽입 scirpt 다이얼로그 *****************************/ 
		    /* 게시판 게시글  삽입 다이얼로그  창 띄우는 jquery*/
		    	/* 게시판 게시글  삽입 다이얼로그 창 띄우는 jquery */
			var boardInsertDialog = $( "#insertDialog" ).dialog({
		      autoOpen: false,
		      height: 700,
		      width: 800,
		      modal: true,
		      close: function() {
		      }
		    });
		    
			 /* 게시판 게시글 삽입 다이얼로그 이벤트핸들러  JQuery방법 2*/
		    $("#boardInsert").on("click", function() {
		    	boardInsertDialog.dialog("open");
		    });
			 
		    /* 게시판 게시글 삽입버튼 클릭 시 inputType=text값이 VO의 필드로 매칭되는 이벤트핸들러 */
		      $(document).on("click", "#boardInsertForm", function() {
				    const boardTitle = $("#title");
				    const boardContents = $("#contents");
				
				    const Title = boardTitle.val();
				    const Contents = boardContents.val();
				    
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
		    	  boardInsert(param);
			    });
		    
			   /* 게시판 삽입 다이얼로그창에서 등록 버튼클릭 시 controller로 넘어가는 비동기통신 */
		      function boardInsert(param) {
		    	    $.ajax({
		    	        url: "<c:url value='/board/insert.do'/>"
		    	        
		    	         , type: 'POST'
		    	      , data: JSON.stringify(param)
		    	      , contentType : 'application/json; charset=UTF-8'
		    	      , dataType : 'json'
		    	      , success : function(data) {
			     	         alert(data.message);
							 if (data.status) {
								 location.href = "<c:url value='/board/boardList.do'/>"
							 }
		    	        }
		    	    });
		    	}
		/**************************************************************************/
		
		/****************************** 게시글 수정 scirpt 다이얼로그 *****************************/
		 /* 게시글  수정 다이얼로그  창 띄우는 jquery*/
			var boardUpdateDialog = $( "#boardUpdateDialog" ).dialog({
		      autoOpen: false,
		      height: 700,
		      width: 800,
		      modal: true,
		      close: function() {
		      }
		    });
		    
		
			 /* 게시글 수정 다이얼로그 이벤트핸들러  JQuery방법 2*/
		    $("#reviseScreenSwitch").on("click", function() {
		    	 // 서버에 AJAX 요청을 보내서 해당 게시글의 내용을 가져옵니다.
				   $.ajax({
				      type: "POST",
					  url: "<c:url value='/board/boardView.do'/>",  
				      contentType: "application/json; charset=UTF-8",
				      data: JSON.stringify({ boardId: boardId }),
				      dataType: "json",
				      success: function(response) {
				    	  if(response.status){
				    		  const board = response.board;
					         // 응답으로 받은 데이터를 다이얼로그에 설정합니다.
					         $('#updateTitle').val(board.title);
					         $('#updateContents').val(board.contents);
						     // 다이얼로그를 오픈합니다.
					         boardUpdateDialog.dialog("open"); 
				    	  }
				    	  
				      },
				      error: function(error) {
				         alert("데이터를 가져오는 데 실패했습니다.");
				      }
				   });
		    	
		    	
		    });
			 
		    /* 게시글 수정하기버튼 클릭 시 inputType=text값이 VO의 필드로 매칭되는 이벤트핸들러 */
		        $(document).on("click", "#revise", function() {
				    const boardTitle = $("#updateTitle");
				    const boardContents = $("#updateContents");
				
				    const Title = boardTitle.val();
				    const Contents = boardContents.val();
				    
				    if (Title === "") {
				        alert("제목을 입력하세요.");
				        updateTitle.focus();
				        return;
				    }
				
				    if (Contents === "") {
				        alert("내용을 입력하세요.");
				        updateContents.focus();
				        return;
				    }
				
				    const param = {
				    	userId : $("#updateMemberid").val(),
				    	boardId : boardId,
				    	title: Title,
				    	contents :Contents,
				    };
		    	  boardUpdate(param);
			    }); 
		    
			   /* 게시판 수정 다이얼로그창에서 수정 버튼클릭 시 controller로 넘어가는 비동기통신 */
		        function boardUpdate(param) {
		    	    $.ajax({
		    	        url: "<c:url value='/board/update.do'/>"
		    	         , type: 'POST'
		    	      , data: JSON.stringify(param)
		    	      , contentType : 'application/json; charset=UTF-8'
		    	      , dataType : 'json'
		    	      , success : function(data) {
			     	         alert(data.message);
							 if (data.status) {
								 location.href = "<c:url value='/board/boardList.do'/>"
							 }
		    	        }
		    	    });
		    	}  
		    
			   /* 
			   	    게시판 상세보기 다이얼로그창에서 삭제 버튼클릭 시 
			   	  sciprt태그에서 전역변수로 선언한noticeId를 
			   	    서버로 넘겨주는 ajax구문
			   	*/
			    $("#delete").on("click", function() {
		    	    $.ajax({
		    	        url: "<c:url value='/board/delete.do'/>"
		    	         , type: 'POST'
		    	      ,data: JSON.stringify({ boardId: boardId })
		    	      , contentType : 'application/json; charset=UTF-8'
		    	      , dataType : 'json'
		    	      , success : function(data) {
			     	         alert(data.message);
							 if (data.status) {
								 location.href = "<c:url value='/board/boardList.do'/>"
							 }
		    	        }
		    	    });
		    	});  
		/**************************************************************************/
		
		 /****************************** 답글 양식 다이얼로그 *****************************/ 
		    /* 답글작성 양식 다이얼로그 창 띄우는 jquery */
			var replyDialog = $( "#replyDialog" ).dialog({
		      autoOpen: false,
		      height: 700,
		      width: 800,
		      modal: true,
		      close: function() {
		      }
		    });
		    
			 /* 답글 삽입 다이얼로그 이벤트핸들러  JQuery방법 2*/
		    $("#replyForm").on("click", function() {
		    	replyDialog.dialog("open");
		    });
			 
		    /* 답글 삽입버튼 클릭 시 inputType=text값이 VO의 필드로 매칭되는 이벤트핸들러 */
		      $(document).on("click", "#replyRegistration", function() {
				    const replyTitle = $("#replyTitle");
				    const replyContents = $("#replyContents");
				
				    const Title = replyTitle.val();
				    const Contents = replyContents.val();
				    
				    if (Title === "") {
				        alert("제목을 입력하세요.");
				        replyTitle.focus();
				        return;
				    }
				
				    if (Contents === "") {
				        alert("내용을 입력하세요.");
				        replyContents.focus();
				        return;
				    }
				
				    const param = {
				    	pid : boardId,
				    	userId : $("#memberid").val(),
				    	title: Title,
				    	contents :Contents,
				    };
		    	  replyInsert(param);
			    });
		    
			   /* 게시판 삽입 다이얼로그창에서 등록 버튼클릭 시 controller로 넘어가는 비동기통신 */
		      function replyInsert(param) {
		    	    $.ajax({
		    	        url: "<c:url value='/board/replyBoard'/>"
		    	         , type: 'POST'
		    	      , data: JSON.stringify(param)
		    	      , contentType : 'application/json; charset=UTF-8'
		    	      , dataType : 'json'
		    	      , success : function(data) {
			     	         alert(data.message);
							 if (data.status) {
								 location.href = "<c:url value='/board/boardList.do'/>"
							 }
		    	        }
		    	    });
		    	}
		/**************************************************************************/
	});
		</script>
</body>
</html>