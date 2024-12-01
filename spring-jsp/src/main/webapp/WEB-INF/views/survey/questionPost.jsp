<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>설문 조사</title>
</head>
<style>
body {
	font-family: Arial, sans-serif;
	line-height: 1.6;
	padding: 20px;
}

.question-container {
	margin-bottom: 20px;
	padding: 15px;
	border: 1px solid #ccc;
	border-radius: 5px;
	background-color: #f9f9f9;
}

.question-text {
	font-size: 18px;
	font-weight: bold;
	margin-bottom: 10px;
}

.options {
	margin-left: 20px;
}

.pagination-container {
	margin-top: 30px;
	text-align: center;
}

.pagination {
	display: inline-block;
	list-style: none;
	padding: 0;
}

.pagination li {
	display: inline;
	margin: 0 5px;
}

.pagination a {
	padding: 8px 12px;
	text-decoration: none;
	color: #007bff;
	border: 1px solid #ccc;
	border-radius: 5px;
}

.pagination .active a {
	background-color: #007bff;
	color: #fff;
	border-color: #007bff;
}

.grid-container {
	display: grid;
	gap: 10px; /* 아이템 간의 간격 */
	grid-template-columns: repeat(auto-fill, minmax(150px, 1fr));
	/* 최소 너비 150px, 아이템 개수에 따라 자동 조정 */
	align-items: start; /* 아이템을 상단 정렬 */
	justify-items: start; /* 아이템을 좌측 정렬 */
}

.grid-item {
	display: flex;
	align-items: center;
}

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
</style>
<body>
	<h1>설문 질문 리스트</h1>
	<form action="/survey/submitAnswers.do" method="POST">
		<c:set var="childIndex" value="0" />
		<c:forEach items="${question}" var="question" varStatus="status">
			<c:choose>
				<c:when test="${question.questionLevel == 1}">
					<c:set var="childIndex" value="0" />
					<div class="question-container">
						<div class="question-text">
							<span>문항 ${question.questionIndex}. <c:choose>
									<c:when test="${question.categoryName != null}">
                						[${question.categoryName}]
            						</c:when>
								</c:choose>
							</span> <span> ${question.questionText}</span>
						</div>
						<div class="options grid-container">

							<c:if test="${question.questionType == 2}">

								<c:set var="hasAnswer" value="false" />
								<c:forEach var="option" items="${answerText}">
									<c:if test="${option.questionId == question.questionId}">
										<textarea name="text-${question.questionId}"
											placeholder="답변을 입력해주세요">
                    						<c:out value="${option.answerText}" default="" />
                						</textarea>
										<c:set var="hasAnswer" value="true" />
									</c:if>
								</c:forEach>

								<c:if test="${not hasAnswer}">
									<textarea name="text-${question.questionId}"
										placeholder="답변을 입력해주세요"></textarea>
								</c:if>
							</c:if>

							<c:if test="${question.questionType != 2}">
								<c:forEach var="optionItem" items="${option}">
									<c:if test="${optionItem.questionId == question.questionId}">
										<div class="grid-item">
											<input type="checkbox" id="option-${optionItem.optionId}"
												name="answers-${question.questionId}"
												value="${optionItem.optionId}"
												data-type="${question.questionType}"
												${optionItem.isSelected == 1 || optionItem.answerText != null ? 'checked' : ''} />
											<label for="option-${optionItem.optionId}">${optionItem.optionText}</label>


											<c:if test="${optionItem.optionText.startsWith('기타')}">
												<!-- answerText에서 해당 question_id와 일치하는 ANSWER_TEXT 가져오기 -->
												<c:set var="otherAnswerText" value="" />
												<c:forEach var="answer" items="${answerText}">
													<c:if test="${answer.questionId == question.questionId}">
														<c:set var="otherAnswerText" value="${answer.answerText}" />
													</c:if>
												</c:forEach>
												<input type="text" id="other-text-${optionItem.optionId}"
													name="otherText-${question.questionId}"
													style="display: ${optionItem.isSelected == 1 ? 'block' : 'none'};"
													value="${otherAnswerText}" placeholder="기타 내용을 입력하세요" />
											</c:if>
										</div>
									</c:if>
								</c:forEach>
							</c:if>
						</div>
					</div>
				</c:when>
				<c:otherwise>
					<c:set var="childIndex" value="${childIndex + 1}" />
					<div class="question-container"
						style="margin-left: ${question.questionLevel * 20}px;">
						<div class="question-text">문항 ${parentIndex}-${childIndex}.
							${question.questionText}</div>

						<div class="options grid-container">

							<c:if test="${question.questionType == 2}">
								<c:set var="hasAnswer" value="false" />
								<c:forEach var="option" items="${answerText}">
									<c:if test="${option.questionId == question.questionId}">
										<textarea name="text-${question.questionId}"
											placeholder="답변을 입력해주세요">
                    <c:out value="${option.answerText}" default="" />
                </textarea>
										<c:set var="hasAnswer" value="true" />
									</c:if>
								</c:forEach>

								<c:if test="${not hasAnswer}">
									<textarea name="text-${question.questionId}"
										placeholder="답변을 입력해주세요"></textarea>
								</c:if>
							</c:if>
							<c:if test="${question.questionType != 2}">
								<c:forEach var="optionItem" items="${option}">
									<c:if test="${optionItem.questionId == question.questionId}">
										<div class="grid-item">
											<input type="checkbox" id="${optionItem.optionId}"
												name="answers-${question.questionId}"
												value="${optionItem.optionId}"
												data-type="${question.questionType}"
												<c:if test="${optionItem.isSelected == 1}">checked</c:if> />
											<label for="option-${optionItem.optionId}">${optionItem.optionText}</label>

											<c:if test="${optionItem.optionText.startsWith('기타')}">
												<!-- answerText에서 해당 question_id와 일치하는 ANSWER_TEXT 가져오기 -->
												<c:set var="otherAnswerText" value="" />
												<c:forEach var="answer" items="${answerText}">
													<c:if test="${answer.questionId == question.questionId}">
														<c:set var="otherAnswerText" value="${answer.answerText}" />
													</c:if>
												</c:forEach>
												<input type="text" id="other-text-${optionItem.optionId}"
													name="otherText-${question.questionId}"
													style="display: ${optionItem.isSelected == 1 ? 'block' : 'none'};"
													value="${otherAnswerText}" placeholder="기타 내용을 입력하세요" />
											</c:if>
										</div>
									</c:if>
								</c:forEach>
							</c:if>
						</div>
					</div>
				</c:otherwise>
			</c:choose>
		</c:forEach>

		<div class="pagination-container">
			<ul class="pagination">
				<c:if test="${pageDTO.prev}">
					<li><a class="page-link"
						href="/survey/questionPost.do?surveyId=${survey}&pageNum=${criteria.pageNum - 1}&amount=${criteria.amount}"
						aria-label="Previous">&lt;</a></li>
				</c:if>

				<c:if test="${pageDTO.next}">
					<li><a class="page-link"
						href="/survey/questionPost.do?surveyId=${survey}&pageNum=${criteria.pageNum + 1}&amount=${criteria.amount}"
						aria-label="Next">&gt;</a></li>
				</c:if>
			</ul>
		</div>
		<div class="button-container">
			<div class="left-buttons">
				<button>
					<a href="/survey/surveyList.do" class="btn btn-outline-secondary">목록</a>
				</button>
			</div>
			<div class="right-button">
				<button type="submit">제출하기</button>
			</div>
		</div>
	</form>
</body>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="/js/egovframework/survey/questionPost.js"></script>
<script>
	$(document).ready(function() {
		$('.question-container').each(function() {
			// 각 question-container 내부의 grid-item 개수를 계산
			const optionCount = $(this).find('.grid-item').length;
			const gridContainer = $(this).find('.grid-container');

			gridContainer.attr('data-count', optionCount);

			if (optionCount < 9) {
				gridContainer.css('grid-template-columns', 'repeat(4, 1fr)'); // 한 줄에 4개
			} else {
				gridContainer.css('grid-template-columns', 'repeat(3, 1fr)'); // 한 줄에 3개
			}
		});
	});
</script>
</html>