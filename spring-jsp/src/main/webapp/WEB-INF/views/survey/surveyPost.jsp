<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<title>설문내용</title>
</head>
<style>
.button-container {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-top: 10px;
}
.left-buttons, .right-button {
    display: flex;
    gap: 10px;
}
nav#top-menu {
    background-color: #343a40 !important;
    padding: 10px 20px !important;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1) !important;
    height: 60px !important;
}

nav#top-menu .menu-bar {
    display: flex !important;
    justify-content: flex-start !important;
    list-style: none !important;
    margin: 0 !important;
    padding: 0 !important;
}

nav#top-menu .menu-item {
    margin-right: 20px !important; /* 메뉴 아이템 간 간격 */
    margin-top: 5px !important;
}

nav#top-menu .menu-link {
    text-decoration: none !important;
    color: #ffffff !important; /* 텍스트 색상 */
    font-size: 20px !important;
    font-weight: bold !important;
    transition: color 0.3s, background-color 0.3s !important;
    padding: 5px 10px !important;
    border-radius: 4px !important; /* 약간 둥근 모서리 */
}

nav#top-menu .menu-link:hover {
    background-color: #007bff !important; /* 호버 시 배경색 */
    color: #ffffff !important; /* 호버 시 텍스트 색상 */
}
</style>
<body>
	<main class="mt-5 pt-5">
		<div class="container-fluid px-4">
			<h1 class="mt-4">설문 조회</h1>
			<div class="card mb-4">
				<div class="card-body">
				    <input type="hidden" id="surveyId" value="${surveyPost.surveyId}">
					<div class="mb-3">
						<label for="title" class="form-label">제목</label>
						<input type="text" class="form-control" id="title" name="title" value="${surveyPost.title}" readOnly>
					</div>
					<div class="mb-3">
						<label for="content" class="form-label">내용</label>
						<textarea class="form-control" id="content" name="content" readOnly>${surveyPost.content}</textarea>
					</div>

					<div class="button-container">
						<div class="left-buttons">
							<a href="/survey/surveyList.do" class="btn btn-outline-secondary">목록</a>
						</div>
						<div class="right-buttons">
							<a href="/survey/questionPost.do?surveyId=${surveyPost.surveyId}" class="btn btn-outline-primary">설문참가</a>
						</div>	
					</div>					
				</div>
			</div>
		</div>
		
	</main>
</body>
<script src="https://code.jquery.com/jquery-3.6.1.js" integrity="sha256-3zlB5s2uwoUzrXK3BT7AX3FyvojsraNFxCc2vC/7pNI=" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<script type="text/javascript">

</script>
<script type="text/javascript">
$(document).ready(function() {
   

});
</script>
</html>