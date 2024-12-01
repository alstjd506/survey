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
					<c:set var="parentIndex" value="${question.questionIndex}"/>
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
											placeholder="500자 이내의 답변을 입력해주세요" maxlength="500">
                    						<c:out value="${option.answerText}" default="" />
                						</textarea>
										<c:set var="hasAnswer" value="true" />
									</c:if>
								</c:forEach>

								<c:if test="${not hasAnswer}">
									<textarea name="text-${question.questionId}"
										placeholder="500자 이내의 답변을 입력해주세요" maxlength="500"></textarea>
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
												<c:forEach var="answer" items="${answerText}">
													<c:if test="${answer.questionId == question.questionId}">
														<c:set var="otherAnswerText" value="${answer.answerText}" />
													</c:if>
												</c:forEach>
												<input type="text" id="other-text-${optionItem.optionId}"
													name="otherText-${question.questionId}"
													style="display: ${optionItem.isSelected == 1 ? 'block' : 'none'};"
													value="${otherAnswerText}" placeholder="100자 이내의 기타 내용을 입력하세요" maxlength="100" />
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
											placeholder="500자 이내의 답변을 입력해주세요" maxlength="500">
                    <c:out value="${option.answerText}" default="" />
                </textarea>
										<c:set var="hasAnswer" value="true" />
									</c:if>
								</c:forEach>

								<c:if test="${not hasAnswer}">
									<textarea name="text-${question.questionId}"
										placeholder="500자 이내의 답변을 입력해주세요" maxlength="500"></textarea>
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
													value="${otherAnswerText}" placeholder="100자 이내의 기타 내용을 입력하세요" maxlength="100" />
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
<script>
	$(document).ready(function() {
		$('.question-container').each(function() {
			const optionCount = $(this).find('.grid-item').length;
			const gridContainer = $(this).find('.grid-container');

			gridContainer.attr('data-count', optionCount);

			if (optionCount < 9) {
				gridContainer.css('grid-template-columns', 'repeat(4, 1fr)'); 
			} else {
				gridContainer.css('grid-template-columns', 'repeat(3, 1fr)'); 
			}
		});
		
		
		$('input[type="checkbox"]').on('click', function () {
	        const questionGroup = $(this).attr('name'); // 체크박스 그룹 가져오기
	        const optionText = $(this).next('label').text().trim(); // label 텍스트 가져오기
	        const questionId = questionGroup.split('-')[1]; // questionId 추출
	        const optionId = $(this).val(); // optionId 가져오기
	        const isChecked = $(this).is(':checked'); // 현재 체크 상태
	        const isType3 = $(this).data('type') === 3; // 타입 3인지 확인
			
	        if (optionText !== '없음') {
	            $('input[name="' + questionGroup + '"]').each(function () {
	                const siblingOptionText = $(this).next('label').text().trim();
	                if (siblingOptionText === '없음' && $(this).is(':checked')) {
	                    const noneOptionId = $(this).val(); 
	                    $(this).prop('checked', false); 
	                    clearData(questionId, noneOptionId);
	                }
	            });
	        }
	        
	        if (optionText === '없음') {
	            if (isChecked) {
	                $('input[name="' + questionGroup + '"]').not(this).each(function () {
	                    const otherOptionId = $(this).val();
	                    const otherInputId = '#other-text-' + otherOptionId;
	                    $(this).prop('checked', false);
	                    $(otherInputId).hide().val('');
	                    clearData(questionId, otherOptionId);
	                });

	                sendData(questionId, optionId, true);
	            } else {
	                clearData(questionId, optionId);
	            }
	       
	        } else if (isType3) {
	            // 타입 3: 최대 2개 선택 가능
	            const checkedCount = $('input[name="' + questionGroup + '"]:checked').length;
	            if (checkedCount > 2) {
	                alert('최대 2개만 선택 가능합니다.');
	                $(this).prop('checked', false);
	                return;
	            }
	            if (!optionText.startsWith('기타')) {
	                if (isChecked) {
	                    sendData(questionId, optionId, true); // 선택 데이터 저장
	                } else {
	                    clearData(questionId, optionId); // 선택 해제 시 데이터 삭제
	                }
	            }
	        } else {
	            // 일반 객관식 처리 (단일 선택)
	            $('input[name="' + questionGroup + '"]').not(this).prop('checked', false); // 다른 체크박스 해제
	            if (!optionText.startsWith('기타')) {
	                if (isChecked) {
	                    sendData(questionId, optionId, true); // 선택 데이터 저장
	                } else {
	                    clearData(questionId, optionId); // 선택 해제 시 데이터 삭제
	                }
	            }
	        }
	        
	        if (optionText.startsWith('기타')) {
	            const otherInputId = '#other-text-' + optionId; // "기타" 입력창 ID

	            if (isChecked) {
	                // "기타" 체크박스가 체크되면 입력창만 표시
	                $(otherInputId).show().focus();

	                // 입력창의 `blur` 이벤트에서만 데이터 전송
	                $(otherInputId).off('blur').on('blur', function () {
	                    const otherAnswerText = $(this).val(); // 입력된 내용
	                    if (otherAnswerText.trim() !== "") {
	                        sendData(questionId, optionId, true, otherAnswerText); // 데이터 전송
	                    } 
	                });
	            } else {
	                // "기타" 체크박스가 해제되면 입력창 숨기고 데이터 삭제
	            	const otherAnswerText = $(otherInputId).val().trim();
	                if (otherAnswerText === '') {
	                    alert('기타항목을 입력하세요.');
	                    $(this).prop('checked', true); // 체크 상태 유지
	                    return;
	                }

	                // 입력값이 있으면 삭제 처리
	                clearData(questionId, optionId);
	                $(otherInputId).hide().val('');
	            }
	        }
	        
	    });
	        $('textarea').on('blur', function () {
	            const questionId = $(this).attr('name').split('-')[1]; // questionId 추출
	            const answerText = $(this).val().trim(); // 입력된 텍스트

	            if (answerText !== '') {
	                sendData(questionId, null, true, answerText); // 데이터 저장 (optionId는 null로 처리)
	            } else {
	                clearData(questionId, null); // 텍스트가 비어있으면 데이터 삭제
	            }
	        });
	        

	    // 데이터 전송 함수
	    function sendData(questionId, optionId, isSelected, answerText = null) {
	        $.ajax({
	            type: 'POST',
	            url: isSelected ? '/survey/insAnswer.do' : '/survey/delAnswer',
	            contentType: 'application/json',
	            data: JSON.stringify({
	                questionId: questionId,
	                optionId: optionId,
	                answerText: answerText,
	                userId: 1 
	            }),
	            success: function (response) {
	                console.log('Response:', response);
	            },
	            error: function (xhr, status, error) {
	                console.error('Error:', error);
	            }
	        });
	    }
	    
	    function clearData(questionId, optionId) {
	        $.ajax({
	            type: 'POST',
	            url: '/survey/clearSelection',
	            contentType: 'application/json',
	            data: JSON.stringify({
	                questionId: questionId,
	                optionId: optionId,
	                userId: 1 
	            }),
	            success: function (response) {
	                console.log('Response:', response);
	            },
	            error: function (xhr, status, error) {
	                console.error('Error:', error);
	            }
	        });
	    }
	    
	    function processAnswer(questionId, optionId) {
	        $.ajax({
	            type: 'POST',
	            url: '/survey/processAnswer.do',
	            contentType: 'application/json',
	            data: JSON.stringify({
	                questionId: questionId,
	                optionId: optionId,
	                userId: 1 
	            }),
	            success: function (response) {
	                console.log('Response:', response);
	            },
	            error: function (xhr, status, error) {
	                console.error('Error:', error);
	            }
	        });
	    }
	});
	

</script>

</html>