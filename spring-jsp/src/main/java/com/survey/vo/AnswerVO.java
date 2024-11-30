package com.survey.vo;

import lombok.Data;

@Data
public class AnswerVO {
	private Integer answerId;
	private String answerText;
	private Integer questionId;
	private Integer userId;
	private Integer optionId;
}
