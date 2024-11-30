package com.survey.vo;

import lombok.Data;

@Data
public class QuestionVO {
	private Integer questionId;
	private String questionText;
	private Integer surveyId;
	private Integer questionType;
	private Integer parentQuestionId;
	private Integer turn;
	private Integer required;
	private Integer qCategoryId;
	private String qCategoryName;
}
