<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi"
	crossorigin="anonymous">
<title>설문조사</title>
</head>
<style>
</style>
<body>
	<main class="mt-5 pt-5">
		<div class="container-fluid px-4">
			<div class="nav">
				<h1 class="mt-4">설문리스트</h1>
				<button type="button" id="logout" class="btn btn-secondary float-end" href="/logout.do"> <i
					class="fas fa-edit"></i> 로그아웃
				</button>
			</div>
			<div class="card mb-4">
				<div class="card-header">

				
					</a>
				</div>
				<div class="card-body">
					<div class="top-container">
						<div class="count-display">
							<span>총</span><span>${totalCount}개</span>	
						</div>
					</div>
					<div id="surveyListConatiner">
						<table class="table table-hover table-striped">
							<thead>
								<tr>
									<th>surveyId</th>
									<th>순번</th>
									<th>제목</th>
									<th>작성자</th>
									<th>작성일</th>
								</tr>
							</thead>
							<c:set var="startNumber" value="${totalCount - (criteria.pageNum - 1) * criteria.amount}" />
							<tbody>
								<c:forEach items="${surveyList}" var="survey" varStatus="status">
									<tr>
										<td>${survey.surveyId}</td>
            							<td>
            								${startNumber - status.index}
            								<input type="hidden" value="${survey.surveyId}">
            							</td>
        								<td class="title-column">
											<a href="/survey/surveyPost.do?surveyId=${survey.surveyId}">
												${survey.title}
											</a></td>
										<td>${survey.name}</td>
										<td>
   	 										<fmt:formatDate value="${survey.createDt}" pattern="yyyy-MM-dd" />
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
					<div class="pagination-container">
					<ul class="pagination">
    					<c:if test="${pageDTO.prev}">
        					<li class="page-item">
        						<a class="page-link" href="/survey/surveyList.do?pageNum=1&amount=${criteria.amount}" aria-label="Previous">
                					<span aria-hidden="true">&laquo;</span>
            					</a>
            				</li>
            				<li>
            					<a class="page-link" href="/survey/surveyList.do?pageNum=${pageDTO.startPage - 1}&amount=${criteria.amount}" aria-label="Previous">
                					<span aria-hidden="true">&lt;</span>
            					</a>
        					</li>
    					</c:if>

    					<c:forEach var="pageNum" begin="${pageDTO.startPage}" end="${pageDTO.endPage}">
        					<li class="page-item ${pageNum == criteria.pageNum ? 'active' : ''}">
            					<a class="page-link" href="/survey/surveyList.do?pageNum=${pageNum}&amount=${criteria.amount}">${pageNum}</a>
        					</li>
    					</c:forEach>

    					<c:if test="${pageDTO.next}">
        					<li class="page-item">
        						<a class="page-link" href="/survey/surveyList.do?pageNum=${pageDTO.endPage + 1}&amount=${criteria.amount}" aria-label="Next">
                					<span aria-hidden="true">&gt;</span>
            					</a>
        					</li>
        					<li>
            					<a class="page-link" href="/survey/surveyList.do?pageNum=${pageDTO.realEnd}&amount=${criteria.amount}&searchType=${criteria.searchType}&keyword=${criteria.keyword}" aria-label="Next">
                					<span aria-hidden="true">&raquo;</span>
            					</a>
        					</li>
        					
    					</c:if>
					</ul>
					
					</div>
				</div>
			</div>
		</div>
		
	</main>
</body>
<script src="https://code.jquery.com/jquery-3.6.1.js"
	integrity="sha256-3zlB5s2uwoUzrXK3BT7AX3FyvojsraNFxCc2vC/7pNI="
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3"
	crossorigin="anonymous"></script>
<script type="text/javascript">
	$(document).ready(function() {
		
	});
</script>
</html>