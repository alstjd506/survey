package com.survey.vo;

import lombok.Data;

@Data
public class OptionVO {
	private Integer optionId;
	private String optionText;
	private Integer questionId;
	private Integer turn;
	private Integer isSelected;
	private Integer userId;
	private Integer surveyId;
	private String answerText;
}
