<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="content">
   <table id="table-noticelistbody">
      <caption>
         <h1>회원 공지사항 </h1>
      </caption>

   <form name="mForm" id="mForm" action="<c:url value='/noticelist'/>" method="post">
    <input type="hidden" name="pageNo" id="mpageNo" value="${result.notice.pageNo}" />
    <div class="center-container">
        <div class="search-container">
            <label>건수: </label>
            <select name="pageLength" id="pageLength">
                <option value="10" ${result.notice.pageLength == 10 ? 'selected="selected"' : ''}>10건</option>
                <option value="20" ${result.notice.pageLength == 20 ? 'selected="selected"' : ''}>20건</option>
                <option value="50" ${result.notice.pageLength == 50 ? 'selected="selected"' : ''}>50건</option>
                <option value="100" ${result.notice.pageLength == 100 ? 'selected="selected"' : ''}>100건</option>
            </select>
            <label>제목 : </label>
            <input type="text" name="searchTitle" id="searchTitle" value="${result.notice.searchTitle}">
            <input type="submit" value="검색">
        </div>
    </div>
</form>

      <!-- 페이징 처리 -->
      <form name="pageForm" id="pageForm"
         action="<c:url value='/noticelist'/>" method="post">
         <input type="hidden" name="pageNo" id="pageNo"
            value="${result.notice.pageNo}" /> <input type="hidden"
            name="searchTitle" id="searchTitle"
            value="${result.notice.searchTitle}"> <input type="hidden"
            name="pageLength" id="pageLength"
            value="${result.notice.pageLength}">
      </form>

         <tbody id="getNoticeList">
            <tr class="tr-noticelistbody">
               <th>공지 번호</th>
               <th>제목</th>
               <th>작성자</th>
               <th>등록날짜</th>
               <th>수정날짜</th>
               <th>조회수</th>
            </tr>
            <c:forEach var="notice" items="${result.list}">
               <tr class="tr-adminnoticelistbody">
                  <td id="noticeNo">${notice.noticeid}</td>
                  <td id="notice-detail" data-noticeid="${notice.noticeid}"><a
                     href="javascript:void(0);" class="notice-usertitle">${notice.title}</a></td>
                  <td>${notice.writer_uid}</td>
                  <td>${notice.reg_date}</td>
                  <td>${notice.mod_date}</td>
                  <td>${notice.view_count}</td>
               </tr>
            </c:forEach>

            <!--    목록이 하나도 없을 경우 -->
            <c:if test="${empty result.list}">
               <tr>
                  <td colspan=7>검색결과가 없습니다</td>
               </tr>
            </c:if>

         </tbody>
   </table>

   <div id="pagingnav">
      <c:if test="${result.notice.navStart != 1}">
         <a href="javascript:jsPageNo(${result.notice.navStart-1})"
            id="pagingnav-btn"> &lt; </a>
      </c:if>
      <c:forEach var="item" begin="${result.notice.navStart}"
         end="${result.notice.navEnd}">
         <c:choose>
            <c:when test="${result.notice.pageNo != item }">
               <a href="javascript:jsPageNo(${item})" id="pagingnav-link">${item}</a>
            </c:when>
            <c:otherwise>
               <strong id="pagingnav-strong">${item}</strong>
            </c:otherwise>
         </c:choose>
      </c:forEach>
      <c:if test="${result.notice.navEnd != result.notice.totalPageSize}">
         <a href="javascript:jsPageNo(${result.notice.navEnd+1})"
            id="pagingnav-btn"> &gt; </a>
      </c:if>
   </div>


</div>

<!--  공지사항 상세보기  다이얼로그-->
<div id="notice-userdialog" title="공지사항 상세보기 ">
   <form name="bForm" id="bForm" method="post" autocomplete="off">
      <fieldset>
         <label for="noticeid">공지사항번호 : </label> <input id="noticeid"
            type="text" name="noticeid" required="required" value=""
            class="text ui-widget-content ui-corner-all" disabled="disabled" /><br />

         <label for="title">제목 : </label> <input id="title" type="text"
            name="title" required="required" value=""
            class="text ui-widget-content ui-corner-all" disabled="disabled" /><br />

         <label for="contents">내용 : </label> <input id="contents" type="text"
            name="contents" value="" required="required"
            class="text ui-widget-content ui-corner-all" disabled="disabled" /><br />

         <label for="writer_uid">작성자 : </label> <input id="writer_uid"
            type="text" name="writer_uid" value="" required="required"
            class="text ui-widget-content ui-corner-all" disabled="disabled" /><br />
   </form>
</div>





<script src="<c:url value='/resources/js/notice.js'/>"></script>
<script>
   // notice.js 상세보기 ajax url 보내기
   const GET_NOTICEID_URL = "<c:url value='/admin/getnoticeid' />";

   <!-- //공지사항 유저의 상세보기 다이알로그 -->
   NoticeDetailUserDialog = $("#notice-userdialog").dialog({
      autoOpen : false,
      height : 650,
      width : 600,
      modal : true,
      buttons : {
         "닫기" : function() {
            NoticeDetailUserDialog.dialog("close");
         },
      },
      close : function() {
         NoticeDetailUserDialog.dialog("close");
      }
   });
   
   
   $(document).on("click", ".notice-usertitle", function() {
	   const noticeId = $(this).parent().data("noticeid");  // noticeid 값을 가져옵니다.
	   // 서버에 AJAX 요청을 보내서 해당 공지사항의 내용을 가져옵니다.
	   $.ajax({
	      url: GET_NOTICEID_URL,  
	      type: "POST",
	      data: { noticeid: noticeId },
	      dataType: "json",
	      success: function(response) {
	         // 응답으로 받은 데이터를 다이얼로그에 설정합니다.
	         $('#noticeid').val(response.noticeid);
	         $('#title').val(response.title);
	         $('#contents').val(response.contents);
	         $('#writer_uid').val(response.writer_uid);
	         
	         // 다이얼로그를 오픈합니다.
	         NoticeDetailUserDialog.dialog("open");
	      },
	      error: function(error) {
	         alert("데이터를 가져오는 데 실패했습니다.");
	      }
	   });
	}); 공지사항 유저의 상세보기 ajax
   </script> 공지사항 사용자의 jsp 파일